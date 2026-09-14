--[[
    neverloose — Unified Roblox Cheat UI
    UI: Bracket Lib V2 (loaded from git)
    
    Tabs:
        Combat  — Triggerbot
        Visuals — Skeleton ESP, Health Bars, Tracers
        Sounds  — Hit / Shoot / Kill sounds
        Skins   — Desert Eagle textures, M9Bayonet colors
    
    Press RightShift to toggle UI.
    VERSION: 5
]]

-- ═══════════════════════════════════════════════════
-- LOAD UI LIB
-- ═══════════════════════════════════════════════════
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/screensharingx/roblox/main/lib.lua"))()

-- ═══════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UserInput     = game:GetService("UserInputService")
local TweenService  = game:GetService("TweenService")
local CoreGui       = game:GetService("CoreGui")
local VIM           = game:GetService("VirtualInputManager")
local LP            = Players.LocalPlayer
local Camera        = workspace.CurrentCamera

-- ═══════════════════════════════════════════════════
-- VERSION CHECK — always kill previous instance
-- ═══════════════════════════════════════════════════
local VERSION = 4
local GLOBAL_KEY = "_neverloose_version"
local CLEANUP_KEY = "_neverloose_cleanup"
local UI_KEY = "_neverloose_ui"

if _G[CLEANUP_KEY] and type(_G[CLEANUP_KEY]) == "function" then
    pcall(_G[CLEANUP_KEY])
    print("[neverloose] previous instance cleaned up")
end
_G[GLOBAL_KEY] = VERSION

-- ═══════════════════════════════════════════════════
-- NOTIFY
-- ═══════════════════════════════════════════════════
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

-- ═══════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════
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

local DESkinID   = "rbxassetid://0"
local DESkinName = "Default"
local KnifeSkinName = "Default"

local Connections = {}
local ESP = {}
local UIScreen = nil

-- ═══════════════════════════════════════════════════
-- CREATE WINDOW
-- ═══════════════════════════════════════════════════
local Window, ScreenGui = Library:CreateWindow("neverloose", Color3.fromRGB(0, 255, 255))
UIScreen = ScreenGui

-- ═══════════════════════════════════════════════════
-- TABS
-- ═══════════════════════════════════════════════════
local MenuTab     = Window:CreateTab("Menu")
local CombatTab   = Window:CreateTab("Combat")
local VisualsTab  = Window:CreateTab("Visuals")
local SoundsTab   = Window:CreateTab("Sounds")

