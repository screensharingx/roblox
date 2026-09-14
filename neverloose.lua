local Library = {}
function Library:GetColor(color, table)
    table = table or false
    if (color.R == nil) then return Color3.fromRGB(19, 119, 255) end
    local ColorRed = math.round(color.R * 255)
    local ColorGreen = math.round(color.G * 255)
    local ColorBlue = math.round(color.B * 255)
    if (table) then
        return { Red = ColorRed, Green = ColorGreen, Blue = ColorBlue }
    else
        return Color3.fromRGB(ColorRed, ColorGreen, ColorBlue)
    end
end
function Library:GetSide(LeftSize, RightSize)
    if LeftSize - 1 > RightSize - 1 then return "Right"
    else return "Left" end
end
function Library:CreateWindow(title, color)
    title = title or "Bracket Lib V2"
    color = color and Library:GetColor(color) or Color3.fromRGB(19, 119, 255)
    local WinTypes = {}
    local WindowDragging, SliderDragging, ColorPickerDragging = false, false, false
    local oldcolor = nil
    local keybind = "RightShift"
    local cancbind = false
    local BracketV2 = Instance.new("ScreenGui")
    local core = Instance.new("Frame")
    local title_18 = Instance.new("TextLabel")
    local outlinecore = Instance.new("Frame")
    local inline = Instance.new("Frame")
    local inlineoutline = Instance.new("Frame")
    local inlinecore = Instance.new("Frame")
    local tabbar = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local container = Instance.new("Frame")
    BracketV2.Name = title
    BracketV2.Parent = game.CoreGui
    BracketV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    core.Name = "core"
    core.Parent = BracketV2
    core.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    core.BorderColor3 = Color3.fromRGB(8, 8, 8)
    core.Position = UDim2.new(0.156000003, 0, 0.140000001, 0)
    core.Size = UDim2.new(0, 540, 0, 531)
    outlinecore.Name = "outlinecore"
    outlinecore.Parent = core
    outlinecore.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    outlinecore.BorderSizePixel = 0
    outlinecore.Position = UDim2.new(0, 1, 0, 1)
    outlinecore.Size = UDim2.new(0, 538, 0, 529)
    title_18.Name = "title"
    title_18.Parent = outlinecore
    title_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title_18.BackgroundTransparency = 1.000
    title_18.Position = UDim2.new(0.0185185187, 0, 0.00188323914, 0)
    title_18.Size = UDim2.new(0, 521, 0, 23)
    title_18.Font = Enum.Font.SourceSans
    title_18.Text = title
    title_18.TextColor3 = Color3.fromRGB(255, 255, 255)
    title_18.TextSize = 18.000
    title_18.TextStrokeTransparency = 0.000
    title_18.TextXAlignment = Enum.TextXAlignment.Left
    inline.Name = "inline"
    inline.Parent = outlinecore
    inline.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    inline.BorderSizePixel = 0
    inline.Position = UDim2.new(0, 7, 0, 23)
    inline.Size = UDim2.new(0, 525, 0, 500)
    inlineoutline.Name = "inlineoutline"
    inlineoutline.Parent = inline
    inlineoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    inlineoutline.BorderSizePixel = 0
    inlineoutline.Position = UDim2.new(0, 1, 0, 1)
    inlineoutline.Size = UDim2.new(0, 523, 0, 498)
    inlinecore.Name = "inlinecore"
    inlinecore.Parent = inlineoutline
    inlinecore.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    inlinecore.BorderSizePixel = 0
    inlinecore.Position = UDim2.new(0, 1, 0, 1)
    inlinecore.Size = UDim2.new(0, 521, 0, 496)
    tabbar.Name = "tabbar"
    tabbar.Parent = inlinecore
    tabbar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    tabbar.BorderColor3 = Color3.fromRGB(8, 8, 8)
    tabbar.Size = UDim2.new(0, 521, 0, 25)
    UIListLayout.Parent = tabbar
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    container.Name = "container"
    container.Parent = inlinecore
    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    container.BackgroundTransparency = 1.000
    container.BorderSizePixel = 0
    container.Position = UDim2.new(0, 0, 0.0504032262, 0)
    container.Size = UDim2.new(1, 0, 0.949596763, 0)
    local userinputservice = game:GetService("UserInputService")
    local dragInput, dragStart, startPos = nil, nil, nil
    core.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
            dragStart = input.Position
            startPos = core.Position
            WindowDragging = true
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then WindowDragging = false end
            end)
        end
    end)
    core.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    userinputservice.InputChanged:Connect(function(input)
        if input == dragInput and WindowDragging and not SliderDragging and not ColorPickerDragging then
            local Delta = input.Position - dragStart
            core.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        end
    end)
    userinputservice.InputBegan:Connect(function(input)
        if (input.KeyCode == Enum.KeyCode[keybind]) then BracketV2.Enabled = not BracketV2.Enabled end
    end)
    function WinTypes:Destroy()
        BracketV2:Destroy()
    end
    function WinTypes:UpdateColor(newcolor)
        color = Library:GetColor(newcolor)
    end
    function WinTypes:UpdateBind(bind, custombind)
        keybind = bind
        cancbind = custombind
    end
    function WinTypes:CreateTab(name, players)
        name = name or "NewTab"
        players = players or false
        local TabTypes = {}
        local tab = Instance.new("TextButton")
        local title = Instance.new("TextLabel")
        local UIGradient = Instance.new("UIGradient")
        local Pattern = Instance.new("ImageLabel")
        local Left = Instance.new("ScrollingFrame")
        local UIPadding = Instance.new("UIPadding")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local Right = Instance.new("ScrollingFrame")
        local UIPadding_3 = Instance.new("UIPadding")
        local UIListLayout_5 = Instance.new("UIListLayout")
        tab.Name = "tab"
        tab.Parent = tabbar
        tab.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        tab.BorderColor3 = Color3.fromRGB(35, 35, 35)
        tab.BorderSizePixel = 0
        tab.Size = UDim2.new(0, tabbar.AbsoluteSize.X / (#tabbar:GetChildren() - 1), 0, 25)
        tab.Font = Enum.Font.SourceSans
        tab.Text = ""
        tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.TextSize = 18.000
        tab.TextStrokeTransparency = 0.000
        tab.TextWrapped = true
        title.Name = "title"
        title.Parent = tab
        title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        title.BackgroundTransparency = 1.000
        title.Size = UDim2.new(1, 0, 1, 0)
        title.Font = Enum.Font.SourceSans
        title.Text = name
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 18.000
        title.TextStrokeTransparency = 0.000
        UIGradient.Enabled = false
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
        UIGradient.Rotation = 90
        UIGradient.Parent = tab
        UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 0.00)}
        Pattern.Name = "container"
        Pattern.Parent = container
        Pattern.AnchorPoint = Vector2.new(0.5, 0.5)
        Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Pattern.BackgroundTransparency = 1.000
        Pattern.Position = UDim2.new(0.499520153, 0, 0.499957234, 0)
        Pattern.Size = UDim2.new(0, 521, 0, 471)
        Pattern.ZIndex = 9
        Pattern.Image = "rbxassetid://2151741365"
        Pattern.ImageTransparency = 0.600
        Pattern.ScaleType = Enum.ScaleType.Tile
        Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
        Pattern.TileSize = UDim2.new(0, 250, 0, 250)
        Pattern.Visible = false
        if (not players) then
            Left.Name = "Left"
            Left.Parent = Pattern
            Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Left.BackgroundTransparency = 1.000
            Left.Size = UDim2.new(0, 260, 0, 471)
            Left.BottomImage = ""
            Left.CanvasSize = UDim2.new(0, 0, 0, 0)
            Left.ScrollBarThickness = 0
            Left.TopImage = ""
            UIPadding.Parent = Left
            UIPadding.PaddingLeft = UDim.new(0, 3)
            UIPadding.PaddingTop = UDim.new(0, 8)
            UIListLayout_2.Parent = Left
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.Padding = UDim.new(0, 8)
            Right.Name = "Right"
            Right.Parent = Pattern
            Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Right.BackgroundTransparency = 1.000
            Right.Position = UDim2.new(0.499040306, 0, 0, 0)
            Right.Size = UDim2.new(0, 260, 0, 471)
            Right.BottomImage = ""
            Right.CanvasSize = UDim2.new(0, 0, 0, 0)
            Right.ScrollBarThickness = 0
            Right.TopImage = ""
            UIPadding_3.Parent = Right
            UIPadding_3.PaddingLeft = UDim.new(0, 3)
            UIPadding_3.PaddingTop = UDim.new(0, 8)
            UIListLayout_5.Parent = Right
            UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_5.Padding = UDim.new(0, 8)
            UIListLayout_5:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Right.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_5.AbsoluteContentSize.Y + 15)
            end)
            UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Left.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 15)
            end)
        end
        for i,v in pairs(tabbar:GetChildren()) do
            if (v.Name:find("tab")) then
                v.Size = UDim2.new(0, tabbar.AbsoluteSize.X / (#tabbar:GetChildren() - 1), 0, 25)
            end
        end
        tab.MouseButton1Click:Connect(function()
            tab.BackgroundColor3 = color
            UIGradient.Enabled = true
            Pattern.Visible = true
            for i,v in pairs(tabbar:GetChildren()) do
                if (v.Name:find("tab") and v ~= tab) then
                    v.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    v.UIGradient.Enabled = false
                end
            end
            for i,v in pairs(container:GetChildren()) do
                if (v.Name:find("container") and v ~= Pattern) then
                    v.Visible = false
                end
            end
        end)
        function TabTypes:CreateGroupbox(name, side)
            name = name or "NewGroupbox"
            side = side and side or Library:GetSide(#Left:GetChildren(), #Right:GetChildren())
            local GroupTypes = {}
            local groupboxoutline = Instance.new("Frame")
            local groupboxinline = Instance.new("Frame")
            local background = Instance.new("Frame")
            local title_2 = Instance.new("TextLabel")
            local container_2 = Instance.new("Frame")
            local UIPadding_2 = Instance.new("UIPadding")
            local UIListLayout_3 = Instance.new("UIListLayout")
            groupboxoutline.Name = "groupboxoutline"
            groupboxoutline.Parent = Pattern[side]
            groupboxoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            groupboxoutline.BorderSizePixel = 0
            groupboxoutline.Position = UDim2.new(0.0115384618, 0, 0.0169851389, 0)
            groupboxoutline.Size = UDim2.new(0, 254, 0, 40)
            groupboxinline.Name = "groupboxinline"
            groupboxinline.Parent = groupboxoutline
            groupboxinline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            groupboxinline.BorderSizePixel = 0
            groupboxinline.Position = UDim2.new(0, 1, 0, 1)
            groupboxinline.Size = UDim2.new(0, 252, 0, 38)
            background.Name = "background"
            background.Parent = groupboxinline
            background.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            background.BorderSizePixel = 0
            background.Position = UDim2.new(0, 1, 0, 1)
            background.Size = UDim2.new(0, 250, 0, 36)
            title_2.Name = "title"
            title_2.Parent = background
            title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            title_2.BackgroundTransparency = 1.000
            title_2.Position = UDim2.new(0, 15, 0, -10)
            title_2.Size = UDim2.new(0, 240, 0, 20)
            title_2.Font = Enum.Font.SourceSans
            title_2.Text = name
            title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            title_2.TextSize = 15.000
            title_2.TextStrokeTransparency = 0.000
            title_2.TextXAlignment = Enum.TextXAlignment.Left
            container_2.Name = "container"
            container_2.Parent = background
            container_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            container_2.BackgroundTransparency = 1.000
            container_2.Position = UDim2.new(0, 0, 0, 10)
            container_2.Size = UDim2.new(0, 250, 0, 26)
            UIPadding_2.Parent = container_2
            UIPadding_2.PaddingLeft = UDim.new(0, 10)
            UIPadding_2.PaddingTop = UDim.new(0, 5)
            UIListLayout_3.Parent = container_2
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_3.Padding = UDim.new(0, 7)
            UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                groupboxoutline.Size = UDim2.new(0, 254, 0, (UIListLayout_3.AbsoluteContentSize.Y) + 30)
                groupboxinline.Size = UDim2.new(0, 252, 0, (UIListLayout_3.AbsoluteContentSize.Y - 2) + 30)
                background.Size = UDim2.new(0, 250, 0, (UIListLayout_3.AbsoluteContentSize.Y - 4) + 30)
                container_2.Size = UDim2.new(0, 250, 0, (UIListLayout_3.AbsoluteContentSize.Y - 14) + 30)
            end)
            function GroupTypes:CreateToggle(name, callback, default)
                name = name or "New Toggle"
                callback = callback or function(v) print(v) end
                local ToggleTypes = {}
                local Enabled = default or false
                local checkbox = Instance.new("Frame")
                local UIGradient_2 = Instance.new("UIGradient")
                local title_3 = Instance.new("TextLabel")
                local main = Instance.new("TextButton")
                checkbox.Name = "checkbox"
                checkbox.Parent = container_2
                checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                checkbox.BorderColor3 = Color3.fromRGB(8, 8, 8)
                checkbox.Size = UDim2.new(0, 12, 0, 12)
                checkbox.ZIndex = 0
                UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_2.Rotation = 90
                UIGradient_2.Parent = checkbox
                title_3.Name = "title"
                title_3.Parent = checkbox
                title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_3.BackgroundTransparency = 1.000
                title_3.Position = UDim2.new(1.58333337, 0, 0, 0)
                title_3.Size = UDim2.new(0, 215, 0, 12)
                title_3.Font = Enum.Font.SourceSans
                title_3.Text = name
                title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_3.TextSize = 15.000
                title_3.TextStrokeTransparency = 0.000
                title_3.TextXAlignment = Enum.TextXAlignment.Left
                main.Name = "main"
                main.Parent = checkbox
                main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                main.BackgroundTransparency = 1.000
                main.Size = UDim2.new(19.5, 0, 1, 0)
                main.Font = Enum.Font.SourceSans
                main.Text = ""
                main.TextColor3 = Color3.fromRGB(0, 0, 0)
                main.TextSize = 14.000
                if Enabled then checkbox.BackgroundColor3 = color end
                local ToggleCallback = callback
                game.RunService.Heartbeat:Connect(function()
                    if (checkbox.BackgroundColor3 == oldcolor) then checkbox.BackgroundColor3 = color end
                end)
                main.MouseButton1Click:Connect(function()
                    Enabled = not Enabled
                    if (Enabled) then checkbox.BackgroundColor3 = color
                    else checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
                    callback(Enabled)
                end)
                function ToggleTypes:SetState(state)
                    state = state or false
                    Enabled = state
                    if (Enabled) then checkbox.BackgroundColor3 = color
                    else checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
                    callback(Enabled)
                end
                function ToggleTypes:GetState()
                    return Enabled
                end
                function ToggleTypes:CreateKeyBind(def, callback)
                    def = def or "NONE"
                    local keytypes = {}
                    local bindtext = Instance.new("TextLabel")
                    local keymain = Instance.new("TextButton")
                    bindtext.Name = "bindtext"
                    bindtext.Parent = checkbox
                    bindtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bindtext.BackgroundTransparency = 1.000
                    bindtext.BorderSizePixel = 0
                    bindtext.Position = UDim2.new(13.5, 0, 0, 0)
                    bindtext.Size = UDim2.new(0, 71, 0, 12)
                    bindtext.Font = Enum.Font.SourceSans
                    bindtext.Text = "[ " .. def .. " ]"
                    bindtext.TextColor3 = Color3.fromRGB(176, 176, 176)
                    bindtext.TextSize = 14.000
                    bindtext.TextStrokeTransparency = 0.000
                    bindtext.TextXAlignment = Enum.TextXAlignment.Right
                    keymain.Name = "keymain"
                    keymain.Parent = bindtext
                    keymain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    keymain.BackgroundTransparency = 1.000
                    keymain.Size = UDim2.new(1, 0, 1, 0)
                    keymain.Font = Enum.Font.SourceSans
                    keymain.TextColor3 = Color3.fromRGB(0, 0, 0)
                    keymain.TextSize = 14.000
                    keymain.Text = ""
                    local WaitingForBind = false
                    local Clicked = false
                    local Sel = def
                    local Blacklisted = { "W", "A", "S", "D", "Slash", "Tab", "Backspace", "Escape", "Space", "Delete", "Unknown" }
                    keymain.MouseButton1Click:Connect(function()
                        Clicked = true
                        bindtext.Text = "[ ... ]"
                    end)
                    game.RunService.Heartbeat:Connect(function()
                        if (WaitingForBind == false) then
                            if (Clicked == true) then WaitingForBind = true Clicked = false end
                        end
                    end)
                    userinputservice.InputBegan:Connect(function(Input)
                        if (WaitingForBind and Input.UserInputType == Enum.UserInputType.Keyboard) then
                            local Key = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
                            if (not table.find(Blacklisted, Key)) then bindtext.Text = "[ " .. Key .. " ]"
                            else bindtext.Text = "[ NONE ]" end
                            Sel = Key
                            WaitingForBind = false
                        else
                            if (Input.UserInputType == Enum.UserInputType.Keyboard) then
                                local Key = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
                                if (Key == Sel) then
                                    Enabled = not Enabled
                                    if (Enabled) then checkbox.BackgroundColor3 = color
                                    else checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
                                    if (callback) then callback(Key) else ToggleCallback(Enabled) end
                                end
                            end
                        end
                    end)
                    function keytypes:SetBind(key) bindtext.Text = "[ " .. key .. " ]" Sel = key end
                    function keytypes:GetBind() return Sel end
                    return keytypes
                end
                return ToggleTypes
            end
            function GroupTypes:CreateSlider(name, min, max, def, callback)
                name = name or "New Slider"
                min = min or 0
                max = max or 100
                def = def or 50
                callback = callback or function(s) print(s) end
                local SliderTypes = {}
                local Dragging = false
                local Value = 0
                local title_15 = Instance.new("TextLabel")
                local slider = Instance.new("Frame")
                local UIGradient_15 = Instance.new("UIGradient")
                local bar = Instance.new("Frame")
                local UIGradient_16 = Instance.new("UIGradient")
                local value = Instance.new("TextLabel")
                title_15.Name = "title"
                title_15.Parent = container_2
                title_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_15.BackgroundTransparency = 1.000
                title_15.Position = UDim2.new(0, 10, 0, 51)
                title_15.Size = UDim2.new(0, 234, 0, 37)
                title_15.ZIndex = 0
                title_15.Font = Enum.Font.SourceSans
                title_15.Text = name
                title_15.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_15.TextSize = 15.000
                title_15.TextStrokeTransparency = 0.000
                title_15.TextXAlignment = Enum.TextXAlignment.Left
                title_15.TextYAlignment = Enum.TextYAlignment.Top
                slider.Name = "slider"
                slider.Parent = title_15
                slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                slider.BorderColor3 = Color3.fromRGB(8, 8, 8)
                slider.Position = UDim2.new(0, 0, 0, 22)
                slider.Size = UDim2.new(0, 234, 0, 15)
                UIGradient_15.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_15.Rotation = 90
                UIGradient_15.Parent = slider
                bar.Name = "bar"
                bar.Parent = slider
                bar.BackgroundColor3 = color
                bar.BorderColor3 = Color3.fromRGB(27, 42, 53)
                bar.BorderSizePixel = 0
                bar.Size = UDim2.new(0, 50, 1, 0)
                UIGradient_16.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_16.Rotation = 90
                UIGradient_16.Parent = bar
                value.Name = "value"
                value.Parent = slider
                value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                value.BackgroundTransparency = 1.000
                value.Size = UDim2.new(1, 0, 1, 0)
                value.Font = Enum.Font.SourceSans
                value.Text = min .. "/" .. max
                value.TextColor3 = Color3.fromRGB(255, 255, 255)
                value.TextSize = 14.000
                value.TextStrokeTransparency = 0.000
                bar.Size = UDim2.new(def / max, 0, 1, 0)
                value.Text = def .. "/" .. max
                local function Slide(input)
                    local pos = UDim2.new(math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1), 0, 1, 0)
                    bar.Size = pos
                    local s = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                    Value = s
                    value.Text = tostring(s) .. "/" .. max
                    callback(Value)
                end
                slider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then Slide(input) Dragging = true SliderDragging = true end
                end)
                slider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false SliderDragging = false end
                end)
                userinputservice.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then Slide(input) end
                end)
                function SliderTypes:SetValue(s) s = s or 0 Value = s bar.Size = UDim2.new(Value / max, 0, 1, 0) value.Text = tostring(Value) .. "/" .. max callback(Value) end
                function SliderTypes:GetValue() return Value end
                return SliderTypes
            end
            function GroupTypes:CreateDropdown(name, options, callback)
                name = name or "Dropdown"
                options = options or {}
                callback = callback or function(o) print(o) end
                local DropTypes = {}
                local Selected = ""
                local title_15 = Instance.new("TextLabel")
                local combobox = Instance.new("Frame")
                local main_2 = Instance.new("TextButton")
                local UIGradient_3 = Instance.new("UIGradient")
                local title_4 = Instance.new("TextLabel")
                local list = Instance.new("Frame")
                local UIGradient_4 = Instance.new("UIGradient")
                local UIListLayout_4 = Instance.new("UIListLayout")
                title_15.Name = "title"
                title_15.Parent = container_2
                title_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_15.BackgroundTransparency = 1.000
                title_15.Position = UDim2.new(0, 10, 0, 51)
                title_15.Size = UDim2.new(0, 234, 0, 42)
                title_15.ZIndex = 0
                title_15.Font = Enum.Font.SourceSans
                title_15.Text = name
                title_15.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_15.TextSize = 15.000
                title_15.TextStrokeTransparency = 0.000
                title_15.TextXAlignment = Enum.TextXAlignment.Left
                title_15.TextYAlignment = Enum.TextYAlignment.Top
                combobox.Name = "combobox"
                combobox.Parent = title_15
                combobox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                combobox.BorderColor3 = Color3.fromRGB(8, 8, 8)
                combobox.Position = UDim2.new(0, 0, 0, 22)
                combobox.Size = UDim2.new(0, 234, 0, 20)
                main_2.Name = "main"
                main_2.Parent = combobox
                main_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                main_2.BackgroundTransparency = 1.000
                main_2.Size = UDim2.new(1, 0, 1, 0)
                main_2.Font = Enum.Font.SourceSans
                main_2.Text = ""
                main_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                main_2.TextSize = 14.000
                UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_3.Rotation = 90
                UIGradient_3.Parent = combobox
                title_4.Name = "title"
                title_4.Parent = combobox
                title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_4.BackgroundTransparency = 1.000
                title_4.Position = UDim2.new(0, 11, 0, 0)
                title_4.Size = UDim2.new(0, 223, 0, 20)
                title_4.Font = Enum.Font.SourceSans
                title_4.Text = "..."
                title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_4.TextSize = 15.000
                title_4.TextStrokeTransparency = 0.000
                title_4.TextXAlignment = Enum.TextXAlignment.Left
                list.Name = "list"
                list.Parent = combobox
                list.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                list.BorderColor3 = Color3.fromRGB(8, 8, 8)
                list.Position = UDim2.new(0, 0, 1, 0)
                list.Size = UDim2.new(0, 234, 0, 5)
                list.Visible = false
                UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_4.Rotation = 90
                UIGradient_4.Parent = list
                UIListLayout_4.Parent = list
                UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    list.Size = UDim2.new(0, 234, 0, UIListLayout_4.AbsoluteContentSize.Y)
                end)
                main_2.MouseButton1Click:Connect(function()
                    title_15.ZIndex = 9
                    list.Visible = not list.Visible
                    for i,v in pairs(container_2:GetChildren()) do
                        if (v ~= title_15 and not v.Name:find("UI")) then v.ZIndex = 0 end
                    end
                end)
                if (#options > 0) then
                    for i,v in pairs(options) do
                        local item = Instance.new("TextButton")
                        local UIGradient_5 = Instance.new("UIGradient")
                        local title_5 = Instance.new("TextLabel")
                        item.Name = "item"
                        item.Parent = list
                        item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        item.BorderSizePixel = 0
                        item.Size = UDim2.new(1, 0, 0, 19)
                        item.Font = Enum.Font.SourceSans
                        item.Text = ""
                        item.TextColor3 = Color3.fromRGB(0, 0, 0)
                        item.TextSize = 14.000
                        UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                        UIGradient_5.Rotation = 90
                        UIGradient_5.Parent = item
                        UIGradient_5.Enabled = false
                        title_5.Name = "title"
                        title_5.Parent = item
                        title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        title_5.BackgroundTransparency = 1.000
                        title_5.Size = UDim2.new(1, 0, 1, 0)
                        title_5.Font = Enum.Font.SourceSans
                        title_5.Text = v
                        title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
                        title_5.TextSize = 14.000
                        title_5.TextStrokeTransparency = 0.000
                        item.MouseButton1Click:Connect(function()
                            UIGradient_5.Enabled = true
                            item.BackgroundColor3 = color
                            for i,v in pairs(list:GetChildren()) do
                                if (v.Name:find("item") and v ~= item) then
                                    v.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                    v.UIGradient.Enabled = false
                                end
                            end
                            Selected = v
                            title_4.Text = Selected
                            callback(Selected)
                        end)
                    end
                end
                function DropTypes:SetOption(option)
                    option = option or options[1]
                    Selected = tostring(option)
                    for i,v in pairs(list:GetChildren()) do
                        if (v.Name:find("item")) then
                            if (v.Text == Selected) then v.BackgroundColor3 = color v.UIGradient.Enabled = true
                            else v.BackgroundColor3 = Color3.fromRGB(30, 30, 30) v.UIGradient.Enabled = false end
                        end
                    end
                    title_4.Text = Selected
                    callback(Selected)
                end
                function DropTypes:GetOption() return Selected end
                return DropTypes
            end
            function GroupTypes:CreateButton(name, callback)
                name = name or "New Button"
                callback = callback or function() print("clicked") end
                local Button = Instance.new("TextButton")
                local UIGradient_17 = Instance.new("UIGradient")
                local title_16 = Instance.new("TextLabel")
                Button.Name = "Button"
                Button.Parent = container_2
                Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Button.BorderColor3 = Color3.fromRGB(8, 8, 8)
                Button.Position = UDim2.new(0.0399999991, 0, 0.273542613, 0)
                Button.Size = UDim2.new(0, 234, 0, 20)
                Button.ZIndex = 0
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14.000
                UIGradient_17.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_17.Rotation = 90
                UIGradient_17.Parent = Button
                title_16.Name = "title"
                title_16.Parent = Button
                title_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_16.BackgroundTransparency = 1.000
                title_16.Size = UDim2.new(1, 0, 1, 0)
                title_16.Font = Enum.Font.SourceSans
                title_16.Text = name
                title_16.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_16.TextSize = 15.000
                title_16.TextStrokeTransparency = 0.000
                Button.MouseButton1Click:Connect(function() callback() end)
            end
            function GroupTypes:CreateColorPicker(name, def, callback)
                name = name or "New ColorPicker"
                def = def or Color3.fromRGB(255, 255, 255)
                callback = callback or function(s) print(s) end
                local ColorTypes = {}
                local Dragging = false
                local ColorInput = nil
                local HueInput = nil
                local ColorH = 5
                local ColorS = 1
                local ColorV = 1
                local SelectedColor = def
                local colorpicker = Instance.new("Frame")
                local UIGradient_18 = Instance.new("UIGradient")
                local title_17 = Instance.new("TextLabel")
                local main_3 = Instance.new("TextButton")
                local colorframe = Instance.new("Frame")
                local inline_2 = Instance.new("Frame")
                local bg = Instance.new("Frame")
                local gradient = Instance.new("ImageLabel")
                local colorselection = Instance.new("ImageLabel")
                local colorslider = Instance.new("Frame")
                local UIGradient_20 = Instance.new("UIGradient")
                local bar_2 = Instance.new("Frame")
                colorpicker.Name = "colorpicker"
                colorpicker.Parent = container_2
                colorpicker.BackgroundColor3 = def
                colorpicker.BorderColor3 = Color3.fromRGB(8, 8, 8)
                colorpicker.Position = UDim2.new(0.0399999991, 0, 0.734939754, 0)
                colorpicker.Size = UDim2.new(0, 19, 0, 19)
                colorpicker.ZIndex = 0
                UIGradient_18.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient_18.Rotation = 90
                UIGradient_18.Parent = colorpicker
                title_17.Name = "title"
                title_17.Parent = colorpicker
                title_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                title_17.BackgroundTransparency = 1.000
                title_17.Position = UDim2.new(1.5833323, 0, 0, 0)
                title_17.Size = UDim2.new(0, 203, 0, 19)
                title_17.Font = Enum.Font.SourceSans
                title_17.Text = name
                title_17.TextColor3 = Color3.fromRGB(255, 255, 255)
                title_17.TextSize = 15.000
                title_17.TextStrokeTransparency = 0.000
                title_17.TextXAlignment = Enum.TextXAlignment.Left
                main_3.Name = "main"
                main_3.Parent = colorpicker
                main_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                main_3.BackgroundTransparency = 1.000
                main_3.Size = UDim2.new(12.3157892, 0, 1, 0)
                main_3.Font = Enum.Font.SourceSans
                main_3.Text = ""
                main_3.TextColor3 = Color3.fromRGB(0, 0, 0)
                main_3.TextSize = 14.000
                colorframe.Name = "colorframe"
                colorframe.Parent = BracketV2
                colorframe.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
                colorframe.BorderColor3 = Color3.fromRGB(8, 8, 8)
                colorframe.BorderSizePixel = 0
                colorframe.Position = UDim2.new(0, 0, 0, 0)
                colorframe.Size = UDim2.new(0, 178, 0, 151)
                colorframe.Visible = false
                colorframe.ZIndex = 1
                inline_2.Name = "inline"
                inline_2.Parent = colorframe
                inline_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                inline_2.BorderSizePixel = 0
                inline_2.Position = UDim2.new(0, 1, 0, 1)
                inline_2.Size = UDim2.new(0, 176, 0, 149)
                bg.Name = "bg"
                bg.Parent = inline_2
                bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                bg.BorderSizePixel = 0
                bg.Position = UDim2.new(0, 1, 0, 1)
                bg.Size = UDim2.new(0, 174, 0, 147)
                gradient.Name = "gradient"
                gradient.Parent = bg
                gradient.BackgroundColor3 = def
                gradient.BorderColor3 = Color3.fromRGB(8, 8, 8)
                gradient.Position = UDim2.new(0, 10, 0, 10)
                gradient.Size = UDim2.new(0, 154, 0, 104)
                gradient.ZIndex = 10
                gradient.Image = "rbxassetid://4155801252"
                colorselection.Name = "colorselection"
                colorselection.Parent = gradient
                colorselection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorselection.BackgroundTransparency = 1.000
                colorselection.ZIndex = 25
                colorselection.AnchorPoint = Vector2.new(0.5, 0.5)
                colorselection.Position = UDim2.new(def and select(3, Color3.toHSV(def)))
                colorselection.Size = UDim2.new(0, 18, 0, 18)
                colorselection.Image = "rbxassetid://4953646208"
                colorselection.ScaleType = Enum.ScaleType.Fit
                colorslider.Name = "colorslider"
                colorslider.Parent = bg
                colorslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorslider.BorderColor3 = Color3.fromRGB(8, 8, 8)
                colorslider.Position = UDim2.new(0.0574712642, 0, 0.84353739, 0)
                colorslider.Size = UDim2.new(0, 154, 0, 15)
                UIGradient_20.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 0, 251)),
                    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 17, 255)),
                    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(21, 255, 0)),
                    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(234, 255, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
                }
                UIGradient_20.Parent = colorslider
                bar_2.Name = "bar"
                bar_2.Parent = colorslider
                bar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                bar_2.BorderColor3 = Color3.fromRGB(8, 8, 8)
                bar_2.Size = UDim2.new(0, 1, 1, 0)
                local function UpdateColor()
                    colorpicker.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                    gradient.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                    SelectedColor = colorpicker.BackgroundColor3
                    callback(SelectedColor)
                end
                UpdateColor()
                local ColorDragging = false
                local dragInput, dragStart, startPos = nil, nil, nil
                local Mouse = game.Players.LocalPlayer:GetMouse()
                colorframe.InputBegan:Connect(function(input)
                    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
                        dragStart = input.Position
                        startPos = colorframe.Position
                        ColorDragging = true
                        ColorPickerDragging = true
                        input.Changed:Connect(function()
                            if (input.UserInputState == Enum.UserInputState.End) then ColorDragging = false ColorPickerDragging = false end
                        end)
                    end
                end)
                colorframe.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
                end)
                userinputservice.InputChanged:Connect(function(input)
                    if input == dragInput and ColorDragging and not SliderDragging and not Dragging then
                        local Delta = input.Position - dragStart
                        colorframe.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
                    end
                end)
                main_3.MouseButton1Click:Connect(function() colorframe.Visible = not colorframe.Visible end)
                gradient.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (ColorInput) then ColorInput:Disconnect() end
                        ColorInput = game.RunService.RenderStepped:Connect(function()
                            local ColorX = (math.clamp(Mouse.X - colorslider.AbsolutePosition.X, 0, colorslider.AbsoluteSize.X) / colorslider.AbsoluteSize.X)
                            local ColorY = (math.clamp(Mouse.Y - gradient.AbsolutePosition.Y, 0, gradient.AbsoluteSize.Y) / gradient.AbsoluteSize.Y)
                            ColorS = ColorX ColorV = 1 - ColorY
                            colorselection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                            UpdateColor()
                        end)
                        Dragging = true
                    end
                end)
                gradient.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (ColorInput) then ColorInput:Disconnect() end
                        Dragging = false
                    end
                end)
                colorslider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (HueInput) then HueInput:Disconnect() end
                        HueInput = game.RunService.RenderStepped:Connect(function()
                            local HueY = (math.clamp(Mouse.X - colorslider.AbsolutePosition.X, 0, colorslider.AbsoluteSize.X) / colorslider.AbsoluteSize.X)
                            bar_2.Position = UDim2.new(HueY, 0, 0, 0) ColorH = 1 - HueY
                            UpdateColor()
                        end)
                        Dragging = true
                    end
                end)
                colorslider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (HueInput) then HueInput:Disconnect() end
                        Dragging = false
                    end
                end)
                function ColorTypes:SetColor(color)
                    color = color or Color3.fromRGB(255, 255, 255)
                    colorpicker.BackgroundColor3 = color
                    gradient.BackgroundColor3 = color
                    SelectedColor = colorpicker.BackgroundColor3
                    callback(SelectedColor)
                end
                return ColorTypes
            end
            return GroupTypes
        end
        return TabTypes
    end
    return WinTypes, BracketV2
