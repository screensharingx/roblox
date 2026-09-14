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
            function GroupTypes:CreateToggle(name, callback)
                name = name or "New Toggle"
                callback = callback or function(v) print(v) end
                local ToggleTypes = {}
                local Enabled = false
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
            function GroupTypes:CreateESPPreview(opts)
                opts = opts or {}
                local accent = opts.accent or Color3.fromRGB(19, 119, 255)
                local boxColor = opts.boxColor or Color3.fromRGB(0, 255, 0)
                local skeletonColor = opts.skeletonColor or Color3.fromRGB(255, 255, 255)
                local healthHigh = opts.healthHigh or Color3.fromRGB(0, 255, 0)
                local healthLow = opts.healthLow or Color3.fromRGB(255, 0, 0)
                local preview = Instance.new("Frame")
                preview.Name = "ESPPreview"
                preview.Parent = container_2
                preview.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                preview.BorderColor3 = Color3.fromRGB(8, 8, 8)
                preview.Size = UDim2.new(1, -20, 0, 300)
                preview.ClipsDescendants = true
                local previewInline = Instance.new("Frame")
                previewInline.Parent = preview
                previewInline.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                previewInline.BorderSizePixel = 0
                previewInline.Position = UDim2.new(0, 1, 0, 1)
                previewInline.Size = UDim2.new(1, -2, 1, -2)
                local previewTitle = Instance.new("TextLabel")
                previewTitle.Parent = previewInline
                previewTitle.BackgroundTransparency = 1
                previewTitle.Position = UDim2.new(0, 10, 0, 4)
                previewTitle.Size = UDim2.new(0, 200, 0, 16)
                previewTitle.Font = Enum.Font.SourceSans
                previewTitle.Text = "ESP Preview"
                previewTitle.TextColor3 = accent
                previewTitle.TextSize = 13
                previewTitle.TextXAlignment = Enum.TextXAlignment.Left
                local canvas = Instance.new("Frame")
                canvas.Parent = previewInline
                canvas.BackgroundTransparency = 1
                canvas.Position = UDim2.new(0, 0, 0, 22)
                canvas.Size = UDim2.new(1, 0, 1, -26)
                local function makeLine(parent, p, s, rot, col)
                    local l = Instance.new("Frame")
                    l.Parent = parent
                    l.AnchorPoint = Vector2.new(0.5, 0.5)
                    l.BackgroundColor3 = col
                    l.BorderSizePixel = 0
                    l.Position = p
                    l.Size = s
                    l.Rotation = rot or 0
                    l.ZIndex = 5
                    return l
                end
                local function makeText(parent, p, s, txt, col, sz, align)
                    local t = Instance.new("TextLabel")
                    t.Parent = parent
                    t.BackgroundTransparency = 1
                    t.Position = p
                    t.Size = s
                    t.Font = Enum.Font.SourceSans
                    t.Text = txt
                    t.TextColor3 = col
                    t.TextSize = sz or 11
                    t.TextStrokeTransparency = 0.3
                    t.ZIndex = 10
                    t.TextXAlignment = align or Enum.TextXAlignment.Center
                    return t
                end
                local cx = 0.5
                local headY = 0.12
                local neckY = 0.21
                local shoulderY = 0.25
                local hipY = 0.52
                local kneeY = 0.72
                local head = Instance.new("Frame")
                head.Parent = canvas
                head.AnchorPoint = Vector2.new(0.5, 0.5)
                head.BackgroundColor3 = skeletonColor
                head.BackgroundTransparency = 0.3
                head.Position = UDim2.new(cx, 0, headY, 0)
                head.Size = UDim2.new(0, 20, 0, 20)
                head.ZIndex = 4
                Instance.new("UICorner", head).CornerRadius = UDim.new(1, 0)
                makeLine(canvas, UDim2.new(cx, 0, (neckY + hipY) / 2, 0), UDim2.new(0, 2, 0, (hipY - neckY) * 270), 0, skeletonColor)
                makeLine(canvas, UDim2.new(cx, 0, shoulderY, 0), UDim2.new(0, 40, 0, 2), 0, skeletonColor)
                makeLine(canvas, UDim2.new(cx - 0.045, 0, shoulderY, 0), UDim2.new(0, 2, 0, 35), 25, skeletonColor)
                makeLine(canvas, UDim2.new(cx - 0.065, 0, shoulderY + 0.06, 0), UDim2.new(0, 2, 0, 32), 5, skeletonColor)
                makeLine(canvas, UDim2.new(cx + 0.045, 0, shoulderY, 0), UDim2.new(0, 2, 0, 35), -25, skeletonColor)
                makeLine(canvas, UDim2.new(cx + 0.065, 0, shoulderY + 0.06, 0), UDim2.new(0, 2, 0, 32), -5, skeletonColor)
                makeLine(canvas, UDim2.new(cx, 0, hipY, 0), UDim2.new(0, 24, 0, 2), 0, skeletonColor)
                makeLine(canvas, UDim2.new(cx - 0.03, 0, hipY, 0), UDim2.new(0, 2, 0, 55), 8, skeletonColor)
                makeLine(canvas, UDim2.new(cx - 0.04, 0, kneeY, 0), UDim2.new(0, 2, 0, 55), 3, skeletonColor)
                makeLine(canvas, UDim2.new(cx + 0.03, 0, hipY, 0), UDim2.new(0, 2, 0, 55), -8, skeletonColor)
                makeLine(canvas, UDim2.new(cx + 0.04, 0, kneeY, 0), UDim2.new(0, 2, 0, 55), -3, skeletonColor)
                local boxX = cx - 0.12
                local boxY = headY - 0.065
                local boxW = 0.24
                local boxH = 0.88
                makeLine(canvas, UDim2.new(cx, 0, boxY, 0), UDim2.new(boxW, 0, 0, 2), 0, boxColor)
                makeLine(canvas, UDim2.new(cx, 0, boxY + boxH, 0), UDim2.new(boxW, 0, 0, 2), 0, boxColor)
                makeLine(canvas, UDim2.new(boxX, 0, (boxY + boxY + boxH) / 2, 0), UDim2.new(0, 2, 0, boxH * 270), 0, boxColor)
                makeLine(canvas, UDim2.new(boxX + boxW, 0, (boxY + boxY + boxH) / 2, 0), UDim2.new(0, 2, 0, boxH * 270), 0, boxColor)
                local hbX = boxX - 0.03
                local hbTop = boxY + 0.01
                local hbBot = boxY + boxH - 0.01
                local hbH = hbBot - hbTop
                local hbBg = Instance.new("Frame")
                hbBg.Parent = canvas
                hbBg.AnchorPoint = Vector2.new(0.5, 0)
                hbBg.Position = UDim2.new(hbX, 0, hbTop, 0)
                hbBg.Size = UDim2.new(0.01, 0, hbH, 0)
                hbBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                hbBg.BorderSizePixel = 0
                hbBg.ZIndex = 6
                local hbFill = Instance.new("Frame")
                hbFill.Parent = hbBg
                hbFill.AnchorPoint = Vector2.new(0, 1)
                hbFill.Position = UDim2.new(0, 0, 1, 0)
                hbFill.Size = UDim2.new(1, 0, 0.72, 0)
                hbFill.BackgroundColor3 = healthHigh
                hbFill.BorderSizePixel = 0
                hbFill.ZIndex = 7
                makeText(canvas, UDim2.new(hbX - 0.025, 0, hbTop - 0.025, 0), UDim2.new(0, 30, 0, 12), "72", healthHigh, 10)
                makeText(canvas, UDim2.new(cx, 0, boxY - 0.04, 0), UDim2.new(0, 120, 0, 14), "PlayerName", Color3.fromRGB(255, 255, 255), 12)
                makeText(canvas, UDim2.new(cx, 0, boxY + boxH + 0.01, 0), UDim2.new(0, 60, 0, 12), "[24m]", Color3.fromRGB(180, 180, 180), 10)
                makeText(canvas, UDim2.new(cx, 0, boxY + boxH + 0.03, 0), UDim2.new(0, 80, 0, 12), "AK-47", accent, 9)
                makeLine(canvas, UDim2.new(0.5, 0, 1, 0), UDim2.new(0, 1, 0, (1 - (boxY + boxH)) * 270 - 8), 0, accent)
                local ESPPreviewTypes = {}
                function ESPPreviewTypes:SetColors(cfg)
                    if cfg.box then boxColor = cfg.box end
                    if cfg.skeleton then skeletonColor = cfg.skeleton end
                    if cfg.accent then accent = cfg.accent end
                    if cfg.healthHigh then healthHigh = cfg.healthHigh end
                    if cfg.healthLow then healthLow = cfg.healthLow end
                end
                function ESPPreviewTypes:GetCanvas() return canvas end
                return ESPPreviewTypes
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
local ESP_Name       = true
local ESP_Health     = true
local ESP_Distance   = true
local ESP_Weapon     = true
local ESP_Tracer     = false
local ESP_Thickness  = 1
local ESP_MaxDist    = 2000
local ESP_HideLocal  = true
local ESP_TeamCheck  = false

