return {
    snippetBindings = {
        [{ '', 'd', 'Date' }] = function() return os.date('%d %B %Y', os.time()) end,
    },
    functionBindings = {
        [{ '', 'p', 'Ping' }] = function()
            lib.pingLatency(function(status, latency)
                hs.alert('Ping: ' .. status .. (latency and (' (' .. latency .. 'ms)') or ''))
            end)
        end,
        [{ '', 'b', 'bundleID' }] = function()
            hs.pasteboard.setContents(
                hs.window.focusedWindow():application():bundleID())
        end,
    },
    appBindings = {
        c = 'com.microsoft.VSCode',
        -- window bindings
        r = { 'com.microsoft.VSCode', {
                k = 'kubernetes',
            },
        },
    },
    appInputMethods = {
        -- Use unicode hex input instead of default US/UK keyboards which
        -- do not support OPT/ALT key shortcuts.
        ['com.googlecode.iterm2'] = 'com.apple.keylayout.UnicodeHexInput',
    }
    focusFollowsMouse = {
        ignoreOcclusionApps = {},
        ignoredApps = {},
    }
}
