local Slider = {}
Slider.__index = Slider

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Slider.new(parent, config)
    local self = setmetatable({}, Slider)
    
    self.Parent = parent
    self.Text = config.Text or "Slider"
    self.Min = config.Min or 0
    self.Max = config.Max or 100
    self.Value = config.Default or 50
    self.Callback = config.Callback or function() end
    
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(1, -20, 0, 55)
    self.Frame.BackgroundTransparency = 1
    self.Frame.Parent = parent.Content
    
    self.Label = Instance.new("TextLabel")
    self.Label.Text = self.Text .. ": " .. math.floor(self.Value)
    self.Label.Size = UDim2.new(1, -10, 0, 20)
    self.Label.Position = UDim2.new(0, 5, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = parent.Window.Theme.Text
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextSize = 14
    self.Label.Parent = self.Frame
    
    self.SliderFrame = Instance.new("Frame")
    self.SliderFrame.Size = UDim2.new(1, -60, 0, 4)
    self.SliderFrame.Position = UDim2.new(0, 5, 0, 30)
    self.SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    self.SliderFrame.BorderSizePixel = 0
    self.SliderFrame.Parent = self.Frame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = self.SliderFrame
    
    self.Fill = Instance.new("Frame")
    self.Fill.Size = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), 0, 1, 0)
    self.Fill.BackgroundColor3 = parent.Window.Theme.Primary
    self.Fill.BorderSizePixel = 0
    self.Fill.Parent = self.SliderFrame
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = self.Fill
    
    self.Knob = Instance.new("Frame")
    self.Knob.Size = UDim2.new(0, 12, 0, 12)
    self.Knob.Position = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), -6, 0.5, -6)
    self.Knob.BackgroundColor3 = parent.Window.Theme.Primary
    self.Knob.BorderSizePixel = 0
    self.Knob.Parent = self.SliderFrame
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = self.Knob
    
    local dragging = false
    
    local function updateValue(inputPos)
        local relativePos = math.clamp((inputPos.X - self.SliderFrame.AbsolutePosition.X) / self.SliderFrame.AbsoluteSize.X, 0, 1)
        self.Value = self.Min + (relativePos * (self.Max - self.Min))
        self.Value = math.floor(self.Value)
        
        self.Fill.Size = UDim2.new(relativePos, 0, 1, 0)
        self.Knob.Position = UDim2.new(relativePos, -6, 0.5, -6)
        self.Label.Text = self.Text .. ": " .. self.Value
        
        if self.Callback then
            self.Callback(self.Value)
        end
    end
    
    self.Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position)
        end
    end)
    
    self.SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateValue(input.Position)
            dragging = true
        end
    end)
    
    return self
end

function Slider:SetValue(value)
    self.Value = math.clamp(value, self.Min, self.Max)
    local relativePos = (self.Value - self.Min) / (self.Max - self.Min)
    self.Fill.Size = UDim2.new(relativePos, 0, 1, 0)
    self.Knob.Position = UDim2.new(relativePos, -6, 0.5, -6)
    self.Label.Text = self.Text .. ": " .. math.floor(self.Value)
    if self.Callback then
        self.Callback(self.Value)
    end
end

return Slider
