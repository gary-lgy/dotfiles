local module = {}

function module.start()
    if module._menuBarIcon ~= nil then
        return
    end

    local menuBarIcon = hs.menubar.new(true)
    module._menuBarIcon = menubarIcon
    module.timer = hs.timer.doEvery(0.5, function()
        if hs.eventtap.isSecureInputEnabled() and not menuBarIcon:isInMenuBar() then
            menuBarIcon:returnToMenuBar()
            menuBarIcon:setTitle('⚠️')
            menuBarIcon:setMenu({
                    { title = 'Secure input is enabled!', disabled = true }
                })
        elseif not hs.eventtap.isSecureInputEnabled() and menuBarIcon:isInMenuBar() then
            menuBarIcon:removeFromMenuBar()
        end
    end)
end

return module
