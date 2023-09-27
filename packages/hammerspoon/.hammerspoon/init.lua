lib = require('lib')

local config = require('config')
local windowChooser = require('window_chooser')
local touchWatcher = require('touch_watcher')
local focusFollowsMouse = require('focus_follows_mouse')
local clipboardHistory = require('clipboard_history')
local secureInputWatcher = require('secure_input_watcher')
local inputSourceSwitch = require('input_source_switch')
local lastCursorPosition = require('last_cursor_position')

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

local function getFunctionBindings(map)
    local t = {}
    for key, fn in pairs(map) do
        if type(snippet) == 'table' then
            -- recursive binding
            t[key] = getFunctionBindings(snippet)
        else
            t[key] = fn
        end
    end

    return t
end

hs.hotkey.setLogLevel(hs.logger.defaultLogLevel) -- fix verbose default logging level of hs.hotkey
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
        [{ '', 'f', 'Functions' }] = getFunctionBindings(config.functionBindings),
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
            lastCursorPosition.moveCursorToLastKnownOrCenter(
                app:focusedWindow() or app:mainWindow())
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
        lastCursorPosition.moveCursorToLastKnownOrCenter(
            hs.window.focusedWindow():application())
    end)
end)

-- https://github.com/miromannino/miro-windows-manager
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0
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
hs.hotkey.bind(hyper, '1', lib.showSpaces)
hs.hotkey.bind(hyper, '2', function()
    local win = hs.window.filter.default:getWindows(hs.window.filter.sortByFocusedLast)[2]
    if win ~= nil then
        win:focus()
        lastCursorPosition.moveCursorToLastKnownOrCenter(win)
    end
end)
hs.hotkey.bind(hyper, '3', windowChooser.toggle)

hs.hotkey.bind({'cmd', 'shift'}, 'c', clipboardHistory.toggleChooser)

focusFollowsMouse.occlusionAllowedApps = config.focusFollowsMouse.occlusionAllowedApps
focusFollowsMouse.ignoredApps = config.focusFollowsMouse.ignoredApps
focusFollowsMouse.start()

touchWatcher.start()
clipboardHistory.start()
secureInputWatcher.start()
inputSourceSwitch.start(config.appInputMethods)
lastCursorPosition.start()

hs.alert.show('Hammerspoon config reloaded', 1)
