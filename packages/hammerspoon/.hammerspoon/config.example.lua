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
    },
}