end

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UserInput    = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui      = game:GetService("CoreGui")
local VIM          = game:GetService("VirtualInputManager")
local RS           = game:GetService("ReplicatedStorage")
local LP           = Players.LocalPlayer
local Camera       = workspace.CurrentCamera

local VERSION     = 6
local GLOBAL_KEY  = "_neverloose_v"
local CLEANUP_KEY = "_neverloose_cleanup"

if _G[CLEANUP_KEY] and type(_G[CLEANUP_KEY]) == "function" then
    pcall(_G[CLEANUP_KEY])
end
_G[GLOBAL_KEY] = VERSION

local LastNotify = 0
local function Notify(title, text, duration)
    local now = tick()
    if now - LastNotify < 1 then return end
    LastNotify = now
    task.spawn(function()
        duration = duration or 3
        local gui = Instance.new("ScreenGui")
        gui.Name = "NL_NOTIFY"
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.DisplayOrder = 999
        pcall(function() gui.Parent = CoreGui end)
        if not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end

        local frame = Instance.new("Frame")
        frame.AnchorPoint = Vector2.new(1, 1)
        frame.Position = UDim2.new(1, 300, 1, -16)
        frame.Size = UDim2.new(0, 280, 0, 60)
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        frame.BackgroundTransparency = 0.05
        frame.BorderSizePixel = 0
        frame.Parent = gui
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

        local accent = Instance.new("Frame")
        accent.Size = UDim2.new(0, 4, 1, 0)
        accent.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        accent.BorderSizePixel = 0
        accent.Parent = frame
        Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 8)

        local t = Instance.new("TextLabel")
        t.Position = UDim2.new(0, 14, 0, 8)
        t.Size = UDim2.new(1, -22, 0, 20)
        t.BackgroundTransparency = 1
        t.Text = title or ""
        t.TextColor3 = Color3.fromRGB(255, 255, 255)
        t.TextSize = 14
        t.Font = Enum.Font.GothamBold
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.TextTruncate = Enum.TextTruncate.AtEnd
        t.Parent = frame

        local b = Instance.new("TextLabel")
        b.Position = UDim2.new(0, 14, 0, 30)
        b.Size = UDim2.new(1, -22, 0, 22)
        b.BackgroundTransparency = 1
        b.Text = text or ""
        b.TextColor3 = Color3.fromRGB(180, 180, 180)
        b.TextSize = 12
        b.Font = Enum.Font.Gotham
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextTruncate = Enum.TextTruncate.AtEnd
        b.Parent = frame

        TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -16, 1, -16)
        }):Play()

        task.delay(duration, function()
            local out = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 300, 1, -16)
            })
            out:Play()
            out.Completed:Wait()
            gui:Destroy()
        end)
    end)