local DESkinName     = "Default"
local DESkinID       = "rbxassetid://0"
local KnifeSkinName  = "Default"
local HitSoundID     = "rbxassetid://0"
local ShootSoundID   = "rbxassetid://0"
local KillSoundID    = "rbxassetid://0"

local Connections = {}
local ESP = {}
local UIScreen = nil
local ActiveTabIndex = 3

local Window, ScreenGui = Library:CreateWindow("neverloose", Color3.fromRGB(0, 255, 255))
UIScreen = ScreenGui

local CombatTab  = Window:CreateTab("Combat")
local VisualsTab = Window:CreateTab("Visuals")
local SoundsTab  = Window:CreateTab("Sounds")
local SkinsTab   = Window:CreateTab("Skins")

local function DetectActiveTab()
    local core = ScreenGui:FindFirstChild("core", true)
    if not core then return end
    local mainContainer = nil
    for _, v in ipairs(core:GetDescendants()) do
        if v:IsA("Frame") and v.Name == "container" and v.Parent and v.Parent:IsA("Frame") and v.Parent.Name == "inlinecore" then
            mainContainer = v
            break
        end
    end
    if not mainContainer then return end
    local idx = 0
    for _, child in ipairs(mainContainer:GetChildren()) do
        if child.Name == "container" and child:IsA("Frame") then
            idx = idx + 1
            if child.Visible then
                ActiveTabIndex = idx
                return
            end
        end
    end
