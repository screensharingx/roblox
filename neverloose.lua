--[[
    neverloose — Unified Roblox Cheat UI
    UI: Bracket Lib V2 (embedded)

    Tabs:
        Combat  — Triggerbot
        Visuals — Skeleton ESP, Health Bars, Tracers
        Sounds  — Hit / Shoot / Kill sounds

    Press RightControl to toggle UI.
    VERSION: 3
]]

local Library = {}

function Library:GetColor(color, table)
    table = table or false
    if (color.R == nil) then return Color3.fromRGB(19, 119, 255) end

    local ColorRed = math.round(color.R * 255)
    local ColorGreen = math.round(color.G * 255)
    local ColorBlue = math.round(color.B * 255)

    if (table) then
        return {
            Red = ColorRed,
            Green = ColorGreen,
            Blue = ColorBlue,
        }
    else
        return Color3.fromRGB(ColorRed, ColorGreen, ColorBlue)
    end
end

function Library:GetSide(LeftSize, RightSize)
    if LeftSize - 1 > RightSize - 1 then
        return "Right"
    else
        return "Left"
    end
end

function Library:CreateWindow(title, color)
    title = title or "Bracket Lib V2"
    color = color and Library:GetColor(color) or Color3.fromRGB(19, 119, 255)

    -- Window Main
    local WinTypes = {}
    local WindowDragging, SliderDragging, ColorPickerDragging = false, false, false
    local oldcolor = nil
    local keybind = "RightControl"
    local cancbind = false

    -- Window Instances
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

    -- Window Properties
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

    -- Window Dragging
    local userinputservice = game:GetService("UserInputService")
    local dragInput, dragStart, startPos = nil, nil, nil

    core.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and userinputservice:GetFocusedTextBox() == nil then
            dragStart = input.Position
            startPos = core.Position
            WindowDragging = true
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    WindowDragging = false
                end
            end)
        end
    end)

    core.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    userinputservice.InputChanged:Connect(function(input)
        if input == dragInput and WindowDragging and not SliderDragging and not ColorPickerDragging then
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            core.Position = Position
        end
    end)

    userinputservice.InputBegan:Connect(function(input)
        if (cancbind) then
            if (input.KeyCode == Enum.KeyCode[keybind]) then
                BracketV2.Enabled = not BracketV2.Enabled
            end
        else
            if (input.KeyCode == Enum.KeyCode.RightControl) then
                BracketV2.Enabled = not BracketV2.Enabled
            end
        end
    end)

    -- Window Types
    function WinTypes:Destroy()
        BracketV2:Destory()
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

        -- Tab Main
        local TabTypes = {}

        -- Tab Instances
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

        -- Tab Properties
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

        -- Tab Code
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

        -- Tab Types
        function TabTypes:CreateGroupbox(name, side)
            name = name or "NewGroupbox"
            side = side and side or Library:GetSide(#Left:GetChildren(), #Right:GetChildren())

            -- Groupbox Main
            local GroupTypes = {}

            -- Groupbox Instances
            local groupboxoutline = Instance.new("Frame")
            local groupboxinline = Instance.new("Frame")
            local background = Instance.new("Frame")
            local title_2 = Instance.new("TextLabel")
            local container_2 = Instance.new("Frame")
            local UIPadding_2 = Instance.new("UIPadding")
            local UIListLayout_3 = Instance.new("UIListLayout")

            -- Groupbox Properties
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
                groupboxinline.Size = UDim2.new(0, 252, 0, (UIListLayout_3.AbsoluteContentSize.Y - 2)  + 30)
                background.Size = UDim2.new(0, 250, 0, (UIListLayout_3.AbsoluteContentSize.Y - 4)  + 30)
                container_2.Size = UDim2.new(0, 250, 0, (UIListLayout_3.AbsoluteContentSize.Y - 14) + 30)
            end)

            -- Groupbox Types
            function GroupTypes:CreateToggle(name, callback)
                name = name or "New Toggle"
                callback = callback or function(v) print(v) end

                -- Toggle Main
                local ToggleTypes = {}
                local Enabled = false

                -- Toggle Instances
                local checkbox = Instance.new("Frame")
                local UIGradient_2 = Instance.new("UIGradient")
                local title_3 = Instance.new("TextLabel")
                local main = Instance.new("TextButton")

                -- Toggle Properties
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

                -- Toggle Code
                local ToggleCallback = callback

                game.RunService.Heartbeat:Connect(function()
                    if (checkbox.BackgroundColor3 == oldcolor) then
                        checkbox.BackgroundColor3 = color
                    end
                end)

                main.MouseButton1Click:Connect(function()
                    Enabled = not Enabled

                    if (Enabled) then
                        checkbox.BackgroundColor3 = color
                    else
                        checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end

                    callback(Enabled)
                end)

                -- Toggle Types
                function ToggleTypes:SetState(state)
                    state = state or false
                    Enabled = state

                    if (Enabled) then
                        checkbox.BackgroundColor3 = color
                    else
                        checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end

                    callback(Enabled)
                end

                function ToggleTypes:GetState()
                    return Enabled
                end

                function ToggleTypes:CreateKeyBind(def, callback)
                    def = def or "NONE"

                    -- Keybind Main
                    local keytypes = {}

                    -- Keybind Instances
                    local bindtext = Instance.new("TextLabel")
                    local keymain = Instance.new("TextButton")

                    -- Keybind Properties
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

                    -- Keybind Codes
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
                            if (Clicked == true) then
                                WaitingForBind = true
                                Clicked = false
                            end
                        end
                    end)

                    userinputservice.InputBegan:Connect(function(Input)
                        if (WaitingForBind and Input.UserInputType == Enum.UserInputType.Keyboard) then
                            local Key = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")

                            if (not table.find(Blacklisted, Key)) then
                                bindtext.Text = "[ " .. Key .. " ]"
                            else
                                bindtext.Text = "[ NONE ]"
                            end

                            Sel = Key
                            WaitingForBind = false
                        else
                            if (Input.UserInputType == Enum.UserInputType.Keyboard) then
                                local Key = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")

                                if (Key == Sel) then
                                    Enabled = not Enabled

                                    if (Enabled) then
                                        checkbox.BackgroundColor3 = color
                                    else
                                        checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                                    end

                                    if (callback) then
                                        callback(Key)
                                    else
                                        ToggleCallback(Enabled)
                                    end
                                end
                            end
                        end
                    end)

                    function keytypes:SetBind(key)
                        bindtext.Text = "[ " .. key .. " ]"
                        Sel = key
                    end

                    function keytypes:GetBind()
                        return Sel
                    end

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

                -- Slider Main
                local SliderTypes = {}
                local Dragging = false
                local Value = 0

                -- Slider Instances
                local title_15 = Instance.new("TextLabel")
                local slider = Instance.new("Frame")
                local UIGradient_15 = Instance.new("UIGradient")
                local bar = Instance.new("Frame")
                local UIGradient_16 = Instance.new("UIGradient")
                local value = Instance.new("TextLabel")

                -- Slider Properties
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

                -- Slider Code
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
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Slide(input)
                        Dragging = true
                        SliderDragging = true
                    end
                end)
    
                slider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                        SliderDragging = false
                    end
                end)
    
                userinputservice.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        Slide(input)
                    end
                end)

                -- Slider Types
                function SliderTypes:SetValue(s)
                    s = s or 0
                    Value = s
                    bar.Size = UDim2.new(Value / max, 0, 1, 0)
                    value.Text = tostring(Value) .. "/" .. max
                    callback(Value)
                end

                function SliderTypes:GetValue()
                    return Value
                end

                return SliderTypes
            end

            function GroupTypes:CreateDropdown(name, options, callback)
                name = name or "Dropdown"
                options = options or {}
                callback = callback or function(o) print(o) end

                -- Dropdown Main
                local DropTypes = {}
                local Selected = ""

                -- Dropdown Instances
                local title_15 = Instance.new("TextLabel")
                local combobox = Instance.new("Frame")
                local main_2 = Instance.new("TextButton")
                local UIGradient_3 = Instance.new("UIGradient")
                local title_4 = Instance.new("TextLabel")
                local list = Instance.new("Frame")
                local UIGradient_4 = Instance.new("UIGradient")
                local UIListLayout_4 = Instance.new("UIListLayout")

                -- Dropdown Properties
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

                -- Dropdown Code
                main_2.MouseButton1Click:Connect(function()
                    title_15.ZIndex = 9
                    list.Visible = not list.Visible

                    for i,v in pairs(container_2:GetChildren()) do
                        if (v ~= title_15 and not v.Name:find("UI")) then
                            v.ZIndex = 0
                        end
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

                -- Dropdown Types
                function DropTypes:SetOption(option)
                    option = option or options[1]
                    Selected = tostring(option)
                    
                    for i,v in pairs(list:GetChildren()) do
                        if (v.Name:find("item")) then
                            if (v.Text == Selected) then
                                v.BackgroundColor3 = color
                                v.UIGradient.Enabled = true
                            else
                                v.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                v.UIGradient.Enabled = false
                            end
                        end
                    end

                    title_4.Text = Selected
                    callback(Selected)
                end

                function DropTypes:GetOption()
                    return Selected
                end

                return DropTypes
            end

            function GroupTypes:CreateButton(name, callback)
                name = name or "New Button"
                callback = callback or function() print("clicked") end

                -- Button Instances
                local Button = Instance.new("TextButton")
                local UIGradient_17 = Instance.new("UIGradient")
                local title_16 = Instance.new("TextLabel")

                -- Button Properties
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

                -- Button Code
                Button.MouseButton1Click:Connect(function()
                    callback()
                end)
            end

            function GroupTypes:CreateColorPicker(name, def, callback)
                name = name or "New ColorPicker"
                def = def or Color3.fromRGB(255, 255, 255)
                callback = callback or function(s) print(s) end

                -- ColorPicker Main
                local ColorTypes = {}
                local Dragging = false
                local ColorInput = nil
                local HueInput = nil
                local ColorH = 5
                local ColorS = 1
                local ColorV = 1
                local SelectedColor = def

                -- ColorPicker Instances
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

                -- ColorPicker Properties
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

                -- ColorPicker Code
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
                            if (input.UserInputState == Enum.UserInputState.End) then
                                ColorDragging = false
                                ColorPickerDragging = false
                            end
                        end)
                    end
                end)
            
                colorframe.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                        dragInput = input
                    end
                end)
            
                userinputservice.InputChanged:Connect(function(input)
                    if input == dragInput and ColorDragging and not SliderDragging and not Dragging then
                        local Delta = input.Position - dragStart
                        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
                        colorframe.Position = Position
                    end
                end)

                main_3.MouseButton1Click:Connect(function()
                    colorframe.Visible = not colorframe.Visible
                end)

                gradient.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (ColorInput) then
                            ColorInput:Disconnect()
                        end

                        ColorInput = game.RunService.RenderStepped:Connect(function()
                            local ColorX = (math.clamp(Mouse.X - colorslider.AbsolutePosition.X, 0, colorslider.AbsoluteSize.X) / colorslider.AbsoluteSize.X)
                            local ColorY = (math.clamp(Mouse.Y - gradient.AbsolutePosition.Y, 0, gradient.AbsoluteSize.Y) / gradient.AbsoluteSize.Y)

                            ColorS = ColorX
                            ColorV = 1 - ColorY

                            colorselection.Position = UDim2.new(ColorX, 0, ColorY, 0)

                            UpdateColor()
                        end)

                        Dragging = true
                    end
                end)

                gradient.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (ColorInput) then
                            ColorInput:Disconnect()
                        end

                        Dragging = false
                    end
                end)

                colorslider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (HueInput) then
                            HueInput:Disconnect()
                        end

                        HueInput = game.RunService.RenderStepped:Connect(function()
                            local HueY = (math.clamp(Mouse.X - colorslider.AbsolutePosition.X, 0, colorslider.AbsoluteSize.X) / colorslider.AbsoluteSize.X)

                            bar_2.Position = UDim2.new(HueY, 0, 0, 0)
                            ColorH = 1 - HueY

                            UpdateColor()
                        end)

                        Dragging = true
                    end
                end)

                colorslider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if (HueInput) then
                            HueInput:Disconnect()
                        end

                        Dragging = false
                    end
                end)

                -- ColorPicker Types
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

        function TabTypes:CratePlayerList(showbuttons, events)
            showbuttons = showbuttons or false
            events = events or {}
            events.onwhitelist = events.onwhitelist or function() end
            events.onblacklist = events.onblacklist or function() end
            events.onprioritize = events.onprioritize or function() end
            events.onunprioritize = events.onunprioritize or function() end

            -- PlayerList Main
            local PlayerListTypes = {}

            -- PlayerList Instances
            local main = Instance.new("Frame")
            local UIPadding = Instance.new("UIPadding")
            local UIListLayout = Instance.new("UIListLayout")
            local groupboxoutline = Instance.new("Frame")
            local groupboxinline = Instance.new("Frame")
            local background = Instance.new("Frame")
            local title = Instance.new("TextLabel")
            local players = Instance.new("Frame")
            local container_players = Instance.new("ScrollingFrame")
            local UIListLayout_2 = Instance.new("UIListLayout")

            -- PlayerList Properties
            main.Name = "main"
            main.Parent = Pattern
            main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            main.BackgroundTransparency = 1.000
            main.Size = UDim2.new(0, 520, 0, 471)
            
            UIPadding.Parent = main
            UIPadding.PaddingLeft = UDim.new(0, 3)
            UIPadding.PaddingTop = UDim.new(0, 8)
            
            UIListLayout.Parent = main
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 8)
            
            groupboxoutline.Name = "groupboxoutline"
            groupboxoutline.Parent = main
            groupboxoutline.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
            groupboxoutline.BorderSizePixel = 0
            groupboxoutline.Position = UDim2.new(0.00576923089, 0, 0.0169851389, 0)
            groupboxoutline.Size = UDim2.new(0, 513, 0, 460)
            
            groupboxinline.Name = "groupboxinline"
            groupboxinline.Parent = groupboxoutline
            groupboxinline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            groupboxinline.BorderSizePixel = 0
            groupboxinline.Position = UDim2.new(0, 1, 0, 1)
            groupboxinline.Size = UDim2.new(0, 511, 0, 458)
            
            background.Name = "background"
            background.Parent = groupboxinline
            background.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            background.BorderSizePixel = 0
            background.Position = UDim2.new(0, 1, 0, 1)
            background.Size = UDim2.new(0, 509, 0, 456)
            
            title.Name = "title"
            title.Parent = background
            title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            title.BackgroundTransparency = 1.000
            title.Position = UDim2.new(0, 15, 0, -10)
            title.Size = UDim2.new(0, 240, 0, 20)
            title.Font = Enum.Font.SourceSans
            title.Text = "Player List"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextSize = 15.000
            title.TextStrokeTransparency = 0.000
            title.TextXAlignment = Enum.TextXAlignment.Left
            
            players.Name = "players"
            players.Parent = background
            players.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
            players.BorderColor3 = Color3.fromRGB(8, 8, 8)
            players.Position = UDim2.new(0, 7, 0, 17)
            players.Size = UDim2.new(0, 494, 0, 430)
            
            container_players.Name = "container"
            container_players.Parent = players
            container_players.Active = true
            container_players.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            container_players.BackgroundTransparency = 1.000
            container_players.BorderSizePixel = 0
            container_players.Size = UDim2.new(0, 494, 0, 430)
            container_players.BottomImage = ""
            container_players.ScrollBarThickness = 3
            container_players.TopImage = ""
            
            UIListLayout_2.Parent = container_players
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

            UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                container_players.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 40)
            end)
            
            -- PlayerList Code
            local insertedplayers = {}

            local function CreatePlayerCard(Name, UserId, MemberShipType, TeamColor)
                local playercard = Instance.new("Frame")
                local UIGradient = Instance.new("UIGradient")
                local pfp = Instance.new("ImageLabel")
                local info = Instance.new("TextLabel")
                local whitelist = Instance.new("TextButton")
                local UIGradient_2 = Instance.new("UIGradient")
                local title_2 = Instance.new("TextLabel")
                local blacklist = Instance.new("TextButton")
                local UIGradient_3 = Instance.new("UIGradient")
                local title_3 = Instance.new("TextLabel")
                local prioritize = Instance.new("TextButton")
                local UIGradient_4 = Instance.new("UIGradient")
                local title_4 = Instance.new("TextLabel")
                local unprioritize = Instance.new("TextButton")
                local UIGradient_5 = Instance.new("UIGradient")
                local title_5 = Instance.new("TextLabel")

                local Pfp = game.Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

                playercard.Name = "playercard"
                playercard.Parent = container_players
                playercard.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                playercard.BorderSizePixel = 0
                playercard.Size = UDim2.new(1, 0, 0, 60)
                
                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                UIGradient.Rotation = 90
                UIGradient.Parent = playercard
                
                pfp.Name = "pfp"
                pfp.Parent = playercard
                pfp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                pfp.BackgroundTransparency = 1.000
                pfp.Position = UDim2.new(0, 5, 0, 5)
                pfp.Size = UDim2.new(0, 48, 0, 48)
                pfp.Image = Pfp
                
                info.Name = "info"
                info.Parent = playercard
                info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                info.BackgroundTransparency = 1.000
                info.Position = UDim2.new(0.119433202, 0, 0.111111142, 0)
                info.Size = UDim2.new(0, 435, 0, 18)
                info.Font = Enum.Font.SourceSans
                info.Text = "Username: " .. Name .. " | UserId: " .. UserId .. " | MembeShipType: " .. MemberShipType
                info.TextColor3 = TeamColor
                info.TextSize = 15.000
                info.TextStrokeTransparency = 0.000
                info.TextWrapped = true
                info.TextXAlignment = Enum.TextXAlignment.Left
                
                if (showbuttons) then
                    whitelist.Name = "whitelist"
                    whitelist.Parent = playercard
                    whitelist.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    whitelist.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    whitelist.Position = UDim2.new(0.119433202, 0, 0.511111259, 0)
                    whitelist.Size = UDim2.new(0, 100, 0, 19)
                    whitelist.Font = Enum.Font.SourceSans
                    whitelist.Text = ""
                    whitelist.TextColor3 = Color3.fromRGB(255, 255, 255)
                    whitelist.TextSize = 14.000
                    whitelist.TextStrokeTransparency = 0.000
                    
                    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_2.Rotation = 90
                    UIGradient_2.Parent = whitelist
                    
                    title_2.Name = "title"
                    title_2.Parent = whitelist
                    title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_2.BackgroundTransparency = 1.000
                    title_2.BorderSizePixel = 0
                    title_2.Size = UDim2.new(1, 0, 1, 0)
                    title_2.Font = Enum.Font.SourceSans
                    title_2.Text = "Whitelist"
                    title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_2.TextSize = 14.000
                    title_2.TextStrokeTransparency = 0.000
                    
                    blacklist.Name = "blacklist"
                    blacklist.Parent = playercard
                    blacklist.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    blacklist.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    blacklist.Position = UDim2.new(0.338999987, 0, 0.510999978, 0)
                    blacklist.Size = UDim2.new(0, 100, 0, 19)
                    blacklist.Font = Enum.Font.SourceSans
                    blacklist.Text = ""
                    blacklist.TextColor3 = Color3.fromRGB(255, 255, 255)
                    blacklist.TextSize = 14.000
                    blacklist.TextStrokeTransparency = 0.000
                    
                    UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_3.Rotation = 90
                    UIGradient_3.Parent = blacklist
                    
                    title_3.Name = "title"
                    title_3.Parent = blacklist
                    title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_3.BackgroundTransparency = 1.000
                    title_3.BorderSizePixel = 0
                    title_3.Size = UDim2.new(1, 0, 1, 0)
                    title_3.Font = Enum.Font.SourceSans
                    title_3.Text = "Blacklist"
                    title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_3.TextSize = 14.000
                    title_3.TextStrokeTransparency = 0.000
                    
                    prioritize.Name = "prioritize"
                    prioritize.Parent = playercard
                    prioritize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    prioritize.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    prioritize.Position = UDim2.new(0.559000015, 0, 0.510999978, 0)
                    prioritize.Size = UDim2.new(0, 100, 0, 19)
                    prioritize.Font = Enum.Font.SourceSans
                    prioritize.Text = ""
                    prioritize.TextColor3 = Color3.fromRGB(255, 255, 255)
                    prioritize.TextSize = 14.000
                    prioritize.TextStrokeTransparency = 0.000
                    
                    UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_4.Rotation = 90
                    UIGradient_4.Parent = prioritize
                    
                    title_4.Name = "title"
                    title_4.Parent = prioritize
                    title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_4.BackgroundTransparency = 1.000
                    title_4.BorderSizePixel = 0
                    title_4.Size = UDim2.new(1, 0, 1, 0)
                    title_4.Font = Enum.Font.SourceSans
                    title_4.Text = "Prioritize"
                    title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_4.TextSize = 14.000
                    title_4.TextStrokeTransparency = 0.000
                    
                    unprioritize.Name = "unprioritize"
                    unprioritize.Parent = playercard
                    unprioritize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    unprioritize.BorderColor3 = Color3.fromRGB(8, 8, 8)
                    unprioritize.Position = UDim2.new(0.778999984, 0, 0.510999978, 0)
                    unprioritize.Size = UDim2.new(0, 100, 0, 19)
                    unprioritize.Font = Enum.Font.SourceSans
                    unprioritize.Text = ""
                    unprioritize.TextColor3 = Color3.fromRGB(255, 255, 255)
                    unprioritize.TextSize = 14.000
                    unprioritize.TextStrokeTransparency = 0.000
                    
                    UIGradient_5.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(167, 167, 167))}
                    UIGradient_5.Rotation = 90
                    UIGradient_5.Parent = unprioritize
                    
                    title_5.Name = "title"
                    title_5.Parent = unprioritize
                    title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_5.BackgroundTransparency = 1.000
                    title_5.BorderSizePixel = 0
                    title_5.Size = UDim2.new(1, 0, 1, 0)
                    title_5.Font = Enum.Font.SourceSans
                    title_5.Text = "Unprioritize"
                    title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
                    title_5.TextSize = 14.000
                    title_5.TextStrokeTransparency = 0.000

                    whitelist.MouseButton1Click:Connect(function()
                        events.onwhitelist(UserId)
                    end)

                    blacklist.MouseButton1Click:Connect(function()
                        events.onblacklist(UserId)
                    end)

                    prioritize.MouseButton1Click:Connect(function()
                        events.onprioritize(UserId)
                    end)

                    unprioritize.MouseButton1Click:Connect(function()
                        events.onunprioritize(UserId)
                    end)
                end

                insertedplayers[UserId] = playercard
            end

            for i,v in pairs(game.Players:GetPlayers()) do
                if (v.Name ~= game.Players.LocalPlayer.Name) then
                    local MemberShip = tostring(v.MembershipType):gsub("Enum.MembershipType.", "")
                    CreatePlayerCard(v.Name, v.UserId, MemberShip, v.TeamColor.Color)
                end
            end

            game.Players.ChildAdded:Connect(function(Plr)
                local MemberShip = tostring(Plr.MembershipType):gsub("Enum.MembershipType.", "")
                CreatePlayerCard(Plr.Name, Plr.UserId, MemberShip, Plr.TeamColor.Color)
            end)

            game.Players.ChildRemoved:Connect(function(Plr)
                insertedplayers[Plr.UserId]:Destroy()
            end)
        end

        return TabTypes
    end

    return WinTypes, BracketV2
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- SERVICES
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UserInput     = game:GetService("UserInputService")
local TweenService  = game:GetService("TweenService")
local CoreGui       = game:GetService("CoreGui")
local VIM           = game:GetService("VirtualInputManager")
local LP            = Players.LocalPlayer
local Camera        = workspace.CurrentCamera

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- VERSION CHECK
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local VERSION = 1
local GLOBAL_KEY = "_neverloose_version"
local CLEANUP_KEY = "_neverloose_cleanup"

