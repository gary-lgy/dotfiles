local module = {}

local libwindow = require('hs.libwindow')

module.waitDuration = 0.1 -- seconds
module.disableMod = 'fn' -- hold to disable

-- use this instead of hs.window.orderedWindows() so we include the Hammerspoon console window
-- https://github.com/Hammerspoon/hammerspoon/blob/master/extensions/window/window.lua#L173
local function orderedWindows()
    local orderedWinIds = libwindow._orderedwinids()
    local allWindows = {}
    for _, w in ipairs(hs.window.allWindows()) do
        if w:isVisible() then
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

module.start = function()
    module.eventtap = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, lib.debounce(module.waitDuration, function(event)
        if module.disableMod and hs.eventtap.checkKeyboardModifiers()[module.disableMod] then
            return
        end

        local windows = orderedWindows()
        local windowUnderCursor = nil
        local cursorPosition = hs.geometry.new(hs.mouse.absolutePosition())
        for _, w in ipairs(windows) do
            if cursorPosition:inside(w:frame()) then
                windowUnderCursor = w
                break
            end
        end

        if windowUnderCursor == nil or windowUnderCursor:id() == hs.window.focusedWindow():id() then
            return
        end

        for _, w in ipairs(windows) do
            if w:id() == windowUnderCursor:id() then
                -- no window above us intesects with us, we can safely raise ourselves
                break
            end

            local intersection = w:frame():intersect(windowUnderCursor:frame())
            if intersection.w ~= 0.0 and intersection.h ~= 0.0 then
                -- intersects with another window, don't raise it
                return
            end
        end

        windowUnderCursor:focus()
    end)):start()
end

return module
