local Nexo = loadstring(game:HttpGet("https://raw.githubusercontent.com/lcsezx/UINexo/main/Init.lua"))()

local Janela = Nexo:CreateWindow({
    Title = "Meu Hub",
    Subtitle = "By @usuario",
    Size = {600, 450},
    Theme = "Cyber",
    Loading = true,
    Watermark = true,
    Draggable = true
})

local AbaPrincipal = Janela:CreateTab("Principal")
local Secao = AbaPrincipal:CreateSection("Configurações")

Secao:Label("Bem-vindo ao NexoUI")

Secao:Button("Clique aqui", function()
    Nexo:Notify("Título", "Você clicou no botão!", 3)
end)

local toggleValue = false
Secao:Toggle("Ativar função", false, function(v)
    toggleValue = v
    print("Toggle:", v)
end)

Secao:Slider("Velocidade", 0, 100, 50, function(v)
    print("Slider:", v)
end)

Secao:Dropdown("Opções", {"Opção 1", "Opção 2", "Opção 3"}, "Opção 1", function(v)
    print("Dropdown:", v)
end)

Secao:ColorPicker("Cor", Color3.fromRGB(255,0,0), function(c)
    print("Cor:", c)
end)

Secao:Keybind("Tecla de atalho", "Q", function(k)
    print("Tecla pressionada:", k)
end)

Secao:Textbox("Nome da configuração", function(t)
    print("Texto:", t)
end)

Secao:Checkbox("Opção extra", false, function(v)
    print("Checkbox:", v)
end)
