local module = {}

local libwindow = require('hs.libwindow')

module.mouseMoveWaitDurationSeconds = 0.1
module.timerPeriodSeconds = 0.25
module.disableMod = 'fn' -- hold to disable
module.occlusionThresholdPixels = 20.0 -- occlusion with either height or width below this value will be ignored

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

        if w:application():name() ~= 'Hammerspoon' then -- allow Hammerspoon windows to occlude other windows
            local intersection = w:frame():intersect(window:frame())
            -- ignore small intersections
            if intersection.w > module.occlusionThresholdPixels and intersection.h > module.occlusionThresholdPixels then
                -- found the occluding window
                return w
            end
        end
    end

    return nil
end

module.focusWindowUnderCursor = function()
    local windows = module.orderedWindows()
    local windowUnderCursor = nil
    local cursorPosition = hs.geometry.new(hs.mouse.absolutePosition())
    for _, w in ipairs(windows) do
        if cursorPosition:inside(w:frame()) then
            windowUnderCursor = w
            break
        end
    end

    local focused = hs.window.focusedWindow()
    if windowUnderCursor == nil or -- no window under cursor
        focused ~= nil and windowUnderCursor:id() == focused:id() or -- window under cursor already focused
        focused == nil and hs.application.frontmostApplication():name() == 'Finder' or -- renaming item in Finder window
        windowUnderCursor:application():name() == 'Lark Meetings' -- window under cursor is Lark Meeting (screen sharing, small window preview etc)
        then
        return
    end

    -- check if the window is occluded
    occludingWindow = module.getOccludingWindow(windowUnderCursor, windows)
    if occludingWindow == nil then
        windowUnderCursor:focus()
    end
end

module.start = function()
    module._mouseMovedEventTap = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, lib.debounce(module.mouseMoveWaitDurationSeconds, function(event)
        if module.disableMod and hs.eventtap.checkKeyboardModifiers()[module.disableMod] or #hs.eventtap.checkMouseButtons() > 0 then
            return
        end

        module.focusWindowUnderCursor()
    end)):start()

    -- sometimes after closing a window none of the existing windows are focused
    -- use this timer to focus the window under the cursor in such scenarios
    module._timer = hs.timer.doEvery(module.timerPeriodSeconds, function()
        if hs.window.focusedWindow() == nil then
            module.focusWindowUnderCursor()
        end
    end)
end

return module