end

local Combat_Enabled = true
local Visuals_Enabled = true
local Sounds_Enabled = true
local Skins_Enabled = true

local Trig_Enabled   = true
local Trig_MaxDist   = 500
local Trig_Delay     = 0

local ESP_Skeleton   = true
local ESP_Box        = true
local ESP_FillBox    = false
local ESP_Name       = true
local ESP_Health     = true
local ESP_Distance   = true
local ESP_Weapon     = true
local ESP_Tracer     = false
local ESP_Thickness  = 1
local ESP_MaxDist    = 2000
local ESP_HideLocal  = true
local ESP_TeamCheck  = false
local ESP_Color      = Color3.fromRGB(0, 255, 255)

local DESkinName     = "Default"
local DESkinID       = "rbxassetid://0"
local KnifeSkinName  = "Default"
local HitSoundID     = "rbxassetid://0"
local ShootSoundID   = "rbxassetid://0"
local KillSoundID    = "rbxassetid://0"

local Connections = {}
local ESP = {}
local UIScreen = nil

local Window, ScreenGui = Library:CreateWindow("neverloose", Color3.fromRGB(0, 255, 255))
UIScreen = ScreenGui

local CombatTab  = Window:CreateTab("Combat")
local VisualsTab = Window:CreateTab("Visuals")
local SoundsTab  = Window:CreateTab("Sounds")
local SkinsTab   = Window:CreateTab("Skins")

