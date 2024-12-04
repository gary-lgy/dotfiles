local module = {}

-- TODO: look at how other libraries prevent new windows being immediately put under

local libwindow = require('hs.libwindow')

module.logger = hs.logger.new('focus_follows_mouse')
module.mouseMoveWaitDurationSeconds = 0.1
module.timerPeriodSeconds = 0.25
module.disableMod = 'fn' -- hold to disable
module.occlusionThresholdPixels = 40.0 -- occlusion with either height or width below this value will be ignored
module.newWindowDisableSeconds = 1.0 -- disable autofocus for this period after a new window is created
-- List of app names which do not stop window under cursor from being focused when
-- the occluding it. Usually for picture-in-picture style windows.
module.occlusionAllowedApps = {}
-- List of app names which should not be focused even when under cursor.
-- Usually for picture-in-picture style windows.
-- TODO: should these be the same config?
module.ignoredApps = {}

module.occlusionAllowed = function(window)
    if window:title() == 'Hammerspoon Console' then
        return true
    end

    -- popup windows
    if not window:isStandard() then
        return true
    end

    local appName = window:application():name()
    for _, allowedAppName in ipairs(module.occlusionAllowedApps) do
        if allowedAppName == appName then
            return true
        end
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

module.getOccludingWindow = function(window, orderedWindows)
    -- look at each window from top to bottom
    for _, w in ipairs(orderedWindows) do
        if w:id() == window:id() then
            -- no window above w intersects with it
            return nil
        end

        if not module.occlusionAllowed(w) then
            local occludingFrame = w:frame()
            local targetFrame = window:frame()
            local intersection = occludingFrame:intersect(targetFrame)
            
            -- ignore small intersections
            local isFullyContained = occludingFrame:inside(targetFrame)
            local isIntersectionSignificant = intersection.w > module.occlusionThresholdPixels and intersection.h > module.occlusionThresholdPixels
            if isFullyContained or isIntersectionSignificant then
                -- found the occluding window
                return w
            end
        end
    end

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
