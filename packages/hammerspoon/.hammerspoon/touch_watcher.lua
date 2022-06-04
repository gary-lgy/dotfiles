-- replicate some of BTT's functionalities

-- TODO: tip-tap?
-- TODO: swipe?
-- TODO: recognize 'tap' (down quickly followed by down) as opposed to move?

local module = {}

local function touchChanged(touches)
    if lib.numEntries(touches) == 5 then
        lib.showSpaces()
    end
end

module.touches = {}
module.staleThreshold = 500 * 1000 * 1000 -- ns = 500ms

module.start = function()
    module._gestureEventTap = hs.eventtap.new({hs.eventtap.event.types.gesture}, function(event)
        local someBegan = false

        for _, touch in ipairs(event:getTouches()) do
            if touch.type == 'indirect' then -- only handle touchpad events
                if touch.touching then
                    module.touches[touch.identity] = touch
                    if touch.phase == 'began' then
                        someBegan = true
                    end
                else
                    module.touches[touch.identity] = nil
                end

            end
        end

        -- prune stale touches - some touch events never reach the 'ended' phase
        local stale = {}
        for id, touch in pairs(module.touches) do
            if hs.timer.absoluteTime() - touch.timestamp * 1e9 > module.staleThreshold then
                table.insert(stale, id)
            end
        end
        for _, id in ipairs(stale) do
            module.touches[id] = nil
        end

        if someBegan then
            touchChanged(module.touches)
        end
    end):start()
end

return module

