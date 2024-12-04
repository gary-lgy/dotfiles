local module = {}

-- TODO: look at how other libraries prevent new windows being immediately put under

local libwindow = require('hs.libwindow')

module.logger = hs.logger.new('focus_follows_mouse')
module.mouseMoveWaitDurationSeconds = 0.1
module.timerPeriodSeconds = 5
module.disableMod = 'fn' -- hold to disable
module.occlusionRatioThreshold = 0.1 -- occluding windows with either height or weight below this ratio will be ignored
module.newWindowDisableSeconds = 1.0 -- disable autofocus for this period after a new window is created
-- List of app names which do not stop window under cursor from being focused when
-- occluding it. Usually for floating always-on-top windows.
module.ignoreOcclusionApps = {}
-- List of app names which should not be focused even when under cursor.
-- Usually for picture-in-picture style windows.
-- TODO: should these be the same config?
module.ignoredApps = {}

-- windows for which this function returns true will not block the window under
-- cursor from being focused, even if occluding.
module.ignoreOccluding = function(window)
    if window:title() == 'Hammerspoon Console' then
        return true
    end

    -- popup windows
    -- this targets too many windows, and would de-focus too many pop-up windows
    -- if not window:isStandard() then
    --     return true
    -- end

    local appName = window:application():name()
    for _, allowedAppName in ipairs(module.ignoreOcclusionApps) do
        if allowedAppName == appName then
            return true
        end
    end

    -- ignore occlusion by invisible brave windows
    if window:application():bundleID() == 'com.brave.Browser' and not window:isStandard() then
        return true
    end

    return false
end

-- use this instead of hs.window.orderedWindows() so we include the Hammerspoon console window
-- https://github.com/Hammerspoon/hammerspoon/blob/master/extensions/window/window.lua#L173
module.orderedWindows = function()
    local orderedWinIds = libwindow._orderedwinids()
    local allWindows = {}
    for _, w in ipairs(hs.window.allWindows()) do
        if w:isVisible() and w:title() ~= 'Notification Center' then
            allWindows[w:id()] = w
        end
    end
    local r = {}
    for _, id in ipairs(orderedWinIds) do
        local w = allWindows[id]
        if w ~= nil then
            table.insert(r, w)
        end
    end
    return r
end

module.isOcclusionSignificant = function(occludingFrame, targetFrame)
    local intersection = occludingFrame:intersect(targetFrame)
    module.logger.d(string.format(
            'intersection h=%d w=%d, occludingFrame h=%d w=%d, ratios h=%f w=%f',
            intersection.h, intersection.w,
            occludingFrame.h, occludingFrame.w,
            intersection.h / occludingFrame.h,
            intersection.w / occludingFrame.w
        ))
    return intersection.w / occludingFrame.w > module.occlusionRatioThreshold and intersection.h / occludingFrame.h > module.occlusionRatioThreshold
end

module.getOccludingWindow = function(window, orderedWindows)
    -- look at each window from top to bottom
    for _, w in ipairs(orderedWindows) do
        if w:id() == window:id() then
            -- no window above w intersects with it
            module.logger.d('no occluding window found')
            return nil
        end

        if not module.ignoreOccluding(w) then
            local occludingFrame = w:frame()
            local targetFrame = window:frame()
            module.logger.d(string.format(
                'evaluating occlusion bundleID=%s title=%s isStandard=%s role=%s subrole=%s',
                w:application():bundleID(),
                w:title(),
                w:isStandard(),
                w:role(),
                w:subrole()
            ))
            
            -- ignore small intersections
            if module.isOcclusionSignificant(occludingFrame, targetFrame) then
                module.logger.d('found occluding window')
                return w
            end
        else
            module.logger.d(string.format(
                'skip occlusion evaluation bundleID=%s title=%s isStandard=%s role=%s subrole=%s',
                w:application():bundleID(),
                w:title(),
                w:isStandard(),
                w:role(),
                w:subrole()
            ))
        end
    end

    module.logger.d('potential bug, did not find focused window in all windows')
    return nil
end

module.getWindowUnderCursor = function(windows)
    local cursorPosition = hs.geometry.new(hs.mouse.absolutePosition())
    for _, w in ipairs(windows) do
        if cursorPosition:inside(w:frame()) then
            return w
        end
    end

    return nil
