local Checkbox = {}
Checkbox.__index = Checkbox

local TweenService = game:GetService("TweenService")

function Checkbox.new(parent, config)
    local self = setmetatable({}, Checkbox)
    
    self.Parent = parent
    self.Text = config.Text or "Checkbox"
    self.State = config.Default or false
    self.Callback = config.Callback or function() end
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 35)
    self.Frame.BackgroundTransparency = 1
    self.Frame.Parent = parent.Content
    
    self.CheckFrame = Instance.new("Frame")
    self.CheckFrame.Size = UDim2.new(0, 20, 0, 20)
    self.CheckFrame.Position = UDim2.new(0, 5, 0.5, -10)
    self.CheckFrame.BackgroundColor3 = self.State and parent.Window.Theme.Primary or Color3.fromRGB(40, 40, 60)
    self.CheckFrame.BackgroundTransparency = self.State and 0.2 or 0.5
    self.CheckFrame.BorderSizePixel = 0
    self.CheckFrame.Parent = self.Frame
    
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 4)
    checkCorner.Parent = self.CheckFrame
    
    self.CheckMark = Instance.new("TextLabel")
    self.CheckMark.Text = "✓"
    self.CheckMark.Size = UDim2.new(1, 0, 1, 0)
    self.CheckMark.BackgroundTransparency = 1
    self.CheckMark.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CheckMark.TextSize = 16
    self.CheckMark.Visible = self.State
    self.CheckMark.Parent = self.CheckFrame
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text
    self.Label.Size = UDim2.new(1, -35, 1, 0)
    self.Label.Position = UDim2.new(0, 30, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = parent.Window.Theme.Text
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextSize = 14
    self.Label.Parent = self.Frame
    
    self.Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:Toggle()
        end
    end)
    
    return self
end

function Checkbox:Toggle()
    self.State = not self.State
    
    local targetColor = self.State and self.Parent.Window.Theme.Primary or Color3.fromRGB(40, 40, 60)
    local targetTrans = self.State and 0.2 or 0.5
    
    local tween = TweenService:Create(self.CheckFrame, TweenInfo.new(0.1, Enum.EasingStyle.Out), {
        BackgroundColor3 = targetColor,
        BackgroundTransparency = targetTrans
    })
    tween:Play()
    
    self.CheckMark.Visible = self.State
    
    if self.Callback then
        self.Callback(self.State)
    end
end

return Checkbox
