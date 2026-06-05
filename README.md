
# NexoUI

## Carregar

```lua
local Nexo = loadstring(game:HttpGet("https://github.com/lcsezx/UINexo/blob/main/init.lua"))()
```

## Criar Janela

```lua
local Janela = Nexo:CreateWindow({
    Title = "Meu Hub",
    Subtitle = "By @usuario",
    Size = {650, 500},
    Position = {100, 100},
    MinSize = {400, 300},
    MaxSize = {1000, 800},
    Resizable = true,
    Draggable = true,
    StartClosed = false,
    SavePosition = true,
    Minimizable = true,
    Maximizable = true,
    Closable = true,
    Loading = true,
    LoadingText = "Carregando...",
    LoadingColor = Color3.fromRGB(0, 200, 255),
    Watermark = true,
    WatermarkText = "NexoUI | By @usuario",
    WatermarkPosition = "BottomRight",
    WatermarkColor = Color3.fromRGB(150, 150, 150),
    FloatingIcon = true,
    FloatingIconColor = Color3.fromRGB(0, 200, 255),
    FloatingIconPosition = {50, 50},
    FloatingIconSavePosition = true,
    Theme = "Cyber"
})
```

## Criar Aba

```lua
local Aba = Janela:CreateTab("Principal")
```

## Criar Seção

```lua
local Secao = Aba:CreateSection("Configurações")
```

## Label

```lua
Secao:Label("Texto")
```

## Botão

```lua
Secao:Button("Clique", function()
    print("clicou")
end)
```

## Toggle

```lua
Secao:Toggle("Ligar", false, function(v)
    print(v)
end)
```

## Checkbox

```lua
Secao:Checkbox("Opção", false, function(v)
    print(v)
end)
```

## Slider

```lua
Secao:Slider("Valor", 0, 100, 50, function(v)
    print(v)
end)
```

## Dropdown

```lua
Secao:Dropdown("Selecione", {"A", "B", "C"}, "A", function(v)
    print(v)
end)
```

## ColorPicker

```lua
Secao:ColorPicker("Cor", Color3.fromRGB(255, 0, 0), function(c)
    print(c)
end)
```

## Keybind

```lua
Secao:Keybind("Tecla", "Q", function(k)
    print(k)
end)
```

## Textbox

```lua
Secao:Textbox("Digite", function(t)
    print(t)
end)
```

## Notificação

```lua
Nexo:Notify("Título", "Descrição", 3)
```

## Trocar Tema

```lua
Janela:SetTheme("Cyber")
Janela:SetTheme("Nebula")
Janela:SetTheme("Crystal")
```

## Mudar Título

```lua
Janela:SetTitle("Novo título")
Janela:SetSubtitle("Novo subtítulo")
```

## Mudar Tamanho

```lua
Janela:SetSize(800, 600)
```

## Travar Posição

```lua
Janela:SetDraggable(false)
```
