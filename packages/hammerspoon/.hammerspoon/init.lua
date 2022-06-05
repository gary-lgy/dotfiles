log = hs.logger.new('init', 'verbose')
lib = require('lib')

-- keepActive is an undocumented call to keep the wf active even without subscription,
-- which in turn forces it to refresh the window list when we switch spaces.
hs.window.filter.default:keepActive()
hs.window.filter.defaultCurrentSpace:keepActive()

local config = require('config')
local windowChooser = require('window_chooser')
local touchWatcher = require('touch_watcher')
local focusFollowsMouse = require('focus_follows_mouse')
local clipboardHistory = require('clipboard_history')

local function vivaldiSearch()
    local app = hs.application.get('Vivaldi')
    app:activate()
    lib.waitUntil(
        function() return app:isFrontmost() end,
        function()
            lib.moveCursorToCurrentWindow()
            hs.eventtap.keyStroke({ 'cmd' }, 'e', app)
        end,
        0.2
    )
end

local function displayPingLatency()
    lib.pingLatency(function(status, latency)
        hs.alert('Ping: ' .. status .. (latency and (' (' .. latency .. 'ms)') or ''))
    end)
end

local function getAppBindings(map)
    local t = {}
    for key, app in pairs(map) do
        if type(app) == 'table' then
            -- recursive binding
            t[{ '', key, app[1] }] = getAppBindings(app[2])
        else
            t[{ '', key, app }] = function()
                hs.application.open(app)
                lib.moveCursorToCurrentWindow()
            end
        end
    end

    return t
end

local function getSnippetBindings(map)
    local t = {}
    for key, snippet in pairs(map) do
        if type(snippet) == 'table' then
            -- recursive binding
            t[key] = getSnippetBindings(snippet)
        else
            t[key] = function()
                -- snippet may be a string or a nullary function (for custom logic, e.g. getting current datetime)
                local text = type(snippet) == 'function' and snippet() or snippet
                hs.eventtap.keyStrokes(text)
            end
        end
    end

    return t
end

hyper = { 'cmd', 'ctrl', 'shift', 'alt' }

local rbinder = hs.loadSpoon('RecursiveBinder')
rbinder.helperFormat = { atScreenEdge = 0 }
local activateRecursiveModal = rbinder.recursiveBind({
        [{ '', 't', 'Vivaldi' }]  = vivaldiSearch,
        [{ '', 'r', 'Reload' }]   = hs.reload,
        [{ '', 'c', 'Console' }]  = hs.toggleConsole,
        [{ '', 'p', 'Ping' }]     = displayPingLatency,
        [{ '', 'w', 'Windows' }]  = windowChooser.toggle,
        [{ '', 's', 'Spaces' }]   = lib.showSpaces,
        [{ '', 'd', 'X Notif' }]  = lib.dismissNotifications,
        [{ '', 'a', 'Apps' }]     = getAppBindings(config.appBindings),
        [{ '', 'n', 'Snippets' }] = getSnippetBindings(config.snippetBindings),
    })

hs.hotkey.bind(hyper, 'space',
    function()
        if hs.eventtap.isSecureInputEnabled() then
            hs.alert.show('⚠️ Secure input enabled!')
        
        else
            activateRecursiveModal()
        end
    end
)

-- https://github.com/dbalatero/SkyRocket.spoon
local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
    -- Opacity of resize canvas
    opacity = 0.3,
    -- Which modifiers to hold to move a window?
    moveModifiers = { 'fn' },
    -- Which mouse button to hold to move a window?
    moveMouseButton = 'left',
    -- Which modifiers to hold to resize a window?
    resizeModifiers = { 'fn' },
    -- Which mouse button to hold to resize a window?
    resizeMouseButton = 'right',
})

hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({
    up         = { hyper, "up" },
    right      = { hyper, "right" },
    down       = { hyper, "down" },
    left       = { hyper, "left" },
    fullscreen = { hyper, "f" },
    nextscreen = { hyper, "n" }
})

-- change focus and bring the cursor along
hs.fnutils.ieach({
    { 'h', hs.window.filter.focusWest },
    { 't', hs.window.filter.focusSouth },
    { 's', hs.window.filter.focusEast },
    { 'c', hs.window.filter.focusNorth },
}, function(map)
    hs.hotkey.bind(hyper, map[1], function()
        map[2]()
        lib.moveCursorToCurrentWindow()
    end)
end)

hs.hotkey.bind('', 'pad1', lib.showSpaces)
hs.hotkey.bind('', 'pad3', function() hs.eventtap.keyStroke({ 'cmd', 'shift' }, '4') end)
hs.hotkey.bind('', 'pad5', windowChooser.toggle)
hs.hotkey.bind({'cmd', 'shift'}, 'c', clipboardHistory.toggleChooser)

hs.alert.show('Hammerspoon config reloaded', 1)

local secureInputMenuBarIcon = hs.menubar.new(true)
hs.timer.doEvery(0.5, function()
    if hs.eventtap.isSecureInputEnabled() and not secureInputMenuBarIcon:isInMenuBar() then
        secureInputMenuBarIcon:returnToMenuBar()
        secureInputMenuBarIcon:setTitle('⚠️')
        secureInputMenuBarIcon:setMenu({
                { title = 'Secure input is enabled!', disabled = true }
            })
    elseif not hs.eventtap.isSecureInputEnabled() and secureInputMenuBarIcon:isInMenuBar() then
        secureInputMenuBarIcon:removeFromMenuBar()
    end
end)

touchWatcher.start()
focusFollowsMouse.start()
clipboardHistory.start()

-- TODO: hs.layout
