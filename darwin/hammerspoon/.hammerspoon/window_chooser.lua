local debounce = lib.debounce
local fuzzyScore = lib.fuzzyScore

local module = {}

-- stop using yabai for now
-- yabaiGetWindows(function(windows)
--     _chooser = showChooser(windows, yabaiFocusWindow)
-- end)
local function yabaiParseWindows(stdOut)
    local raw = hs.json.decode(stdOut)

    local windows = {}
    local seenIds = {}
    for _, window in ipairs(raw) do
        if not seenIds[window.id] and window.subrole == 'AXStandardWindow' then
            seenIds[window.id] = true
            local application = hs.application.find(window.pid)
            table.insert(windows, {
                text = window.title,
                subText = window.app,
                image = application and hs.image.imageFromAppBundle(application:bundleID()) or hs.image.iconFromName('NSStatusUnavailable'),
                id = window.id,
                frame = window.frame,
            })
        end
    end

    return windows
end

local function yabaiGetWindows(cb)
    -- use hs.task instead of os.execute to prevent blocking the lua main thread
    hs.task.new(
        '/usr/local/bin/yabai',
        function(exitCode, stdOut, stdErr)
            if exitCode ~= 0 then
                log.e('yabai returned error - [stdout] ' .. stdOut .. ' [stderr] ' .. stdErr)
                return
            end

            local windows = yabaiParseWindows(stdOut)
            cb(windows)
        end,
        { '-m', 'query', '--windows' }
    )
        :start()
end

local function yabaiFocusWindow(win)
    local oldSID = hs.screen.mainScreen():id()
    hs.task.new(
        '/usr/local/bin/yabai',
        function(exitCode, stdOut, stdErr)
            if exitCode ~= 0 then
                log.e('yabai returned error - [stdout] ' .. stdOut or '' .. ' [stderr] ' .. stdErr or '')
                return
            end

            -- if screen changed, move cursor to center of focused window
            local newSID = hs.screen.mainScreen():id()
            if newSID ~= oldSID then
                hs.mouse.absolutePosition(hs.geometry.new(win.frame).center)
            end
        end,
        { '-m', 'window', tostring(win.id), '--focus' }
    ):start()
end

-- scenario:
-- Space 1 has window 1 (current space), Space 2 has window 2 (for the same app)
-- If we go to space 2 and focus window 2, then go back to space 1 and invoke `getWindows`,
-- window 2 will not be in the returned list.
-- This is because the window list is only refreshed when we actually invoke `getWindows`.
-- keepActive is an undocumented call to keep the wf active even without subscription,
-- which in turn forces it to refresh the window list when we switch spaces.
module._wf = hs.window.filter.new():setDefaultFilter({}):keepActive()

local function getWindows()
    return hs.fnutils.imap(module._wf:getWindows(), function(win)
        local app = win:application()
        return {
            id = win:id(),
            text = win:title(),
            subText = app:name(),
            image = hs.image.imageFromAppBundle(app:bundleID()),
        }
    end)
end

local function focusWindow(win)
    local winObj = hs.fnutils.find(module._wf:getWindows(), function(w)
        return w:id() == win.id
    end)

    if winObj == nil then
        return
    end

    local oldSID = hs.screen.mainScreen():id()

    if win.isMinimized then
        winObj:unminimize()
    end
    winObj:focus()

    local newSID = hs.screen.mainScreen():id()
    if oldSID ~= newSID then
        lib.moveCursorToCurrentWindow()
    end
end

-- singleton instance
module._chooser = hs.chooser.new(function(choice)
    if choice == nil then
        return
    end

    focusWindow(choice)
end)

function module.toggle()
    if module._chooser:isVisible() then
        module._chooser:hide()
        return
    end

    local screenFrame = hs.screen.mainScreen():frame()

    -- chooser and preview combined should approximately be centered on screen

    local chooserWidthPercentage = 30
    local chooserFrame = {
        x = screenFrame.x + screenFrame.w * 0.1,
        y = screenFrame.y + screenFrame.h * 0.1,
        w = screenFrame.w * (chooserWidthPercentage / 100),
    }

    local canvas = hs.canvas.new({
        -- to the right of chooser
        x = chooserFrame.x + chooserFrame.w + 5,
        y = chooserFrame.y,
        w = screenFrame.w * 0.5,
        h = screenFrame.h * 0.5
    })

    local snapshotCache = {}
    local function previewWindow(rowNumber)
        local win = module._chooser:selectedRowContents(rowNumber)
        if win.id == nil then
            -- invalid row number, got empty table
            return
        end
        if snapshotCache[win.id] == nil then
            snapshotCache[win.id] = hs.window.snapshotForID(win.id)
        end
        local img = snapshotCache[win.id]

        canvas:assignElement({
            type = 'image',
            image = img,
            imageAlignment = 'topLeft',
        }, 1)
        -- force garbage collection for the old snapshot image
        collectgarbage()
        collectgarbage()
    end

    local windows = getWindows()

    -- update preview when selection is changed
    local eventtap = hs.eventtap.new(
        {
            hs.eventtap.event.types.keyDown,
            hs.eventtap.event.types.mouseMoved
        },
        debounce(0.02, function(event)
            if event:getType() == hs.eventtap.event.types.keyDown and
                (event:getKeyCode() ~= hs.keycodes.map.down and event:getKeyCode() ~= hs.keycodes.map.up) then
                -- ignore other key presses
                return
            end

            local row = module._chooser:selectedRow()
            previewWindow(row)
        end))

    local function filterChoices(query)
        local choices = {}
        if query:len() == 0 then
            -- reset query
            choices = windows
        else
            hs.fnutils.each(windows, function(w)
                w.score = fuzzyScore(w.text .. ' ' .. w.subText, query)
                if w.score >= 0.1 then
                    table.insert(choices, w)
                end
            end)
            table.sort(choices, function(w1, w2) return w1.score > w2.score end)
        end
        module._chooser:choices(choices)

        -- preview first window
        previewWindow(1)
    end

    module._chooser
        :placeholderText("Choose window to focus")
        :width(chooserWidthPercentage)
        :choices(windows)
        :query(nil)
        :showCallback(function()
            eventtap:start()
            -- preview first window
            previewWindow(1)
            canvas:show()
            -- focus the chooser window to allow mouse hover
            hs.application.get('Hammerspoon'):activate()
        end)
        :hideCallback(function()
            eventtap:stop()
            canvas:delete()
            -- clear the cache to free up memory
            snapshotCache = {}
            collectgarbage()
            collectgarbage()
        end)
        :queryChangedCallback(debounce(0.02, function(query)
            filterChoices(query)
        end))
        :show({
            x = chooserFrame.x,
            y = chooserFrame.y,
        })
end

-- TODO: what can we do in rightClickCallback?

return module