end

local ESPPreviewFrame
do
    local accent    = Color3.fromRGB(0, 255, 255)
    local boxColor  = Color3.fromRGB(0, 255, 0)
    local skelColor = Color3.fromRGB(255, 255, 255)
    local hpHigh    = Color3.fromRGB(0, 255, 0)

    ESPPreviewFrame = Instance.new("Frame")
    ESPPreviewFrame.Name = "ESPPreview"
    ESPPreviewFrame.Parent = ScreenGui
    ESPPreviewFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    ESPPreviewFrame.BorderColor3 = Color3.fromRGB(8, 8, 8)
    ESPPreviewFrame.Size = UDim2.new(0, 220, 0, 340)
    ESPPreviewFrame.ClipsDescendants = true
    ESPPreviewFrame.Visible = false
    Instance.new("UICorner", ESPPreviewFrame).CornerRadius = UDim.new(0, 6)

    local inner = Instance.new("Frame")
    inner.Parent = ESPPreviewFrame
    inner.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    inner.BorderSizePixel = 0
    inner.Position = UDim2.new(0, 1, 0, 1)
    inner.Size = UDim2.new(1, -2, 1, -2)
    Instance.new("UICorner", inner).CornerRadius = UDim.new(0, 5)

    local title = Instance.new("TextLabel")
    title.Parent = inner
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 10, 0, 6)
    title.Size = UDim2.new(1, -20, 0, 16)
    title.Font = Enum.Font.GothamBold
    title.Text = "ESP Preview"
    title.TextColor3 = accent
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left

    local canvas = Instance.new("Frame")
    canvas.Parent = inner
    canvas.BackgroundTransparency = 1
    canvas.Position = UDim2.new(0, 0, 0, 24)
    canvas.Size = UDim2.new(1, 0, 1, -30)

    local function mkLine(parent, p, s, rot, col)
        local l = Instance.new("Frame")
        l.Parent = parent
        l.AnchorPoint = Vector2.new(0.5, 0.5)
        l.BackgroundColor3 = col
        l.BorderSizePixel = 0
        l.Position = p
        l.Size = s
        l.Rotation = rot or 0
        l.ZIndex = 5
        return l
    end

    local function mkText(parent, p, s, txt, col, sz)
        local t = Instance.new("TextLabel")
        t.Parent = parent
        t.BackgroundTransparency = 1
        t.Position = p
        t.Size = s
        t.Font = Enum.Font.Gotham
        t.Text = txt
        t.TextColor3 = col
        t.TextSize = sz or 11
        t.TextStrokeTransparency = 0.3
        t.ZIndex = 10
        t.TextXAlignment = Enum.TextXAlignment.Center
        return t
    end

    local cx = 0.5
    local headY = 0.12
    local neckY = 0.21
    local shY   = 0.25
    local hipY  = 0.52
    local kneeY = 0.72

    local head = Instance.new("Frame")
    head.Parent = canvas
    head.AnchorPoint = Vector2.new(0.5, 0.5)
    head.BackgroundColor3 = skelColor
    head.BackgroundTransparency = 0.3
    head.Position = UDim2.new(cx, 0, headY, 0)
    head.Size = UDim2.new(0, 18, 0, 18)
    head.ZIndex = 4
    Instance.new("UICorner", head).CornerRadius = UDim.new(1, 0)

    mkLine(canvas, UDim2.new(cx, 0, (neckY + hipY) / 2, 0), UDim2.new(0, 2, 0, (hipY - neckY) * 280), 0, skelColor)
    mkLine(canvas, UDim2.new(cx, 0, shY, 0), UDim2.new(0, 36, 0, 2), 0, skelColor)
    mkLine(canvas, UDim2.new(cx - 0.04, 0, shY, 0), UDim2.new(0, 2, 0, 32), 25, skelColor)
    mkLine(canvas, UDim2.new(cx - 0.058, 0, shY + 0.06, 0), UDim2.new(0, 2, 0, 28), 5, skelColor)
    mkLine(canvas, UDim2.new(cx + 0.04, 0, shY, 0), UDim2.new(0, 2, 0, 32), -25, skelColor)
    mkLine(canvas, UDim2.new(cx + 0.058, 0, shY + 0.06, 0), UDim2.new(0, 2, 0, 28), -5, skelColor)
    mkLine(canvas, UDim2.new(cx, 0, hipY, 0), UDim2.new(0, 22, 0, 2), 0, skelColor)
    mkLine(canvas, UDim2.new(cx - 0.028, 0, hipY, 0), UDim2.new(0, 2, 0, 50), 8, skelColor)
    mkLine(canvas, UDim2.new(cx - 0.038, 0, kneeY, 0), UDim2.new(0, 2, 0, 50), 3, skelColor)
    mkLine(canvas, UDim2.new(cx + 0.028, 0, hipY, 0), UDim2.new(0, 2, 0, 50), -8, skelColor)
    mkLine(canvas, UDim2.new(cx + 0.038, 0, kneeY, 0), UDim2.new(0, 2, 0, 50), -3, skelColor)

    local bx = cx - 0.11
    local by = headY - 0.06
    local bw = 0.22
    local bh = 0.86
    mkLine(canvas, UDim2.new(cx, 0, by, 0), UDim2.new(bw, 0, 0, 2), 0, boxColor)
    mkLine(canvas, UDim2.new(cx, 0, by + bh, 0), UDim2.new(bw, 0, 0, 2), 0, boxColor)
    mkLine(canvas, UDim2.new(bx, 0, (by + by + bh) / 2, 0), UDim2.new(0, 2, 0, bh * 280), 0, boxColor)
    mkLine(canvas, UDim2.new(bx + bw, 0, (by + by + bh) / 2, 0), UDim2.new(0, 2, 0, bh * 280), 0, boxColor)

    local hbX = bx - 0.028
    local hbTop = by + 0.01
    local hbBot = by + bh - 0.01
    local hbH = hbBot - hbTop

    local hbBg = Instance.new("Frame")
    hbBg.Parent = canvas
    hbBg.AnchorPoint = Vector2.new(0.5, 0)
    hbBg.Position = UDim2.new(hbX, 0, hbTop, 0)
    hbBg.Size = UDim2.new(0.012, 0, hbH, 0)
    hbBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    hbBg.BorderSizePixel = 0
    hbBg.ZIndex = 6

    local hbFill = Instance.new("Frame")
    hbFill.Parent = hbBg
    hbFill.AnchorPoint = Vector2.new(0, 1)
    hbFill.Position = UDim2.new(0, 0, 1, 0)
    hbFill.Size = UDim2.new(1, 0, 0.72, 0)
    hbFill.BackgroundColor3 = hpHigh
    hbFill.BorderSizePixel = 0
    hbFill.ZIndex = 7

    mkText(canvas, UDim2.new(hbX - 0.03, 0, hbTop - 0.03, 0), UDim2.new(0, 28, 0, 12), "72", hpHigh, 10)
    mkText(canvas, UDim2.new(cx, 0, by - 0.04, 0), UDim2.new(0, 120, 0, 14), "PlayerName", Color3.fromRGB(255, 255, 255), 12)
    mkText(canvas, UDim2.new(cx, 0, by + bh + 0.01, 0), UDim2.new(0, 60, 0, 12), "[24m]", Color3.fromRGB(180, 180, 180), 10)
    mkText(canvas, UDim2.new(cx, 0, by + bh + 0.03, 0), UDim2.new(0, 80, 0, 12), "AK-47", accent, 9)
    mkLine(canvas, UDim2.new(0.5, 0, 1, 0), UDim2.new(0, 1, 0, (1 - (by + bh)) * 280 - 8), 0, accent)
