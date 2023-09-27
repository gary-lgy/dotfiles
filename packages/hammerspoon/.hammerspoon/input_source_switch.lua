local module = {}

module.appInputSourceIDs = {}

module.start = function(appInputMethods)
    -- NOTE: when switching apps, hs.application.watcher reports 
    -- activation of the new app before deactivation of the previous app.
    -- Therefore, we can't rely on the deactivation signal to record the
    -- input source of the deactivated app because the input source may
    -- have already swithed to the one predefined for the new application.
    hs.keycodes.inputSourceChanged(function()
        local app = hs.application.frontmostApplication()
        if app == nil then
            return
        end
        local bundleID = app:bundleID()
        
        if appInputMethods[bundleID] ~= nil then
            -- no need to record all predefined applications
            return
        end

        module.appInputSourceIDs[bundleID] = hs.keycodes.currentSourceID()
    end)

    module.appWatcher = hs.application.watcher.new(function(_, eventType, app)
        if app == nil or eventType ~= hs.application.watcher.activated then
            return
        end

        local bundleID = app:bundleID()
        local predefinedSourceID = appInputMethods[bundleID]

        if predefinedSourceID ~= nil then
            -- if a predefined source ID exists, use it
            hs.keycodes.currentSourceID(predefinedSourceID)
            return
        end

        -- otherwise, use the last recorded source ID
        local lastSourceID = module.appInputSourceIDs[bundleID]
        if lastSourceID ~= nil then
            hs.keycodes.currentSourceID(lastSourceID)
        end
    end):start()
end

return module
