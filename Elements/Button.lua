local Button = {}
Button.__index = Button

local TweenService = game:GetService("TweenService")

function Button.new(parent, config)
    local self = setmetatable({}, Button)
    
    self.Parent = parent
    self.Text = config.Text or "Botão"
    self.Callback = config.Callback or function() end
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 35)
    self.Frame.BackgroundColor3 = parent.Window.Theme.Secondary
    self.Frame.BackgroundTransparency = 0.2
    self.Frame.BorderSizePixel = 0
    self.Frame.Parent = parent.Content
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.Frame
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text
    self.Label.Size = UDim2.new(1, 0, 1, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = parent.Window.Theme.Text
    self.Label.TextSize = 14
    self.Label.Font = Enum.Font.Gotham
    self.Label.Parent = self.Frame
    
    self.Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Efeito de clique
            local tween = TweenService:Create(self.Frame, TweenInfo.new(0.1, Enum.EasingStyle.Out), {
                BackgroundTransparency = 0.5
            })
            tween:Play()
            tween.Completed:Connect(function()
                local tween2 = TweenService:Create(self.Frame, TweenInfo.new(0.1, Enum.EasingStyle.Out), {
                    BackgroundTransparency = 0.2
                })
                tween2:Play()
            end)
            
            if self.Callback then
                self.Callback()
            end
        end
    end)
    
    return self
end

return Button
