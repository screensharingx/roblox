--[[
    neverloose — Unified Roblox Cheat UI
    UI: Bracket Lib V2 (loaded from git)
    
    Tabs:
        Combat  — Triggerbot
        Visuals — Skeleton ESP, Health Bars, Tracers
        Sounds  — Hit / Shoot / Kill sounds
    
    Press RightControl to toggle UI.
    VERSION: 3
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
local CombatTab   = Window:CreateTab("Combat")
local VisualsTab  = Window:CreateTab("Visuals")
local SoundsTab   = Window:CreateTab("Sounds")

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
-- MAIN LOOP
-- ═══════════════════════════════════════════════════
local SoundTick = 0
Connections.render = RunService.RenderStepped:Connect(function()
    pcall(RenderESP)
    pcall(RenderTriggerbot)
    -- re-apply sounds every ~3 seconds (cheap scan, keeps them locked)
    SoundTick = SoundTick + 1
    if SoundTick >= 180 then -- ~3s at 60fps
        SoundTick = 0
        pcall(ScanAndReplace)
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