end

local CombatGroup = CombatTab:CreateGroupbox("Triggerbot")
CombatGroup:CreateToggle("Enable Combat", function(v)
    Combat_Enabled = v
    Notify("Combat", v and "ON" or "OFF", 2)
end):CreateKeyBind("T")
CombatGroup:CreateToggle("Triggerbot", function(v) Trig_Enabled = v end)
CombatGroup:CreateSlider("Max Distance", 100, 2000, 500, function(v) Trig_MaxDist = v end)
CombatGroup:CreateSlider("Delay (ms)", 0, 200, 0, function(v) Trig_Delay = v end)

local VisualsGroup = VisualsTab:CreateGroupbox("Visuals")
VisualsGroup:CreateToggle("Enable Visuals", function(v)
    Visuals_Enabled = v
    if not v then
        for p, _ in pairs(ESP) do pcall(DestroyESP, p) end
    end
    Notify("Visuals", v and "ON" or "OFF", 2)
end):CreateKeyBind("P")
VisualsGroup:CreateToggle("Skeleton", function(v) ESP_Skeleton = v end)
VisualsGroup:CreateToggle("Box", function(v) ESP_Box = v end)
VisualsGroup:CreateToggle("Nametag", function(v) ESP_Name = v end)
VisualsGroup:CreateToggle("Health Bar", function(v) ESP_Health = v end)
VisualsGroup:CreateToggle("Distance", function(v) ESP_Distance = v end)
VisualsGroup:CreateToggle("Weapon", function(v) ESP_Weapon = v end)
VisualsGroup:CreateToggle("Tracers", function(v) ESP_Tracer = v end)
VisualsGroup:CreateSlider("Thickness", 1, 5, 1, function(v) ESP_Thickness = v end)
VisualsGroup:CreateSlider("Max Distance", 500, 5000, 2000, function(v) ESP_MaxDist = v end)
VisualsGroup:CreateToggle("Hide Local Player", function(v) ESP_HideLocal = v end)
VisualsGroup:CreateToggle("Team Check", function(v) ESP_TeamCheck = v end)

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

