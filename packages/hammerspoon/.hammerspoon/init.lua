lib = require('lib')

local config = require('config')
local windowChooser = require('window_chooser')
local touchWatcher = require('touch_watcher')
local focusFollowsMouse = require('focus_follows_mouse')
local clipboardHistory = require('clipboard_history')
local secureInputWatcher = require('secure_input_watcher')

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
        [{ '', 'r', 'Reload' }]   = hs.reload,
        [{ '', 'c', 'Console' }]  = hs.toggleConsole,
        [{ '', 'w', 'Windows' }]  = windowChooser.toggle,
        [{ '', 's', 'Spaces' }]   = lib.showSpaces,
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

lib.eachKV(config.appBindings, function(key, bundleID)
    hs.hotkey.bind(meh, key, function()
        local app = hs.application.applicationsForBundleID(bundleID)[1]
        if app == nil then
            hs.application.open(bundleID)
        elseif app:isFrontmost() and #(app:allWindows()) > 0 then
            app:hide()
        else
            hs.application.launchOrFocusByBundleID(bundleID)
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
