local debounce = lib.debounce
local fuzzyScore = lib.fuzzyScore

local module = {}

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

local function focusWindow(win, doWarp)
    local winObj = hs.fnutils.find(module._wf:getWindows(), function(w)
        return w:id() == win.id
    end)

    if winObj == nil then
        return nil
    end

    local oldSID = hs.screen.mainScreen():id()

    if win.isMinimized then
        winObj:unminimize()
    end
    winObj:focus()

    local newSID = hs.screen.mainScreen():id()
    if doWarp and oldSID ~= newSID then
        lib.centerCursorInWindow(winObj)
    end

    return winObj
end

local function tileWindows(first, second, targetFrame, direction)
    local firstFrame = targetFrame
    local secondFrame = firstFrame:copy()

    if direction == hs.keycodes.map.left then
        secondFrame.x = firstFrame.x
        secondFrame.w = firstFrame.w / 2
        secondFrame.h = firstFrame.h
        firstFrame.w = firstFrame.w / 2
        firstFrame.x = firstFrame.x + firstFrame.w
    elseif direction == hs.keycodes.map.right then
        secondFrame.x = firstFrame.x + firstFrame.w / 2
        secondFrame.w = firstFrame.w / 2
        secondFrame.h = firstFrame.h
        firstFrame.w = firstFrame.w / 2
    elseif direction == hs.keycodes.map.up then
        secondFrame.y = firstFrame.y
        secondFrame.w = firstFrame.w
        secondFrame.h = firstFrame.h / 2
        firstFrame.h = firstFrame.h / 2
        firstFrame.y = firstFrame.y + firstFrame.h
    elseif direction == hs.keycodes.map.down then
        secondFrame.y = firstFrame.y + firstFrame.h / 2
        secondFrame.h = firstFrame.h / 2
        secondFrame.w = firstFrame.w
        firstFrame.h = firstFrame.h / 2
    end

    first:setFrame(firstFrame, 0)
    second:setFrame(secondFrame, 0)
    second:raise()
end

-- singleton instance
module._chooser = hs.chooser.new(function(choice)
    if choice == nil then
        return
    end

    focusWindow(choice, true)
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
    local previousWindow = hs.window.frontmostWindow()

    -- cmd+arrow[+shift]: tile previous window and selected window on the current screen (hold shift to use the frame of the previous window instead of current screen)
    -- up/down: update preview when selection is changed
    local eventtap = hs.eventtap.new(
        {
            hs.eventtap.event.types.keyDown,
            hs.eventtap.event.types.mouseMoved
        },
        debounce(0.02, function(event)
            if hs.eventtap.checkKeyboardModifiers()['cmd'] then
                if event:getType() == hs.eventtap.event.types.keyDown then
                    local rowContents = module._chooser:selectedRowContents()
                    module._chooser:cancel()

                    if previousWindow:id() == rowContents.id then
                        -- don't do anything if we selected the previously focused window to prevent
                        -- spurious resizing
                        return
                    end

                    local newWindow = hs.fnutils.find(module._wf:getWindows(), function(w)
                        return w:id() == rowContents.id
                    end)
                    if newWindow == nil then
                        return
                    end

                    local targetFrame = hs.eventtap.checkKeyboardModifiers()['shift'] and previousWindow:frame() or previousWindow:screen():frame()
                    tileWindows(previousWindow, newWindow, targetFrame, event:getKeyCode())
                end
            else
                if event:getType() == hs.eventtap.event.types.keyDown and
                    (event:getKeyCode() ~= hs.keycodes.map.down and event:getKeyCode() ~= hs.keycodes.map.up) then
                    -- ignore other key presses
                    return
                end

                local row = module._chooser:selectedRow()
                previewWindow(row)
            end
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

return module