local CombatGroup = CombatTab:CreateGroupbox("Triggerbot")
CombatGroup:CreateToggle("Enable Combat", function(v)
    Combat_Enabled = v
    Notify("Combat", v and "ON" or "OFF", 2)
end, true):CreateKeyBind("T")
CombatGroup:CreateToggle("Triggerbot", function(v) Trig_Enabled = v end, true)
CombatGroup:CreateSlider("Max Distance", 100, 2000, 500, function(v) Trig_MaxDist = v end)
CombatGroup:CreateSlider("Delay (ms)", 0, 200, 0, function(v) Trig_Delay = v end)

local VisualsGroup = VisualsTab:CreateGroupbox("Visuals")
VisualsGroup:CreateToggle("Enable Visuals", function(v)
    Visuals_Enabled = v
    if not v then
        for p, _ in pairs(ESP) do pcall(DestroyESP, p) end
    end
    Notify("Visuals", v and "ON" or "OFF", 2)
end, true):CreateKeyBind("P")
VisualsGroup:CreateToggle("Skeleton", function(v) ESP_Skeleton = v end, true)
VisualsGroup:CreateToggle("Box", function(v) ESP_Box = v end, true)
VisualsGroup:CreateToggle("Fill Box", function(v) ESP_FillBox = v end, false)
VisualsGroup:CreateToggle("Nametag", function(v) ESP_Name = v end, true)
VisualsGroup:CreateToggle("Health Bar", function(v) ESP_Health = v end, true)
VisualsGroup:CreateToggle("Distance", function(v) ESP_Distance = v end, true)
VisualsGroup:CreateToggle("Weapon", function(v) ESP_Weapon = v end, true)
VisualsGroup:CreateToggle("Tracers", function(v) ESP_Tracer = v end, false)
VisualsGroup:CreateSlider("Thickness", 1, 5, 1, function(v) ESP_Thickness = v end)
VisualsGroup:CreateSlider("Max Distance", 500, 5000, 2000, function(v) ESP_MaxDist = v end)
VisualsGroup:CreateToggle("Hide Local Player", function(v) ESP_HideLocal = v end)
VisualsGroup:CreateToggle("Team Check", function(v) ESP_TeamCheck = v end)
VisualsGroup:CreateColorPicker("ESP Color", Color3.fromRGB(0, 255, 255), function(v) ESP_Color = v end)