if _G[GLOBAL_KEY] and _G[GLOBAL_KEY] ~= VERSION then
    if _G[CLEANUP_KEY] and type(_G[CLEANUP_KEY]) == "function" then
        pcall(_G[CLEANUP_KEY])
    end
    print("[neverloose] old version â€” unloaded.")
    return
end
_G[GLOBAL_KEY] = VERSION

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- NOTIFY
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local LastNotify = 0
local function Notify(title, text, duration)
    local now = tick()
    if now - LastNotify < 1 then return end
    LastNotify = now
    task.spawn(function()
        duration = duration or 3
        local gui = Instance.new("ScreenGui")
        gui.Name = "CHEAT_NOTIFY"
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

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- STATE
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local ESP_Enabled      = true
local Trig_Enabled     = true
local Trig_MaxDist     = 500
local Trig_Delay       = 0
local ESP_Thickness    = 1
local ESP_MaxDist      = 2000
local ESP_ShowHealth   = true
local ESP_ShowTracer   = false
local ESP_HideLocal    = true
local ESP_TeamCheck    = false

local Connections = {}
local ESP = {}

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- CREATE WINDOW
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local Window = Library:CreateWindow("neverloose", Color3.fromRGB(0, 255, 255))

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- TABS
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local CombatTab   = Window:CreateTab("Combat")
local VisualsTab  = Window:CreateTab("Visuals")
local SoundsTab   = Window:CreateTab("Sounds")

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- COMBAT TAB
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local TrigGroup = CombatTab:CreateGroupbox("Triggerbot")
TrigGroup:CreateToggle("Enable Triggerbot", function(v)
    Trig_Enabled = v
    Notify("Triggerbot", v and "ON" or "OFF", 2)
end):CreateKeyBind("T")

TrigGroup:CreateSlider("Max Distance", 100, 2000, 500, function(v)
    Trig_MaxDist = v
end)

TrigGroup:CreateSlider("Delay (ms)", 0, 200, 0, function(v)
    Trig_Delay = v
end)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- VISUALS TAB
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local ESPGroup = VisualsTab:CreateGroupbox("Skeleton ESP")
ESPGroup:CreateToggle("Enable ESP", function(v)
    ESP_Enabled = v
    if not v then
        for p, _ in pairs(ESP) do DestroyESP(p) end
    end
    Notify("Skeleton ESP", v and "ON" or "OFF", 2)
end):CreateKeyBind("P")

ESPGroup:CreateSlider("Thickness", 1, 5, 1, function(v)
    ESP_Thickness = v
end)

ESPGroup:CreateSlider("Max Distance", 500, 5000, 2000, function(v)
    ESP_MaxDist = v
end)

ESPGroup:CreateToggle("Show Health Bar", function(v)
    ESP_ShowHealth = v
end)

ESPGroup:CreateToggle("Show Tracers", function(v)
    ESP_ShowTracer = v
end)

ESPGroup:CreateToggle("Hide Local Player", function(v)
    ESP_HideLocal = v
end)

ESPGroup:CreateToggle("Team Check", function(v)
    ESP_TeamCheck = v
end)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- SOUNDS TAB
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- preset sound library: name â†’ asset id
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
    ["M55solix"]    = "rbxassetid://364942410",
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
    ["None"]        = "rbxassetid://0",
    ["Silencer"]    = "rbxassetid://1415221962",
    ["Laser"]       = "rbxassetid://1651687704",
    ["Rust Bang"]   = "rbxassetid://2920959",
    ["Phaser"]      = "rbxassetid://269158884",
    ["Blaster"]     = "rbxassetid://16211026",
    ["Pop"]         = "rbxassetid://3205573783",
}