end

module.shouldAbort = function(focusedWindow, windowUnderCursor)
    local frontmostApp = hs.application.frontmostApplication()
    if focusedWindow == nil and frontmostApp ~= nil then
        -- check for ongoing transient stuff
        if frontmostApp:bundleID() == 'com.apple.finder' then
            -- renaming item in Finder window, focusing anything (including the Finder window) will cause renaming to be aborted
            module.logger.d('Finder renaming in progress, aborting')
            return true
        elseif frontmostApp:bundleID() == 'com.apple.dock.helper' then
            -- menu for a dock item is opened
            module.logger.df('hovering over dock, aborting')
            return true
        end
    end

    for _, ignoredAppName in ipairs(module.ignoredApps) do
        if ignoredAppName == windowUnderCursor:application():name() then
            module.logger.df('application %s is in the ignore list, aborting', ignoredAppName)
            return true
        end
    end

    return false
end

module.focusWindowUnderCursor = function()
    local windows = module.orderedWindows()
    local windowUnderCursor = module.getWindowUnderCursor(windows)
    if windowUnderCursor == nil then
        -- no window under cursor
        return
    end
    module.logger.df('window under cursor appname=%s id=%d title=%s',
        windowUnderCursor:application():name(),
        windowUnderCursor:id(),
        windowUnderCursor:title())

    local focused = hs.window.focusedWindow()
    if focused == nil then
        module.logger.d('no currently focused window')
    else
        module.logger.df('currently focused window appname=%s id=%s',
            focused:application():name(),
            focused:id(),
            focused:title())
    end

    -- window under cursor already focused
    if focused ~= nil and windowUnderCursor:id() == focused:id() then
        module.logger.d('window under cursor is already focused')
        return
    end

    if module.shouldAbort(focused, windowUnderCursor) then
        module.logger.d('aborting autofocus')
        return
    end

    -- check if the window is occluded
    occludingWindow = module.getOccludingWindow(windowUnderCursor, windows)
    if occludingWindow ~= nil then
        module.logger.df('occluding window appname=%s id=%d title=%s',
            occludingWindow:application():name(),
            occludingWindow:id(),
            occludingWindow:title())
        return
    end

    module.logger.df('focusing appname=%s id=%d title=%s',
        windowUnderCursor:application():name(),
        windowUnderCursor:id(),
        windowUnderCursor:title())
    windowUnderCursor:focus()
end

module.start = function()
    -- record the timestamp of the last possible window creation (e.g. left click, key down, etc), so we could disable autofocus for a while
    -- to prevent the new window from being immediately put under an existing window.
    local lastPossibleWindowCreationTimestamp = 0
    module._possibleWindowCreationEventTap = hs.eventtap.new({
            hs.eventtap.event.types.leftMouseDown,
            hs.eventtap.event.types.leftMouseUp,
            hs.eventtap.event.types.keyUp,
            hs.eventtap.event.types.keyDown,
        },
        function(event)
            lastPossibleWindowCreationTimestamp = hs.timer.secondsSinceEpoch()
        end
        ):start()

    shouldTrigger = function()
        -- don't trigger if module.disableMod is being held
        if module.disableMod and hs.eventtap.checkKeyboardModifiers()[module.disableMod] or #hs.eventtap.checkMouseButtons() > 0 then
            module.logger.d('auto focus disabled due to modifier or button clicks')
            return false
        end

        -- don't autofocus if a new window is (possibly) being created
        if hs.timer.secondsSinceEpoch() - lastPossibleWindowCreationTimestamp < module.newWindowDisableSeconds then
            module.logger.d('auto focus disabled due to possible new window creation')
            return false
        end

        return true
    end

    -- listen to mouse move events to focus the window under cursor
    module._mouseMovedEventTap = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, lib.debounce(module.mouseMoveWaitDurationSeconds, function(event)
        if shouldTrigger() then
            module.focusWindowUnderCursor()
        end
    end)):start()

    -- sometimes after closing a window none of the existing windows are focused
    -- use this timer to focus the window under the cursor in such scenarios
    module._timer = hs.timer.doEvery(module.timerPeriodSeconds, function()
        if shouldTrigger() and hs.window.focusedWindow() == nil then
            module.focusWindowUnderCursor()
        end
    end)
end

return module