local HitSounds = {
    ["None"]        = "rbxassetid://0",
    ["Skeet"]       = "rbxassetid://5447626464",
    ["Rust"]        = "rbxassetid://5043539486",
    ["Bag"]         = "rbxassetid://364942410",
    ["Baimware"]    = "rbxassetid://6607339542",
    ["1nn"]         = "rbxassetid://7349055654",
    ["Cod"]         = "rbxassetid://131864673",
    ["Bonk"]        = "rbxassetid://3765689841",
    ["Semi"]        = "rbxassetid://7791675603",
    ["Osu"]         = "rbxassetid://7149919358",
    ["Tf2"]         = "rbxassetid://296102734",
    ["Tf2 Pan"]     = "rbxassetid://3431749479",
    ["Slap"]        = "rbxassetid://4888372697",
    ["Minecraft"]   = "rbxassetid://7273736372",
    ["Jojo"]        = "rbxassetid://6787514780",
    ["Vibe"]        = "rbxassetid://1848288500",
    ["Super Smash"] = "rbxassetid://2039907664",
    ["Epic"]        = "rbxassetid://7344303740",
    ["Retro"]       = "rbxassetid://3466984142",
    ["Quek"]        = "rbxassetid://4868633804",
    ["Dababy"]      = "rbxassetid://6559380085",
    ["Welcome"]     = "rbxassetid://5149595745",
}
local ShootSounds = {
    ["None"]      = "rbxassetid://0",
    ["Silencer"]  = "rbxassetid://1415221962",
    ["Laser"]     = "rbxassetid://1651687704",
    ["Rust Bang"] = "rbxassetid://2920959",
    ["Phaser"]    = "rbxassetid://269158884",
    ["Blaster"]   = "rbxassetid://16211026",
    ["Pop"]       = "rbxassetid://3205573783",
}
local KillSounds = {
    ["None"]          = "rbxassetid://0",
    ["Metal Pipe"]    = "rbxassetid://1316391753",
    ["Rust Headshot"] = "rbxassetid://103094294870161",
    ["TF2 Crit"]      = "rbxassetid://312947118",
    ["Vine Boom"]     = "rbxassetid://6006265990",
    ["Bazinga"]       = "rbxassetid://1387505453",
}

