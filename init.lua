local Nexo = {}

-- Carregar módulos
local Window = require(script.Core.Window)
local Notification = require(script.Core.Notification)
local LoadingScreen = require(script.Core.LoadingScreen)
local ThemeManager = require(script.Core.ThemeManager)

function Nexo:CreateWindow(config)
    if config.Loading ~= false then
        LoadingScreen:Show(config.LoadingText or "Carregando...")
        task.wait(0.3)
        local janela = Window.new(config)
        LoadingScreen:Hide()
        return janela
    end
    return Window.new(config)
end

function Nexo:Notify(title, desc, duration, color)
    return Notification.new(title, desc, duration, color)
end

function Nexo:GetTheme(name)
    return ThemeManager.get(name)
end

return Nexo
