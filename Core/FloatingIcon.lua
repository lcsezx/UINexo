local FloatingIcon = {}
FloatingIcon.__index = FloatingIcon

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function FloatingIcon.new(config)
    local self = setmetatable({}, FloatingIcon)
    
    self.Callback = config.Callback
    self.Color = config.Color or Color3.fromRGB(0, 200, 255)
    self.Position = config.Position or {50, 50}
    self.Visible = true
    
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "NexoUI_FloatingIcon"
    self.Gui.Parent = game:GetService("CoreGui")
    self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    self.Button = Instance.new("ImageButton")
    self.Button.Size = UDim2.new(0, 50, 0, 50)
    self.Button.Position = UDim2.new(0, self.Position[1], 0, self.Position[2])
    self.Button.BackgroundColor3 = self.Color
    self.Button.BackgroundTransparency = 0.2
    self.Button.BorderSizePixel = 0
    self.Button.Image = "rbxassetid://6031094773"
    self.Button.ImageColor3 = Color3.fromRGB(255,255,255)
    self.Button.Parent = self.Gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = self.Button
    
    local shadow = Instance.new("UIShadow")
    shadow.Parent = self.Button
    
    -- Efeito pulsante
    local tween = TweenService:Create(self.Button, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundTransparency = 0.05
    })
    tween:Play()
    
    -- Arrastar
    local dragging = false
    local dragStart
    local startPos
    
    self.Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.Button.Position
        end
    end)
    
    self.Button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            -- Salvar posição
            task.spawn(function()
                local settings = require(script.Parent.SettingsManager)
                settings:Save("IconPosition", {self.Button.Position.X.Offset, self.Button.Position.Y.Offset})
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            self.Button.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
        end
    end)
    
    self.Button.MouseButton1Click:Connect(function()
        if self.Callback then
            self.Callback()
        end
    end)
    
    -- Carregar posição salva
    task.spawn(function()
        local settings = require(script.Parent.SettingsManager)
        local savedPos = settings:Load("IconPosition")
        if savedPos then
            self.Button.Position = UDim2.new(0, savedPos[1], 0, savedPos[2])
        end
    end)
    
    return self
end

function FloatingIcon:Show()
    self.Visible = true
    self.Gui.Enabled = true
end

function FloatingIcon:Hide()
    self.Visible = false
    self.Gui.Enabled = false
end

function FloatingIcon:SetColor(color)
    self.Color = color
    self.Button.BackgroundColor3 = color
end

return FloatingIcon