local function BuildNames(tbl)
    local names = {}
    for k in pairs(tbl) do names[#names+1] = k end
    table.sort(names)
    return names
end

local SoundsGroup = SoundsTab:CreateGroupbox("Preset Sounds")
SoundsGroup:CreateToggle("Enable Sounds", function(v)
    Sounds_Enabled = v
    Notify("Sounds", v and "ON" or "OFF", 2)
end)
SoundsGroup:CreateDropdown("Hit Sound", BuildNames(HitSounds), function(v)
    HitSoundID = HitSounds[v] or "rbxassetid://0"
    Notify("Sounds", "Hit: " .. v, 2)
end):SetOption("None")
SoundsGroup:CreateDropdown("Shoot Sound", BuildNames(ShootSounds), function(v)
    ShootSoundID = ShootSounds[v] or "rbxassetid://0"
    Notify("Sounds", "Shoot: " .. v, 2)
end):SetOption("None")
SoundsGroup:CreateDropdown("Kill Sound", BuildNames(KillSounds), function(v)
    KillSoundID = KillSounds[v] or "rbxassetid://0"
    Notify("Sounds", "Kill: " .. v, 2)
end):SetOption("None")

local CustomSoundGroup = SoundsTab:CreateGroupbox("Custom IDs")
CustomSoundGroup:CreateButton("Reset All Sounds", function()
    HitSoundID = "rbxassetid://0"
    ShootSoundID = "rbxassetid://0"
    KillSoundID = "rbxassetid://0"
    Notify("Sounds", "All IDs reset", 3)
end)

local DESkinList = {
    "Default",
    "Burned", "404", "Caution",
    "Plasma", "Magma", "Carbon Stealth",
    "Blaze",
    "Dual Tone", "Redline",
    "Whiteout", "Artic", "Coldfire", "Purple Phantom", "Blizzard", "Emerald", "Ruby Swirl",
    "Pixelated Havoc", "Inferno Star", "Shadow",
    "Ghost Walker", "Dark Presence", "Frankenstrat",
    "Candy Clouds",
    "Purple Storm", "Royal Gold", "Sapphire",
    "Cosmic Flare", "GoldStrike", "Red Rage", "Sapphire Strike",
    "Crimson",
}
table.sort(DESkinList)

local SkinsGroup = SkinsTab:CreateGroupbox("Desert Eagle")
SkinsGroup:CreateToggle("Enable Skins", function(v)
    Skins_Enabled = v
    Notify("Skins", v and "ON" or "OFF", 2)
end)
SkinsGroup:CreateDropdown("Skin", DESkinList, function(v)
    DESkinName = v
    DESkinID = (v == "Default") and "rbxassetid://110831261114219" or "lookup"
    Notify("Skins", "DE: " .. v, 2)
end):SetOption("Default")

local KnifeSkinList = {"Default"}
pcall(function()
    local tex = RS:FindFirstChild("Textures")
    if tex then
        for _, knife in ipairs({"M9Bayonet", "Butterfly", "Karambit"}) do
            local kf = tex:FindFirstChild(knife)
            if kf then
                for _, rarity in ipairs(kf:GetChildren()) do
                    if rarity:IsA("Folder") then
                        for _, skin in ipairs(rarity:GetChildren()) do
                            if skin:IsA("Folder") then
                                KnifeSkinList[#KnifeSkinList+1] = skin.Name
                            end
                        end
                    end
                end
            end
        end
    end
end)
table.sort(KnifeSkinList)

local KnifeGroup = SkinsTab:CreateGroupbox("Knife")
KnifeGroup:CreateDropdown("Skin", KnifeSkinList, function(v)
    KnifeSkinName = v
    Notify("Skins", "Knife: " .. v, 2)
end):SetOption("Default")

-- (Custom Skin ID group removed — use DE dropdown or set DESkinID manually)
-- console: _G.setCustomSkin("rbxassetid://YOURID")
_G.setCustomSkin = function(id)
    if id and id ~= "" then
        DESkinID = id
        DESkinName = "Custom"
        Notify("Skins", "Custom skin: " .. id, 2)
    end
end

local R15 = {
    {"HumanoidRootPart", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "Head"}, {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"}, {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"},
}

local R6 = {
    {"HumanoidRootPart", "Torso"}, {"Torso", "Head"},
    {"Torso", "Left Arm"}, {"Torso", "Right Arm"},
    {"Torso", "Left Leg"}, {"Torso", "Right Leg"},
}

local function W2S(pos)
    local v, s = Camera:WorldToViewportPoint(pos)
    return Vector2.new(v.X, v.Y), s, v.Z
end

local function IsAlive(char)
    if not char then return false end
    local h = char:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function GetBones(char)
    return char:FindFirstChild("LowerTorso") and R15 or char:FindFirstChild("Torso") and R6 or nil
end

local function MakeLine()
    local l = Drawing.new("Line")
    l.Visible = false
    l.Color = Color3.fromRGB(0, 255, 255)
    l.Thickness = ESP_Thickness
    l.Transparency = 1
    l.ZIndex = 999
    return l
end

local function MakeQuad()
    local q = Drawing.new("Quad")
    q.Visible = false
    q.Color = Color3.fromRGB(0, 255, 255)
    q.Filled = false
    q.Thickness = ESP_Thickness
    q.Transparency = 1
    q.ZIndex = 998
    return q
end

local function MakeTextDrawing()
    local d = Drawing.new("Text")
    d.Visible = false
    d.Color = Color3.fromRGB(255, 255, 255)
    d.Size = 14
    d.Center = true
    d.Outline = true
    d.OutlineColor = Color3.fromRGB(0, 0, 0)
    d.Font = 2
    d.ZIndex = 1000
    return d
end

local function CreateESP(player)
    if ESP[player] then return end
    local ok, e = pcall(function()
        local data = {
            lines = {},
            boxLines = {},
            boxFill = nil,
            hpBar = nil,
            hpBg = nil,
            tracer = nil,
            name = nil,
            dist = nil,
            weapon = nil,
        }
        for i = 1, 15 do data.lines[i] = MakeLine() end
        for i = 1, 4 do data.boxLines[i] = MakeLine() end
        data.boxFill = MakeQuad()
        data.boxFill.Filled = true
        data.boxFill.Transparency = 0.25
        data.tracer = MakeLine()
        data.hpBg = MakeQuad()
        data.hpBar = MakeQuad()
        data.name = MakeTextDrawing()
        data.dist = MakeTextDrawing()
        data.dist.Size = 12
        data.weapon = MakeTextDrawing()
        data.weapon.Size = 11
        data.weapon.Color = Color3.fromRGB(0, 255, 255)
        return data
    end)
    if ok and e then
        ESP[player] = e
    end
end

function DestroyESP(player)
    local e = ESP[player]
    if not e then return end
    for _, l in ipairs(e.lines) do pcall(function() l:Remove() end) end
    for _, l in ipairs(e.boxLines) do pcall(function() l:Remove() end) end
    pcall(function() e.boxFill:Remove() end)
    pcall(function() e.tracer:Remove() end)
    pcall(function() e.hpBg:Remove() end)
    pcall(function() e.hpBar:Remove() end)
    pcall(function() e.name:Remove() end)
    pcall(function() e.dist:Remove() end)
    pcall(function() e.weapon:Remove() end)
    ESP[player] = nil
end

local function HideESP(e)
    for _, l in ipairs(e.lines) do l.Visible = false end
    for _, l in ipairs(e.boxLines) do l.Visible = false end
    e.boxFill.Visible = false
    e.tracer.Visible = false
    e.hpBg.Visible = false
    e.hpBar.Visible = false
    e.name.Visible = false
    e.dist.Visible = false
    e.weapon.Visible = false
end

local function GetWeaponName(char)
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then return tool.Name end
    return ""
end

-- compute world-space AABB from all BaseParts in a character
local function GetCharBounds(char)
    local minV, maxV
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local p = part.Position
            local s = part.Size
            local corners = {
                p + Vector3.new(-s.X/2, -s.Y/2, -s.Z/2),
                p + Vector3.new( s.X/2, -s.Y/2, -s.Z/2),
                p + Vector3.new(-s.X/2,  s.Y/2, -s.Z/2),
                p + Vector3.new( s.X/2,  s.Y/2, -s.Z/2),
                p + Vector3.new(-s.X/2, -s.Y/2,  s.Z/2),
                p + Vector3.new( s.X/2, -s.Y/2,  s.Z/2),
                p + Vector3.new(-s.X/2,  s.Y/2,  s.Z/2),
                p + Vector3.new( s.X/2,  s.Y/2,  s.Z/2),
            }
            for _, c in ipairs(corners) do
                if not minV then
                    minV = c
                    maxV = c
                else
                    minV = Vector3.new(math.min(minV.X, c.X), math.min(minV.Y, c.Y), math.min(minV.Z, c.Z))
                    maxV = Vector3.new(math.max(maxV.X, c.X), math.max(maxV.Y, c.Y), math.max(maxV.Z, c.Z))
                end
            end
        end
    end
    return minV, maxV
end

-- project a world-space AABB to screen-space box (left, top, right, bottom, onscreen)
local function AABB2Screen(minV, maxV)
    local cam = Camera.CFrame
    local vp = Camera.ViewportSize
    local function proj(p)
        local v = cam:PointToObjectSpace(p)
        if v.Z > 0 then return nil end
        local x = (v.X / -v.Z) * (vp.X / 2) + vp.X / 2
        local y = (v.Y / -v.Z) * (vp.Y / 2) + vp.Y / 2
        return Vector2.new(x, y)
    end
    -- project all 8 corners
    local pts = {}
    for _, c in ipairs({
        Vector3.new(minV.X, minV.Y, minV.Z),
        Vector3.new(maxV.X, minV.Y, minV.Z),
        Vector3.new(minV.X, maxV.Y, minV.Z),
        Vector3.new(maxV.X, maxV.Y, minV.Z),
        Vector3.new(minV.X, minV.Y, maxV.Z),
        Vector3.new(maxV.X, minV.Y, maxV.Z),
        Vector3.new(minV.X, maxV.Y, maxV.Z),
        Vector3.new(maxV.X, maxV.Y, maxV.Z),
    }) do
        local s = proj(c)
        if s then table.insert(pts, s) end
    end
    if #pts < 2 then return 0, 0, 0, 0, false end
    local lx, ty = pts[1].X, pts[1].Y
    local rx, by = pts[1].X, pts[1].Y
    for _, p in ipairs(pts) do
        if p.X < lx then lx = p.X end
        if p.X > rx then rx = p.X end
        if p.Y < ty then ty = p.Y end
        if p.Y > by then by = p.Y end
    end
    return lx, ty, rx, by, true
end

local function RenderESP()
    Camera = workspace.CurrentCamera
    if not Visuals_Enabled then
        for _, e in pairs(ESP) do HideESP(e) end
        return
    end

    local color = ESP_Color

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LP and ESP_HideLocal then
            if ESP[plr] then DestroyESP(plr) end
            continue
        end

        if ESP_TeamCheck and plr.Team and plr.Team == LP.Team then
            if ESP[plr] then DestroyESP(plr) end
            continue
        end

        local char = plr.Character
        local bones = char and GetBones(char)
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local show = false
        local dist = 0

        if bones and IsAlive(char) and hrp then
            local _, on, d = W2S(hrp.Position)
            if on and d <= ESP_MaxDist then
                show = true
                dist = math.floor(d)
            end
        end

        local e = ESP[plr]
        if not show then
            if e then HideESP(e) end
            continue
        end

        if not e then CreateESP(plr) end
        e = ESP[plr]
        if not e then continue end

        -- skeleton
        if ESP_Skeleton then
            local count = #bones
            for i = 1, count do
                local a = char:FindFirstChild(bones[i][1])
                local b = char:FindFirstChild(bones[i][2])
                if a and b then
                    local sa, oa = W2S(a.Position)
                    local sb, ob = W2S(b.Position)
                    e.lines[i].From = sa
                    e.lines[i].To = sb
                    e.lines[i].Visible = oa and ob
                    e.lines[i].Color = Color3.fromRGB(255, 255, 255)
                    e.lines[i].Thickness = ESP_Thickness
                else
                    e.lines[i].Visible = false
                end
            end
            for i = count + 1, 15 do e.lines[i].Visible = false end
        else
            for _, l in ipairs(e.lines) do l.Visible = false end
        end

        -- box + health + text
        if head and humanoid then
            local minV, maxV = GetCharBounds(char)
            if minV and maxV then
                local boxLeft, boxTop, boxRight, boxBot, boxOn = AABB2Screen(minV, maxV)

                if boxOn then
                    local boxH = boxBot - boxTop
                    local cx = (boxLeft + boxRight) / 2
                    local boxW = boxRight - boxLeft

                    -- filled box (background)
                    if ESP_FillBox then
                        e.boxFill.PointA = Vector2.new(boxLeft, boxTop)
                        e.boxFill.PointB = Vector2.new(boxRight, boxTop)
                        e.boxFill.PointC = Vector2.new(boxRight, boxBot)
                        e.boxFill.PointD = Vector2.new(boxLeft, boxBot)
                        e.boxFill.Color = color
                        e.boxFill.Transparency = 0.25
                        e.boxFill.Visible = true
                    else
                        e.boxFill.Visible = false
                    end

                    -- box outline (4 lines)
                    if ESP_Box then
                        e.boxLines[1].From = Vector2.new(boxLeft, boxTop)
                        e.boxLines[1].To = Vector2.new(boxRight, boxTop)
                        e.boxLines[2].From = Vector2.new(boxRight, boxTop)
                        e.boxLines[2].To = Vector2.new(boxRight, boxBot)
                        e.boxLines[3].From = Vector2.new(boxRight, boxBot)
                        e.boxLines[3].To = Vector2.new(boxLeft, boxBot)
                        e.boxLines[4].From = Vector2.new(boxLeft, boxBot)
                        e.boxLines[4].To = Vector2.new(boxLeft, boxTop)
                        for _, l in ipairs(e.boxLines) do
                            l.Visible = true
                            l.Color = color
                            l.Thickness = ESP_Thickness
                        end
                    else
                        for _, l in ipairs(e.boxLines) do l.Visible = false end
                    end

                    -- health bar (left side, 4px wide)
                    if ESP_Health then
                        local barW = 4
                        local barX = boxLeft - barW - 3
                        local barH = boxBot - boxTop
                        local hp = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)

                        e.hpBg.PointA = Vector2.new(barX, boxTop)
                        e.hpBg.PointB = Vector2.new(barX + barW, boxTop)
                        e.hpBg.PointC = Vector2.new(barX + barW, boxBot)
                        e.hpBg.PointD = Vector2.new(barX, boxBot)
                        e.hpBg.Color = Color3.fromRGB(20, 20, 20)
                        e.hpBg.Visible = true

                        local fill = barH * hp
                        e.hpBar.PointA = Vector2.new(barX, boxBot - fill)
                        e.hpBar.PointB = Vector2.new(barX + barW, boxBot - fill)
                        e.hpBar.PointC = Vector2.new(barX + barW, boxBot)
                        e.hpBar.PointD = Vector2.new(barX, boxBot)
                        if hp > 0.6 then
                            e.hpBar.Color = Color3.fromRGB(0, 255, 100)
                        elseif hp > 0.3 then
                            e.hpBar.Color = Color3.fromRGB(255, 200, 0)
                        else
                            e.hpBar.Color = Color3.fromRGB(255, 50, 50)
                        end
                        e.hpBar.Visible = true
                    else
                        e.hpBg.Visible = false
                        e.hpBar.Visible = false
                    end

                    -- nametag (above box)
                    if ESP_Name then
                        e.name.Position = Vector2.new(cx, boxTop - 16)
                        e.name.Text = plr.DisplayName
                        e.name.Color = Color3.fromRGB(255, 255, 255)
                        e.name.Size = 14
                        e.name.Visible = true
                    else
                        e.name.Visible = false
                    end

                    -- distance (below box)
                    local infoY = boxBot + 4
                    if ESP_Distance then
                        e.dist.Position = Vector2.new(cx, infoY)
                        e.dist.Text = "[" .. dist .. "m]"
                        e.dist.Color = Color3.fromRGB(180, 180, 180)
                        e.dist.Size = 12
                        e.dist.Visible = true
                    else
                        e.dist.Visible = false
                    end

                    -- weapon (below distance)
                    if ESP_Weapon then
                        local wName = GetWeaponName(char)
                        if wName ~= "" then
                            e.weapon.Position = Vector2.new(cx, infoY + 13)
                            e.weapon.Text = wName
                            e.weapon.Color = color
                            e.weapon.Size = 11
                            e.weapon.Visible = true
                        else
                            e.weapon.Visible = false
                        end
                    else
                        e.weapon.Visible = false
                    end

                    -- tracers (bottom center to box bottom)
                    if ESP_Tracer then
                        local vp = Camera.ViewportSize
                        e.tracer.From = Vector2.new(vp.X / 2, vp.Y)
                        e.tracer.To = Vector2.new(cx, boxBot)
                        e.tracer.Visible = true
                        e.tracer.Color = color
                        e.tracer.Thickness = ESP_Thickness
                        e.tracer.Transparency = 0.6
                    else
                        e.tracer.Visible = false
                    end
                else
                    -- box not on screen
                    e.boxFill.Visible = false
                    for _, l in ipairs(e.boxLines) do l.Visible = false end
                    e.hpBg.Visible = false
                    e.hpBar.Visible = false
                    e.name.Visible = false
                    e.dist.Visible = false
                    e.weapon.Visible = false
                    e.tracer.Visible = false
                end
            else
                -- bounds failed
                e.boxFill.Visible = false
                for _, l in ipairs(e.boxLines) do l.Visible = false end
                e.hpBg.Visible = false
                e.hpBar.Visible = false
                e.name.Visible = false
                e.dist.Visible = false
                e.weapon.Visible = false
                e.tracer.Visible = false
            end
        else
            -- no head/humanoid
            e.boxFill.Visible = false
            for _, l in ipairs(e.boxLines) do l.Visible = false end
            e.hpBg.Visible = false
            e.hpBar.Visible = false
            e.name.Visible = false
            e.dist.Visible = false
            e.weapon.Visible = false
            e.tracer.Visible = false
            for _, l in ipairs(e.lines) do l.Visible = false end
        end
    end
end

local LastClick = 0
local ValidParts = {}
for _, name in ipairs({"Head", "UpperTorso", "LowerTorso", "Torso", "HumanoidRootPart",
    "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
    ValidParts[name] = true
end

local function Click()
    pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, true, nil, 1) end)
    pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, false, nil, 1) end)
    pcall(function() mouse1press() end)
    pcall(function() mouse1release() end)
