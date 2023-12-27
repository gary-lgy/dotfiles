local module = {}

module.maxHistorySize = 2000
module.storePath = '~/.hammerspoon/clipboard_history'

local function getHistoryPath()
    return module.storePath .. '/history.json'
end

local function getImagesPath()
    return module.storePath .. '/images'
end

local function loadHistory()
    local content = hs.json.read(getHistoryPath())
    return content or {}
end

local function saveHistory(history)
    hs.json.write(history, getHistoryPath(), false, true)
end

local function copyItem(item)
    if item.contentType == 'image' then
        local img = hs.image.imageFromPath(item.path)
        hs.pasteboard.writeObjects(img)
    elseif item.contentType == 'string' then
        hs.pasteboard.writeObjects(item.original)
    end
end

local function getPasteboardContent()
    local types = hs.pasteboard.typesAvailable()
    local application = hs.window.frontmostWindow():application()
    local bundleID = application:bundleID()
    local now = os.time()
    local filenameDateString = os.date('%Y-%m-%d %H%M%S', now)
    local timestamp = os.date('%Y-%m-%d %H:%M:%S', now)

    local item = nil
    if types['image'] then
        local img = hs.pasteboard.readImage()
        local filename = getImagesPath() .. '/' .. filenameDateString .. '-' .. bundleID .. '-' .. hs.host.uuid() .. '.png'
        img:saveToFile(filename)
        
        item = {
            contentType='image',
            text='image from ' .. application:name() .. ' (' .. bundleID .. ')',
            subText=timestamp,
            path=filename,
        }
    elseif types['string'] then
        local text = hs.pasteboard.readString()
        -- count non-whitespace characters only
        local stripped = text:gsub('%s', '')
        if utf8.len(stripped) <= 3 then
            return
        end

        item = {
            contentType='string',
            text=text:gsub('%s+', ' '), -- coalesce whitespace characters in display text
            subText=timestamp,
            original=text,
        }
    else
        return
    end

    item.bundleID = bundleID

    table.insert(module._history, 1, item)

    while #module._history > module.maxHistorySize do
        local item = table.remove(module._history)
        if item.contentType == 'image' then
            os.remove(hs.fs.pathToAbsolute(item.path))
        end
    end

    saveHistory(module._history)
end

local function choiceCallback(choice)
    if choice == nil then
        return
    end

    copyItem(choice)
    hs.eventtap.keyStroke('cmd', 'v')
end

-- singleton instance
module._chooser = hs.chooser.new(choiceCallback)

function module.toggleChooser()
    if module._chooser:isVisible() then
        module._chooser:hide()
        return
    end

    local screenFrame = hs.screen.mainScreen():frame()

    -- chooser and preview combined should approximately be centered on screen

    local chooserWidthPercentage = 30
    local chooserFrame = {
        x = screenFrame.x + screenFrame.w * 0.2,
        y = screenFrame.y + screenFrame.h * 0.2,
        w = screenFrame.w * (chooserWidthPercentage / 100),
    }

    local canvasFrame = {
        -- to the right of chooser
        x = chooserFrame.x + chooserFrame.w + 5,
        y = chooserFrame.y,
        w = screenFrame.w * 0.3,
        h = screenFrame.h * 0.3
    }
    local canvas = hs.canvas.new(canvasFrame)
    local background = {
        type = 'rectangle',
        action = 'fill',
        fillColor = { red = 0.2, green = 0.2, blue = 0.2, alpha = 0.9 }
    }

    local function previewChoice(row)
        local rowContents = module._chooser:selectedRowContents(row)
        local elements = {}
        if rowContents then
            if rowContents.contentType == 'image' then
                local img = hs.image.imageFromPath(rowContents.path)
                local newSize = {
                        w = math.min(img:size().w, canvasFrame.w),
                        h = math.min(img:size().h, canvasFrame.h),
                    }
                img:size(newSize)

                elements = { background, {
                    type = 'image',
                    image = img,
                    imageAlignment = 'topLeft',
                    imageScaling = 'none',
                } }
            elseif rowContents.contentType == 'string' then
                elements = { background, {
                    type = 'text',
                    text = rowContents.original,
                    textSize = 20,
                    textColor = { white = 0.8 }
                } }
            end
        end

        canvas:replaceElements(table.unpack(elements))
        -- force garbage collection for the old image preview
        collectgarbage()
        collectgarbage()
    end

    -- up/down: update preview when selection is changed
    local eventtap = hs.eventtap.new(
        {
            hs.eventtap.event.types.keyDown,
            hs.eventtap.event.types.mouseMoved
        },
        lib.debounce(0.02, function(event)
            if event:getType() == hs.eventtap.event.types.keyDown then
                if event:getKeyCode() == hs.keycodes.map.down or event:getKeyCode() == hs.keycodes.map.up then
                    local row = module._chooser:selectedRow()
                    previewChoice(row)
                end
            end
        end))

    local copyKeyBinding = hs.hotkey.new('cmd', 'c', function() 
        -- copy item and dismiss chooser
        copyItem(module._chooser:selectedRowContents())
        module._chooser:cancel()
    end)

    local allHistory = {}
    hs.fnutils.ieach(module._history, function(item)
        -- cache the app icons; this can speed up 10x
        local appIcon = module._appIcons[item.bundleID]
        if appIcon == nil then
            appIcon = hs.image.imageFromAppBundle(item.bundleID)
            module._appIcons[item.bundleID] = appIcon
        end

        local o = {
            image=appIcon,
        }
        for k, v in pairs(item) do
            o[k] = v
        end
        table.insert(allHistory, o)
    end)

    local function filterChoices(query)
        local choices = {}
        if query:len() == 0 then
            -- reset query
            choices = allHistory
        else
            hs.fnutils.each(allHistory, function(choice)
                choice.score = lib.fuzzyScore(choice.text, query)
                if choice.score >= 0.1 then
                    table.insert(choices, choice)
                end
            end)
            table.sort(choices, function(c1, c2) return c1.score > c2.score end)
        end
        module._chooser:choices(choices)

        -- preview first choice
        previewChoice(1)
    end

    module._chooser
        :placeholderText("Clipboard history")
        :width(chooserWidthPercentage)
        :choices(allHistory)
        :rows(15)
        :query(nil)
        :showCallback(function()
            eventtap:start()
            copyKeyBinding:enable()
            -- preview first choice
            previewChoice(1)
            canvas:show()
            -- focus the chooser window to allow mouse hover
            hs.application.get('Hammerspoon'):activate()
        end)
        :hideCallback(function()
            eventtap:stop()
            copyKeyBinding:disable()
            canvas:delete()
        end)
        :queryChangedCallback(lib.debounce(0.02, function(query)
            filterChoices(query)
        end))
        :show({
            x = chooserFrame.x,
            y = chooserFrame.y,
        })
end

module.start = function()
    hs.fs.mkdir(module.storePath)
    hs.fs.mkdir(getImagesPath())

    module._history = loadHistory()
    module._watcher = hs.pasteboard.watcher.new(getPasteboardContent):start()
    module._appIcons = {}
end

return module

