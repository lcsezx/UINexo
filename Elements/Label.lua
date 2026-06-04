local Label = {}
Label.__index = Label

function Label.new(parent, config)
    local self = setmetatable({}, Label)
    
    self.Parent = parent
    self.Text = config.Text or ""
    self.Color = config.Color or parent.Window.Theme.Text
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 30)
    self.Frame.BackgroundTransparency = 1
    self.Frame.Parent = parent.Content
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text
    self.Label.Size = UDim2.new(1, -10, 1, 0)
    self.Label.Position = UDim2.new(0, 5, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = self.Color
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextSize = 13
    self.Label.Parent = self.Frame
    
    return self
end

return Label