end

local function GetCharFromPart(part)
    if not part then return nil end
    local model = part:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    return model:FindFirstChildOfClass("Humanoid") and model or nil
end

local function GetPlayerFromCharacter(char)
    if not char then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character == char then return p end
    end
    return nil
end

local function RenderTriggerbot()
    if not Combat_Enabled or not Trig_Enabled then return end

    local rayOrigin = Camera.CFrame.Position
    local rayDir = Camera.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LP.Character}
    params.RespectCanCollide = false

    local result = workspace:Raycast(rayOrigin, rayDir * Trig_MaxDist, params)
    if not result then return end

    local hitPart = result.Instance
    if not ValidParts[hitPart.Name] then return end

    local hitChar = GetCharFromPart(hitPart)
    if not hitChar or not IsAlive(hitChar) then return end

    local hrp = hitChar:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
        if dist > Trig_MaxDist then return end
    end

    local now = tick()
    if Trig_Delay > 0 and (now - LastClick) < (Trig_Delay / 1000) then return end

    LastClick = now
    Click()
end

local function ScanAndReplace()
    if not Sounds_Enabled then return end
    if HitSoundID == "rbxassetid://0" and ShootSoundID == "rbxassetid://0" and KillSoundID == "rbxassetid://0" then return end

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") then
            if HitSoundID ~= "rbxassetid://0" and v.Name == "HitSound" then
                if v.SoundId ~= HitSoundID then v.SoundId = HitSoundID end
            elseif ShootSoundID ~= "rbxassetid://0" and (v.Name == "Shoot1" or v.Name == "Shoot" or v.Name == "Fire") then
                if v.SoundId ~= ShootSoundID then v.SoundId = ShootSoundID end
            end
        end
    end

    if KillSoundID ~= "rbxassetid://0" then
        local elim = game:GetService("SoundService"):FindFirstChild("EliminatedSound")
        if elim and elim.SoundId ~= KillSoundID then
            elim.SoundId = KillSoundID
        end
    end
