local module = {}

function module.new(checkInterval, checkFn)
    local watcher = {
        checkInterval = checkInterval,
        checkFn = checkFn,
    }

    function watcher:start()
        if watcher._menuBarIcon ~= nil then
            -- already started
            return
        end

        local menuBarIcon = hs.menubar.new(true)
        watcher._menuBarIcon = menubarIcon
        watcher.timer = hs.timer.doEvery(watcher.checkInterval, function()
            local shouldWarn, title, menu = watcher.checkFn()
            if shouldWarn and not menuBarIcon:isInMenuBar() then
                menuBarIcon:returnToMenuBar()
                menuBarIcon:setTitle(title)
                menuBarIcon:setMenu(menu)
            elseif not shouldWarn and menuBarIcon:isInMenuBar() then
                menuBarIcon:removeFromMenuBar()
            end
        end)
    end

    return watcher
end

return module
