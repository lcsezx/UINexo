local ColorPicker = {}
ColorPicker.__index = ColorPicker

local TweenService = game:GetService("TweenService")

function ColorPicker.new(parent, config)
    local self = setmetatable({}, ColorPicker)
    
    self.Parent = parent
    self.Text = config.Text or "ColorPicker"
    self.Color = config.Default or Color3.fromRGB(255, 0, 0)
    self.Callback = config.Callback or function() end
    self.Open = false
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 35)
    self.Frame.BackgroundTransparency = 1
    self.Frame.Parent = parent.Content
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text
    self.Label.Size = UDim2.new(0.5, -10, 1, 0)
    self.Label.Position = UDim2.new(0, 5, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = parent.Window.Theme.Text
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextSize = 14
    self.Label.Parent = self.Frame
    
    self.ColorBox = Instance.new("Frame")
    self.ColorBox.Size = UDim2.new(0, 40, 1, 0)
    self.ColorBox.Position = UDim2.new(0.6, 0, 0, 0)
    self.ColorBox.BackgroundColor3 = self.Color
    self.ColorBox.BorderSizePixel = 0
    self.ColorBox.Parent = self.Frame
    
    local colorCorner = Instance.new("UICorner")
    colorCorner.CornerRadius = UDim.new(0, 6)
    colorCorner.Parent = self.ColorBox
    
    self.PickerFrame = Instance.new("Frame")
    self.PickerFrame.Size = UDim2.new(0, 200, 0, 0)
    self.PickerFrame.Position = UDim2.new(0.6, -20, 0, 35)
    self.PickerFrame.BackgroundColor3 = parent.Window.Theme.Secondary
    self.PickerFrame.BackgroundTransparency = 0.05
    self.PickerFrame.BorderSizePixel = 0
    self.PickerFrame.ClipsDescendants = true
    self.PickerFrame.Visible = false
    self.PickerFrame.Parent = self.Frame
    
    local pickerCorner = Instance.new("UICorner")
    pickerCorner.CornerRadius = UDim.new(0, 8)
    pickerCorner.Parent = self.PickerFrame
    
    -- Simples seletor de cores com botões
    local colors = {
        Color3.fromRGB(255, 0, 0),     -- Vermelho
        Color3.fromRGB(0, 255, 0),     -- Verde
        Color3.fromRGB(0, 0, 255),     -- Azul
        Color3.fromRGB(255, 255, 0),   -- Amarelo
        Color3.fromRGB(255, 0, 255),   -- Rosa
        Color3.fromRGB(0, 255, 255),   -- Ciano
        Color3.fromRGB(255, 255, 255), -- Branco
        Color3.fromRGB(0, 0, 0),       -- Preto
        Color3.fromRGB(128, 0, 128),   -- Roxo
        Color3.fromRGB(255, 128, 0),   -- Laranja
    }
    
    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 40, 0, 40)
    grid.CellPadding = UDim2.new(0, 5, 0, 5)
    grid.Parent = self.PickerFrame
    
    for i, col in ipairs(colors) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 40, 0, 40)
        btn.BackgroundColor3 = col
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.Parent = self.PickerFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            self.Color = col
            self.ColorBox.BackgroundColor3 = col
            self:Toggle()
            if self.Callback then
                self.Callback(col)
            end
        end)
    end
    
    self.ColorBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:Toggle()
        end
    end)
    
    return self
end

function ColorPicker:Toggle()
    self.Open = not self.Open
    
    if self.Open then
        self.PickerFrame.Visible = true
        local tween = TweenService:Create(self.PickerFrame, TweenInfo.new(0.2, Enum.EasingStyle.Out), {
            Size = UDim2.new(0, 200, 0, 150)
        })
        tween:Play()
    else
        local tween = TweenService:Create(self.PickerFrame, TweenInfo.new(0.15, Enum.EasingStyle.In), {
            Size = UDim2.new(0, 200, 0, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            self.PickerFrame.Visible = false
        end)
    end
end

return ColorPicker