local KillSounds = {
    ["None"]        = "rbxassetid://0",
    ["Metal Pipe"]  = "rbxassetid://1316391753",
    ["Rust Headshot"] = "rbxassetid://103094294870161",
    ["TF2 Crit"]    = "rbxassetid://312947118",
    ["Vine Boom"]   = "rbxassetid://6006265990",
    ["Bazinga"]     = "rbxassetid://1387505453",
}

local HitSoundID   = "rbxassetid://0"
local ShootSoundID = "rbxassetid://0"
local KillSoundID  = "rbxassetid://0"

-- build display names for dropdowns
local HitNames, ShootNames, KillNames = {}, {}, {}
for k in pairs(HitSounds)   do HitNames[#HitNames+1] = k end
for k in pairs(ShootSounds) do ShootNames[#ShootNames+1] = k end
for k in pairs(KillSounds)  do KillNames[#KillNames+1] = k end
table.sort(HitNames)
table.sort(ShootNames)
table.sort(KillNames)

local SoundGroup = SoundsTab:CreateGroupbox("Preset Sounds")

SoundGroup:CreateDropdown("Hit Sound", HitNames, function(v)
    HitSoundID = HitSounds[v] or "rbxassetid://0"
    Notify("Sounds", "Hit: " .. v, 2)
end):SetOption("None")

SoundGroup:CreateDropdown("Shoot Sound", ShootNames, function(v)
    ShootSoundID = ShootSounds[v] or "rbxassetid://0"
    Notify("Sounds", "Shoot: " .. v, 2)
end):SetOption("None")

SoundGroup:CreateDropdown("Kill Sound", KillNames, function(v)
    KillSoundID = KillSounds[v] or "rbxassetid://0"
    Notify("Sounds", "Kill: " .. v, 2)
end):SetOption("None")

-- custom ID group for manual entry
local CustomGroup = SoundsTab:CreateGroupbox("Custom IDs")

CustomGroup:CreateButton("Apply Custom IDs", function()
    local soundService = workspace:FindFirstChild("SoundService")
    if not soundService then
        Notify("Sounds", "SoundService not found", 3)
        return
    end

    local applied = 0

    local hit = soundService:FindFirstChild("LocalHitSound")
    if hit and HitSoundID ~= "rbxassetid://0" then
        hit.SoundId = HitSoundID
        applied = applied + 1
    end

    local shoot = soundService:FindFirstChild("LocalShootSound")
    if shoot and ShootSoundID ~= "rbxassetid://0" then
        shoot.SoundId = ShootSoundID
        applied = applied + 1
    end

    local kill = soundService:FindFirstChild("EliminatedSound")
    if kill and KillSoundID ~= "rbxassetid://0" then
        kill.SoundId = KillSoundID
        applied = applied + 1
    end

    Notify("Sounds", applied .. " sound(s) replaced", 3)
    print("[neverloose] " .. applied .. " sound(s) applied")
end)

CustomGroup:CreateButton("Reset All Sounds", function()
    HitSoundID = "rbxassetid://0"
    ShootSoundID = "rbxassetid://0"
    KillSoundID = "rbxassetid://0"
    Notify("Sounds", "All IDs reset", 3)
end)

-- custom textboxes injected into the groupbox
local function CreateTextbox(parent, label, default, callback)
    local f = Instance.new("Frame")
    f.Name = "textbox_" .. label
    f.Size = UDim2.new(1, -8, 0, 24)
    f.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    f.BorderSizePixel = 0
    f.Parent = parent

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(0.38, 0, 1, 0)
    t.Position = UDim2.new(0, 8, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = label
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.TextSize = 13
    t.Font = Enum.Font.SourceSans
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = f

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.58, 0, 0.75, 0)
    box.Position = UDim2.new(0.4, 0, 0.125, 0)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.BorderSizePixel = 0
    box.Text = default or ""
    box.TextColor3 = Color3.fromRGB(200, 200, 200)
    box.TextSize = 12
    box.Font = Enum.Font.SourceSans
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.Parent = f

    box.FocusLost:Connect(function()
        callback(box.Text)
    end)

    return box
end

local function FindGroupboxContainer(groupbox)
    for _, v in ipairs(groupbox:GetDescendants()) do
        if (v.Name == "container" or v.Name == "Container" or v.Name == "Content") and v:IsA("Frame") then
            return v
        end
    end
    -- fallback: find the first ScrollingFrame or Frame that holds children
    for _, v in ipairs(groupbox:GetDescendants()) do
        if v:IsA("Frame") and #v:GetChildren() > 0 then
            return v
        end
    end
    return nil
end

local customContainer = FindGroupboxContainer(CustomGroup)
if customContainer then
    CreateTextbox(customContainer, "Hit ID", "rbxassetid://0", function(v)
        HitSoundID = v
    end)
    CreateTextbox(customContainer, "Shoot ID", "rbxassetid://0", function(v)
        ShootSoundID = v
    end)
    CreateTextbox(customContainer, "Kill ID", "rbxassetid://0", function(v)
        KillSoundID = v
    end)
else
    warn("[neverloose] could not find groupbox container for custom textboxes")
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- ESP ENGINE
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
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
    q.Filled = true
    q.Thickness = 0
    q.Transparency = 1
    q.ZIndex = 998
    return q
end

local function CreateESP(player)
    if ESP[player] then return end
    local e = { lines = {}, hpBar = nil, hpBg = nil, tracer = nil }
    for i = 1, 15 do e.lines[i] = MakeLine() end
    e.tracer = MakeLine()
    e.hpBg = MakeQuad()
    e.hpBar = MakeQuad()
    ESP[player] = e
end

function DestroyESP(player)
    local e = ESP[player]
    if not e then return end
    for _, l in ipairs(e.lines) do pcall(function() l:Remove() end) end
    if e.tracer then pcall(function() e.tracer:Remove() end) end
    if e.hpBg then pcall(function() e.hpBg:Remove() end) end
    if e.hpBar then pcall(function() e.hpBar:Remove() end) end
    ESP[player] = nil
end

local function RenderESP()
    Camera = workspace.CurrentCamera
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LP and ESP_HideLocal then
            if ESP[plr] then DestroyESP(plr) end
            continue
        end

        local char = plr.Character
        local bones = char and GetBones(char)
        local show = false

        if ESP_Enabled and bones and IsAlive(char) then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local _, on, dist = W2S(hrp.Position)
                if on and dist <= ESP_MaxDist then show = true end
            end
        end

        local e = ESP[plr]
        if not show then
            if e then
                for _, l in ipairs(e.lines) do l.Visible = false end
                e.tracer.Visible = false
                e.hpBg.Visible = false
                e.hpBar.Visible = false
            end
            continue
        end

        if not e then CreateESP(plr) end
        e = ESP[plr]
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
                e.lines[i].Color = Color3.fromRGB(0, 255, 255)
                e.lines[i].Thickness = ESP_Thickness
            else
                e.lines[i].Visible = false
            end
        end
        for i = count + 1, 15 do e.lines[i].Visible = false end

        if ESP_ShowHealth then
            local head = char:FindFirstChild("Head")
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if head and humanoid then
                local top, topOn = W2S(head.Position + Vector3.new(0, 0.6, 0))
                local bot, botOn = W2S(head.Position + Vector3.new(0, -3.2, 0))
                if topOn and botOn then
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
            else
                e.hpBg.Visible = false
                e.hpBar.Visible = false
            end
        else
            e.hpBg.Visible = false
            e.hpBar.Visible = false
        end
    end
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- TRIGGERBOT ENGINE
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
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
    if not Trig_Enabled then return end

    local rayOrigin = Camera.CFrame.Position
    local rayDir = Camera.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LP.Character }
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

    local hitPlayer = GetPlayerFromCharacter(hitChar)
    local hitName = hitPlayer and hitPlayer.DisplayName or "Unknown"
    local humanoid = hitChar:FindFirstChildOfClass("Humanoid")
    local hpPct = 0
    if humanoid and humanoid.MaxHealth > 0 then
        hpPct = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
    end
    Notify("Triggerbot", hitName .. " - " .. hitPart.Name .. " - " .. hpPct .. "% HP", 2)
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- MAIN LOOP
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
Connections.render = RunService.RenderStepped:Connect(function()
    pcall(RenderESP)
    pcall(RenderTriggerbot)
end)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- PLAYER TRACKING
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
Connections.playerAdded = Players.PlayerAdded:Connect(function(p)
    if ESP_Enabled then pcall(CreateESP, p) end
end)

Connections.playerRemoving = Players.PlayerRemoving:Connect(function(p)
    pcall(DestroyESP, p)
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP or not ESP_HideLocal then pcall(CreateESP, p) end
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- CLEANUP
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local function Unload()
    for k, v in pairs(Connections) do
        pcall(function() if v and v.Connected then v:Disconnect() end end)
    end
    Connections = {}
    for p, _ in pairs(ESP) do pcall(DestroyESP, p) end
    _G[GLOBAL_KEY] = nil
    _G[CLEANUP_KEY] = nil
    print("[neverloose] unloaded.")
end

_G[CLEANUP_KEY] = Unload

print("[neverloose] v" .. VERSION .. " loaded â€” RightControl to toggle UI")
