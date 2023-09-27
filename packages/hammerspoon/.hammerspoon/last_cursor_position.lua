local lib = require('lib')
local module = {}

module.lastKnownCursorLocations = {}

module.start = function()
    module.recordLocationTimer = hs.eventtap.new(
        {hs.eventtap.event.types.mouseMoved},
        lib.debounce(0.1, function(event)
            local win = hs.window.focusedWindow()
            if win == nil then
                return
            end
            local pos = hs.geometry.new(hs.mouse.absolutePosition())
            if pos:inside(win:frame()) then
                module.lastKnownCursorLocations[win:id()] = pos
            end
        end)):start()
end

module.moveCursorToLastKnownOrCenter = function(win)
    local lastKnown = module.lastKnownCursorLocations[win:id()]
    if lastKnown ~= nil then
        hs.mouse.absolutePosition(lastKnown)
    else
        lib.centerCursorInWindow(win)
    end
end

return module