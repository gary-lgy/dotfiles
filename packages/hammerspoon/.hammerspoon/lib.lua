local module = {}

module.numEntries = function(t)
    local count = 0
    for _, _ in pairs(t) do
        count = count + 1
    end
    return count
end

-- https://stackoverflow.com/a/52697380
module.isArray = function(t)
    if type(t) ~= 'table' then
        return false
    end

    -- objects always return empty size
    if #t > 0 then
        return true
    end

    -- only object can have empty length with elements inside
    for k, v in pairs(t) do
        return false
    end

    -- if no elements it can be array and not at same time
    return true
end

module.dismissNotifications = function()
    hs.osascript.applescript([[
    tell application "System Events"
        tell process "NotificationCenter"
            set windowCount to count windows
            repeat with i from windowCount to 1 by -1
                click button "Close" of window i
            end repeat
        end tell
    end tell
        ]])
end

module.debounce = function(delay, fn)
    local timer = nil
    local arg = nil
    return function(...)
        arg = { ... }

        if timer == nil then
            timer = hs.timer.doAfter(delay, function()
                fn(table.unpack(arg))
            end)
        else
            timer:setNextTrigger(delay)
        end
    end
end

module.fuzzyScore = function(text, query)
    text, query = text:lower(), query:lower()
    -- naive algorithm based on https://github.com/junegunn/fzf/blob/master/src/algo/algo.go
    local matchStart = nil
    local i, j = 1, 1
    while i <= text:len() and j <= query:len() do
        local tc = text:sub(i, i)
        local qc = query:sub(j, j)
        if tc == qc then
            -- charactar matched
            if matchStart == nil then
                matchStart = i
            end

            i = i + 1
            j = j + 1
        else
            i = i + 1
        end
    end

    if matchStart == nil then
        -- not a single character matched
        return -1
    end

    -- prioritize shorter matches
    local matchLen = math.huge
    if j > query:len() then
        -- query fully matched
        matchLen = i - matchStart
    end
    -- lenScore in (0, 1]
    local lenScore = query:len() / matchLen

    -- small boost to texts with early matches
    -- positionScore in (0, 0.1]
    local positionScore = 0.1 / matchStart

    return positionScore + lenScore
end

module.pingLatency = function(fn)
    if fn == nil or type(fn) ~= 'function' then
        log.e('Expected a function as the first argument')
        return
    end

    local count = 5
    local sendFailCount = 0
    hs.network.ping(
        "8.8.8.8", -- destination
        count, -- count
        0.1, -- interval
        1.0, -- timeout
        "any", -- IP class
        function(object, message, ...) -- callback
            if message == 'sendPacketFailed' then
                sendFailCount = sendFailCount + 1
                if sendFailCount == count then
                    fn('disconnected', nil)
                end
                return
            elseif message ~= 'didFinish' then
                return
            end

            local summary = object:summary()
            local packetLoss = tonumber(string.match(summary, '(%d+%.%d+) packet loss'))
            local avg = tonumber(string.match(summary, '%d+%.%d+/(%d+%.%d+)/%d+%.%d+ ms'))
            if packetLoss >= 99.9 then
                fn('disconnected', nil)
            elseif avg <= 100 then
                fn('good', avg)
            elseif avg <= 200 then
                fn('ok', avg)
            else
                fn('bad', avg)
            end
        end
    )
end

module.execute = function(command, cb)
    hs.task.new(
        '/bin/bash',
        function(exitCode, stdOut, stdErr)
            if exitCode ~= 0 then
                log.e('Command `' .. command .. '` returned error - [stdout] ' .. stdOut .. ' [stderr] ' .. stdErr)
                return
            end

            if cb ~= nil then
                cb(stdOut)
            end
        end,
        { '-c', command }
    ):start()
end

module.moveCursorToCurrentWindow = function()
    local center = hs.window.frontmostWindow():frame().center
    hs.mouse.absolutePosition(center)
end

module.showSpaces = function()
    local mousePos = hs.mouse.absolutePosition()
    hs.mouse.setRelativePosition({ x = 0, y = 0 })
    hs.spaces.toggleMissionControl()
    hs.timer.doAfter(0.05, function()
        hs.mouse.absolutePosition(mousePos)
    end)
end

-- Same as hs.timer.waitUntil, except it calls predicateFn once when called
-- and invokes actionFn immediately if it returns true.
module.waitUntil = function(predicateFn, actionFn, checkInterval)
    if predicateFn() then
        actionFn()
        return nil
    else
        return hs.timer.waitUntil(predicateFn, actionFn, checkInterval)
    end
end

return module
