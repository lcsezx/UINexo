local Textbox = {}
Textbox.__index = Textbox

function Textbox.new(parent, config)
    local self = setmetatable({}, Textbox)
    
    self.Parent = parent
    self.Text = config.Text or "Textbox"
    self.Placeholder = config.Placeholder or "Digite..."
    self.Callback = config.Callback or function() end
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 35)
    self.Frame.BackgroundTransparency = 1
    self.Frame.Parent = parent.Content
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text
    self.Label.Size = UDim2.new(0.4, -10, 1, 0)
    self.Label.Position = UDim2.new(0, 5, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = parent.Window.Theme.Text
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextSize = 14
    self.Label.Parent = self.Frame
    
    self.Box = Instance.new("TextBox")
    self.Box.Size = UDim2.new(0.5, 0, 1, 0)
    self.Box.Position = UDim2.new(0.5, 0, 0, 0)
    self.Box.PlaceholderText = self.Placeholder
    self.Box.BackgroundColor3 = parent.Window.Theme.Secondary
    self.Box.BackgroundTransparency = 0.2
    self.Box.BorderSizePixel = 0
    self.Box.TextColor3 = parent.Window.Theme.Text
    self.Box.TextSize = 13
    self.Box.Font = Enum.Font.Gotham
    self.Box.Parent = self.Frame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = self.Box
    
    self.Box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            if self.Callback then
                self.Callback(self.Box.Text)
            end
        end
    end)
    
    return self
end

return Textbox
