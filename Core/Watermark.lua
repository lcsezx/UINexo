local Watermark = {}
Watermark.__index = Watermark

function Watermark.new(text, position)
    local self = setmetatable({}, Watermark)
    
    position = position or "BottomRight"
    
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "NexoUI_Watermark"
    self.Gui.Parent = game:GetService("CoreGui")
    self.Gui.IgnoreGuiInset = true
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = text or "NexoUI | By @user"
    self.Label.Size = UDim2.new(0, 200, 0, 30)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = Color3.fromRGB(255,255,255)
    self.Label.TextTransparency = 0.5
    self.Label.TextSize = 12
    self.Label.Font = Enum.Font.Gotham
    self.Label.Parent = self.Gui
    
    if position == "TopLeft" then
        self.Label.Position = UDim2.new(0, 10, 0, 10)
        self.Label.TextXAlignment = Enum.TextXAlignment.Left
    elseif position == "TopRight" then
        self.Label.Position = UDim2.new(1, -210, 0, 10)
        self.Label.TextXAlignment = Enum.TextXAlignment.Right
    elseif position == "BottomLeft" then
        self.Label.Position = UDim2.new(0, 10, 1, -40)
        self.Label.TextXAlignment = Enum.TextXAlignment.Left
    else -- BottomRight
        self.Label.Position = UDim2.new(1, -210, 1, -40)
        self.Label.TextXAlignment = Enum.TextXAlignment.Right
    end
    
    return self
end

function Watermark:SetText(text)
    self.Label.Text = text
end

function Watermark:SetPosition(position)
    if position == "TopLeft" then
        self.Label.Position = UDim2.new(0, 10, 0, 10)
        self.Label.TextXAlignment = Enum.TextXAlignment.Left
    elseif position == "TopRight" then
        self.Label.Position = UDim2.new(1, -210, 0, 10)
        self.Label.TextXAlignment = Enum.TextXAlignment.Right
    elseif position == "BottomLeft" then
        self.Label.Position = UDim2.new(0, 10, 1, -40)
        self.Label.TextXAlignment = Enum.TextXAlignment.Left
    else
        self.Label.Position = UDim2.new(1, -210, 1, -40)
        self.Label.TextXAlignment = Enum.TextXAlignment.Right
    end
end

return Watermark
