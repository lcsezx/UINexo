local Window = {}
Window.__index = Window

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ThemeManager = require(script.Parent.ThemeManager)
local FloatingIcon = require(script.Parent.FloatingIcon)
local Watermark = require(script.Parent.Watermark)

function Window.new(config)
    local self = setmetatable({}, Window)
    
    -- Configurações
    self.Title = config.Title or "NexoUI"
    self.Subtitle = config.Subtitle or ""
    self.Size = config.Size or {600, 450}
    self.ThemeName = config.Theme or "Cyber"
    self.Draggable = config.Draggable ~= false
    self.Resizable = config.Resizable ~= false
    self.Minimized = false
    self.Closed = false
    
    -- Tema
    self.Theme = ThemeManager.get(self.ThemeName)
    
    -- Criar GUI
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "NexoUI"
    self.Gui.Parent = game:GetService("CoreGui")
    self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    self.Main = Instance.new("Frame")
    self.Main.Size = UDim2.new(0, self.Size[1], 0, self.Size[2])
    self.Main.Position = UDim2.new(0.5, -self.Size[1]/2, 0.5, -self.Size[2]/2)
    self.Main.BackgroundColor3 = self.Theme.Background
    self.Main.BackgroundTransparency = 0.05
    self.Main.BorderSizePixel = 0
    self.Main.ClipsDescendants = true
    self.Main.Parent = self.Gui
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.Main
    
    -- Shadow
    local shadow = Instance.new("UIShadow")
    shadow.Parent = self.Main
    
    -- Title Bar
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    self.TitleBar.BackgroundColor3 = self.Theme.Secondary
    self.TitleBar.BackgroundTransparency = 0.1
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Parent = self.Main
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = self.TitleBar
    
    -- Title Label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Text = self.Title
    self.TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.TextColor3 = self.Theme.Text
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextSize = 16
    self.TitleLabel.Parent = self.TitleBar
    
    -- Subtitle Label
    if self.Subtitle ~= "" then
        self.SubtitleLabel = Instance.new("TextLabel")
        self.SubtitleLabel.Text = self.Subtitle
        self.SubtitleLabel.Size = UDim2.new(0, 200, 1, 0)
        self.SubtitleLabel.Position = UDim2.new(0, 15, 0, 20)
        self.SubtitleLabel.BackgroundTransparency = 1
        self.SubtitleLabel.TextColor3 = self.Theme.Text
        self.SubtitleLabel.TextColor3 = Color3.fromRGB(150,150,170)
        self.SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        self.SubtitleLabel.Font = Enum.Font.Gotham
        self.SubtitleLabel.TextSize = 11
        self.SubtitleLabel.Parent = self.TitleBar
    end
    
    -- Minimize Button
    self.MinimizeBtn = Instance.new("TextButton")
    self.MinimizeBtn.Text = "—"
    self.MinimizeBtn.Size = UDim2.new(0, 40, 1, 0)
    self.MinimizeBtn.Position = UDim2.new(1, -100, 0, 0)
    self.MinimizeBtn.BackgroundTransparency = 1
    self.MinimizeBtn.TextColor3 = self.Theme.Text
    self.MinimizeBtn.TextSize = 20
    self.MinimizeBtn.Font = Enum.Font.Gotham
    self.MinimizeBtn.Parent = self.TitleBar
    
    -- Maximize Button
    self.MaximizeBtn = Instance.new("TextButton")
    self.MaximizeBtn.Text = "□"
    self.MaximizeBtn.Size = UDim2.new(0, 40, 1, 0)
    self.MaximizeBtn.Position = UDim2.new(1, -60, 0, 0)
    self.MaximizeBtn.BackgroundTransparency = 1
    self.MaximizeBtn.TextColor3 = self.Theme.Text
    self.MaximizeBtn.TextSize = 20
    self.MaximizeBtn.Font = Enum.Font.Gotham
    self.MaximizeBtn.Parent = self.TitleBar
    
    -- Close Button
    self.CloseBtn = Instance.new("TextButton")
    self.CloseBtn.Text = "✕"
    self.CloseBtn.Size = UDim2.new(0, 40, 1, 0)
    self.CloseBtn.Position = UDim2.new(1, -20, 0, 0)
    self.CloseBtn.BackgroundTransparency = 1
    self.CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    self.CloseBtn.TextSize = 18
    self.CloseBtn.Font = Enum.Font.Gotham
    self.CloseBtn.Parent = self.TitleBar
    
    -- Container para abas
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Size = UDim2.new(0, 150, 1, -40)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 40)
    self.TabContainer.BackgroundColor3 = self.Theme.Secondary
    self.TabContainer.BackgroundTransparency = 0.05
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Parent = self.Main
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 0)
    tabCorner.Parent = self.TabContainer
    
    -- Container para conteúdo
    self.ContentContainer = Instance.new("Frame")
    self.ContentContainer.Size = UDim2.new(1, -150, 1, -40)
    self.ContentContainer.Position = UDim2.new(0, 150, 0, 40)
    self.ContentContainer.BackgroundTransparency = 1
    self.ContentContainer.Parent = self.Main
    
    -- ScrollingFrame para abas
    self.TabScroller = Instance.new("ScrollingFrame")
    self.TabScroller.Size = UDim2.new(1, 0, 1, 0)
    self.TabScroller.BackgroundTransparency = 1
    self.TabScroller.BorderSizePixel = 0
    self.TabScroller.ScrollBarThickness = 3
    self.TabScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.TabScroller.Parent = self.TabContainer
    
    self.TabList = Instance.new("UIListLayout")
    self.TabList.Padding = UDim.new(0, 5)
    self.TabList.Parent = self.TabScroller
    
    -- Variáveis
    self.Tabs = {}
    self.CurrentTab = nil
    self.TabButtons = {}
    
    -- Arrastar
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Draggable then
            dragging = true
            dragStart = input.Position
            startPos = self.Main.Position
        end
    end)
    
    self.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            self.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    -- Botões
    self.MinimizeBtn.MouseButton1Click:Connect(function()
        self:Minimize()
    end)
    
    self.MaximizeBtn.MouseButton1Click:Connect(function()
        if self.Minimized then
            self:Restore()
        else
            self:Minimize()
        end
    end)
    
    self.CloseBtn.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    -- Watermark
    if config.Watermark ~= false then
        Watermark.new(config.WatermarkText or "NexoUI | By @user")
    end
    
    -- Floating Icon
    self.FloatingIcon = FloatingIcon.new({
        Color = self.Theme.Primary,
        Callback = function()
            if self.Closed then
                self:Open()
            elseif self.Minimized then
                self:Restore()
            else
                self:Close()
            end
        end
    })
    
    if config.StartClosed then
        self:Close()
    end
    
    return self
