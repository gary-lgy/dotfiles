log = hs.logger.new('init', 'verbose')
lib = require('lib')

local config = require('config')

local windowChooser = require('window_chooser')

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
            if type(snippet) == 'function' then
                snippet = snippet()
            end

            t[key] = function()
                hs.eventtap.keyStrokes(snippet)
            end
        end
    end

    return t
end

hyper = { 'cmd', 'ctrl', 'shift', 'alt' }

local rbinder = hs.loadSpoon('RecursiveBinder')
rbinder.helperFormat = { atScreenEdge = 0 }

hs.hotkey.bind(hyper, 'space',
    rbinder.recursiveBind({
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

hs.alert.show('Hammerspoon config reloaded', 1)

-- TODO: hs.layout
-- TODO: gestures
-- TODO: autoraise
