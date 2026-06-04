local SettingsManager = {}

local Settings = {}

function SettingsManager:Save(key, value)
    Settings[key] = value
    return true
end

function SettingsManager:Load(key)
    return Settings[key]
end

function SettingsManager:Delete(key)
    Settings[key] = nil
end

function SettingsManager:Clear()
    Settings = {}
end

return SettingsManager
