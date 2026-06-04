local Dropdown = {}
Dropdown.__index = Dropdown

local TweenService = game:GetService("TweenService")

function Dropdown.new(parent, config)
    local self = setmetatable({}, Dropdown)
    
    self.Parent = parent
    self.Text = config.Text or "Dropdown"
    self.Options = config.Options or {}
    self.Selected = config.Default or (self.Options[1] or "")
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
    
    self.SelectFrame = Instance.new("Frame")
    self.SelectFrame.Size = UDim2.new(0.4, 0, 1, 0)
    self.SelectFrame.Position = UDim2.new(0.6, 0, 0, 0)
    self.SelectFrame.BackgroundColor3 = parent.Window.Theme.Secondary
    self.SelectFrame.BackgroundTransparency = 0.2
    self.SelectFrame.BorderSizePixel = 0
    self.SelectFrame.Parent = self.Frame
    
    local selectCorner = Instance.new("UICorner")
    selectCorner.CornerRadius = UDim.new(0, 6)
    selectCorner.Parent = self.SelectFrame
    
    self.SelectLabel = Instance.new("TextLabel")
    self.SelectLabel.Text = self.Selected
    self.SelectLabel.Size = UDim2.new(1, -20, 1, 0)
    self.SelectLabel.Position = UDim2.new(0, 10, 0, 0)
    self.SelectLabel.BackgroundTransparency = 1
    self.SelectLabel.TextColor3 = parent.Window.Theme.Text
    self.SelectLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.SelectLabel.Font = Enum.Font.Gotham
    self.SelectLabel.TextSize = 13
    self.SelectLabel.Parent = self.SelectFrame
    
    self.Arrow = Instance.new("TextLabel")
    self.Arrow.Text = "▼"
    self.Arrow.Size = UDim2.new(0, 20, 1, 0)
    self.Arrow.Position = UDim2.new(1, -20, 0, 0)
    self.Arrow.BackgroundTransparency = 1
    self.Arrow.TextColor3 = parent.Window.Theme.Text
    self.Arrow.TextSize = 12
    self.Arrow.Parent = self.SelectFrame
    
    self.DropdownFrame = Instance.new("Frame")
    self.DropdownFrame.Size = UDim2.new(0.4, 0, 0, 0)
    self.DropdownFrame.Position = UDim2.new(0.6, 0, 0, 35)
    self.DropdownFrame.BackgroundColor3 = parent.Window.Theme.Secondary
    self.DropdownFrame.BackgroundTransparency = 0.05
    self.DropdownFrame.BorderSizePixel = 0
    self.DropdownFrame.ClipsDescendants = true
    self.DropdownFrame.Visible = false
    self.DropdownFrame.Parent = self.Frame
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = self.DropdownFrame
    
    self.DropdownList = Instance.new("ScrollingFrame")
    self.DropdownList.Size = UDim2.new(1, 0, 1, 0)
    self.DropdownList.BackgroundTransparency = 1
    self.DropdownList.BorderSizePixel = 0
    self.DropdownList.ScrollBarThickness = 3
    self.DropdownList.CanvasSize = UDim2.new(0, 0, 0, #self.Options * 30)
    self.DropdownList.Parent = self.DropdownFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = self.DropdownList
    
    self.OptionButtons = {}
    for i, opt in ipairs(self.Options) do
        local btn = Instance.new("TextButton")
        btn.Text = opt
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = parent.Window.Theme.Secondary
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 0
        btn.TextColor3 = parent.Window.Theme.Text
        btn.TextSize = 13
        btn.Font = Enum.Font.Gotham
        btn.Parent = self.DropdownList
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            self.Selected = opt
            self.SelectLabel.Text = opt
            self:Toggle()
            if self.Callback then
                self.Callback(opt)
            end
        end)
        
        table.insert(self.OptionButtons, btn)
    end
    
    self.SelectFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:Toggle()
        end
    end)
    
    return self
end

function Dropdown:Toggle()
    self.Open = not self.Open
    
    if self.Open then
        self.DropdownFrame.Visible = true
        local height = math.min(#self.Options * 32, 150)
        local tween = TweenService:Create(self.DropdownFrame, TweenInfo.new(0.2, Enum.EasingStyle.Out), {
            Size = UDim2.new(0.4, 0, 0, height)
        })
        tween:Play()
        self.Arrow.Text = "▲"
    else
        local tween = TweenService:Create(self.DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.In), {
            Size = UDim2.new(0.4, 0, 0, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            self.DropdownFrame.Visible = false
        end)
        self.Arrow.Text = "▼"
    end
end

return Dropdown