end

function Window:CreateTab(name, icon)
    local Tab = {}
    Tab.Name = name
    Tab.Icon = icon or ""
    Tab.Window = self
    Tab.Sections = {}
    Tab.NextY = 10
    
    -- Botão da aba
    local btn = Instance.new("TextButton")
    btn.Text = (icon ~= "" and icon .. " " or "") .. name
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, #self.Tabs * 45 + 10)
    btn.BackgroundColor3 = self.Theme.Primary
    btn.BackgroundTransparency = 0.8
    btn.BorderSizePixel = 0
    btn.TextColor3 = self.Theme.Text
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.Parent = self.TabScroller
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Container da aba
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -10)
    container.Position = UDim2.new(0, 10, 0, 5)
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = self.ContentContainer
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = scroll
    
    Tab.Container = scroll
    Tab.Button = btn
    Tab.Layout = layout
    
    btn.MouseButton1Click:Connect(function()
        self:SelectTab(Tab)
    end)
    
    function Tab:CreateSection(title)
        local Section = {}
        Section.Title = title
        Section.Tab = Tab
        Section.Elements = {}
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 0)
        frame.BackgroundColor3 = self.Window.Theme.Secondary
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Parent = Tab.Container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Text = title
        titleLabel.Size = UDim2.new(1, -20, 0, 30)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = self.Window.Theme.Text
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 14
        titleLabel.Parent = frame
        
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, -20, 0, 1)
        line.Position = UDim2.new(0, 10, 0, 35)
        line.BackgroundColor3 = self.Window.Theme.Primary
        line.BackgroundTransparency = 0.5
        line.BorderSizePixel = 0
        line.Parent = frame
        
        local content = Instance.new("Frame")
        content.Size = UDim2.new(1, 0, 0, 0)
        content.Position = UDim2.new(0, 0, 0, 45)
        content.BackgroundTransparency = 1
        content.Parent = frame
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Padding = UDim.new(0, 8)
        contentLayout.Parent = content
        
        Section.Frame = frame
        Section.Content = content
        Section.Layout = contentLayout
        Section.NextY = 0
        
        function Section:AddElement(elementType, elementConfig)
            local Element = require(script.Parent.Parent.Elements[elementType])
            local elem = Element.new(self, elementConfig)
            table.insert(Section.Elements, elem)
            
            -- Atualizar altura da section
            local totalHeight = 45 + (#Section.Elements * 45)
            frame.Size = UDim2.new(1, 0, 0, totalHeight)
            
            -- Atualizar canvas do scroll
            task.wait()
            Tab.Container.CanvasSize = UDim2.new(0, 0, 0, Tab.Layout.AbsoluteContentSize.Y + 20)
            
            return elem
        end
        
        function Section:Label(text, color)
            return self:AddElement("Label", {Text = text, Color = color})
        end
        
        function Section:Button(text, callback)
            return self:AddElement("Button", {Text = text, Callback = callback})
        end
        
        function Section:Toggle(text, default, callback)
            return self:AddElement("Toggle", {Text = text, Default = default, Callback = callback})
        end
        
        function Section:Slider(text, min, max, default, callback)
            return self:AddElement("Slider", {Text = text, Min = min, Max = max, Default = default, Callback = callback})
        end
        
        function Section:Dropdown(text, options, default, callback)
            return self:AddElement("Dropdown", {Text = text, Options = options, Default = default, Callback = callback})
        end
        
        function Section:ColorPicker(text, default, callback)
            return self:AddElement("ColorPicker", {Text = text, Default = default, Callback = callback})
        end
        
        function Section:Keybind(text, default, callback)
            return self:AddElement("Keybind", {Text = text, Default = default, Callback = callback})
        end
        
        function Section:Textbox(text, callback)
            return self:AddElement("Textbox", {Text = text, Callback = callback})
        end
        
        function Section:Checkbox(text, default, callback)
            return self:AddElement("Checkbox", {Text = text, Default = default, Callback = callback})
        end
        
        return Section
    end
    
    function Tab:Select()
        if self.Window.CurrentTab then
            self.Window.CurrentTab.Container.Visible = false
            self.Window.CurrentTab.Button.BackgroundTransparency = 0.8
        end
        self.Container.Visible = true
        self.Button.BackgroundTransparency = 0.3
        self.Window.CurrentTab = self
    end
    
    table.insert(self.Tabs, Tab)
    
    -- Atualizar canvas do scroller
    task.wait()
    self.TabScroller.CanvasSize = UDim2.new(0, 0, 0, #self.Tabs * 45 + 20)
    
    if not self.CurrentTab then
        self:SelectTab(Tab)
    end
    
    return Tab
end

function Window:SelectTab(tab)
    if self.CurrentTab then
        self.CurrentTab.Container.Visible = false
        self.CurrentTab.Button.BackgroundTransparency = 0.8
    end
    tab.Container.Visible = true
    tab.Button.BackgroundTransparency = 0.3
    self.CurrentTab = tab
end

function Window:Minimize()
    self.Minimized = true
    self.Main.Visible = false
end

function Window:Restore()
    self.Minimized = false
    self.Closed = false
    self.Main.Visible = true
end

function Window:Close()
    self.Closed = true
    self.Main.Visible = false
    if self.FloatingIcon then
        self.FloatingIcon:Show()
    end
end

function Window:Open()
    self.Closed = false
    self.Minimized = false
    self.Main.Visible = true
    if self.FloatingIcon then
        self.FloatingIcon:Hide()
    end
end

function Window:Toggle()
    if self.Main.Visible then
        self:Close()
    else
        self:Open()
    end
end

function Window:Hide()
    self.Main.Visible = false
end

function Window:Show()
    self.Main.Visible = true
end

function Window:SetTitle(title)
    self.Title = title
    self.TitleLabel.Text = title
end

function Window:SetSubtitle(subtitle)
    self.Subtitle = subtitle
    if self.SubtitleLabel then
        self.SubtitleLabel.Text = subtitle
    end
end

function Window:SetSize(width, height)
    self.Size = {width, height}
    self.Main.Size = UDim2.new(0, width, 0, height)
    self.Main.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
end

function Window:SetTheme(themeName)
    self.ThemeName = themeName
    self.Theme = ThemeManager.get(themeName)
    self.Main.BackgroundColor3 = self.Theme.Background
    self.TitleBar.BackgroundColor3 = self.Theme.Secondary
    self.TitleLabel.TextColor3 = self.Theme.Text
    self.TabContainer.BackgroundColor3 = self.Theme.Secondary
    if self.FloatingIcon then
        self.FloatingIcon:SetColor(self.Theme.Primary)
    end
end

function Window:SetDraggable(enabled)
    self.Draggable = enabled
end

return Window
