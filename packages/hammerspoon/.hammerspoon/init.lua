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
local secureInputWatcher = require('secure_input_watcher')

-- focus Vivaldi and send Cmd-E
local function vivaldiSearch()
    local app = hs.application.get('Vivaldi')
    if app == nil then
        return nil
    end

    app:activate()

    lib.waitUntil(
        function() return app:isFrontmost() end,
        function()
            lib.centerCursorInApp(app)
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

local meh = { 'shift', 'ctrl', 'alt' }
local hyper = { 'shift', 'ctrl', 'alt', 'cmd' }

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
        [{ '', 'n', 'Snippets' }] = getSnippetBindings(config.snippetBindings),
    })

hs.hotkey.bind(meh, 'space',
    function()
        if hs.eventtap.isSecureInputEnabled() then
            hs.alert.show('⚠️ Secure input enabled!')
        else
            activateRecursiveModal()
        end
    end
)

lib.eachKV(config.appBindings, function(key, appName)
    hs.hotkey.bind(meh, key, function()
        local app = hs.application.get(appName)
        if app == nil then
            hs.application.open(appName)
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
            lib.centerCursorInApp(app)
        end
    end)
end)

-- change focus and bring the cursor along
hs.fnutils.ieach({
    { 'left',  hs.window.filter.focusWest },
    { 'down',  hs.window.filter.focusSouth },
    { 'right', hs.window.filter.focusEast },
    { 'up',    hs.window.filter.focusNorth },
}, function(map)
    hs.hotkey.bind(meh, map[1], function()
        map[2]()
        lib.centerCursorInWindow(hs.window.focusedWindow())
    end)
end)

hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({
    up         = { hyper, "up" },
    right      = { hyper, "right" },
    down       = { hyper, "down" },
    left       = { hyper, "left" },
    fullscreen = { hyper, "return" },
    nextscreen = { hyper, "tab" }
})

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

-- shortcuts
hs.hotkey.bind('', 'pad1', lib.showSpaces)
hs.hotkey.bind('', 'pad3', function() hs.eventtap.keyStroke({ 'ctrl', 'cmd', 'shift' }, '4') end)
hs.hotkey.bind('', 'pad4', function()
    local win = hs.window.filter.default:getWindows(hs.window.filter.sortByFocusedLast)[2]
    if win ~= nil then
        win:focus()
        lib.centerCursorInWindow(win)
    end
end)
hs.hotkey.bind('', 'pad5', windowChooser.toggle)

hs.hotkey.bind({'cmd', 'shift'}, 'c', clipboardHistory.toggleChooser)

touchWatcher.start()
focusFollowsMouse.start()
clipboardHistory.start()
secureInputWatcher.start()

hs.alert.show('Hammerspoon config reloaded', 1)

-- TODO: hs.layout
