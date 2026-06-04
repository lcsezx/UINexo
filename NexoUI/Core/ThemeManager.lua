local ThemeManager = {}

-- Temas padrão
local Themes = {
    Cyber = {
        Primary = Color3.fromRGB(0, 200, 255),
        Secondary = Color3.fromRGB(20, 25, 45),
        Background = Color3.fromRGB(10, 12, 25),
        Text = Color3.fromRGB(255, 255, 255),
        Border = Color3.fromRGB(0, 200, 255)
    },
    Nebula = {
        Primary = Color3.fromRGB(189, 0, 255),
        Secondary = Color3.fromRGB(30, 20, 45),
        Background = Color3.fromRGB(15, 10, 25),
        Text = Color3.fromRGB(255, 255, 255),
        Border = Color3.fromRGB(189, 0, 255)
    },
    Crystal = {
        Primary = Color3.fromRGB(100, 200, 255),
        Secondary = Color3.fromRGB(30, 40, 60),
        Background = Color3.fromRGB(20, 25, 40),
        Text = Color3.fromRGB(255, 255, 255),
        Border = Color3.fromRGB(150, 220, 255)
    },
    Dark = {
        Primary = Color3.fromRGB(80, 80, 100),
        Secondary = Color3.fromRGB(30, 30, 40),
        Background = Color3.fromRGB(20, 20, 30),
        Text = Color3.fromRGB(255, 255, 255),
        Border = Color3.fromRGB(60, 60, 80)
    }
}

function ThemeManager.get(name)
    return Themes[name] or Themes.Cyber
end

function ThemeManager.register(name, theme)
    Themes[name] = theme
end

function ThemeManager.getColor(themeName, colorName)
    local theme = Themes[themeName] or Themes.Cyber
    return theme[colorName] or Color3.fromRGB(255,255,255)
end

return ThemeManager
