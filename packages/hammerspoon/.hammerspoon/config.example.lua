return {
    snippetBindings = {
        [{ '', 'd', 'Date' }] = function() return os.date('%d %B %Y', os.time()) end,
    },
    appBindings = {
        c = 'com.microsoft.VSCode',
    },
}