local function CreateTextbox(parent, label, default, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -8, 0, 24)
    f.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    f.BorderSizePixel = 0
    f.Parent = parent

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(0.35, 0, 1, 0)
    t.Position = UDim2.new(0, 8, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = label
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.TextSize = 13
    t.Font = Enum.Font.SourceSans
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = f

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.6, 0, 0.75, 0)
    box.Position = UDim2.new(0.37, 0, 0.125, 0)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.BorderSizePixel = 0
    box.Text = default or ""
    box.TextColor3 = Color3.fromRGB(200, 200, 200)
    box.TextSize = 12
    box.Font = Enum.Font.SourceSans
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.Parent = f

    box.FocusLost:Connect(function() callback(box.Text) end)
    return box
end

local CustomSkinGroup = SkinsTab:CreateGroupbox("Custom Skin ID")
CreateTextbox(CustomSkinGroup, "Texture ID", "rbxassetid://", function(v)
    if v and v ~= "" and v ~= "rbxassetid://" then
        DESkinID = v
        DESkinName = "Custom"
        Notify("Skins", "Custom skin applied", 2)
    end
end)

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
            hpBar = nil,
            hpBg = nil,
            tracer = nil,
            name = nil,
            dist = nil,
            weapon = nil,
        }
        for i = 1, 15 do data.lines[i] = MakeLine() end
        for i = 1, 4 do data.boxLines[i] = MakeLine() end
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

