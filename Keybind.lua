local Keybind = {}
Keybind.__index = Keybind

local UserInputService = game:GetService("UserInputService")

function Keybind.new(parent, config)
    local self = setmetatable({}, Keybind)
    
    self.Parent = parent
    self.Text = config.Text or "Keybind"
    self.Key = config.Default or "None"
    self.Callback = config.Callback or function() end
    self.Listening = false
    
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
    
    self.KeyFrame = Instance.new("Frame")
    self.KeyFrame.Size = UDim2.new(0, 80, 1, 0)
    self.KeyFrame.Position = UDim2.new(0.6, 0, 0, 0)
    self.KeyFrame.BackgroundColor3 = parent.Window.Theme.Secondary
    self.KeyFrame.BackgroundTransparency = 0.2
    self.KeyFrame.BorderSizePixel = 0
    self.KeyFrame.Parent = self.Frame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = self.KeyFrame
    
    self.KeyLabel = Instance.new("TextLabel")
    self.KeyLabel.Text = self.Key
    self.KeyLabel.Size = UDim2.new(1, 0, 1, 0)
    self.KeyLabel.BackgroundTransparency = 1
    self.KeyLabel.TextColor3 = parent.Window.Theme.Text
    self.KeyLabel.TextSize = 13
    self.KeyLabel.Font = Enum.Font.Gotham
    self.KeyLabel.Parent = self.KeyFrame
    
    self.KeyFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:StartListening()
        end
    end)
    
    -- Escutar tecla global
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if not self.Listening then
            if input.KeyCode.Name == self.Key then
                if self.Callback then
                    self.Callback(self.Key)
                end
            end
        end
    end)
    
    return self
end

function Keybind:StartListening()
    self.Listening = true
    self.KeyLabel.Text = "..."
    self.KeyLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    local connection
    connection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.UserInputType == Enum.UserInputType.Keyboard then
            self.Key = input.KeyCode.Name
            self.KeyLabel.Text = self.Key
            self.KeyLabel.TextColor3 = self.Parent.Window.Theme.Text
            self.Listening = false
            connection:Disconnect()
        end
    end)
    
    task.wait(5)
    if self.Listening then
        self.Listening = false
        self.KeyLabel.Text = self.Key
        self.KeyLabel.TextColor3 = self.Parent.Window.Theme.Text
        if connection then
            connection:Disconnect()
        end
    end
end

return Keybind