end

local Textures = RS:FindFirstChild("Textures")
local FACES = {
    Enum.NormalId.Front, Enum.NormalId.Back,
    Enum.NormalId.Top, Enum.NormalId.Bottom,
    Enum.NormalId.Left, Enum.NormalId.Right,
}

local function isForTexturePart(p)
    if not p:IsA("BasePart") then return false end
    return p.Name == "ForTexture" or p.Name:match("^ForTexture%d+$") ~= nil
end

local function isKnifeTexturePart(p)
    if not p:IsA("BasePart") then return false end
    return p.Name ~= "Main" and p.Name ~= "Grip" and p.Name ~= "Grip1" and p.Name ~= "Grip2" and p.Name ~= "Grip3"
end

local function clearTextures(part)
    for _, v in ipairs(part:GetChildren()) do
        if v:IsA("Texture") or v:IsA("Decal") then
            v:Destroy()
        end
    end
end

local function applyTexToPart(part, texSource)
    if not texSource then return end
    local function applyOne(tex)
        if not (tex:IsA("Texture") or tex:IsA("Decal")) then return end
        for _, face in ipairs(FACES) do
            local clone = tex:Clone()
            clone.Face = face
            clone.Parent = part
        end
    end
    if texSource:IsA("Texture") or texSource:IsA("Decal") then
        applyOne(texSource)
    else
        for _, child in ipairs(texSource:GetChildren()) do
            applyOne(child)
        end
    end
end

local function getSkinTexture(weaponName, skinName)
    if not Textures then return nil end
    local wf = Textures:FindFirstChild(weaponName)
    if not wf then return nil end
    for _, rarity in ipairs(wf:GetChildren()) do
        if rarity:IsA("Folder") then
            local sf = rarity:FindFirstChild(skinName)
            if sf then return sf:FindFirstChild("TextureImage") end
        end
    end
    return nil
end

local function getFPSModel(tool)
    if not tool then return nil end
    for _, v in ipairs(tool:GetChildren()) do
        if v:IsA("Model") and v.Name:match("_FPSMODEL$") then return v end
    end
    for _, v in ipairs(tool:GetDescendants()) do
        if v:IsA("Model") and v.Name:match("_FPSMODEL$") then return v end
    end
    return nil
end

local function FindTool(weaponName)
    local char = LP.Character
    if char then
        local t = char:FindFirstChild(weaponName)
        if t then return t end
    end
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        local t = bp:FindFirstChild(weaponName)
        if t then return t end
    end
    return nil
end

local function ApplyDESkins()
    if not Skins_Enabled then return end
    if DESkinName == "Default" then return end
    local tool = FindTool("Desert Eagle")
    if not tool then return end

    local models = {}
    local fps = getFPSModel(tool)
    if fps then models[#models+1] = fps end
    local worldModel = tool:FindFirstChild("Desert Eagle")
    if worldModel then models[#models+1] = worldModel end

    local texSource = nil
    if DESkinID == "lookup" then
        texSource = getSkinTexture("Desert Eagle", DESkinName)
    end

    for _, model in ipairs(models) do
        for _, v in ipairs(model:GetDescendants()) do
            if isForTexturePart(v) then clearTextures(v) end
        end
        if texSource then
            for _, v in ipairs(model:GetDescendants()) do
                if isForTexturePart(v) then applyTexToPart(v, texSource) end
            end
        elseif DESkinID ~= "lookup" then
            local tmp = Instance.new("Texture")
            tmp.Texture = DESkinID
            for _, v in ipairs(model:GetDescendants()) do
                if isForTexturePart(v) then applyTexToPart(v, tmp) end
            end
            tmp:Destroy()
        end
    end
end

local function ApplyKnifeSkins()
    if not Skins_Enabled then return end
    if KnifeSkinName == "Default" then return end
    local knifeNames = {"M9Bayonet", "Butterfly", "Karambit"}
    local tool, weaponName
    for _, name in ipairs(knifeNames) do
        tool = FindTool(name)
        if tool then weaponName = name break end
    end
    if not tool then return end

    local models = {}
    local fps = getFPSModel(tool)
    if fps then models[#models+1] = fps end
    local worldModel = tool:FindFirstChild(weaponName)
    if worldModel then models[#models+1] = worldModel end

    local texSource = getSkinTexture(weaponName, KnifeSkinName)

    for _, model in ipairs(models) do
        for _, v in ipairs(model:GetDescendants()) do
            if isKnifeTexturePart(v) then clearTextures(v) end
        end
        if texSource then
            for _, v in ipairs(model:GetDescendants()) do
                if isKnifeTexturePart(v) then applyTexToPart(v, texSource) end
            end
        end
    end
end

local SoundTick = 0
Connections.render = RunService.RenderStepped:Connect(function()
    pcall(RenderESP)
    pcall(RenderTriggerbot)

    SoundTick = SoundTick + 1
    if SoundTick >= 60 then
        SoundTick = 0
        pcall(ScanAndReplace)
        pcall(ApplyDESkins)
        pcall(ApplyKnifeSkins)
    end
end)

Connections.playerAdded = Players.PlayerAdded:Connect(function(p)
    pcall(CreateESP, p)
end)

Connections.playerRemoving = Players.PlayerRemoving:Connect(function(p)
    pcall(DestroyESP, p)
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP or not ESP_HideLocal then pcall(CreateESP, p) end
end

task.delay(2, function()
    pcall(ScanAndReplace)
end)

local function Unload()
    for k, v in pairs(Connections) do
        pcall(function() if v and v.Connected then v:Disconnect() end end)
    end
    Connections = {}
    for p, _ in pairs(ESP) do pcall(DestroyESP, p) end
    ESP = {}
    for _, gui in ipairs(CoreGui:GetChildren()) do
        if gui.Name == "neverloose" and gui:IsA("ScreenGui") then
            pcall(function() gui:Destroy() end)
        end
    end
    if UIScreen then
        pcall(function() UIScreen:Destroy() end)
        UIScreen = nil
    end
    pcall(function()
        for _, gui in ipairs(LP.PlayerGui:GetChildren()) do
            if gui.Name == "neverloose" and gui:IsA("ScreenGui") then
                gui:Destroy()
            end
        end
    end)
    _G[GLOBAL_KEY] = nil
    _G[CLEANUP_KEY] = nil
end

_G[CLEANUP_KEY] = Unload
print("[neverloose] v" .. VERSION .. " loaded")