-- ═══════════════════════════════════════════════════
-- MENU TAB
-- ═══════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════
-- ESP PREVIEW — floating panel outside menu
-- ═══════════════════════════════════════════════════
do
    local accent    = Color3.fromRGB(0, 255, 255)
    local boxColor  = Color3.fromRGB(0, 255, 0)
    local skelColor = Color3.fromRGB(255, 255, 255)
    local hpHigh    = Color3.fromRGB(0, 255, 0)

    local preview = Instance.new("Frame")
    preview.Name = "ESPPreview"
    preview.Parent = ScreenGui
    preview.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    preview.BorderColor3 = Color3.fromRGB(8, 8, 8)
    preview.Size = UDim2.new(0, 220, 0, 340)
    preview.ClipsDescendants = true
    Instance.new("UICorner", preview).CornerRadius = UDim.new(0, 6)

    -- position to the right of the core window
    local core = ScreenGui:FindFirstChild("core", true)
    if core then
        preview.Position = UDim2.new(0, core.AbsolutePosition.X + core.AbsoluteSize.X + 12, 0, core.AbsolutePosition.Y)
        -- keep it there if window moves
        game:GetService("RunService").RenderStepped:Connect(function()
            preview.Position = UDim2.new(0, core.AbsolutePosition.X + core.AbsoluteSize.X + 12, 0, core.AbsolutePosition.Y)
        end)
    else
        preview.Position = UDim2.new(0.5, 50, 0.14, 0)
    end

    local inner = Instance.new("Frame")
    inner.Parent = preview
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

    -- helpers
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

    local function mkText(parent, p, s, txt, col, sz, align)
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
        t.TextXAlignment = align or Enum.TextXAlignment.Center
        return t
    end

    local cx = 0.5
    local headY  = 0.12
    local neckY  = 0.21
    local shY    = 0.25
    local hipY   = 0.52
    local kneeY  = 0.72

    -- head
    local head = Instance.new("Frame")
    head.Parent = canvas
    head.AnchorPoint = Vector2.new(0.5, 0.5)
    head.BackgroundColor3 = skelColor
    head.BackgroundTransparency = 0.3
    head.Shape = Enum.FrameType.Circle
    head.Position = UDim2.new(cx, 0, headY, 0)
    head.Size = UDim2.new(0, 18, 0, 18)
    head.ZIndex = 4

    -- spine
    mkLine(canvas, UDim2.new(cx, 0, (neckY + hipY) / 2, 0), UDim2.new(0, 2, 0, (hipY - neckY) * 280), 0, skelColor)
    -- shoulders
    mkLine(canvas, UDim2.new(cx, 0, shY, 0), UDim2.new(0, 36, 0, 2), 0, skelColor)
    -- left arm
    mkLine(canvas, UDim2.new(cx - 0.04, 0, shY, 0), UDim2.new(0, 2, 0, 32), 25, skelColor)
    mkLine(canvas, UDim2.new(cx - 0.058, 0, shY + 0.06, 0), UDim2.new(0, 2, 0, 28), 5, skelColor)
    -- right arm
    mkLine(canvas, UDim2.new(cx + 0.04, 0, shY, 0), UDim2.new(0, 2, 0, 32), -25, skelColor)
    mkLine(canvas, UDim2.new(cx + 0.058, 0, shY + 0.06, 0), UDim2.new(0, 2, 0, 28), -5, skelColor)
    -- hips
    mkLine(canvas, UDim2.new(cx, 0, hipY, 0), UDim2.new(0, 22, 0, 2), 0, skelColor)
    -- left leg
    mkLine(canvas, UDim2.new(cx - 0.028, 0, hipY, 0), UDim2.new(0, 2, 0, 50), 8, skelColor)
    mkLine(canvas, UDim2.new(cx - 0.038, 0, kneeY, 0), UDim2.new(0, 2, 0, 50), 3, skelColor)
    -- right leg
    mkLine(canvas, UDim2.new(cx + 0.028, 0, hipY, 0), UDim2.new(0, 2, 0, 50), -8, skelColor)
    mkLine(canvas, UDim2.new(cx + 0.038, 0, kneeY, 0), UDim2.new(0, 2, 0, 50), -3, skelColor)

    -- box
    local bx = cx - 0.11
    local by = headY - 0.06
    local bw = 0.22
    local bh = 0.86
    mkLine(canvas, UDim2.new(cx, 0, by, 0), UDim2.new(bw, 0, 0, 2), 0, boxColor)
    mkLine(canvas, UDim2.new(cx, 0, by + bh, 0), UDim2.new(bw, 0, 0, 2), 0, boxColor)
    mkLine(canvas, UDim2.new(bx, 0, (by + by + bh) / 2, 0), UDim2.new(0, 2, 0, bh * 280), 0, boxColor)
    mkLine(canvas, UDim2.new(bx + bw, 0, (by + by + bh) / 2, 0), UDim2.new(0, 2, 0, bh * 280), 0, boxColor)

    -- health bar
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

    -- name
    mkText(canvas, UDim2.new(cx, 0, by - 0.04, 0), UDim2.new(0, 120, 0, 14), "PlayerName", Color3.fromRGB(255, 255, 255), 12)
    -- distance
    mkText(canvas, UDim2.new(cx, 0, by + bh + 0.01, 0), UDim2.new(0, 60, 0, 12), "[24m]", Color3.fromRGB(180, 180, 180), 10)
    -- weapon
    mkText(canvas, UDim2.new(cx, 0, by + bh + 0.03, 0), UDim2.new(0, 80, 0, 12), "AK-47", accent, 9)
    -- tracer
    mkLine(canvas, UDim2.new(0.5, 0, 1, 0), UDim2.new(0, 1, 0, (1 - (by + bh)) * 280 - 8), 0, accent)
end

-- ═══════════════════════════════════════════════════
-- COMBAT TAB
-- ═══════════════════════════════════════════════════
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

-- ═══════════════════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════════════════
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

-- ═══════════════════════════════════════════════════
-- SOUNDS TAB
-- ═══════════════════════════════════════════════════

-- preset sound library: name → asset id
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

-- ═══════════════════════════════════════════════════
-- SOUND ENGINE — scan everything, replace everything
-- ═══════════════════════════════════════════════════
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

local CustomGroup = SoundsTab:CreateGroupbox("Custom IDs")

CustomGroup:CreateButton("Reset All Sounds", function()
    HitSoundID = "rbxassetid://0"
    ShootSoundID = "rbxassetid://0"
    KillSoundID = "rbxassetid://0"
    Notify("Sounds", "All IDs reset", 3)
end)

-- ═══════════════════════════════════════════════════
-- SKINS TAB — Desert Eagle + Knife skins
-- ═══════════════════════════════════════════════════
local SkinsTab = Window:CreateTab("Skins")

-- all DE skins from CaseConfig (forAllGun = true)
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

local DESkinGroup = SkinsTab:CreateGroupbox("Desert Eagle Skins")
DESkinGroup:CreateDropdown("Skin", DESkinList, function(v)
    DESkinName = v
    if v == "Default" then
        DESkinID = "rbxassetid://110831261114219"
    else
        DESkinID = "lookup"
    end
    Notify("Skins", "DE: " .. v, 2)
end):SetOption("Default")