local function RenderESP()
    Camera = workspace.CurrentCamera
    if not Visuals_Enabled then
        for _, e in pairs(ESP) do HideESP(e) end
        return
    end

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

        local color = Color3.fromRGB(0, 255, 255)

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
                    e.lines[i].Color = color
                    e.lines[i].Thickness = ESP_Thickness
                else
                    e.lines[i].Visible = false
                end
            end
            for i = count + 1, 15 do e.lines[i].Visible = false end
        else
            for _, l in ipairs(e.lines) do l.Visible = false end
        end

        if head and humanoid then
            local top, topOn = W2S(head.Position + Vector3.new(0, 0.6, 0))
            local bot, botOn = W2S(head.Position + Vector3.new(0, -3.2, 0))

            if ESP_Box and topOn and botOn then
                local boxH = bot.Y - top.Y
                local boxW = boxH / 2
                local boxCenterX = top.X
                local boxLeft = boxCenterX - boxW / 2
                local boxRight = boxCenterX + boxW / 2
                local boxTop = top.Y
                local boxBot = bot.Y

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

            if ESP_Health and topOn and botOn then
                local barW, barX = 3, top.X - 8
                local barH = bot.Y - top.Y
                local hp = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                e.hpBg.PointA = Vector2.new(barX, top.Y)
                e.hpBg.PointB = Vector2.new(barX + barW, top.Y)
                e.hpBg.PointC = Vector2.new(barX + barW, top.Y + barH)
                e.hpBg.PointD = Vector2.new(barX, top.Y + barH)
                e.hpBg.Visible = true
                local fill = barH * hp
                e.hpBar.PointA = Vector2.new(barX, top.Y + barH - fill)
                e.hpBar.PointB = Vector2.new(barX + barW, top.Y + barH - fill)
                e.hpBar.PointC = Vector2.new(barX + barW, top.Y + barH)
                e.hpBar.PointD = Vector2.new(barX, top.Y + barH)
                e.hpBar.Visible = true
                e.hpBar.Color = hp > 0.5 and Color3.fromRGB(0, 255, 255) or hp > 0.25 and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(255, 50, 50)
            else
                e.hpBg.Visible = false
                e.hpBar.Visible = false
            end

            if topOn then
                local nameY = top.Y - 18
                if ESP_Name then
                    e.name.Position = Vector2.new(top.X, nameY)
                    e.name.Text = plr.DisplayName
                    e.name.Visible = true
                else
                    e.name.Visible = false
                end

                local infoY = botOn and bot.Y + 4 or top.Y + 40
                if ESP_Distance then
                    e.dist.Position = Vector2.new(top.X, infoY)
                    e.dist.Text = "[" .. dist .. "m]"
                    e.dist.Visible = true
                else
                    e.dist.Visible = false
                end

                if ESP_Weapon then
                    e.weapon.Position = Vector2.new(top.X, infoY + 14)
                    e.weapon.Text = GetWeaponName(char)
                    e.weapon.Visible = true
                else
                    e.weapon.Visible = false
                end

                if ESP_Tracer then
                    local screenW = Camera.ViewportSize.X
                    e.tracer.From = Vector2.new(screenW / 2, Camera.ViewportSize.Y)
                    e.tracer.To = Vector2.new(top.X, botOn and bot.Y or top.Y + 40)
                    e.tracer.Visible = true
                    e.tracer.Color = color
                    e.tracer.Thickness = ESP_Thickness
                else
                    e.tracer.Visible = false
                end
            else
                e.name.Visible = false
                e.dist.Visible = false
                e.weapon.Visible = false
                e.tracer.Visible = false
            end
        else
            e.hpBg.Visible = false
            e.hpBar.Visible = false
            e.name.Visible = false
            e.dist.Visible = false
            e.weapon.Visible = false
            e.tracer.Visible = false
            for _, l in ipairs(e.boxLines) do l.Visible = false end
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
    pcall(function()
        DetectActiveTab()
        ESPPreviewFrame.Visible = (ActiveTabIndex == 2)
        if ESPPreviewFrame.Visible then
            local core = ScreenGui:FindFirstChild("core", true)
            if core then
                ESPPreviewFrame.Position = UDim2.new(0, core.AbsolutePosition.X + core.AbsoluteSize.X + 12, 0, core.AbsolutePosition.Y)
            end
        end
    end)

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
