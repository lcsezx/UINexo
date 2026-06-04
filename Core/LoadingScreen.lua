local Notification = {}
Notification.__index = Notification

local TweenService = game:GetService("TweenService")

function Notification.new(title, description, duration, color)
    local self = setmetatable({}, Notification)
    
    duration = duration or 3
    color = color or Color3.fromRGB(0, 200, 255)
    
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "NexoUI_Notification"
    self.Gui.Parent = game:GetService("CoreGui")
    self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(0, 300, 0, 70)
    self.Frame.Position = UDim2.new(1, 10, 0, 10)
    self.Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    self.Frame.BackgroundTransparency = 0.1
    self.Frame.BorderSizePixel = 0
    self.Frame.Parent = self.Gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Frame
    
    local border = Instance.new("UIStroke")
    border.Color = color
    border.Thickness = 2
    border.Transparency = 0.5
    border.Parent = self.Frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.Parent = self.Frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Text = description
    descLabel.Size = UDim2.new(1, -20, 0, 30)
    descLabel.Position = UDim2.new(0, 10, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 12
    descLabel.Parent = self.Frame
    
    -- Animação de entrada
    self.Frame.Position = UDim2.new(1, 320, 0, 10)
    local tweenIn = TweenService:Create(self.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Out, Enum.EasingDirection.Quad), {
        Position = UDim2.new(1, -310, 0, 10)
    })
    tweenIn:Play()
    
    -- Auto destruir
    task.wait(duration)
    
    local tweenOut = TweenService:Create(self.Frame, TweenInfo.new(0.3, Enum.EasingStyle.In, Enum.EasingDirection.Quad), {
        Position = UDim2.new(1, 320, 0, 10)
    })
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        self.Gui:Destroy()
    end)
    
    return self
end

return Notification