-- knife skin names (discovered from RS.Textures.M9Bayonet)
local KnifeSkinList = {
    "Default",
}
-- try to discover knife skins at runtime
pcall(function()
    local tex = RS:FindFirstChild("Textures")
    if tex then
        local knifeFolder = tex:FindFirstChild("M9Bayonet")
        if knifeFolder then
            for _, rarity in ipairs(knifeFolder:GetChildren()) do
                if rarity:IsA("Folder") then
                    for _, skin in ipairs(rarity:GetChildren()) do
                        if skin:IsA("Folder") then
                            KnifeSkinList[#KnifeSkinList+1] = skin.Name
                        end
                    end
                end
            end
        end
        -- also butterfly/karambit
        for _, knife in ipairs({"Butterfly", "Karambit"}) do
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

local KnifeGroup = SkinsTab:CreateGroupbox("Knife Skins")
KnifeGroup:CreateDropdown("Skin", KnifeSkinList, function(v)
    KnifeSkinName = v
    Notify("Skins", "Knife: " .. v, 2)
end):SetOption("Default")

-- custom skin ID textbox
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

    box.FocusLost:Connect(function()
        callback(box.Text)
    end)

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

-- ═══════════════════════════════════════════════════
-- ESP ENGINE
-- ═══════════════════════════════════════════════════
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

-- ═══════════════════════════════════════════════════
-- TRIGGERBOT ENGINE
-- ═══════════════════════════════════════════════════
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

-- ═══════════════════════════════════════════════════
-- SOUND ENGINE — scans entire workspace, locks sounds
-- ═══════════════════════════════════════════════════
local function ScanAndReplace()
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

-- ═══════════════════════════════════════════════════
-- SKIN ENGINE — mirrors game's exact skin application
-- targets FPS model (first person) + world model
-- ═══════════════════════════════════════════════════
local RS = game:GetService("ReplicatedStorage")
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
            if sf then
                return sf:FindFirstChild("TextureImage")
            end
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
    if DESkinName == "Default" then return end

    local tool = FindTool("Desert Eagle")
    if not tool then return end

    -- try FPS model first (first person view), then world model
    local models = {}
    local fps = getFPSModel(tool)
    if fps then models[#models+1] = fps end
    local worldModel = tool:FindFirstChild("Desert Eagle")
    if worldModel then models[#models+1] = worldModel end

    -- get texture source
    local texSource = nil
    if DESkinID == "lookup" then
        texSource = getSkinTexture("Desert Eagle", DESkinName)
    end

    for _, model in ipairs(models) do
        -- clear existing textures
        for _, v in ipairs(model:GetDescendants()) do
            if isForTexturePart(v) then clearTextures(v) end
        end
        -- apply new textures
        if texSource then
            for _, v in ipairs(model:GetDescendants()) do
                if isForTexturePart(v) then applyTexToPart(v, texSource) end
            end
        elseif DESkinID ~= "lookup" then
            -- custom ID
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
    if KnifeSkinName == "Default" then return end

    -- find any knife tool
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

-- ═══════════════════════════════════════════════════
-- MAIN LOOP
-- ═══════════════════════════════════════════════════
local SoundTick = 0
Connections.render = RunService.RenderStepped:Connect(function()
    pcall(RenderESP)
    pcall(RenderTriggerbot)
    -- re-apply sounds + skins every ~1 second
    SoundTick = SoundTick + 1
    if SoundTick >= 60 then
        SoundTick = 0
        pcall(ScanAndReplace)
        pcall(ApplyDESkins)
        pcall(ApplyKnifeSkins)
    end
end)

-- ═══════════════════════════════════════════════════
-- PLAYER TRACKING
-- ═══════════════════════════════════════════════════
Connections.playerAdded = Players.PlayerAdded:Connect(function(p)
    if ESP_Enabled then pcall(CreateESP, p) end
end)

Connections.playerRemoving = Players.PlayerRemoving:Connect(function(p)
    pcall(DestroyESP, p)
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP or not ESP_HideLocal then pcall(CreateESP, p) end
end

-- immediate first scan after load
task.delay(2, function()
    pcall(ScanAndReplace)
end)

-- ═══════════════════════════════════════════════════
-- CLEANUP
-- ═══════════════════════════════════════════════════
local function Unload()
    -- disconnect all event connections
    for k, v in pairs(Connections) do
        pcall(function() if v and v.Connected then v:Disconnect() end end)
    end
    Connections = {}

    -- destroy all ESP drawings
    for p, _ in pairs(ESP) do pcall(DestroyESP, p) end
    ESP = {}

    -- kill the UI (also kills any old instances with same name)
    for _, gui in ipairs(CoreGui:GetChildren()) do
        if gui.Name == "neverloose" and gui:IsA("ScreenGui") then
            pcall(function() gui:Destroy() end)
        end
    end
    if UIScreen then
        pcall(function() UIScreen:Destroy() end)
        UIScreen = nil
    end

    -- also check PlayerGui fallback
    pcall(function()
        for _, gui in ipairs(LP.PlayerGui:GetChildren()) do
            if gui.Name == "neverloose" and gui:IsA("ScreenGui") then
                gui:Destroy()
            end
        end
    end)

    _G[GLOBAL_KEY] = nil
    _G[CLEANUP_KEY] = nil
    _G[UI_KEY] = nil
    print("[neverloose] cleaned up.")
end

_G[CLEANUP_KEY] = Unload

print("[neverloose] v" .. VERSION .. " loaded — RightShift to toggle UI")
