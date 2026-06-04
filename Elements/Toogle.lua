local Toggle = {}
Toggle.__index = Toggle

local TweenService = game:GetService("TweenService")

function Toggle.new(parent, config)
    local self = setmetatable({}, Toggle)
    
    self.Parent = parent
    self.Text = config.Text or "Toggle"
    self.State = config.Default or false
    self.Callback = config.Callback or function() end
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 35)
    self.Frame.BackgroundTransparency = 1
    self.Frame.Parent = parent.Content
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text
    self.Label.Size = UDim2.new(1, -60, 1, 0)
    self.Label.Position = UDim2.new(0, 5, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = parent.Window.Theme.Text
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextSize = 14
    self.Label.Parent = self.Frame
    
    self.ToggleFrame = Instance.new("Frame")
    self.ToggleFrame.Size = UDim2.new(0, 40, 0, 20)
    self.ToggleFrame.Position = UDim2.new(1, -50, 0.5, -10)
    self.ToggleFrame.BackgroundColor3 = self.State and parent.Window.Theme.Primary or Color3.fromRGB(60, 60, 80)
    self.ToggleFrame.BackgroundTransparency = self.State and 0.2 or 0.5
    self.ToggleFrame.BorderSizePixel = 0
    self.ToggleFrame.Parent = self.Frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = self.ToggleFrame
    
    self.ToggleKnob = Instance.new("Frame")
    self.ToggleKnob.Size = UDim2.new(0, 16, 0, 16)
    self.ToggleKnob.Position = self.State and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    self.ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.ToggleKnob.BorderSizePixel = 0
    self.ToggleKnob.Parent = self.ToggleFrame
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = self.ToggleKnob
    
    self.Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:Toggle()
        end
    end)
    
    return self
end

function Toggle:Toggle()
    self.State = not self.State
    
    local targetColor = self.State and self.Parent.Window.Theme.Primary or Color3.fromRGB(60, 60, 80)
    local targetTrans = self.State and 0.2 or 0.5
    local targetPos = self.State and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    
    local tween1 = TweenService:Create(self.ToggleFrame, TweenInfo.new(0.15, Enum.EasingStyle.Out), {
        BackgroundColor3 = targetColor,
        BackgroundTransparency = targetTrans
    })
    tween1:Play()
    
    local tween2 = TweenService:Create(self.ToggleKnob, TweenInfo.new(0.15, Enum.EasingStyle.Out), {
        Position = targetPos
    })
    tween2:Play()
    
    if self.Callback then
        self.Callback(self.State)
    end
end

function Toggle:SetState(state)
    if self.State ~= state then
        self:Toggle()
    end
end

return Toggle
