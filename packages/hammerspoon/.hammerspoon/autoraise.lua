local module = {}

module.waitDuration = 0.1 -- seconds
module.disableMod = 'fn' -- hold to disable

module.start = function()
    module.eventtap = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, lib.debounce(module.waitDuration, function(event)
        if module.disableMod and hs.eventtap.checkKeyboardModifiers()[module.disableMod] then
            return
        end

        local windows = hs.window.orderedWindows()
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
