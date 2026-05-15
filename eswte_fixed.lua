-- ╔══════════════════════════════════════════════════════════════════╗
-- ║          CyaHub v3.0  |  by Cya (@Cyaofc)                       ║
-- ║  Analysis · Visual · World · Movement · Auto · Troll · Utility · Config ║
-- ╚══════════════════════════════════════════════════════════════════╝

-- ============================================================
-- SERVICIOS
-- ============================================================
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local HttpService      = game:GetService("HttpService")
local StarterGui       = game:GetService("StarterGui")
local ReplicatedStorage= game:GetService("ReplicatedStorage")
local Stats            = game:GetService("Stats")
local TeleportService  = game:GetService("TeleportService")
local LocalPlayer      = Players.LocalPlayer
if not LocalPlayer then
    warn("LocalPlayer no disponible")
    return
end

local Camera           = workspace.CurrentCamera
local Mouse            = LocalPlayer:GetMouse()

-- ============================================================
-- TEMAS
-- ============================================================
local Themes = {
    Purple = {
        Accent      = Color3.fromRGB(124, 58, 237),
        AccentLight = Color3.fromRGB(167, 139, 250),
        AccentDark  = Color3.fromRGB(76, 29, 149),
        BG          = Color3.fromRGB(10, 10, 14),
        BG2         = Color3.fromRGB(14, 14, 22),
        BG3         = Color3.fromRGB(16, 16, 24),
        Border      = Color3.fromRGB(30, 30, 50),
        Text        = Color3.fromRGB(140, 140, 190),
        TextDim     = Color3.fromRGB(60, 60, 90),
    },
    Red = {
        Accent      = Color3.fromRGB(185, 28, 28),
        AccentLight = Color3.fromRGB(252, 165, 165),
        AccentDark  = Color3.fromRGB(127, 10, 10),
        BG          = Color3.fromRGB(14, 8, 8),
        BG2         = Color3.fromRGB(20, 10, 10),
        BG3         = Color3.fromRGB(24, 12, 12),
        Border      = Color3.fromRGB(50, 20, 20),
        Text        = Color3.fromRGB(190, 140, 140),
        TextDim     = Color3.fromRGB(90, 50, 50),
    },
    Blue = {
        Accent      = Color3.fromRGB(29, 78, 216),
        AccentLight = Color3.fromRGB(147, 197, 253),
        AccentDark  = Color3.fromRGB(14, 40, 120),
        BG          = Color3.fromRGB(8, 10, 16),
        BG2         = Color3.fromRGB(10, 14, 24),
        BG3         = Color3.fromRGB(12, 16, 28),
        Border      = Color3.fromRGB(20, 30, 60),
        Text        = Color3.fromRGB(140, 160, 200),
        TextDim     = Color3.fromRGB(50, 60, 100),
    },
    Green = {
        Accent      = Color3.fromRGB(22, 163, 74),
        AccentLight = Color3.fromRGB(134, 239, 172),
        AccentDark  = Color3.fromRGB(10, 90, 40),
        BG          = Color3.fromRGB(8, 14, 10),
        BG2         = Color3.fromRGB(10, 18, 12),
        BG3         = Color3.fromRGB(12, 22, 14),
        Border      = Color3.fromRGB(20, 50, 25),
        Text        = Color3.fromRGB(140, 190, 150),
        TextDim     = Color3.fromRGB(50, 90, 55),
    },
    Dark = {
        Accent      = Color3.fromRGB(100, 100, 120),
        AccentLight = Color3.fromRGB(180, 180, 200),
        AccentDark  = Color3.fromRGB(50, 50, 70),
        BG          = Color3.fromRGB(6, 6, 8),
        BG2         = Color3.fromRGB(10, 10, 12),
        BG3         = Color3.fromRGB(14, 14, 16),
        Border      = Color3.fromRGB(25, 25, 30),
        Text        = Color3.fromRGB(140, 140, 150),
        TextDim     = Color3.fromRGB(55, 55, 65),
    },
    Cyan = {
        Accent      = Color3.fromRGB(6, 182, 212),
        AccentLight = Color3.fromRGB(103, 232, 249),
        AccentDark  = Color3.fromRGB(8, 100, 130),
        BG          = Color3.fromRGB(6, 12, 14),
        BG2         = Color3.fromRGB(8, 16, 20),
        BG3         = Color3.fromRGB(10, 20, 24),
        Border      = Color3.fromRGB(15, 40, 50),
        Text        = Color3.fromRGB(130, 180, 200),
        TextDim     = Color3.fromRGB(40, 80, 100),
    },
    Orange = {
        Accent      = Color3.fromRGB(234, 88, 12),
        AccentLight = Color3.fromRGB(253, 186, 116),
        AccentDark  = Color3.fromRGB(124, 45, 5),
        BG          = Color3.fromRGB(14, 9, 6),
        BG2         = Color3.fromRGB(20, 12, 7),
        BG3         = Color3.fromRGB(24, 15, 8),
        Border      = Color3.fromRGB(50, 25, 10),
        Text        = Color3.fromRGB(200, 165, 130),
        TextDim     = Color3.fromRGB(90, 60, 35),
    },
}
local CurrentTheme = Themes.Purple

-- ============================================================
-- ESTADO GLOBAL
-- ============================================================
local State = {
    -- Movimiento
    Fly = false, NoClip = false, InfJump = false,
    SpeedHack = false, FlySpeed = 60, WalkSpeed = 50,
    GravityMod = false, GravityValue = 196.2,
    BunnyHop = false, AirWalk = false,
    DashCooldown = false, FastClimb = false,
    -- Visual
    ESP = false, SkeletonESP = false, Chams = false,
    Tracers = false, DistanceESP = false,
    NightVision = false, ThermalVision = false,
    FOVCircle = false, FOVRadius = 100,
    RainbowFOV = false, DynamicFOV = false,
    HighlightESP = false, ItemESP = false,
    NPCesp = false, VehicleESP = false,
    Crosshair = false,
    -- World
    Fullbright = false, NoFog = false,
    TimeChanger = false, TimeValue = 14,
    WeatherVis = false, DynamicSkybox = false,
    MotionBlur = false, BloomEffect = false,
    ColorCorrection = false, RetroShader = false,
    -- Combat
    Godmode = false, AntiKick = false, HitboxExpand = false,
    Invisible = false,
    -- Utility
    ClickTP = false, FPSBoost = false,
    WatermarkOn = false, FPSCounterOn = false,
    PingMonitor = false, CoordsDisplay = false,
    VelocityMeter = false,
    -- Auto
    AutoFarm = false, AutoLoot = false,
    AutoRespawn = false, ServerHop = false,
    AutoCollect = false,
    -- GUI
    ToggleKey = Enum.KeyCode.CapsLock,
    ToggleKeyName = "CapsLock",
    ListeningForKey = false,
    RainbowMode = false,
    ActiveTheme = "Purple",
    GuiOpacity = 1,
    -- Misc
    Spectating = nil,
    SelectedPlayer = nil,
    KeySystem = false,
    KeyUnlocked = false,
    ValidKeys = {"CYA-2024", "CYAHUB-VIP", "GRATIS123"},
    SavedLocations = {},
    ConfigProfiles = {},
    ActiveProfile = "Default",
    
      -- ============================================================
    -- PREMIUM FEATURES
    -- ============================================================
    IsPremium = false,
    PremiumTier = "FREE", -- FREE, PRO, VIP
    PremiumExpiry = 0,
    
    -- Aimbot AI
    AimbotAI = false,
    AimbotFOV = 90,
    AimbotSmooth = 0.5,
    AimbotPrediction = false,
    AimbotTeamCheck = true,
    
    -- Anti-Ban AI
    AntibanAI = false,
    HumanizeMovement = true,
    RandomDelays = true,
    
    -- Auto Farm Advanced
    AutoFarmAdvanced = false,
    AutoFarmMode = "NEAREST", -- NEAREST, PATTERN, SMART
    
    -- Exploit Tools
    ExploitTools = false,
    KillAura = false,
    KillAuraRange = 50,
    AutoClicker = false,
    AutoClickerCPS = 10,
    BetrayalESP = false,
    
    -- Advanced Combat
    NoSpreadRecoil = false,
    InstantKill = false,
}

local Connections    = {}
local ESPObjects     = {}
local ChamObjects    = {}
local SkeletonObjs   = {}
local TracerObjs     = {}
local HighlightObjs  = {}
local OriginalValues = {}

-- ============================================================
-- CONFIG SAVE / LOAD
-- ============================================================
local CONFIG_FILE = "CyaHub_v3_config.json"
local PREMIUM_FILE = "CyaHub_v3_premium.json"

local function SaveConfig(profileName)
    profileName = profileName or State.ActiveProfile
    local cfg = {
        ToggleKeyName  = State.ToggleKeyName,
        ActiveTheme    = State.ActiveTheme,
        FlySpeed       = State.FlySpeed,
        WalkSpeed      = State.WalkSpeed,
        RainbowMode    = State.RainbowMode,
        KeySystem      = State.KeySystem,
        GuiOpacity     = State.GuiOpacity,
        FOVRadius      = State.FOVRadius,
        GravityValue   = State.GravityValue,
        TimeValue      = State.TimeValue,
        SavedLocations = State.SavedLocations,
        ActiveProfile  = profileName,
    }
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode(cfg))
    end)
end

local function SavePremium()
    local cfg = {
        IsPremium = State.IsPremium,
        PremiumTier = State.PremiumTier,
        PremiumExpiry = State.PremiumExpiry,
        AimbotFOV = State.AimbotFOV,
        AimbotSmooth = State.AimbotSmooth,
        KillAuraRange = State.KillAuraRange,
        AutoClickerCPS = State.AutoClickerCPS,
    }
    pcall(function()
        writefile(PREMIUM_FILE, HttpService:JSONEncode(cfg))
    end)
end

local function LoadConfig()
    pcall(function()
        if isfile and isfile(CONFIG_FILE) then
            local raw = readfile(CONFIG_FILE)
            local cfg = HttpService:JSONDecode(raw)
            if cfg.ToggleKeyName then
                State.ToggleKeyName = cfg.ToggleKeyName
                local ok, kc = pcall(function() return Enum.KeyCode[cfg.ToggleKeyName] end)
                if ok and kc then State.ToggleKey = kc end
            end
            if cfg.ActiveTheme and Themes[cfg.ActiveTheme] then
                State.ActiveTheme = cfg.ActiveTheme
                CurrentTheme = Themes[cfg.ActiveTheme]
            end
            if cfg.FlySpeed       then State.FlySpeed       = cfg.FlySpeed       end
            if cfg.WalkSpeed      then State.WalkSpeed      = cfg.WalkSpeed      end
            if cfg.RainbowMode ~= nil then State.RainbowMode = cfg.RainbowMode   end
            if cfg.KeySystem ~= nil   then State.KeySystem   = cfg.KeySystem     end
            if cfg.GuiOpacity     then State.GuiOpacity     = cfg.GuiOpacity     end
            if cfg.FOVRadius      then State.FOVRadius      = cfg.FOVRadius      end
            if cfg.GravityValue   then State.GravityValue   = cfg.GravityValue   end
            if cfg.TimeValue      then State.TimeValue      = cfg.TimeValue      end
            if cfg.SavedLocations then State.SavedLocations = cfg.SavedLocations end
            if cfg.ActiveProfile  then State.ActiveProfile  = cfg.ActiveProfile  end
        end
    end)
end

local function ExportConfig()
    local cfg = HttpService:JSONEncode({
        ToggleKeyName = State.ToggleKeyName,
        ActiveTheme   = State.ActiveTheme,
        FlySpeed      = State.FlySpeed,
        WalkSpeed     = State.WalkSpeed,
        FOVRadius     = State.FOVRadius,
        GravityValue  = State.GravityValue,
    })
    pcall(function() setclipboard(cfg) end)
end

local function ImportConfig(str)
    pcall(function()
        local cfg = HttpService:JSONDecode(str)
        if cfg.ActiveTheme and Themes[cfg.ActiveTheme] then
            State.ActiveTheme = cfg.ActiveTheme
            CurrentTheme = Themes[cfg.ActiveTheme]
        end
        if cfg.FlySpeed  then State.FlySpeed  = cfg.FlySpeed  end
        if cfg.WalkSpeed then State.WalkSpeed  = cfg.WalkSpeed end
        if cfg.FOVRadius then State.FOVRadius  = cfg.FOVRadius end
    end)
end

local function LoadPremium()
    pcall(function()
        if isfile and isfile(PREMIUM_FILE) then
            local raw = readfile(PREMIUM_FILE)
            local cfg = HttpService:JSONDecode(raw)
            if cfg.IsPremium then State.IsPremium = cfg.IsPremium end
            if cfg.PremiumTier then State.PremiumTier = cfg.PremiumTier end
            if cfg.PremiumExpiry then State.PremiumExpiry = cfg.PremiumExpiry end
            if cfg.AimbotFOV then State.AimbotFOV = cfg.AimbotFOV end
            if cfg.AimbotSmooth then State.AimbotSmooth = cfg.AimbotSmooth end
            if cfg.KillAuraRange then State.KillAuraRange = cfg.KillAuraRange end
            if cfg.AutoClickerCPS then State.AutoClickerCPS = cfg.AutoClickerCPS end
        end
    end)
end

LoadConfig()
LoadPremium()

-- ============================================================
-- HELPERS CORE
-- ============================================================
local function GetChar() return (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) end
local function GetRoot()
    local c = GetChar(); return c and c:FindFirstChild("HumanoidRootPart")
end
local function GetHum()
    local c = GetChar(); return c and c:FindFirstChildOfClass("Humanoid")
end

-- ============================================================
-- SISTEMA DE NOTIFICACIONES V2
-- ============================================================
local NotifQueue  = {}
local NotifActive = 0
local MAX_NOTIFS  = 5

local function Notify(msg, color, duration, icon)
    color    = color    or CurrentTheme.AccentLight
    duration = duration or 2.5
    icon     = icon     or "✦"

    if NotifActive >= MAX_NOTIFS then return end
    NotifActive = NotifActive + 1

    local sg = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    sg.Name = "CyaNotif_" .. tick()
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 9999

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 50)
    frame.BackgroundColor3 = CurrentTheme.BG2
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(1, 1)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = color; stroke.Thickness = 1

    local accent = Instance.new("Frame", frame)
    accent.Size = UDim2.new(0, 3, 1, -10)
    accent.Position = UDim2.new(0, 0, 0, 5)
    accent.BackgroundColor3 = color
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

    local icLbl = Instance.new("TextLabel", frame)
    icLbl.Size = UDim2.new(0, 30, 1, 0)
    icLbl.Position = UDim2.new(0, 10, 0, 0)
    icLbl.BackgroundTransparency = 1
    icLbl.Text = icon; icLbl.TextColor3 = color
    icLbl.Font = Enum.Font.GothamBold; icLbl.TextSize = 15

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -46, 1, 0)
    lbl.Position = UDim2.new(0, 44, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = CurrentTheme.Text
    lbl.Text = msg; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11
    lbl.TextWrapped = true; lbl.TextXAlignment = Enum.TextXAlignment.Left

    local prog = Instance.new("Frame", frame)
    prog.Size = UDim2.new(1, 0, 0, 2)
    prog.Position = UDim2.new(0, 0, 1, -2)
    prog.BackgroundColor3 = color; prog.BorderSizePixel = 0
    Instance.new("UICorner", prog).CornerRadius = UDim.new(1, 0)

    frame.Position = UDim2.new(1, 320, 1, -(NotifActive * 60) - 10)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -10, 1, -(NotifActive * 60) - 10)
    }):Play()
    TweenService:Create(prog, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 2)
    }):Play()

    task.delay(duration, function()
        TweenService:Create(frame, TweenInfo.new(0.25), {
            Position = UDim2.new(1, 320, 1, -(NotifActive * 60) - 10)
        }):Play()
        task.delay(0.3, function()
            sg:Destroy()
            NotifActive = math.max(0, NotifActive - 1)
        end)
    end)
end

-- ============================================================
-- PREMIUM KEY VALIDATION
-- ============================================================
local function ValidatePremiumKey(key)
    local premiumKeys = {
        ["CYA-PREMIUM-001"] = {tier = "PRO", days = 30},
        ["CYA-PRO-2024"] = {tier = "PRO", days = 30},
        ["CYA-VIP-LIFETIME"] = {tier = "VIP", days = 36500},
        ["CYA-VIP-001"] = {tier = "VIP", days = 30},
    }
    
    if premiumKeys[key] then
        local data = premiumKeys[key]
        State.IsPremium = true
        State.PremiumTier = data.tier
        State.PremiumExpiry = os.time() + (data.days * 86400)
        SavePremium()
        return true, data.tier
    end
    return false
end

-- ============================================================
-- PREMIUM KEY SYSTEM UI
-- ============================================================
local function ShowPremiumKeySystem(onSuccess)
    local kg = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    kg.Name = "CyaPremiumSystem"; kg.ResetOnSpawn = false; kg.DisplayOrder = 99999

    local overlay = Instance.new("Frame", kg)
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.BackgroundColor3 = Color3.new(0,0,0); overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0

    local box = Instance.new("Frame", kg)
    box.Size = UDim2.new(0,420,0,580); box.Position = UDim2.new(0.5,-210,0.5,-290)
    box.BackgroundColor3 = CurrentTheme.BG2; box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)
    local bs = Instance.new("UIStroke", box); bs.Color = CurrentTheme.Accent; bs.Thickness = 2

    -- Header
    local header = Instance.new("Frame", box)
    header.Size = UDim2.new(1,0,0,70); header.BackgroundColor3 = CurrentTheme.Accent
    header.BorderSizePixel = 0
    Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

    local headerTitle = Instance.new("TextLabel", header)
    headerTitle.Size = UDim2.new(1,0,0.6,0); headerTitle.Position = UDim2.new(0,0,0,5)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "👑  CYAHUB PREMIUM  👑"; headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextSize = 18; headerTitle.TextColor3 = Color3.new(1,1,1)

    local headerSub = Instance.new("TextLabel", header)
    headerSub.Size = UDim2.new(1,0,0.4,0); headerSub.Position = UDim2.new(0,0,0.6,0)
    headerSub.BackgroundTransparency = 1; headerSub.Text = "Acceso a features exclusivas"
    headerSub.Font = Enum.Font.Gotham; headerSub.TextSize = 11; headerSub.TextColor3 = Color3.fromRGB(200,200,255)

    -- Plans
    local plansLabel = Instance.new("TextLabel", box)
    plansLabel.Size = UDim2.new(1,-20,0,22); plansLabel.Position = UDim2.new(0,10,0,80)
    plansLabel.BackgroundTransparency = 1; plansLabel.Text = "Planes disponibles:"
    plansLabel.Font = Enum.Font.GothamBold; plansLabel.TextSize = 12
    plansLabel.TextColor3 = CurrentTheme.Text; plansLabel.TextXAlignment = Enum.TextXAlignment.Left

    local plansFrame = Instance.new("Frame", box)
    plansFrame.Size = UDim2.new(1,-20,0,130); plansFrame.Position = UDim2.new(0,10,0,105)
    plansFrame.BackgroundTransparency = 1

    local plans = {
        {name = "FREE", price = "Gratis", color = Color3.fromRGB(100,100,120), features = {"ESP básico", "Config", "Notif"}},
        {name = "PRO", price = "$4.99/mes", color = Color3.fromRGB(100,255,140), features = {"Todo FREE+", "Aimbot AI", "Auto-Farm"}},
        {name = "VIP", price = "$9.99/mes", color = Color3.fromRGB(255,200,80), features = {"Todo PRO+", "Anti-Ban", "Kill Aura"}},
    }

    for i, plan in ipairs(plans) do
        local pcard = Instance.new("Frame", plansFrame)
        pcard.Size = UDim2.new(0.31,-3,1,0); pcard.Position = UDim2.new(0,(i-1)*(0.33)+2,0,0)
        pcard.BackgroundColor3 = CurrentTheme.BG3; pcard.BorderSizePixel = 0
        Instance.new("UICorner", pcard).CornerRadius = UDim.new(0,8)
        local ps = Instance.new("UIStroke", pcard); ps.Color = plan.color; ps.Thickness = 1.5

        local pname = Instance.new("TextLabel", pcard)
        pname.Size = UDim2.new(1,0,0,20); pname.Position = UDim2.new(0,0,0,5)
        pname.BackgroundTransparency = 1; pname.Text = plan.name
        pname.Font = Enum.Font.GothamBold; pname.TextSize = 13; pname.TextColor3 = plan.color

        local pprice = Instance.new("TextLabel", pcard)
        pprice.Size = UDim2.new(1,0,0,16); pprice.Position = UDim2.new(0,0,0,27)
        pprice.BackgroundTransparency = 1; pprice.Text = plan.price
        pprice.Font = Enum.Font.Gotham; pprice.TextSize = 10; pprice.TextColor3 = CurrentTheme.TextDim

        for j, feature in ipairs(plan.features) do
            local feat = Instance.new("TextLabel", pcard)
            feat.Size = UDim2.new(1,-8,0,14); feat.Position = UDim2.new(0,4,0,48+j*14)
            feat.BackgroundTransparency = 1; feat.Text = "✓ " .. feature
            feat.Font = Enum.Font.Gotham; feat.TextSize = 8; feat.TextColor3 = CurrentTheme.TextDim
            feat.TextXAlignment = Enum.TextXAlignment.Left
        end
    end

    -- Key Input Section
    local keyLabel = Instance.new("TextLabel", box)
    keyLabel.Size = UDim2.new(1,-20,0,20); keyLabel.Position = UDim2.new(0,10,0,245)
    keyLabel.BackgroundTransparency = 1; keyLabel.Text = "Ingresa tu PREMIUM KEY:"
    keyLabel.Font = Enum.Font.Gotham; keyLabel.TextSize = 11; keyLabel.TextColor3 = CurrentTheme.Text

    local inputFrame = Instance.new("Frame", box)
    inputFrame.Size = UDim2.new(1,-20,0,40); inputFrame.Position = UDim2.new(0,10,0,270)
    inputFrame.BackgroundColor3 = CurrentTheme.BG; inputFrame.BorderSizePixel = 0
    Instance.new("UICorner", inputFrame).CornerRadius = UDim.new(0,8)
    Instance.new("UIStroke", inputFrame).Color = CurrentTheme.Border

    local input = Instance.new("TextBox", inputFrame)
    input.Size = UDim2.new(1,-12,1,0); input.Position = UDim2.new(0,8,0,0)
    input.BackgroundTransparency = 1; input.PlaceholderText = "CYA-XXXX-XXXX-XXXX"
    input.PlaceholderColor3 = CurrentTheme.TextDim; input.TextColor3 = CurrentTheme.AccentLight
    input.Font = Enum.Font.GothamBold; input.TextSize = 12

    -- Status
    local statusLbl = Instance.new("TextLabel", box)
    statusLbl.Size = UDim2.new(1,-20,0,40); statusLbl.Position = UDim2.new(0,10,0,320)
    statusLbl.BackgroundTransparency = 1; statusLbl.Font = Enum.Font.Gotham; statusLbl.TextSize = 10
    statusLbl.TextWrapped = true; statusLbl.TextColor3 = CurrentTheme.TextDim
    statusLbl.Text = "Obtén keys en: discord.gg/cyahub\n¿No tienes key? ¡Compra Premium ahora!"

    -- Buttons
    local btnFrame = Instance.new("Frame", box)
    btnFrame.Size = UDim2.new(1,-20,0,40); btnFrame.Position = UDim2.new(0,10,0,370)
    btnFrame.BackgroundTransparency = 1
    local btnGrid = Instance.new("UIGridLayout", btnFrame)
    btnGrid.CellSize = UDim2.new(0.5,-4,1,0); btnGrid.CellPadding = UDim2.new(0,8,0,0)

    local confirmBtn = Instance.new("TextButton", btnFrame)
    confirmBtn.BackgroundColor3 = CurrentTheme.Accent; confirmBtn.Text = "Validar KEY"
    confirmBtn.Font = Enum.Font.GothamBold; confirmBtn.TextSize = 12
    confirmBtn.TextColor3 = Color3.new(1,1,1); confirmBtn.BorderSizePixel = 0
    Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0,6)

    local buyBtn = Instance.new("TextButton", btnFrame)
    buyBtn.BackgroundColor3 = Color3.fromRGB(255,200,80); buyBtn.Text = "Comprar Premium"
    buyBtn.Font = Enum.Font.GothamBold; buyBtn.TextSize = 12
    buyBtn.TextColor3 = Color3.new(0,0,0); buyBtn.BorderSizePixel = 0
    Instance.new("UICorner", buyBtn).CornerRadius = UDim.new(0,6)

    local continueBtn = Instance.new("TextButton", box)
    continueBtn.Size = UDim2.new(1,-20,0,36); continueBtn.Position = UDim2.new(0,10,0,530)
    continueBtn.BackgroundColor3 = CurrentTheme.BG3; continueBtn.Text = "Continuar como FREE"
    continueBtn.Font = Enum.Font.Gotham; continueBtn.TextSize = 11
    continueBtn.TextColor3 = CurrentTheme.TextDim; continueBtn.BorderSizePixel = 0
    Instance.new("UICorner", continueBtn).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke", continueBtn).Color = CurrentTheme.Border

    confirmBtn.MouseButton1Click:Connect(function()
        local key = input.Text:upper():gsub("%s","")
        local valid, tier = ValidatePremiumKey(key)
        
        if valid then
            statusLbl.TextColor3 = Color3.fromRGB(100,255,140)
            statusLbl.Text = "✓ KEY VALIDADA - ACCESO " .. tier .. " CONCEDIDO"
            task.delay(1, function() kg:Destroy(); onSuccess() end)
        else
            statusLbl.TextColor3 = Color3.fromRGB(255,100,100)
            statusLbl.Text = "✗ KEY INVÁLIDA O EXPIRADA"
        end
    end)

    buyBtn.MouseButton1Click:Connect(function()
        pcall(function() 
            setclipboard("https://discord.gg/cyahub")
        end)
        Notify("Link de compra copiado al clipboard 🔗", Color3.fromRGB(255,200,80), 2)
    end)

    continueBtn.MouseButton1Click:Connect(function()
        kg:Destroy()
        onSuccess()
    end)
end

-- ============================================================
-- PREMIUM FEATURES - AIMBOT AI SYSTEM
-- ============================================================
local function StartAimbot()
    if State.PremiumTier ~= "PRO" and State.PremiumTier ~= "VIP" then 
        Notify("⚠ Requiere PRO", Color3.fromRGB(255,100,100), 2)
        return
    end
    
    Connections["Aimbot"] = RunService.RenderStepped:Connect(function()
        if not State.AimbotAI then return end
        
        local root = GetRoot(); if not root then return end
        local nearest, nearestDist = nil, State.AimbotFOV
        local screenCenter = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        
        for _, player in pairs(Players:GetPlayers()) do
            if player == LocalPlayer or not player.Character then continue end
            if State.AimbotTeamCheck and player.Team == LocalPlayer.Team then continue end
            
            local target = player.Character:FindFirstChild("Head")
            if target then
                local screenPos = Camera:WorldToViewportPoint(target.Position)
                local diff = screenCenter - Vector2.new(screenPos.X, screenPos.Y)
                local dist = diff.Magnitude
                
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = target
                end
            end
        end
        
        if nearest then
            local predictedPos = nearest.Position
            if State.AimbotPrediction then
                local humanoid = nearest.Parent:FindFirstChildOfClass("Humanoid")
                local hum = GetHum()
                if humanoid and hum then
                    predictedPos = nearest.Position + nearest.Velocity * (State.AimbotSmooth * 0.5)
                end
            end
            
            local targetCF = CFrame.new(Camera.CFrame.Position, predictedPos)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, 0.1 * State.AimbotSmooth)
        end
    end)
    Notify("Aimbot AI ACTIVADO 🎯 (" .. State.PremiumTier .. ")", Color3.fromRGB(255,200,80), 2)
end

local function StopAimbot()
    if Connections["Aimbot"] then Connections["Aimbot"]:Disconnect() end
    Notify("Aimbot AI DESACTIVADO", CurrentTheme.TextDim, 2)
end

-- ============================================================
-- PREMIUM FEATURES - ANTI-BAN AI (VIP ONLY)
-- ============================================================
local function ToggleAntiBanAI(on)
    if State.PremiumTier ~= "VIP" then 
        Notify("⚠ Requiere VIP", Color3.fromRGB(255,100,100), 2)
        return
    end
    
    if on then
        Connections["AntiBan"] = RunService.Heartbeat:Connect(function()
            if not State.AntibanAI then return end
            
            -- Humanizar movimento
            if State.HumanizeMovement and math.random(1,100) < 3 then
                task.wait(math.random(1,5)/100)
            end
            
            -- Añadir delays aleatorios
            if State.RandomDelays and math.random(1,100) < 2 then
                task.wait(math.random(5,15)/1000)
            end
            
            -- Anti-detección de speed hacks
            local hum = GetHum()
            if hum and State.SpeedHack then
                if math.random(1,100) < 5 then
                    hum.WalkSpeed = hum.WalkSpeed + math.random(-1,1) * 0.1
                end
            end
        end)
        Notify("Anti-Ban AI ACTIVADO 🛡", Color3.fromRGB(100,255,140), 2)
    else
        if Connections["AntiBan"] then Connections["AntiBan"]:Disconnect() end
        Notify("Anti-Ban AI DESACTIVADO", CurrentTheme.TextDim, 2)
    end
end

-- ============================================================
-- PREMIUM FEATURES - AUTO FARM ADVANCED
-- ============================================================
local function StartAdvancedAutoFarm()
    if State.PremiumTier ~= "PRO" and State.PremiumTier ~= "VIP" then 
        Notify("⚠ Requiere PRO", Color3.fromRGB(255,100,100), 2)
        return
    end
    
    Connections["AdvancedAutoFarm"] = RunService.Heartbeat:Connect(function()
        if not State.AutoFarmAdvanced then return end
        local root = GetRoot(); if not root then return end
        
        local targets = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.CanTouch then
                local name = obj.Name:lower()
                if name:find("coin") or name:find("cash") or name:find("gem") or 
                   name:find("drop") or name:find("reward") or name:find("item") then
                    local dist = (root.Position - obj.Position).Magnitude
                    if dist < 100 then
                        table.insert(targets, {obj = obj, dist = dist})
                    end
                end
            end
        end
        
        if #targets > 0 then
            table.sort(targets, function(a,b) return a.dist < b.dist end)
            root.CFrame = targets[1].obj.CFrame + Vector3.new(0,3,0)
        end
    end)
    Notify("Auto-Farm Avanzado ACTIVADO 🌾 (" .. State.PremiumTier .. ")", Color3.fromRGB(100,255,140), 2)
end

-- ============================================================
-- PREMIUM FEATURES - KILL AURA
-- ============================================================
local function StartKillAura()
    if State.PremiumTier ~= "PRO" and State.PremiumTier ~= "VIP" then 
        Notify("⚠ Requiere PRO", Color3.fromRGB(255,100,100), 2)
        return
    end
    
    Connections["KillAura"] = RunService.Heartbeat:Connect(function()
        if not State.KillAura then return end
        local root = GetRoot(); if not root then return end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player == LocalPlayer or not player.Character then continue end
            local target = player.Character:FindFirstChild("HumanoidRootPart")
            if target then
                local dist = (root.Position - target.Position).Magnitude
                if dist < State.KillAuraRange then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        humanoid:TakeDamage(humanoid.MaxHealth + 100)
                    end
                end
            end
        end
    end)
    Notify("Kill Aura ACTIVADO 💀 (Rango: " .. State.KillAuraRange .. ")", Color3.fromRGB(255,100,100), 2)
end

-- ============================================================
-- PREMIUM FEATURES - AUTO CLICKER
-- ============================================================
local function ToggleAutoClicker(on)
    if State.PremiumTier ~= "PRO" and State.PremiumTier ~= "VIP" then 
        Notify("⚠ Requiere PRO", Color3.fromRGB(255,100,100), 2)
        return
    end
    
    if on then
        local clickInterval = 1 / State.AutoClickerCPS
        Connections["AutoClicker"] = RunService.Heartbeat:Connect(function()
            if not State.AutoClicker then return end
            pcall(function()
                mouse1press()
                task.wait(clickInterval/2)
                mouse1release()
                task.wait(clickInterval/2)
            end)
        end)
        Notify("Auto Clicker ACTIVADO 🖱 (" .. State.AutoClickerCPS .. " CPS)", Color3.fromRGB(255,200,80), 2)
    else
        if Connections["AutoClicker"] then Connections["AutoClicker"]:Disconnect() end
        Notify("Auto Clicker DESACTIVADO", CurrentTheme.TextDim, 2)
    end
end

-- ============================================================
-- PREMIUM FEATURES - NO RECOIL/SPREAD
-- ============================================================
local function ToggleNoSpreadRecoil(on)
    if State.PremiumTier ~= "VIP" then 
        Notify("⚠ Requiere VIP", Color3.fromRGB(255,100,100), 2)
        return
    end
    
    if on then
        Connections["NoRecoil"] = RunService.RenderStepped:Connect(function()
            if not State.NoSpreadRecoil then return end
            
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, part in pairs(tool:GetDescendants()) do
                        if part.Name:lower():find("muzzle") or part.Name:lower():find("barrel") then
                            part.Orientation = Vector3.new(0,0,0)
                        end
                    end
                end
            end
            
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.LookVector)
        end)
        Notify("No Recoil/Spread ACTIVADO 🎯 (VIP)", Color3.fromRGB(255,200,80), 2)
    else
        if Connections["NoRecoil"] then Connections["NoRecoil"]:Disconnect() end
    end
end

-- ============================================================
-- FUNCIONES — MOVIMIENTO
-- ============================================================
local function StartFly()
    local root = GetRoot(); if not root then return end
    local hum  = GetHum(); if hum then hum.PlatformStand = true end
    local bv = Instance.new("BodyVelocity", root)
    bv.Name = "CyaFlyVel"; bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(1e9,1e9,1e9)
    local bg = Instance.new("BodyGyro", root)
    bg.Name = "CyaFlyGyro"; bg.MaxTorque = Vector3.new(1e9,1e9,1e9); bg.D = 100
    Connections["Fly"] = RunService.Heartbeat:Connect(function()
        if not State.Fly then return end
        local d  = Vector3.zero
        local cf = Camera.CFrame
        local spd = State.FlySpeed
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then spd = spd * 2 end
        if UserInputService:IsKeyDown(Enum.KeyCode.W)     then d = d + cf.LookVector  end
        if UserInputService:IsKeyDown(Enum.KeyCode.S)     then d = d - cf.LookVector  end
        if UserInputService:IsKeyDown(Enum.KeyCode.A)     then d = d - cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D)     then d = d + cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0,1,0) end
        bv.Velocity = d.Magnitude > 0 and d.Unit * spd or Vector3.zero
        bg.CFrame   = cf
    end)
end

local function StopFly()
    local root = GetRoot()
    if root then
        local v = root:FindFirstChild("CyaFlyVel");  if v then v:Destroy() end
        local g = root:FindFirstChild("CyaFlyGyro"); if g then g:Destroy() end
    end
    local hum = GetHum(); if hum then hum.PlatformStand = false end
    if Connections["Fly"] then Connections["Fly"]:Disconnect() end
end

local function StartNoClip()
    Connections["NoClip"] = RunService.Stepped:Connect(function()
        if not State.NoClip then return end
        local c = GetChar(); if not c then return end
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end)
end

local function StopNoClip()
    if Connections["NoClip"] then Connections["NoClip"]:Disconnect() end
    local c = GetChar(); if not c then return end
    for _, p in pairs(c:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = true end
    end
end

local function SetSpeed(v) local h = GetHum(); if h then h.WalkSpeed = v end end
local function SetGravity(v) workspace.Gravity = v end

local function ToggleGodmode(on)
    local h = GetHum(); if not h then return end
    if on then
        OriginalValues.MaxHealth = h.MaxHealth
        h.MaxHealth = math.huge; h.Health = math.huge
        Connections["Godmode"] = h.HealthChanged:Connect(function()
            if State.Godmode then h.Health = math.huge end
        end)
    else
        h.MaxHealth = OriginalValues.MaxHealth or 100
        h.Health    = h.MaxHealth
        if Connections["Godmode"] then Connections["Godmode"]:Disconnect() end
    end
end

local function ToggleInvisible(on)
    local c = GetChar(); if not c then return end
    for _, p in pairs(c:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Transparency = on and 1 or 0
        elseif p:IsA("Decal") then
            p.Transparency = on and 1 or 0
        end
    end
end

Connections["InfJump"] = UserInputService.JumpRequest:Connect(function()
    if State.InfJump then
        local h = GetHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- BunnyHop
Connections["BunnyHop"] = RunService.Heartbeat:Connect(function()
    if not State.BunnyHop then return end
    local h = GetHum(); if not h then return end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        h:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Dash System (Q key)
local function DoDash()
    if State.DashCooldown then return end
    local root = GetRoot(); if not root then return end
    State.DashCooldown = true
    local dir = Camera.CFrame.LookVector
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = -Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir =  Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = -Camera.CFrame.LookVector  end
    local bv = Instance.new("BodyVelocity", root)
    bv.Velocity = dir * 120; bv.MaxForce = Vector3.new(1e9,1e9,1e9)
    game:GetService("Debris"):AddItem(bv, 0.15)
    Notify("Dash!", CurrentTheme.AccentLight, 0.8, "💨")
    task.delay(0.8, function() State.DashCooldown = false end)
end

-- Fast Climb
Connections["FastClimb"] = RunService.Heartbeat:Connect(function()
    if not State.FastClimb then return end
    local h = GetHum(); if not h then return end
    if h:GetState() == Enum.HumanoidStateType.Climbing then
        h.WalkSpeed = 60
    end
end)

-- ============================================================
-- FUNCIONES — ESP / CHAMS / SKELETON / TRACERS
-- ============================================================
local ESP_COLORS = {
    Color3.fromRGB(167,139,250), Color3.fromRGB(100,220,140),
    Color3.fromRGB(250,180,100), Color3.fromRGB(100,200,255),
    Color3.fromRGB(255,120,180), Color3.fromRGB(180,255,120),
}

local function ClearESP()
    for _, o in pairs(ESPObjects) do pcall(function() o:Destroy() end) end
    ESPObjects = {}
end

local function CreateESP()
    ClearESP()
    for i, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local col = ESP_COLORS[(i % #ESP_COLORS) + 1]
        local bb  = Instance.new("BillboardGui")
        bb.Name = "CyaESP"; bb.Size = UDim2.new(0,130,0,58)
        bb.StudsOffset = Vector3.new(0,3.2,0)
        bb.AlwaysOnTop = true; bb.Adornee = root; bb.Parent = root

        local nl = Instance.new("TextLabel", bb)
        nl.Size = UDim2.new(1,0,0.45,0); nl.BackgroundTransparency = 1
        nl.TextColor3 = col; nl.Text = "👤 " .. player.Name
        nl.Font = Enum.Font.GothamBold; nl.TextSize = 13
        nl.TextStrokeTransparency = 0; nl.TextStrokeColor3 = Color3.new(0,0,0)

        -- Distance label
        local dl = Instance.new("TextLabel", bb)
        dl.Size = UDim2.new(1,0,0.3,0); dl.Position = UDim2.new(0,0,0.45,0)
        dl.BackgroundTransparency = 1; dl.Font = Enum.Font.Gotham; dl.TextSize = 10
        dl.TextStrokeTransparency = 0; dl.TextStrokeColor3 = Color3.new(0,0,0)
        dl.TextColor3 = CurrentTheme.TextDim

        local hl = Instance.new("TextLabel", bb)
        hl.Size = UDim2.new(1,0,0.25,0); hl.Position = UDim2.new(0,0,0.75,0)
        hl.BackgroundTransparency = 1; hl.Font = Enum.Font.Gotham; hl.TextSize = 10
        hl.TextStrokeTransparency = 0; hl.TextStrokeColor3 = Color3.new(0,0,0)

        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            local function updateHP(hp)
                hp = math.floor(hp)
                local pct = hp / hum.MaxHealth
                hl.Text = string.format("HP %d  [%s%s]", hp,
                    string.rep("█", math.floor(pct*8)),
                    string.rep("░", 8 - math.floor(pct*8)))
                hl.TextColor3 = Color3.fromRGB(
                    math.floor(255*(1-pct)), math.floor(200*pct), 60)
            end
            updateHP(hum.Health)
            Connections["ESPHealth_"..player.Name] = hum.HealthChanged:Connect(updateHP)
        end

        -- Distance updater
        Connections["ESPDist_"..player.Name] = RunService.Heartbeat:Connect(function()
            local myRoot = GetRoot()
            if myRoot and root and root.Parent then
                local dist = math.floor((myRoot.Position - root.Position).Magnitude)
                dl.Text = dist .. " studs"
            end
        end)

        table.insert(ESPObjects, bb)
    end
end

-- Tracers
local TracerGui = nil
local function ClearTracers()
    if TracerGui then TracerGui:Destroy(); TracerGui = nil end
    TracerObjs = {}
end

local function CreateTracers()
    ClearTracers()
    TracerGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    TracerGui.Name = "CyaTracers"; TracerGui.ResetOnSpawn = false
    TracerGui.DisplayOrder = 9990

    Connections["Tracers"] = RunService.Heartbeat:Connect(function()
        if not State.Tracers then return end
        -- Clear old lines
        for _, f in pairs(TracerGui:GetChildren()) do f:Destroy() end

        local myRoot = GetRoot(); if not myRoot then return end
        local origin = Camera:WorldToViewportPoint(myRoot.Position)

        for i, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer or not player.Character then continue end
            local tRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if not tRoot then continue end
            local tPos, onScreen = Camera:WorldToViewportPoint(tRoot.Position)
            if not onScreen then continue end

            local col = ESP_COLORS[(i % #ESP_COLORS) + 1]
            local dx  = tPos.X - origin.X
            local dy  = tPos.Y - origin.Y
            local len  = math.sqrt(dx*dx + dy*dy)
            local ang  = math.atan2(dy, dx)

            local line = Instance.new("Frame", TracerGui)
            line.BackgroundColor3 = col
            line.BorderSizePixel  = 0
            line.AnchorPoint = Vector2.new(0, 0.5)
            line.Size     = UDim2.new(0, len, 0, 1)
            line.Position = UDim2.new(0, origin.X, 0, origin.Y)
            line.Rotation = math.deg(ang)
        end
    end)
end

-- Skeleton ESP
local BONES = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}

local function ClearSkeleton()
    for _, o in pairs(SkeletonObjs) do pcall(function() o:Destroy() end) end
    SkeletonObjs = {}
end

local function CreateSkeleton()
    ClearSkeleton()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        local char = player.Character
        for _, bone in ipairs(BONES) do
            local p0 = char:FindFirstChild(bone[1])
            local p1 = char:FindFirstChild(bone[2])
            if p0 and p1 then
                local att0 = Instance.new("Attachment", p0); att0.Name = "CyaBoneAtt0"
                local att1 = Instance.new("Attachment", p1); att1.Name = "CyaBoneAtt1"
                local beam = Instance.new("Beam", workspace)
                beam.Name = "CyaSkeletonBeam"
                beam.Attachment0 = att0; beam.Attachment1 = att1
                beam.Color = ColorSequence.new(Color3.fromRGB(0,220,255))
                beam.Width0 = 0.06; beam.Width1 = 0.06
                beam.FaceCamera = true
                beam.Transparency = NumberSequence.new(0)
                table.insert(SkeletonObjs, beam)
                table.insert(SkeletonObjs, att0)
                table.insert(SkeletonObjs, att1)
            end
        end
    end
end

-- Chams V2
local function ClearChams()
    for _, o in pairs(ChamObjects) do pcall(function() o:Destroy() end) end
    ChamObjects = {}
end

local function CreateChams()
    ClearChams()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        local hl = Instance.new("SelectionBox")
        hl.Name = "CyaCham"
        hl.Color3 = CurrentTheme.AccentLight
        hl.LineThickness = 0.04
        hl.SurfaceTransparency = 0.75
        hl.SurfaceColor3 = CurrentTheme.Accent
        hl.Adornee = player.Character
        hl.Parent = workspace
        hl.AlwaysOnTop = true
        table.insert(ChamObjects, hl)
    end
end

-- Highlight ESP
local function ClearHighlight()
    for _, o in pairs(HighlightObjs) do pcall(function() o:Destroy() end) end
    HighlightObjs = {}
end

local function CreateHighlight()
    ClearHighlight()
    for i, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        local col = ESP_COLORS[(i % #ESP_COLORS) + 1]
        local hl  = Instance.new("Highlight")
        hl.Parent = player.Character
        hl.FillColor = col
        hl.OutlineColor = Color3.new(1,1,1)
        hl.FillTransparency = 0.6
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        table.insert(HighlightObjs, hl)
    end
end

-- NPC ESP
local function CreateNPCEsp()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
            local isPlayer = false
            for _, pl in pairs(Players:GetPlayers()) do
                if pl.Character == npc then isPlayer = true; break end
            end
            if not isPlayer then
                local root = npc:FindFirstChild("HumanoidRootPart")
                if root then
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "CyaNPCEsp"; bb.Size = UDim2.new(0,100,0,30)
                    bb.StudsOffset = Vector3.new(0,3,0)
                    bb.AlwaysOnTop = true; bb.Adornee = root; bb.Parent = root
                    local lbl = Instance.new("TextLabel", bb)
                    lbl.Size = UDim2.new(1,0,1,0); lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Color3.fromRGB(255,220,80)
                    lbl.Text = "🤖 " .. npc.Name
                    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11
                    lbl.TextStrokeTransparency = 0
                end
            end
        end
    end
end

-- FOV Circle
local FOVGui = nil
local function ClearFOV()
    if FOVGui then FOVGui:Destroy(); FOVGui = nil end
end

local function CreateFOV()
    ClearFOV()
    FOVGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    FOVGui.Name = "CyaFOV"; FOVGui.ResetOnSpawn = false; FOVGui.DisplayOrder = 9995

    local circle = Instance.new("Frame", FOVGui)
    circle.Name = "FOVCircle"
    circle.Size = UDim2.new(0, State.FOVRadius*2, 0, State.FOVRadius*2)
    circle.Position = UDim2.new(0.5, -State.FOVRadius, 0.5, -State.FOVRadius)
    circle.BackgroundTransparency = 1
    circle.BorderSizePixel = 0
    local uicorner = Instance.new("UICorner", circle)
    uicorner.CornerRadius = UDim.new(1, 0)
    local stroke = Instance.new("UIStroke", circle)
    stroke.Color = CurrentTheme.AccentLight; stroke.Thickness = 1.5

    -- Rainbow FOV updater
    Connections["FOVRainbow"] = RunService.Heartbeat:Connect(function()
        if not State.FOVCircle then return end
        if State.RainbowFOV then
            local hue = (tick()*0.3) % 1
            stroke.Color = Color3.fromHSV(hue, 0.9, 1)
        end
        -- Dynamic FOV pulse
        if State.DynamicFOV then
            local pulse = math.abs(math.sin(tick()*2))
            circle.Size = UDim2.new(0, (State.FOVRadius + pulse*10)*2, 0, (State.FOVRadius + pulse*10)*2)
            circle.Position = UDim2.new(0.5, -(State.FOVRadius + pulse*10), 0.5, -(State.FOVRadius + pulse*10))
        end
    end)
end

-- Crosshair
local CrosshairGui = nil
local function ToggleCrosshair(on)
    if CrosshairGui then CrosshairGui:Destroy(); CrosshairGui = nil end
    if not on then return end
    CrosshairGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    CrosshairGui.Name = "CyaCrosshair"; CrosshairGui.ResetOnSpawn = false
    CrosshairGui.DisplayOrder = 9998
    local center = Instance.new("Frame", CrosshairGui)
    center.Size = UDim2.new(0,3,0,3)
    center.Position = UDim2.new(0.5,-1,0.5,-1)
    center.BackgroundColor3 = CurrentTheme.AccentLight; center.BorderSizePixel = 0
    Instance.new("UICorner", center).CornerRadius = UDim.new(1,0)
    local lines = {
        {UDim2.new(0,14,0,1), UDim2.new(0.5,5,0.5,-0.5)},
        {UDim2.new(0,14,0,1), UDim2.new(0.5,-19,0.5,-0.5)},
        {UDim2.new(0,1,0,14), UDim2.new(0.5,-0.5,0.5,5)},
        {UDim2.new(0,1,0,14), UDim2.new(0.5,-0.5,0.5,-19)},
    }
    for _, d in ipairs(lines) do
        local l = Instance.new("Frame", CrosshairGui)
        l.Size = d[1]; l.Position = d[2]
        l.BackgroundColor3 = CurrentTheme.AccentLight; l.BorderSizePixel = 0
    end
end

-- ============================================================
-- FUNCIONES — WORLD / VISUAL
-- ============================================================
local function ToggleFullbright(on)
    if on then
        OriginalValues.Ambient    = Lighting.Ambient
        OriginalValues.OutdoorAmbient = Lighting.OutdoorAmbient
        OriginalValues.Brightness = Lighting.Brightness
        Lighting.Ambient         = Color3.new(1,1,1)
        Lighting.OutdoorAmbient  = Color3.new(1,1,1)
        Lighting.Brightness      = 2
    else
        Lighting.Ambient         = OriginalValues.Ambient        or Color3.fromRGB(127,127,127)
        Lighting.OutdoorAmbient  = OriginalValues.OutdoorAmbient or Color3.fromRGB(127,127,127)
        Lighting.Brightness      = OriginalValues.Brightness     or 1
    end
end

local function ToggleNoFog(on)
    local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo then
        if on then OriginalValues.FogDensity = atmo.Density; atmo.Density = 0
        else atmo.Density = OriginalValues.FogDensity or 0.3 end
    end
    if on then OriginalValues.FogEnd = Lighting.FogEnd; Lighting.FogEnd = 1e8
    else Lighting.FogEnd = OriginalValues.FogEnd or 1000 end
end

local function SetTime(t)
    Lighting.ClockTime = t
end

local function ToggleNightVision(on)
    if on then
        OriginalValues.NVAmbient = Lighting.Ambient
        Lighting.Ambient = Color3.fromRGB(80,80,120)
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Name = "CyaNightVision"
        cc.Brightness = 0.1; cc.Contrast = 0.2; cc.Saturation = -0.3
        cc.TintColor = Color3.fromRGB(180,255,200)
    else
        Lighting.Ambient = OriginalValues.NVAmbient or Color3.fromRGB(127,127,127)
        local cc = Lighting:FindFirstChild("CyaNightVision")
        if cc then cc:Destroy() end
    end
end

local function ToggleThermal(on)
    if on then
        local cc = Instance.new("ColorCorrectionEffect", Lighting)
        cc.Name = "CyaThermal"
        cc.TintColor = Color3.fromRGB(255,100,50)
        cc.Saturation = -1; cc.Contrast = 0.5
        Lighting.Ambient = Color3.fromRGB(50,0,0)
    else
        local cc = Lighting:FindFirstChild("CyaThermal")
        if cc then cc:Destroy() end
        Lighting.Ambient = OriginalValues.Ambient or Color3.fromRGB(127,127,127)
    end
end

local function ToggleBloom(on)
    if on then
        local bloom = Instance.new("BloomEffect", Lighting)
        bloom.Name = "CyaBloom"; bloom.Intensity = 0.6
        bloom.Size = 24; bloom.Threshold = 0.95
    else
        local b = Lighting:FindFirstChild("CyaBloom"); if b then b:Destroy() end
    end
end

local function ToggleColorCorrection(on)
    if on then
        local cc = Instance.new("ColorCorrectionEffect", Lighting)
        cc.Name = "CyaCC"; cc.Brightness = 0.05
        cc.Contrast = 0.2; cc.Saturation = 0.3
        cc.TintColor = Color3.fromRGB(240,235,255)
    else
        local cc = Lighting:FindFirstChild("CyaCC"); if cc then cc:Destroy() end
    end
end

local function ToggleRetroShader(on)
    if on then
        local cc = Instance.new("ColorCorrectionEffect", Lighting)
        cc.Name = "CyaRetro"; cc.Saturation = -0.5
        cc.Contrast = 0.4; cc.TintColor = Color3.fromRGB(255,240,200)
        local blur = Instance.new("BlurEffect", Lighting)
        blur.Name = "CyaRetroBlur"; blur.Size = 2
    else
        local cc = Lighting:FindFirstChild("CyaRetro");       if cc then cc:Destroy()   end
        local bl = Lighting:FindFirstChild("CyaRetroBlur");   if bl then bl:Destroy()   end
    end
end

local function ToggleMotionBlur(on)
    if on then
        local blur = Instance.new("BlurEffect", Lighting)
        blur.Name = "CyaMotionBlur"; blur.Size = 8
    else
        local b = Lighting:FindFirstChild("CyaMotionBlur"); if b then b:Destroy() end
    end
end

local function ToggleFPSBoost(on)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or
           v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = not on
        end
    end
end

local function ToggleHitbox(on)
    for _, pl in pairs(Players:GetPlayers()) do
        if pl == LocalPlayer or not pl.Character then continue end
        local r = pl.Character:FindFirstChild("HumanoidRootPart")
        if r then
            if on then
                OriginalValues["hbx_"..pl.Name] = r.Size
                r.Size = Vector3.new(10,10,10); r.Transparency = 0.7
            else
                r.Size = OriginalValues["hbx_"..pl.Name] or Vector3.new(2,2,1)
                r.Transparency = 1
            end
        end
    end
end

-- Click Teleport
Connections["ClickTP"] = UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe or not State.ClickTP then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        local root = GetRoot()
        if root and Mouse.Hit then
            root.CFrame = Mouse.Hit + Vector3.new(0,3,0)
            Notify("Teleport!", CurrentTheme.AccentLight, 1, "📍")
        end
    end
end)

-- Dash keybind
Connections["DashKey"] = UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if State.Fly == false and input.KeyCode == Enum.KeyCode.Q then DoDash() end
end)

-- ============================================================
-- ANALYSIS FUNCTIONS
-- ============================================================
local function ScanFE()
    local result = game.Workspace.FilteringEnabled
    Notify("FE: " .. (result and "ENABLED ✓" or "DISABLED ✗"),
        result and Color3.fromRGB(100,255,140) or Color3.fromRGB(255,100,100), 4, "🔍")
    return result
end

local function ScanAdmins()
    local found = {}
    for _, pl in pairs(Players:GetPlayers()) do
        if pl.UserId == game.CreatorId then
            table.insert(found, pl.Name .. " (Creator)")
        end
    end
    if #found == 0 then
        Notify("No admins detectados en servidor", CurrentTheme.AccentLight, 3, "🔑")
    else
        for _, a in ipairs(found) do
            Notify("Admin: " .. a, Color3.fromRGB(255,180,80), 4, "👑")
        end
    end
end

local function ScanRemotes()
    local remotes = {}
    local function scan(obj)
        for _, v in pairs(obj:GetChildren()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                table.insert(remotes, v.ClassName .. ": " .. v.Name)
            end
            scan(v)
        end
    end
    scan(ReplicatedStorage)
    Notify("Remotes encontrados: " .. #remotes, CurrentTheme.AccentLight, 3, "📡")
    for i = 1, math.min(#remotes, 5) do
        Notify(remotes[i], CurrentTheme.TextDim, 3 + i*0.5, "·")
    end
end

local function GetServerInfo()
    local jobId = game.JobId ~= "" and game.JobId:sub(1,12).."..." or "Studio"
    local playerCount = #Players:GetPlayers()
    local maxPlayers  = Players.MaxPlayers
    local gameName    = game.Name ~= "" and game.Name or "Unknown"
    Notify("Game: " .. gameName, CurrentTheme.AccentLight, 4, "🎮")
    Notify("Job: " .. jobId, CurrentTheme.TextDim, 4.2, "🖥")
    Notify("Players: " .. playerCount .. "/" .. maxPlayers, CurrentTheme.AccentLight, 4.4, "👥")
end

local function DetectExecutor()
    local name = "Unknown"
    pcall(function()
        if identifyexecutor then name = identifyexecutor() end
    end)
    Notify("Executor: " .. name, CurrentTheme.AccentLight, 3, "⚡")
end

local function ScanEnvironment()
    local funcs = {"getgenv","getrenv","getsenv","getupvalues","getrawmetatable",
                   "hookfunction","newcclosure","syn","KRNL_ENV","SENTINEL_ENV"}
    local found = {}
    for _, f in ipairs(funcs) do
        if getfenv()[f] ~= nil then table.insert(found, f) end
    end
    Notify("Env functions: " .. #found .. " detected", CurrentTheme.AccentLight, 3, "🔬")
end

local function DetectAntiCheat()
    local suspicious = {}
    for _, script in pairs(game:GetDescendants()) do
        if script:IsA("Script") or script:IsA("LocalScript") then
            local name = script.Name:lower()
            if name:find("anti") or name:find("cheat") or name:find("detect") or
               name:find("ban") or name:find("kick") then
                table.insert(suspicious, script.Name)
            end
        end
    end
    if #suspicious == 0 then
        Notify("No AntiCheat detectado", Color3.fromRGB(100,255,140), 3, "🛡")
    else
        Notify("AntiCheat scripts: " .. #suspicious, Color3.fromRGB(255,160,80), 4, "⚠")
        for i = 1, math.min(#suspicious, 3) do
            Notify(suspicious[i], Color3.fromRGB(255,120,80), 4+i*0.5, "⚠")
        end
    end
end

local function DetectGameGenre()
    local genres = {
        [1] = "All", [2] = "Building", [3] = "Horror",
        [4] = "Town and City", [5] = "Military", [6] = "Comedy",
        [7] = "Biography", [8] = "RPG", [9] = "SciFi",
        [10] = "Sports", [11] = "FPS", [12] = "Adventure",
    }
    local genre = game.Genre
    local genreName = genres[genre] or "Genre #" .. tostring(genre)
    Notify("Género: " .. genreName, CurrentTheme.AccentLight, 3, "🎮")
    Notify("Place ID: " .. game.PlaceId, CurrentTheme.TextDim, 3.5, "🆔")
end

-- ============================================================
-- AUTO FUNCTIONS
-- ============================================================
local function ToggleAutoRetask.spawn(on)
    if on then
        Connections["AutoRespawn"] = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())Removing:Connect(function()
            if State.AutoRespawn then
                task.delay(0.5, function()
                    LocalPlayer:LoadCharacter()
                end)
            end
        end)
        Notify("Auto Respawn ON", Color3.fromRGB(100,255,140), 2, "♻")
    else
        if Connections["AutoRespawn"] then Connections["AutoRespawn"]:Disconnect() end
        Notify("Auto Respawn OFF", CurrentTheme.TextDim, 2, "♻")
    end
end

local function ToggleAutoCollect(on)
    if on then
        Connections["AutoCollect"] = RunService.Heartbeat:Connect(function()
            if not State.AutoCollect then return end
            local root = GetRoot(); if not root then return end
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.CanTouch then
                    local dist = (root.Position - obj.Position).Magnitude
                    if dist < 15 and obj.Name:lower():find("coin") or
                       obj.Name:lower():find("cash") or
                       obj.Name:lower():find("gem") or
                       obj.Name:lower():find("pickup") then
                        root.CFrame = obj.CFrame
                    end
                end
            end
        end)
    else
        if Connections["AutoCollect"] then Connections["AutoCollect"]:Disconnect() end
    end
end

local function DoServerHop()
    Notify("Buscando servidor...", CurrentTheme.AccentLight, 2, "🔄")
    task.delay(1, function()
        local placeId = game.PlaceId
        local success, servers = pcall(function()
            return HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=10")
            )
        end)
        if success and servers and servers.data then
            for _, server in ipairs(servers.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                    return
                end
            end
        end
        Notify("No se encontró servidor disponible", Color3.fromRGB(255,160,80), 2, "⚠")
    end)
end

-- ============================================================
-- TROLL ACTIONS
-- ============================================================
local function GetSelChar()
    if not State.SelectedPlayer then
        Notify("Selecciona un jugador primero", Color3.fromRGB(255,160,80), 2, "⚠"); return nil
    end
    local pl = Players:FindFirstChild(State.SelectedPlayer)
    if not pl or not pl.Character then
        Notify("Jugador sin personaje", Color3.fromRGB(255,100,100), 2, "⚠"); return nil
    end
    return pl.Character
end

local Troll = {}
Troll.Goto = function()
    local c = GetSelChar(); if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart"); local my = GetRoot()
    if r and my then
        my.CFrame = r.CFrame + r.CFrame.LookVector * 3
        Notify("Goto: " .. State.SelectedPlayer, CurrentTheme.AccentLight, 2, "📍")
    end
end
Troll.Bring = function()
    local c = GetSelChar(); if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart"); local my = GetRoot()
    if r and my then
        r.CFrame = my.CFrame + my.CFrame.LookVector * 3
        Notify("Bring: " .. State.SelectedPlayer, CurrentTheme.AccentLight, 2, "🔗")
    end
end
Troll.Spectate = function()
    local c = GetSelChar(); if not c then return end
    State.Spectating = State.SelectedPlayer
    if Connections["Spectate"] then Connections["Spectate"]:Disconnect() end
    Connections["Spectate"] = RunService.Heartbeat:Connect(function()
        local pl = Players:FindFirstChild(State.Spectating)
        if pl and pl.Character and pl.Character:FindFirstChild("Head") then
            Camera.CFrame = pl.Character.Head.CFrame * CFrame.new(0,1.5,5)
        end
    end)
    Camera.CameraType = Enum.CameraType.Scriptable
    Notify("Spectate: " .. State.SelectedPlayer, CurrentTheme.AccentLight, 2, "👁")
end
Troll.StopSpectate = function()
    State.Spectating = nil
    if Connections["Spectate"] then Connections["Spectate"]:Disconnect() end
    Camera.CameraType = Enum.CameraType.Custom
    Notify("Spectate detenido", CurrentTheme.TextDim, 2, "👁")
end
Troll.Kill = function()
    local c = GetSelChar(); if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h then h.Health = 0; Notify("Kill: "..State.SelectedPlayer, Color3.fromRGB(255,100,100), 2, "💀") end
end
Troll.Fling = function()
    local c = GetSelChar(); if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart")
    if r then
        local v = Instance.new("BodyVelocity", r)
        v.Velocity = Vector3.new(math.random(-300,300),800,math.random(-300,300))
        v.MaxForce = Vector3.new(1e9,1e9,1e9)
        game:GetService("Debris"):AddItem(v, 0.15)
        Notify("Fling: "..State.SelectedPlayer, Color3.fromRGB(255,160,80), 2, "🌀")
    end
end
Troll.Freeze = function()
    local c = GetSelChar(); if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart")
    if r then
        r.Anchored = not r.Anchored
        Notify((r.Anchored and "Freeze: " or "Unfreeze: ")..State.SelectedPlayer, CurrentTheme.AccentLight, 2, "❄")
    end
end
Troll.Loop = function()
    if Connections["LoopTP"] then
        Connections["LoopTP"]:Disconnect(); Connections["LoopTP"] = nil
        Notify("Loop TP detenido", CurrentTheme.TextDim, 2, "🔄"); return
    end
    Connections["LoopTP"] = RunService.Heartbeat:Connect(function()
        local c = State.SelectedPlayer and Players:FindFirstChild(State.SelectedPlayer)
        if c and c.Character then
            local r = c.Character:FindFirstChild("HumanoidRootPart"); local my = GetRoot()
            if r and my then r.CFrame = my.CFrame end
        end
    end)
    Notify("Loop TP ON: "..(State.SelectedPlayer or "?"), CurrentTheme.AccentLight, 2, "🔄")
end
Troll.Orbit = function()
    local c = GetSelChar(); if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart")
    if Connections["Orbit"] then
        Connections["Orbit"]:Disconnect(); Connections["Orbit"] = nil
        Notify("Orbit detenido", CurrentTheme.TextDim, 2, "🌙"); return
    end
    local angle = 0
    Connections["Orbit"] = RunService.Heartbeat:Connect(function()
        local target = Players:FindFirstChild(State.SelectedPlayer)
        if target and target.Character then
            local tr = target.Character:FindFirstChild("HumanoidRootPart")
            local my = GetRoot()
            if tr and my then
                angle = angle + 0.05
                local offset = CFrame.new(8 * math.cos(angle), 3, 8 * math.sin(angle))
                my.CFrame = tr.CFrame * offset
            end
        end
    end)
    Notify("Orbit ON: "..(State.SelectedPlayer or "?"), CurrentTheme.AccentLight, 2, "🌙")
end
Troll.FakeAFK = function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    Notify("Fake AFK ON", Color3.fromRGB(255,160,80), 2, "💤")
    task.delay(60, function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    end)
end
Troll.SpinBot = function()
    if Connections["SpinBot"] then
        Connections["SpinBot"]:Disconnect(); Connections["SpinBot"] = nil
        Notify("SpinBot OFF", CurrentTheme.TextDim, 2, "🌀"); return
    end
    local angle = 0
    Connections["SpinBot"] = RunService.Heartbeat:Connect(function()
        local root = GetRoot(); if not root then return end
        angle = angle + 8
        root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(angle), 0)
    end)
    Notify("SpinBot ON", Color3.fromRGB(255,160,80), 2, "🌀")
end

-- KEY SYSTEM
local function ShowKeySystem(onSuccess)
    local kg = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    kg.Name = "CyaKeySystem"; kg.ResetOnSpawn = false; kg.DisplayOrder = 99999

    local overlay = Instance.new("Frame", kg)
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.BackgroundColor3 = Color3.new(0,0,0); overlay.BackgroundTransparency = 0.4
    overlay.BorderSizePixel = 0

    local box = Instance.new("Frame", kg)
    box.Size = UDim2.new(0,320,0,200); box.Position = UDim2.new(0.5,-160,0.5,-100)
    box.BackgroundColor3 = CurrentTheme.BG2; box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)
    local bs = Instance.new("UIStroke", box); bs.Color = CurrentTheme.Accent; bs.Thickness = 1.5

    local title = Instance.new("TextLabel", box)
    title.Size = UDim2.new(1,0,0,40); title.BackgroundTransparency = 1
    title.Text = "🔑  KEY SYSTEM"; title.Font = Enum.Font.GothamBold; title.TextSize = 14
    title.TextColor3 = CurrentTheme.AccentLight

    local sub = Instance.new("TextLabel", box)
    sub.Size = UDim2.new(1,-20,0,20); sub.Position = UDim2.new(0,10,0,38)
    sub.BackgroundTransparency = 1; sub.Text = "Ingresa tu clave para continuar"
    sub.Font = Enum.Font.Gotham; sub.TextSize = 11; sub.TextColor3 = CurrentTheme.Text

    local inputFrame = Instance.new("Frame", box)
    inputFrame.Size = UDim2.new(1,-20,0,34); inputFrame.Position = UDim2.new(0,10,0,66)
    inputFrame.BackgroundColor3 = CurrentTheme.BG3; inputFrame.BorderSizePixel = 0
    Instance.new("UICorner", inputFrame).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke", inputFrame).Color = CurrentTheme.Border

    local input = Instance.new("TextBox", inputFrame)
    input.Size = UDim2.new(1,-12,1,0); input.Position = UDim2.new(0,8,0,0)
    input.BackgroundTransparency = 1; input.PlaceholderText = "CYAHUB-XXXXX"
    input.PlaceholderColor3 = CurrentTheme.TextDim; input.TextColor3 = CurrentTheme.AccentLight
    input.Font = Enum.Font.GothamBold; input.TextSize = 13; input.ClearTextOnFocus = false

    local statusLbl = Instance.new("TextLabel", box)
    statusLbl.Size = UDim2.new(1,-20,0,18); statusLbl.Position = UDim2.new(0,10,0,106)
    statusLbl.BackgroundTransparency = 1; statusLbl.Font = Enum.Font.Gotham; statusLbl.TextSize = 11
    statusLbl.TextColor3 = CurrentTheme.TextDim; statusLbl.Text = "Clave de ejemplo: CYA-2024"

    local confirmBtn = Instance.new("TextButton", box)
    confirmBtn.Size = UDim2.new(1,-20,0,36); confirmBtn.Position = UDim2.new(0,10,0,134)
    confirmBtn.BackgroundColor3 = CurrentTheme.Accent; confirmBtn.Text = "Confirmar"
    confirmBtn.Font = Enum.Font.GothamBold; confirmBtn.TextSize = 13
    confirmBtn.TextColor3 = Color3.new(1,1,1); confirmBtn.BorderSizePixel = 0
    Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0,6)

    confirmBtn.MouseButton1Click:Connect(function()
        local key = input.Text:upper():gsub("%s","")
        local valid = false
        for _, v in ipairs(State.ValidKeys) do
            if v:upper() == key then valid = true; break end
        end
        if valid then
            State.KeyUnlocked = true
            statusLbl.TextColor3 = Color3.fromRGB(100,255,140)
            statusLbl.Text = "✓ Clave válida. Cargando..."
            task.delay(0.8, function() kg:Destroy(); onSuccess() end)
        else
            statusLbl.TextColor3 = Color3.fromRGB(255,100,100)
            statusLbl.Text = "✗ Clave incorrecta"
            TweenService:Create(box, TweenInfo.new(0.05), {Position = UDim2.new(0.5,-155,0.5,-100)}):Play()
            task.delay(0.05, function()
                TweenService:Create(box, TweenInfo.new(0.05), {Position = UDim2.new(0.5,-165,0.5,-100)}):Play()
                task.delay(0.05, function()
                    TweenService:Create(box, TweenInfo.new(0.05), {Position = UDim2.new(0.5,-160,0.5,-100)}):Play()
                end)
            end)
        end
    end)
end

-- ============================================================
-- CONSTRUCCIÓN DEL GUI
-- ============================================================
if LocalPlayer.PlayerGui:FindFirstChild("CyaHub") then
    LocalPlayer.PlayerGui:FindFirstChild("CyaHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyaHub"; ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.DisplayOrder = 999

pcall(function()
    if syn and syn.protect_gui then syn.protect_gui(ScreenGui)
    elseif gethui then ScreenGui.Parent = gethui() end
end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer.PlayerGui end

-- ============================================================
-- INTRO ANIMATION
-- ============================================================
local IntroGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
IntroGui.Name = "CyaIntro"; IntroGui.ResetOnSpawn = false; IntroGui.DisplayOrder = 99999

local introFrame = Instance.new("Frame", IntroGui)
introFrame.Size = UDim2.new(1,0,1,0); introFrame.BackgroundColor3 = Color3.new(0,0,0)
introFrame.BackgroundTransparency = 0; introFrame.BorderSizePixel = 0

local introLabel = Instance.new("TextLabel", introFrame)
introLabel.Size = UDim2.new(1,0,0,60); introLabel.Position = UDim2.new(0,0,0.5,-30)
introLabel.BackgroundTransparency = 1; introLabel.Text = "✦  CyaHub  v3.0"
introLabel.Font = Enum.Font.GothamBold; introLabel.TextSize = 32
introLabel.TextColor3 = Color3.fromRGB(167,139,250); introLabel.TextTransparency = 1

local introSub = Instance.new("TextLabel", introFrame)
introSub.Size = UDim2.new(1,0,0,30); introSub.Position = UDim2.new(0,0,0.5,30)
introSub.BackgroundTransparency = 1; introSub.Text = "by @Cyaofc"
introSub.Font = Enum.Font.Gotham; introSub.TextSize = 14
introSub.TextColor3 = Color3.fromRGB(100,100,140); introSub.TextTransparency = 1

TweenService:Create(introLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
TweenService:Create(introSub,  TweenInfo.new(0.8, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
task.delay(1.8, function()
    TweenService:Create(introFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(introLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(introSub,  TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.delay(0.6, function() IntroGui:Destroy() end)
end)

-- ============================================================
-- VENTANA PRINCIPAL
-- ============================================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0,420,0,480)
MainFrame.Position = UDim2.new(0.5,-210,0.5,-240)
MainFrame.BackgroundColor3 = CurrentTheme.BG; MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = CurrentTheme.Border; MainStroke.Thickness = 1

-- TITULO
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1,0,0,40); TitleBar.BackgroundColor3 = CurrentTheme.BG2
TitleBar.BorderSizePixel = 0

local TitleAccent = Instance.new("Frame", TitleBar)
TitleAccent.Size = UDim2.new(1,0,0,1); TitleAccent.Position = UDim2.new(0,0,1,-1)
TitleAccent.BackgroundColor3 = CurrentTheme.Accent; TitleAccent.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1,-90,1,0); TitleLabel.Position = UDim2.new(0,14,0,0)
TitleLabel.BackgroundTransparency = 1; TitleLabel.TextColor3 = CurrentTheme.AccentLight
TitleLabel.Text = "✦  CyaHub  v3.0"; TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13; TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Version badge
local verBadge = Instance.new("TextLabel", TitleBar)
verBadge.Size = UDim2.new(0,50,0,18); verBadge.Position = UDim2.new(0,160,0.5,-9)
verBadge.BackgroundColor3 = CurrentTheme.AccentDark; verBadge.BorderSizePixel = 0
verBadge.Text = "v3.0"; verBadge.Font = Enum.Font.GothamBold; verBadge.TextSize = 9
verBadge.TextColor3 = CurrentTheme.AccentLight
Instance.new("UICorner", verBadge).CornerRadius = UDim.new(1,0)

local function MakeDot(color, xOffset)
    local d = Instance.new("TextButton", TitleBar)
    d.Size = UDim2.new(0,10,0,10); d.Position = UDim2.new(1,xOffset,0.5,-5)
    d.BackgroundColor3 = color; d.Text = ""; d.BorderSizePixel = 0
    Instance.new("UICorner", d).CornerRadius = UDim.new(1,0)
    return d
end
local MinBtn   = MakeDot(Color3.fromRGB(254,188,46), -72)
local CloseBtn = MakeDot(Color3.fromRGB(255,95,87), -34)

-- Drag
local Dragging, DragStart, StartPos = false, nil, nil
TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true; DragStart = i.Position; StartPos = MainFrame.Position
    end
end)
TitleBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
end)
UserInputService.InputChanged:Connect(function(i)
    if Dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale, StartPos.X.Offset + d.X,
            StartPos.Y.Scale, StartPos.Y.Offset + d.Y)
    end
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(MainFrame, TweenInfo.new(0.25), {
        Size = minimized and UDim2.new(0,420,0,40) or UDim2.new(0,420,0,480)
    }):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {
        Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0)
    }):Play()
    task.delay(0.25, function() ScreenGui:Destroy() end)
end)

-- SEARCH BAR
local SearchBar = Instance.new("Frame", MainFrame)
SearchBar.Size = UDim2.new(1,-16,0,28); SearchBar.Position = UDim2.new(0,8,0,46)
SearchBar.BackgroundColor3 = CurrentTheme.BG3; SearchBar.BorderSizePixel = 0
Instance.new("UICorner", SearchBar).CornerRadius = UDim.new(0,6)
local SearchStroke = Instance.new("UIStroke", SearchBar)
SearchStroke.Color = CurrentTheme.Border; SearchStroke.Thickness = 0.5

local SearchIcon = Instance.new("TextLabel", SearchBar)
SearchIcon.Size = UDim2.new(0,26,1,0); SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"; SearchIcon.TextSize = 12
SearchIcon.Font = Enum.Font.Gotham; SearchIcon.TextColor3 = CurrentTheme.TextDim

local SearchInput = Instance.new("TextBox", SearchBar)
SearchInput.Size = UDim2.new(1,-30,1,0); SearchInput.Position = UDim2.new(0,26,0,0)
SearchInput.BackgroundTransparency = 1; SearchInput.PlaceholderText = "Buscar función..."
SearchInput.PlaceholderColor3 = CurrentTheme.TextDim; SearchInput.TextColor3 = CurrentTheme.Text
SearchInput.Font = Enum.Font.Gotham; SearchInput.TextSize = 12; SearchInput.ClearTextOnFocus = false

-- ============================================================
-- 8 TABS
-- ============================================================
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1,0,0,32); TabBar.Position = UDim2.new(0,0,0,80)
TabBar.BackgroundColor3 = CurrentTheme.BG; TabBar.BorderSizePixel = 0

-- Scrollable tab bar
local TabScroll = Instance.new("ScrollingFrame", TabBar)
TabScroll.Size = UDim2.new(1,0,1,0); TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0; TabScroll.ScrollBarThickness = 0
TabScroll.ScrollingDirection = Enum.ScrollingDirection.X
TabScroll.CanvasSize = UDim2.new(0,680,0,0)

local TabNames = {"🔍 Analysis","👁 Visual","🌍 World","🏃 Movement","⚙ Auto","😈 Troll","🔧 Utility","⚡ Config"}
local Tabs, Panels = {}, {}
local ActiveTab = 1

local TabDiv = Instance.new("Frame", MainFrame)
TabDiv.Size = UDim2.new(1,0,0,1); TabDiv.Position = UDim2.new(0,0,0,112)
TabDiv.BackgroundColor3 = CurrentTheme.Border; TabDiv.BorderSizePixel = 0

local PanelHolder = Instance.new("Frame", MainFrame)
PanelHolder.Size = UDim2.new(1,0,1,-114); PanelHolder.Position = UDim2.new(0,0,0,114)
PanelHolder.BackgroundTransparency = 1; PanelHolder.ClipsDescendants = true

for i = 1, #TabNames do
    local scroll = Instance.new("ScrollingFrame", PanelHolder)
    scroll.Size = UDim2.new(1,0,1,0); scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = CurrentTheme.Accent; scroll.Visible = false
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local pad = Instance.new("UIPadding", scroll)
    pad.PaddingLeft = UDim.new(0,8); pad.PaddingRight = UDim.new(0,8)
    pad.PaddingTop  = UDim.new(0,10); pad.PaddingBottom = UDim.new(0,10)
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,5); layout.SortOrder = Enum.SortOrder.LayoutOrder
    Panels[i] = scroll
end

for i, name in ipairs(TabNames) do
    local btn = Instance.new("TextButton", TabScroll)
    btn.Size = UDim2.new(0,82,1,0)
    btn.Position = UDim2.new(0,(i-1)*83,0,0)
    btn.BackgroundTransparency = 1
    btn.Text = name; btn.Font = Enum.Font.Gotham; btn.TextSize = 10
    btn.TextColor3 = CurrentTheme.TextDim; btn.BorderSizePixel = 0
    Tabs[i] = btn
end

local function SetTab(idx)
    ActiveTab = idx
    for i, t in ipairs(Tabs) do
        local on = i == idx
        t.TextColor3 = on and CurrentTheme.AccentLight or CurrentTheme.TextDim
        Panels[i].Visible = on
    end
    -- Animate panel slide
    local panel = Panels[idx]
    panel.Position = UDim2.new(0.05,0,0,0)
    TweenService:Create(panel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0,0,0,0)
    }):Play()
end
for i, t in ipairs(Tabs) do t.MouseButton1Click:Connect(function() SetTab(i) end) end

-- ============================================================
-- WIDGET HELPERS
-- ============================================================
local AllToggleButtons = {}

local function SectionLabel(parent, text, order)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1,0,0,18); lbl.BackgroundTransparency = 1
    lbl.TextColor3 = CurrentTheme.TextDim; lbl.Text = text:upper()
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.LayoutOrder = order or 0
    return lbl
end

local function ToggleButton(parent, icon, label, order, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,0,0,34); frame.BackgroundColor3 = CurrentTheme.BG3
    frame.BorderSizePixel = 0; frame.LayoutOrder = order or 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
    local fs = Instance.new("UIStroke", frame); fs.Color = CurrentTheme.Border; fs.Thickness = 0.5

    local iconLbl = Instance.new("TextLabel", frame)
    iconLbl.Size = UDim2.new(0,28,1,0); iconLbl.Position = UDim2.new(0,4,0,0)
    iconLbl.BackgroundTransparency = 1; iconLbl.Text = icon
    iconLbl.Font = Enum.Font.Gotham; iconLbl.TextSize = 14; iconLbl.TextColor3 = CurrentTheme.Accent

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1,-60,1,0); lbl.Position = UDim2.new(0,32,0,0)
    lbl.BackgroundTransparency = 1; lbl.Text = label
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12; lbl.TextColor3 = CurrentTheme.Text
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local dot = Instance.new("Frame", frame)
    dot.Size = UDim2.new(0,26,0,14); dot.Position = UDim2.new(1,-36,0.5,-7)
    dot.BackgroundColor3 = CurrentTheme.Border; dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    local thumb = Instance.new("Frame", dot)
    thumb.Size = UDim2.new(0,10,0,10); thumb.Position = UDim2.new(0,2,0.5,-5)
    thumb.BackgroundColor3 = CurrentTheme.TextDim; thumb.BorderSizePixel = 0
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1,0)

    local active = false
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(dot,   TweenInfo.new(0.15), {BackgroundColor3 = active and CurrentTheme.Accent or CurrentTheme.Border}):Play()
        TweenService:Create(thumb, TweenInfo.new(0.15), {Position = active and UDim2.new(1,-12,0.5,-5) or UDim2.new(0,2,0.5,-5), BackgroundColor3 = active and Color3.new(1,1,1) or CurrentTheme.TextDim}):Play()
        TweenService:Create(fs,    TweenInfo.new(0.15), {Color = active and CurrentTheme.Accent or CurrentTheme.Border}):Play()
        callback(active)
    end)
    table.insert(AllToggleButtons, {frame = frame, label = label, icon = icon})
    return frame, function() return active end
end

local function ActionButton(parent, icon, label, order, callback, danger)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,0,0,32); btn.BackgroundColor3 = CurrentTheme.BG3
    btn.Text = icon .. "  " .. label; btn.Font = Enum.Font.Gotham; btn.TextSize = 12
    btn.TextColor3 = danger and Color3.fromRGB(220,100,100) or CurrentTheme.Text
    btn.BorderSizePixel = 0; btn.LayoutOrder = order or 0
    btn.TextXAlignment = Enum.TextXAlignment.Left
    local pad = Instance.new("UIPadding", btn); pad.PaddingLeft = UDim.new(0,10)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    local s = Instance.new("UIStroke", btn)
    s.Color = danger and Color3.fromRGB(80,20,20) or CurrentTheme.Border; s.Thickness = 0.5
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = danger and Color3.fromRGB(28,10,10) or CurrentTheme.BG2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = CurrentTheme.BG3}):Play()
    end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function SliderRow(parent, label, minV, maxV, defV, order, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,0,0,46); frame.BackgroundTransparency = 1; frame.LayoutOrder = order or 0

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7,0,0,18); lbl.BackgroundTransparency = 1
    lbl.TextColor3 = CurrentTheme.Text; lbl.Text = label
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left

    local vLbl = Instance.new("TextLabel", frame)
    vLbl.Size = UDim2.new(0.3,0,0,18); vLbl.Position = UDim2.new(0.7,0,0,0)
    vLbl.BackgroundTransparency = 1; vLbl.Text = tostring(defV)
    vLbl.Font = Enum.Font.GothamBold; vLbl.TextSize = 11
    vLbl.TextColor3 = CurrentTheme.AccentLight; vLbl.TextXAlignment = Enum.TextXAlignment.Right

    local bg = Instance.new("Frame", frame)
    bg.Size = UDim2.new(1,0,0,6); bg.Position = UDim2.new(0,0,0,26)
    bg.BackgroundColor3 = CurrentTheme.BG2; bg.BorderSizePixel = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)

    local fill = Instance.new("Frame", bg)
    fill.Size = UDim2.new((defV-minV)/(maxV-minV),0,1,0)
    fill.BackgroundColor3 = CurrentTheme.Accent; fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

    local dragging = false
    bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
    bg.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((i.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            local val = math.floor(minV + rel*(maxV-minV))
            fill.Size = UDim2.new(rel,0,1,0); vLbl.Text = tostring(val)
            callback(val)
        end
    end)
    return frame
end

local function InfoRow(parent, label, value, order)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1,0,0,28); frame.BackgroundColor3 = CurrentTheme.BG3
    frame.BorderSizePixel = 0; frame.LayoutOrder = order or 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke", frame).Color = CurrentTheme.Border

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.55,0,1,0); lbl.Position = UDim2.new(0,8,0,0)
    lbl.BackgroundTransparency = 1; lbl.Text = label
    lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11; lbl.TextColor3 = CurrentTheme.TextDim
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local val = Instance.new("TextLabel", frame)
    val.Size = UDim2.new(0.45,-8,1,0); val.Position = UDim2.new(0.55,0,0,0)
    val.BackgroundTransparency = 1; val.Text = value
    val.Font = Enum.Font.GothamBold; val.TextSize = 11; val.TextColor3 = CurrentTheme.AccentLight
    val.TextXAlignment = Enum.TextXAlignment.Right
    local pad2 = Instance.new("UIPadding", val); pad2.PaddingRight = UDim.new(0,8)
    return frame, val
end

-- Search
SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
    local q = SearchInput.Text:lower()
    for _, data in ipairs(AllToggleButtons) do
        data.frame.Visible = q == "" or (data.label:lower():find(q, 1, true) ~= nil)
    end
end)

-- ============================================================
-- TAB 1 — ANALYSIS
-- ============================================================
local P1 = Panels[1]
SectionLabel(P1,"— Scanner",1)
ActionButton(P1,"🛡","AntiCheat Detector",2,DetectAntiCheat)
ActionButton(P1,"📡","FE Enabled Scanner",3,ScanFE)
ActionButton(P1,"👑","Admin Detector",4,ScanAdmins)
ActionButton(P1,"📻","Remote Event Analyzer",5,ScanRemotes)
ActionButton(P1,"🔬","Script Environment Scanner",6,ScanEnvironment)
ActionButton(P1,"🎮","Game Genre Detection",7,DetectGameGenre)
ActionButton(P1,"⚡","Executor Compatibility",8,DetectExecutor)

SectionLabel(P1,"— Server",9)
ActionButton(P1,"🖥","Server Info Panel",10,GetServerInfo)

local _, serverInfoRow = InfoRow(P1,"Job ID", game.JobId ~= "" and game.JobId:sub(1,10).."..." or "Studio", 11)
local _, playerRow     = InfoRow(P1,"Players", tostring(#Players:GetPlayers()).."/"..tostring(Players.MaxPlayers), 12)
local _, placeRow      = InfoRow(P1,"Place ID", tostring(game.PlaceId), 13)
local _, pingRow       = InfoRow(P1,"Ping", "—", 14)

-- Live ping update
Connections["PingUpdate"] = RunService.Heartbeat:Connect(function()
    pcall(function()
        pingRow.Text = tostring(math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())) .. " ms"
        playerRow.Text = tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers)
    end)
end)

SectionLabel(P1,"— Player Activity",15)
local playerListFrame = Instance.new("Frame", P1)
playerListFrame.Size = UDim2.new(1,0,0,10); playerListFrame.BackgroundTransparency = 1
playerListFrame.LayoutOrder = 16; playerListFrame.AutomaticSize = Enum.AutomaticSize.Y
local playerLayout = Instance.new("UIListLayout", playerListFrame); playerLayout.Padding = UDim.new(0,3)

local function RefreshPlayerList()
    for _, c in pairs(playerListFrame:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end
    for _, pl in pairs(Players:GetPlayers()) do
        local row = Instance.new("Frame", playerListFrame)
        row.Size = UDim2.new(1,0,0,26); row.BackgroundColor3 = CurrentTheme.BG3
        row.BorderSizePixel = 0
        Instance.new("UICorner", row).CornerRadius = UDim.new(0,5)
        local nameLbl = Instance.new("TextLabel", row)
        nameLbl.Size = UDim2.new(0.7,0,1,0); nameLbl.Position = UDim2.new(0,8,0,0)
        nameLbl.BackgroundTransparency = 1; nameLbl.Text = (pl == LocalPlayer and "★ " or "· ") .. pl.Name
        nameLbl.Font = Enum.Font.Gotham; nameLbl.TextSize = 11
        nameLbl.TextColor3 = pl == LocalPlayer and CurrentTheme.AccentLight or CurrentTheme.Text
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        local selectBtn = Instance.new("TextButton", row)
        selectBtn.Size = UDim2.new(0.3,-4,1,-4); selectBtn.Position = UDim2.new(0.7,0,0,2)
        selectBtn.BackgroundColor3 = CurrentTheme.AccentDark; selectBtn.BorderSizePixel = 0
        selectBtn.Text = "Select"; selectBtn.Font = Enum.Font.Gotham; selectBtn.TextSize = 10
        selectBtn.TextColor3 = CurrentTheme.AccentLight
        Instance.new("UICorner", selectBtn).CornerRadius = UDim.new(0,4)
        selectBtn.MouseButton1Click:Connect(function()
            State.SelectedPlayer = pl.Name
            Notify("Seleccionado: " .. pl.Name, CurrentTheme.AccentLight, 2, "🎯")
        end)
    end
end
RefreshPlayerList()
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(function() task.delay(0.1, RefreshPlayerList) end)
ActionButton(P1,"🔄","Refrescar lista",17, RefreshPlayerList)

-- ============================================================
-- TAB 2 — VISUAL
-- ============================================================
local P2 = Panels[2]
SectionLabel(P2,"— ESP",1)
ToggleButton(P2,"👁","Player ESP",2,function(v)
    State.ESP = v
    if v then CreateESP() else ClearESP() end
    Notify(v and "ESP ON" or "ESP OFF")
end)
ToggleButton(P2,"🦴","Skeleton ESP",3,function(v)
    State.SkeletonESP = v
    if v then CreateSkeleton() else ClearSkeleton() end
    Notify(v and "Skeleton ON" or "Skeleton OFF")
end)
ToggleButton(P2,"📦","Chams V2",4,function(v)
    State.Chams = v
    if v then CreateChams() else ClearChams() end
    Notify(v and "Chams ON" or "Chams OFF")
end)
ToggleButton(P2,"🌟","Highlight ESP",5,function(v)
    State.HighlightESP = v
    if v then CreateHighlight() else ClearHighlight() end
    Notify(v and "Highlight ON" or "Highlight OFF")
end)
ToggleButton(P2,"📏","Distance ESP",6,function(v)
    State.DistanceESP = v
    Notify(v and "Distance ESP ON" or "Distance ESP OFF")
end)
ToggleButton(P2,"➡","Tracers",7,function(v)
    State.Tracers = v
    if v then CreateTracers() else ClearTracers() end
    Notify(v and "Tracers ON" or "Tracers OFF")
end)
ToggleButton(P2,"🤖","NPC ESP",8,function(v)
    State.NPCesp = v
    if v then CreateNPCEsp() else
        for _, o in pairs(workspace:GetDescendants()) do
            if o:IsA("BillboardGui") and o.Name == "CyaNPCEsp" then o:Destroy() end
        end
    end
    Notify(v and "NPC ESP ON" or "NPC ESP OFF")
end)
ToggleButton(P2,"✛","Crosshair",9,function(v)
    State.Crosshair = v; ToggleCrosshair(v)
    Notify(v and "Crosshair ON" or "Crosshair OFF")
end)

SectionLabel(P2,"— FOV",10)
ToggleButton(P2,"⭕","FOV Circle",11,function(v)
    State.FOVCircle = v
    if v then CreateFOV() else ClearFOV() end
    Notify(v and "FOV ON" or "FOV OFF")
end)
ToggleButton(P2,"🌈","Rainbow FOV",12,function(v)
    State.RainbowFOV = v
    Notify(v and "Rainbow FOV ON" or "Rainbow FOV OFF")
end)
ToggleButton(P2,"💫","Dynamic FOV",13,function(v)
    State.DynamicFOV = v
    Notify(v and "Dynamic FOV ON" or "Dynamic FOV OFF")
end)
SliderRow(P2,"FOV Radius",50,300,100,14,function(v)
    State.FOVRadius = v
    if FOVGui then
        local circle = FOVGui:FindFirstChild("FOVCircle")
        if circle then
            circle.Size = UDim2.new(0,v*2,0,v*2)
            circle.Position = UDim2.new(0.5,-v,0.5,-v)
        end
    end
end)

SectionLabel(P2,"— Vision",15)
ToggleButton(P2,"🌙","Night Vision",16,function(v)
    State.NightVision = v; ToggleNightVision(v)
    Notify(v and "Night Vision ON" or "Night Vision OFF")
end)
ToggleButton(P2,"🔥","Thermal Vision",17,function(v)
    State.ThermalVision = v; ToggleThermal(v)
    Notify(v and "Thermal ON" or "Thermal OFF")
end)

-- ============================================================
-- TAB 3 — WORLD
-- ============================================================
local P3 = Panels[3]
SectionLabel(P3,"— Iluminación",1)
ToggleButton(P3,"☀","FullBright+",2,function(v)
    State.Fullbright = v; ToggleFullbright(v)
    Notify(v and "Fullbright ON" or "Fullbright OFF")
end)
ToggleButton(P3,"🌫","Quitar Niebla",3,function(v)
    State.NoFog = v; ToggleNoFog(v)
    Notify(v and "NoFog ON" or "NoFog OFF")
end)
ToggleButton(P3,"🌸","Bloom Effects",4,function(v)
    ToggleBloom(v); Notify(v and "Bloom ON" or "Bloom OFF")
end)
ToggleButton(P3,"🎨","Color Correction",5,function(v)
    ToggleColorCorrection(v); Notify(v and "Color Correction ON" or "Color Correction OFF")
end)
ToggleButton(P3,"📽","Retro Shader",6,function(v)
    ToggleRetroShader(v); Notify(v and "Retro Shader ON" or "Retro Shader OFF")
end)
ToggleButton(P3,"💨","Motion Blur",7,function(v)
    ToggleMotionBlur(v); Notify(v and "Motion Blur ON" or "Motion Blur OFF")
end)

SectionLabel(P3,"— Tiempo y Clima",8)
SliderRow(P3,"Hora del día",0,24,14,9,function(v)
    State.TimeValue = v; SetTime(v)
end)
ActionButton(P3,"🌅","Amanecer (6:00)",10,function() SetTime(6); Notify("Amanecer ☀", Color3.fromRGB(255,200,100), 2) end)
ActionButton(P3,"☀","Mediodía (12:00)",11,function() SetTime(12); Notify("Mediodía ☀", Color3.fromRGB(255,220,80), 2) end)
ActionButton(P3,"🌆","Atardecer (18:00)",12,function() SetTime(18); Notify("Atardecer 🌆", Color3.fromRGB(255,140,60), 2) end)
ActionButton(P3,"🌙","Noche (0:00)",13,function() SetTime(0); Notify("Noche 🌙", Color3.fromRGB(100,100,200), 2) end)

SectionLabel(P3,"— Cámara",14)
ToggleButton(P3,"📷","Freecam",15,function(v)
    if v then
        Camera.CameraType = Enum.CameraType.Scriptable
        Connections["Freecam"] = RunService.Heartbeat:Connect(function()
            if not State.Fly and Camera.CameraType == Enum.CameraType.Scriptable then
                local d = Vector3.zero; local spd = 0.5
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then d = d + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then d = d - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then d = d - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then d = d + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.E) then d = d + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then d = d - Vector3.new(0,1,0) end
                if d.Magnitude > 0 then
                    Camera.CFrame = Camera.CFrame + d.Unit * spd
                end
            end
        end)
        Notify("Freecam ON — WASD+QE para mover", CurrentTheme.AccentLight, 3, "📷")
    else
        Camera.CameraType = Enum.CameraType.Custom
        if Connections["Freecam"] then Connections["Freecam"]:Disconnect() end
        Notify("Freecam OFF")
    end
end)

SliderRow(P3,"Zoom cámara",20,120,70,16,function(v)
    Camera.FieldOfView = v
end)

ActionButton(P3,"🎬","Reset Cámara",17,function()
    Camera.CameraType = Enum.CameraType.Custom
    Camera.FieldOfView = 70
    Notify("Cámara reseteada", CurrentTheme.AccentLight, 2, "🎬")
end)

SectionLabel(P3,"— Mundo",18)
SliderRow(P3,"Fog Density",0,100,30,19,function(v)
    local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmo then atmo.Density = v/100 end
end)
SliderRow(P3,"Skybox Brightness",0,10,1,20,function(v)
    Lighting.Brightness = v/2
end)
ActionButton(P3,"🗺","World Color Reset",21,function()
    ToggleFullbright(false); ToggleNoFog(false)
    for _, e in pairs(Lighting:GetChildren()) do
        if e:IsA("ColorCorrectionEffect") or e:IsA("BlurEffect") or e:IsA("BloomEffect") then
            e:Destroy()
        end
    end
    Notify("World reseteado ✓", Color3.fromRGB(100,255,140), 2, "🗺")
end)

-- ============================================================
-- TAB 4 — MOVEMENT
-- ============================================================
local P4 = Panels[4]
SectionLabel(P4,"— Vuelo",1)
ToggleButton(P4,"✈","Fly System V2",2,function(v)
    State.Fly = v
    if v then StartFly() else StopFly() end
    Notify(v and "Fly ON  (Shift = boost)" or "Fly OFF", CurrentTheme.AccentLight, 2, "✈")
end)
SliderRow(P4,"Fly Speed",10,300,60,3,function(v)
    State.FlySpeed = v
end)

SectionLabel(P4,"— Movimiento",4)
ToggleButton(P4,"👻","Smart NoClip",5,function(v)
    State.NoClip = v
    if v then StartNoClip() else StopNoClip() end
    Notify(v and "NoClip ON" or "NoClip OFF")
end)
ToggleButton(P4,"⬆","Infinite Jump",6,function(v)
    State.InfJump = v; Notify(v and "InfJump ON" or "InfJump OFF")
end)
ToggleButton(P4,"🐰","Bunny Hop",7,function(v)
    State.BunnyHop = v; Notify(v and "BunnyHop ON  (Space)" or "BunnyHop OFF")
end)
ToggleButton(P4,"💨","Dash System  (Q)",8,function(v)
    Notify(v and "Dash ON  (Q para dashear)" or "Dash OFF")
end)
ToggleButton(P4,"🧗","Fast Climb",9,function(v)
    State.FastClimb = v; Notify(v and "Fast Climb ON" or "Fast Climb OFF")
end)
ToggleButton(P4,"🛡","God Mode",10,function(v)
    State.Godmode = v; ToggleGodmode(v)
    Notify(v and "God Mode ON" or "God Mode OFF", v and Color3.fromRGB(100,255,140) or nil)
end)
ToggleButton(P4,"👤","Invisible",11,function(v)
    State.Invisible = v; ToggleInvisible(v)
    Notify(v and "Invisible ON" or "Invisible OFF")
end)
ToggleButton(P4,"📦","Hitbox Expander",12,function(v)
    State.HitboxExpand = v; ToggleHitbox(v)
    Notify(v and "Hitbox ON" or "Hitbox OFF", v and Color3.fromRGB(255,160,80) or nil)
end)
ToggleButton(P4,"🖱","Click Teleport  (Clic Der)",13,function(v)
    State.ClickTP = v; Notify(v and "Click TP ON  (clic derecho)" or "Click TP OFF")
end)

SectionLabel(P4,"— Física",14)
SliderRow(P4,"Walk Speed",16,250,16,15,function(v)
    State.WalkSpeed = v; SetSpeed(v)
end)
SliderRow(P4,"Gravity",50,500,196,16,function(v)
    State.GravityValue = v; SetGravity(v)
end)
ActionButton(P4,"🌍","Reset Gravity",17,function()
    SetGravity(196.2); Notify("Gravity reset", CurrentTheme.AccentLight, 2)
end)
ActionButton(P4,"🏃","Reset Speed",18,function()
    SetSpeed(16); Notify("Speed reset", CurrentTheme.AccentLight, 2)
end)

SectionLabel(P4,"— Teleport",19)
ActionButton(P4,"📍","Click Teleport toggle",20,function()
    State.ClickTP = not State.ClickTP
    Notify(State.ClickTP and "Click TP ON" or "Click TP OFF", CurrentTheme.AccentLight, 2, "📍")
end)
ActionButton(P4,"🏠","Ir a Spawn",21,function()
    local spawn = workspace:FindFirstChild("SpawnLocation")
    if spawn then
        local root = GetRoot()
        if root then root.CFrame = spawn.CFrame + Vector3.new(0,5,0) end
        Notify("Teleport a spawn", CurrentTheme.AccentLight, 2, "🏠")
    end
end)

-- ============================================================
-- TAB 5 — AUTO
-- ============================================================
local P5 = Panels[5]
SectionLabel(P5,"— Automático",1)
ToggleButton(P5,"🌾","Auto Farm AI",2,function(v)
    State.AutoFarm = v
    if v then
        Connections["AutoFarm"] = RunService.Heartbeat:Connect(function()
            if not State.AutoFarm then return end
            local root = GetRoot(); if not root then return end
            -- Generic auto farm: moves to nearest interactable NPC/object
            local nearest, nearestDist = nil, math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
                    local isPlayer = false
                    for _, pl in pairs(Players:GetPlayers()) do
                        if pl.Character == obj then isPlayer = true; break end
                    end
                    if not isPlayer then
                        local r = obj:FindFirstChild("HumanoidRootPart")
                        if r then
                            local dist = (root.Position - r.Position).Magnitude
                            if dist < nearestDist then
                                nearestDist = dist; nearest = r
                            end
                        end
                    end
                end
            end
            if nearest and nearestDist > 5 then
                local hum = GetHum()
                if hum then hum:MoveTo(nearest.Position) end
            end
        end)
        Notify("Auto Farm ON", Color3.fromRGB(100,255,140), 2, "🌾")
    else
        if Connections["AutoFarm"] then Connections["AutoFarm"]:Disconnect() end
        Notify("Auto Farm OFF", CurrentTheme.TextDim, 2, "🌾")
    end
end)
ToggleButton(P5,"💰","Smart Auto Loot",3,function(v)
    State.AutoLoot = v; ToggleAutoCollect(v)
    Notify(v and "Auto Loot ON" or "Auto Loot OFF")
end)
ToggleButton(P5,"🔄","Auto Collect",4,function(v)
    State.AutoCollect = v
    if v then ToggleAutoCollect(true) end
    Notify(v and "Auto Collect ON" or "Auto Collect OFF")
end)
ToggleButton(P5,"♻","Auto Respawn",5,function(v)
    State.AutoRespawn = v; ToggleAutoRetask.spawn(v)
end)

SectionLabel(P5,"— Servidor",6)
ActionButton(P5,"🔀","Auto Server Hop",7,DoServerHop)
ActionButton(P5,"🔄","Rejoin",8,function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

SectionLabel(P5,"— Utilidad Auto",9)
ToggleButton(P5,"🤖","Auto Interact",10,function(v)
    if v then
        Connections["AutoInteract"] = RunService.Heartbeat:Connect(function()
            if not v then return end
            local root = GetRoot(); if not root then return end
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    local part = obj.Parent
                    if part and part:IsA("BasePart") then
                        local dist = (root.Position - part.Position).Magnitude
                        if dist <= obj.MaxActivationDistance then
                            pcall(function() obj:InputHoldBegin() end)
                        end
                    end
                end
            end
        end)
        Notify("Auto Interact ON", Color3.fromRGB(100,255,140), 2, "🤖")
    else
        if Connections["AutoInteract"] then Connections["AutoInteract"]:Disconnect() end
        Notify("Auto Interact OFF")
    end
end)

ActionButton(P5,"🛒","Shop Teleport",11,function()
    local shopNames = {"Shop","Store","Market","Tienda","Buy"}
    local root = GetRoot(); if not root then return end
    for _, name in ipairs(shopNames) do
        local shop = workspace:FindFirstChild(name, true)
        if shop and shop:IsA("BasePart") then
            root.CFrame = shop.CFrame + Vector3.new(0,5,0)
            Notify("Teleport a " .. name, CurrentTheme.AccentLight, 2, "🛒")
            return
        end
    end
    Notify("No se encontró tienda en el mapa", Color3.fromRGB(255,160,80), 2, "⚠")
end)

ActionButton(P5,"🗺","Secret Area Finder",12,function()
    local count = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("secret") or name:find("hidden") or name:find("area") or
               name:find("cave") or name:find("room") then
                count = count + 1
                Notify("📍 " .. obj.Name, Color3.fromRGB(255,200,80), 3+count*0.5)
            end
        end
    end
    if count == 0 then Notify("No se encontraron áreas secretas", CurrentTheme.TextDim, 2, "🗺") end
end)

-- ============================================================
-- TAB 6 — TROLL
-- ============================================================
local P6 = Panels[6]

-- Selector de jugador (en Troll)
SectionLabel(P6,"— Jugador objetivo",1)
local selectedLbl = Instance.new("TextLabel", P6)
selectedLbl.Size = UDim2.new(1,0,0,24); selectedLbl.BackgroundColor3 = CurrentTheme.BG3
selectedLbl.BorderSizePixel = 0; selectedLbl.LayoutOrder = 2
selectedLbl.Text = "Target: " .. (State.SelectedPlayer or "ninguno")
selectedLbl.Font = Enum.Font.GothamBold; selectedLbl.TextSize = 11
selectedLbl.TextColor3 = CurrentTheme.AccentLight
Instance.new("UICorner", selectedLbl).CornerRadius = UDim.new(0,6)

local function RefreshTrollTarget()
    selectedLbl.Text = "🎯 Target: " .. (State.SelectedPlayer or "ninguno")
end

local trollPlayerListFrame = Instance.new("Frame", P6)
trollPlayerListFrame.Size = UDim2.new(1,0,0,10); trollPlayerListFrame.BackgroundTransparency = 1
trollPlayerListFrame.LayoutOrder = 3; trollPlayerListFrame.AutomaticSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", trollPlayerListFrame).Padding = UDim.new(0,3)

local function RefreshTrollList()
    for _, c in pairs(trollPlayerListFrame:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end
    for _, pl in pairs(Players:GetPlayers()) do
        if pl == LocalPlayer then continue end
        local row = Instance.new("TextButton", trollPlayerListFrame)
        row.Size = UDim2.new(1,0,0,26); row.BackgroundColor3 = CurrentTheme.BG3
        row.BorderSizePixel = 0; row.Text = "· " .. pl.Name
        row.Font = Enum.Font.Gotham; row.TextSize = 11; row.TextColor3 = CurrentTheme.Text
        row.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", row).CornerRadius = UDim.new(0,5)
        local pad = Instance.new("UIPadding", row); pad.PaddingLeft = UDim.new(0,8)
        row.MouseButton1Click:Connect(function()
            State.SelectedPlayer = pl.Name
            RefreshTrollTarget()
            Notify("Target: " .. pl.Name, Color3.fromRGB(255,160,80), 2, "🎯")
        end)
    end
end
RefreshTrollList()
Players.PlayerAdded:Connect(RefreshTrollList)
Players.PlayerRemoving:Connect(function() task.delay(0.1, RefreshTrollList) end)

SectionLabel(P6,"— Acciones",4)
ActionButton(P6,"📍","Goto Player",5,Troll.Goto)
ActionButton(P6,"🔗","Bring Player",6,Troll.Bring)
ActionButton(P6,"👁","Spectate+",7,Troll.Spectate)
ActionButton(P6,"⛔","Stop Spectate",8,Troll.StopSpectate)
ActionButton(P6,"❄","Freeze / Unfreeze",9,Troll.Freeze)
ActionButton(P6,"🌀","Fling",10,Troll.Fling)
ActionButton(P6,"🔄","Loop Teleport",11,Troll.Loop)
ActionButton(P6,"🌙","Orbit Player",12,Troll.Orbit)
ActionButton(P6,"🌀","SpinBot (Self)",13,Troll.SpinBot)
ActionButton(P6,"💤","Fake AFK (60s)",14,Troll.FakeAFK)
ActionButton(P6,"💀","Kill",15,Troll.Kill,true)

-- ============================================================
-- TAB 7 — UTILITY
-- ============================================================
local P7 = Panels[7]
SectionLabel(P7,"— Performance",1)
ToggleButton(P7,"🚀","FPS Booster",2,function(v)
    State.FPSBoost = v; ToggleFPSBoost(v)
    Notify(v and "FPS Boost ON" or "FPS Boost OFF")
end)
ActionButton(P7,"🧹","Texture Cleaner",3,function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Transparency = 1
        end
    end
    Notify("Texturas limpiadas", Color3.fromRGB(100,255,140), 2, "🧹")
end)
ActionButton(P7,"💾","Memory Optimizer",4,function()
    game:GetService("ContentProvider"):PreloadAsync({})
    Notify("Memory optimized ✓", Color3.fromRGB(100,255,140), 2, "💾")
end)

SectionLabel(P7,"— HUD Overlays",5)
-- Watermark
local WatermarkGui = nil
ToggleButton(P7,"🏷","Watermark Overlay",6,function(v)
    State.WatermarkOn = v
    if v then
        WatermarkGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
        WatermarkGui.Name = "CyaWatermark"; WatermarkGui.ResetOnSpawn = false; WatermarkGui.DisplayOrder = 9900
        local wf = Instance.new("Frame", WatermarkGui)
        wf.Size = UDim2.new(0,220,0,24); wf.Position = UDim2.new(0,8,0,8)
        wf.BackgroundColor3 = CurrentTheme.BG2; wf.BorderSizePixel = 0
        Instance.new("UICorner", wf).CornerRadius = UDim.new(0,6)
        Instance.new("UIStroke", wf).Color = CurrentTheme.Accent
        local wl = Instance.new("TextLabel", wf)
        wl.Size = UDim2.new(1,-8,1,0); wl.Position = UDim2.new(0,8,0,0)
        wl.BackgroundTransparency = 1
        wl.Text = "✦ CyaHub v3.0  |  " .. LocalPlayer.Name
        wl.Font = Enum.Font.GothamBold; wl.TextSize = 10
        wl.TextColor3 = CurrentTheme.AccentLight; wl.TextXAlignment = Enum.TextXAlignment.Left
    else
        if WatermarkGui then WatermarkGui:Destroy(); WatermarkGui = nil end
    end
end)

-- FPS Counter
local FPSGui = nil
ToggleButton(P7,"📊","FPS Counter",7,function(v)
    State.FPSCounterOn = v
    if v then
        FPSGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
        FPSGui.Name = "CyaFPSCounter"; FPSGui.ResetOnSpawn = false; FPSGui.DisplayOrder = 9901
        local ff = Instance.new("Frame", FPSGui)
        ff.Size = UDim2.new(0,80,0,20); ff.Position = UDim2.new(0,8,0,36)
        ff.BackgroundColor3 = CurrentTheme.BG2; ff.BorderSizePixel = 0
        Instance.new("UICorner", ff).CornerRadius = UDim.new(0,5)
        local fl = Instance.new("TextLabel", ff)
        fl.Size = UDim2.new(1,0,1,0); fl.BackgroundTransparency = 1
        fl.Font = Enum.Font.GothamBold; fl.TextSize = 10; fl.TextColor3 = CurrentTheme.AccentLight
        local lastTime = tick(); local frames = 0
        Connections["FPSCounter"] = RunService.Heartbeat:Connect(function()
            frames = frames + 1
            if tick() - lastTime >= 1 then
                fl.Text = "FPS: " .. frames
                local col = frames >= 55 and Color3.fromRGB(100,255,140) or
                            frames >= 30 and Color3.fromRGB(255,200,80) or Color3.fromRGB(255,100,100)
                fl.TextColor3 = col
                frames = 0; lastTime = tick()
            end
        end)
    else
        if FPSGui then FPSGui:Destroy(); FPSGui = nil end
        if Connections["FPSCounter"] then Connections["FPSCounter"]:Disconnect() end
    end
end)

-- Ping Monitor
local PingGui = nil
ToggleButton(P7,"📶","Ping Monitor",8,function(v)
    State.PingMonitor = v
    if v then
        PingGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
        PingGui.Name = "CyaPing"; PingGui.ResetOnSpawn = false; PingGui.DisplayOrder = 9902
        local pf = Instance.new("Frame", PingGui)
        pf.Size = UDim2.new(0,90,0,20); pf.Position = UDim2.new(0,8,0,60)
        pf.BackgroundColor3 = CurrentTheme.BG2; pf.BorderSizePixel = 0
        Instance.new("UICorner", pf).CornerRadius = UDim.new(0,5)
        local pl2 = Instance.new("TextLabel", pf)
        pl2.Size = UDim2.new(1,0,1,0); pl2.BackgroundTransparency = 1
        pl2.Font = Enum.Font.GothamBold; pl2.TextSize = 10; pl2.TextColor3 = CurrentTheme.AccentLight
        Connections["PingGui"] = RunService.Heartbeat:Connect(function()
            pcall(function()
                local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
                pl2.Text = "Ping: " .. ping .. "ms"
                pl2.TextColor3 = ping < 80 and Color3.fromRGB(100,255,140) or
                                 ping < 150 and Color3.fromRGB(255,200,80) or Color3.fromRGB(255,100,100)
            end)
        end)
    else
        if PingGui then PingGui:Destroy(); PingGui = nil end
        if Connections["PingGui"] then Connections["PingGui"]:Disconnect() end
    end
end)

-- Coords Display
local CoordsGui = nil
ToggleButton(P7,"📍","Coordinates Display",9,function(v)
    State.CoordsDisplay = v
    if v then
        CoordsGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
        CoordsGui.Name = "CyaCoords"; CoordsGui.ResetOnSpawn = false; CoordsGui.DisplayOrder = 9903
        local cf2 = Instance.new("Frame", CoordsGui)
        cf2.Size = UDim2.new(0,180,0,20); cf2.Position = UDim2.new(0,8,0,84)
        cf2.BackgroundColor3 = CurrentTheme.BG2; cf2.BorderSizePixel = 0
        Instance.new("UICorner", cf2).CornerRadius = UDim.new(0,5)
        local cl = Instance.new("TextLabel", cf2)
        cl.Size = UDim2.new(1,-6,1,0); cl.Position = UDim2.new(0,4,0,0)
        cl.BackgroundTransparency = 1; cl.Font = Enum.Font.Gotham; cl.TextSize = 10
        cl.TextColor3 = CurrentTheme.Text; cl.TextXAlignment = Enum.TextXAlignment.Left
        Connections["CoordsDisplay"] = RunService.Heartbeat:Connect(function()
            local root = GetRoot()
            if root then
                local p = root.Position
                cl.Text = string.format("X:%.1f Y:%.1f Z:%.1f", p.X, p.Y, p.Z)
            end
        end)
    else
        if CoordsGui then CoordsGui:Destroy(); CoordsGui = nil end
        if Connections["CoordsDisplay"] then Connections["CoordsDisplay"]:Disconnect() end
    end
end)

-- Velocity Meter
local VelGui = nil
ToggleButton(P7,"💨","Velocity Meter",10,function(v)
    if v then
        VelGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
        VelGui.Name = "CyaVelocity"; VelGui.ResetOnSpawn = false; VelGui.DisplayOrder = 9904
        local vf = Instance.new("Frame", VelGui)
        vf.Size = UDim2.new(0,120,0,20); vf.Position = UDim2.new(0,8,0,108)
        vf.BackgroundColor3 = CurrentTheme.BG2; vf.BorderSizePixel = 0
        Instance.new("UICorner", vf).CornerRadius = UDim.new(0,5)
        local vl = Instance.new("TextLabel", vf)
        vl.Size = UDim2.new(1,0,1,0); vl.BackgroundTransparency = 1
        vl.Font = Enum.Font.GothamBold; vl.TextSize = 10; vl.TextColor3 = CurrentTheme.AccentLight
        Connections["VelocityMeter"] = RunService.Heartbeat:Connect(function()
            local root = GetRoot()
            if root then
                local vel = root.Velocity
                local speed = math.floor(Vector3.new(vel.X,0,vel.Z).Magnitude)
                vl.Text = "Speed: " .. speed .. " st/s"
            end
        end)
    else
        if VelGui then VelGui:Destroy(); VelGui = nil end
        if Connections["VelocityMeter"] then Connections["VelocityMeter"]:Disconnect() end
    end
end)

SectionLabel(P7,"— Waypoints",11)
local waypointLabelFrame = Instance.new("Frame", P7)
waypointLabelFrame.Size = UDim2.new(1,0,0,10); waypointLabelFrame.BackgroundTransparency = 1
waypointLabelFrame.LayoutOrder = 12; waypointLabelFrame.AutomaticSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", waypointLabelFrame).Padding = UDim.new(0,3)

local function RefreshWaypoints()
    for _, c in pairs(waypointLabelFrame:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end
    for i, loc in ipairs(State.SavedLocations) do
        local wf = Instance.new("Frame", waypointLabelFrame)
        wf.Size = UDim2.new(1,0,0,26); wf.BackgroundColor3 = CurrentTheme.BG3
        wf.BorderSizePixel = 0
        Instance.new("UICorner", wf).CornerRadius = UDim.new(0,5)
        local wl = Instance.new("TextLabel", wf)
        wl.Size = UDim2.new(0.65,0,1,0); wl.Position = UDim2.new(0,8,0,0)
        wl.BackgroundTransparency = 1; wl.TextXAlignment = Enum.TextXAlignment.Left
        wl.Text = "📍 " .. loc.name; wl.Font = Enum.Font.Gotham; wl.TextSize = 10
        wl.TextColor3 = CurrentTheme.Text
        local tpBtn = Instance.new("TextButton", wf)
        tpBtn.Size = UDim2.new(0.35,-4,1,-4); tpBtn.Position = UDim2.new(0.65,0,0,2)
        tpBtn.BackgroundColor3 = CurrentTheme.AccentDark; tpBtn.BorderSizePixel = 0
        tpBtn.Text = "TP"; tpBtn.Font = Enum.Font.GothamBold; tpBtn.TextSize = 10
        tpBtn.TextColor3 = CurrentTheme.AccentLight
        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,4)
        tpBtn.MouseButton1Click:Connect(function()
            local root = GetRoot()
            if root then
                root.CFrame = CFrame.new(loc.x, loc.y, loc.z)
                Notify("TP a " .. loc.name, CurrentTheme.AccentLight, 2, "📍")
            end
        end)
    end
end
RefreshWaypoints()

ActionButton(P7,"📌","Guardar ubicación actual",13,function()
    local root = GetRoot()
    if root then
        local p = root.Position
        local name = "Waypoint " .. (#State.SavedLocations + 1)
        table.insert(State.SavedLocations, {name=name, x=p.X, y=p.Y, z=p.Z})
        RefreshWaypoints(); SaveConfig()
        Notify("Guardado: " .. name, Color3.fromRGB(100,255,140), 2, "📌")
    end
end)
ActionButton(P7,"🗑","Limpiar waypoints",14,function()
    State.SavedLocations = {}; RefreshWaypoints(); SaveConfig()
    Notify("Waypoints limpiados", CurrentTheme.TextDim, 2, "🗑")
end)

SectionLabel(P7,"— Coordenadas",15)
ActionButton(P7,"📋","Copiar Coordenadas",16,function()
    local root = GetRoot()
    if root then
        local p = root.Position
        local str = string.format("%.2f, %.2f, %.2f", p.X, p.Y, p.Z)
        pcall(function() setclipboard(str) end)
        Notify("Coords copiadas: " .. str, CurrentTheme.AccentLight, 2, "📋")
    end
end)

-- ============================================================
-- TAB 8 — CONFIG
-- ============================================================
local P8 = Panels[8]
SectionLabel(P8,"— Temas",1)

local themeGrid = Instance.new("Frame", P8)
themeGrid.Size = UDim2.new(1,0,0,10); themeGrid.BackgroundTransparency = 1
themeGrid.LayoutOrder = 2; themeGrid.AutomaticSize = Enum.AutomaticSize.Y
local tg = Instance.new("UIGridLayout", themeGrid)
tg.CellSize = UDim2.new(0.5,-3,0,30); tg.CellPadding = UDim2.new(0,5,0,4)

local ThemeColors = {
    Purple = Color3.fromRGB(124,58,237),
    Red    = Color3.fromRGB(185,28,28),
    Blue   = Color3.fromRGB(29,78,216),
    Green  = Color3.fromRGB(22,163,74),
    Dark   = Color3.fromRGB(100,100,120),
    Cyan   = Color3.fromRGB(6,182,212),
    Orange = Color3.fromRGB(234,88,12),
}

for name, col in pairs(ThemeColors) do
    local tb = Instance.new("TextButton", themeGrid)
    tb.BackgroundColor3 = CurrentTheme.BG3; tb.Text = name
    tb.Font = Enum.Font.GothamBold; tb.TextSize = 11; tb.TextColor3 = col
    tb.BorderSizePixel = 0
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0,6)
    local ts = Instance.new("UIStroke", tb); ts.Color = col; ts.Thickness = 0.5
    tb.MouseButton1Click:Connect(function()
        if not Themes[name] then return end
        CurrentTheme = Themes[name]; State.ActiveTheme = name
        MainFrame.BackgroundColor3 = CurrentTheme.BG
        MainStroke.Color = CurrentTheme.Border
        TitleBar.BackgroundColor3 = CurrentTheme.BG2
        TitleAccent.BackgroundColor3 = CurrentTheme.Accent
        TitleLabel.TextColor3 = CurrentTheme.AccentLight
        TabDiv.BackgroundColor3 = CurrentTheme.Border
        SearchBar.BackgroundColor3 = CurrentTheme.BG3
        SearchStroke.Color = CurrentTheme.Border
        SearchInput.PlaceholderColor3 = CurrentTheme.TextDim
        SearchInput.TextColor3 = CurrentTheme.Text
        for _, sc in pairs(Panels) do
            sc.ScrollBarImageColor3 = CurrentTheme.Accent
        end
        for _, t in ipairs(Tabs) do t.TextColor3 = CurrentTheme.TextDim end
        if ActiveTab then Tabs[ActiveTab].TextColor3 = CurrentTheme.AccentLight end
        SaveConfig()
        Notify("Tema: " .. name, col, 2, "🎨")
    end)
end

SectionLabel(P8,"— Rainbow Mode",3)
ToggleButton(P8,"🌈","Rainbow Mode",4,function(v)
    State.RainbowMode = v
    if v then
        Connections["Rainbow"] = RunService.Heartbeat:Connect(function()
            if not State.RainbowMode then return end
            local hue = (tick()*0.25) % 1
            local c = Color3.fromHSV(hue,0.8,0.9)
            MainStroke.Color = c; TitleAccent.BackgroundColor3 = c; TitleLabel.TextColor3 = c
        end)
    else
        if Connections["Rainbow"] then Connections["Rainbow"]:Disconnect() end
        MainStroke.Color = CurrentTheme.Border
        TitleAccent.BackgroundColor3 = CurrentTheme.Accent
        TitleLabel.TextColor3 = CurrentTheme.AccentLight
    end
end)

SectionLabel(P8,"— Keybind",5)
local keyLabel = Instance.new("TextLabel", P8)
keyLabel.Size = UDim2.new(1,0,0,22); keyLabel.BackgroundTransparency = 1; keyLabel.LayoutOrder = 6
keyLabel.TextColor3 = CurrentTheme.TextDim; keyLabel.Font = Enum.Font.Gotham; keyLabel.TextSize = 11
keyLabel.Text = "Tecla activa:  [" .. State.ToggleKeyName .. "]"
keyLabel.TextXAlignment = Enum.TextXAlignment.Left
_G.CyaKeyLabel = keyLabel

local keyBtn = ActionButton(P8,"⌨","Cambiar tecla (presiona una)",7,function()
    State.ListeningForKey = true
    keyBtn.Text = "  ⌨  Esperando tecla..."
    keyBtn.BackgroundColor3 = CurrentTheme.AccentDark
end)
_G.CyaKeyBtn = keyBtn

SectionLabel(P8,"— Posición GUI",8)
local posF = Instance.new("Frame", P8)
posF.Size = UDim2.new(1,0,0,10); posF.BackgroundTransparency = 1
posF.LayoutOrder = 9; posF.AutomaticSize = Enum.AutomaticSize.Y
local posGrid = Instance.new("UIGridLayout", posF)
posGrid.CellSize = UDim2.new(0.5,-3,0,28); posGrid.CellPadding = UDim2.new(0,5,0,4)
for _, pd in ipairs({
    {"↖ Top Izq",  UDim2.new(0,10,0,10)},
    {"↗ Top Der",  UDim2.new(1,-430,0,10)},
    {"⊞ Centro",   UDim2.new(0.5,-210,0.5,-240)},
    {"↑ Top Cen",  UDim2.new(0.5,-210,0,10)},
    {"↙ Bot Izq",  UDim2.new(0,10,1,-490)},
    {"↘ Bot Der",  UDim2.new(1,-430,1,-490)},
}) do
    local pb = Instance.new("TextButton", posF)
    pb.BackgroundColor3 = CurrentTheme.BG3; pb.Text = pd[1]
    pb.Font = Enum.Font.Gotham; pb.TextSize = 10; pb.TextColor3 = CurrentTheme.Text
    pb.BorderSizePixel = 0
    Instance.new("UICorner", pb).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke", pb).Color = CurrentTheme.Border
    pb.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3,Enum.EasingStyle.Back), {Position = pd[2]}):Play()
    end)
end

SectionLabel(P8,"— Opacidad",10)
SliderRow(P8,"Opacidad ventana",20,100,100,11,function(v)
    State.GuiOpacity = v/100
    MainFrame.BackgroundTransparency = 1-(v/100)
end)

SectionLabel(P8,"— Configuración",12)
ActionButton(P8,"💾","Guardar config",13,function()
    SaveConfig(); Notify("Configuración guardada ✓", Color3.fromRGB(100,255,140), 2, "💾")
end)
ActionButton(P8,"📂","Recargar config",14,function()
    LoadConfig(); Notify("Configuración cargada", CurrentTheme.AccentLight, 2, "📂")
end)
ActionButton(P8,"📤","Exportar config (clipboard)",15,function()
    ExportConfig(); Notify("Config exportada al clipboard ✓", Color3.fromRGB(100,255,140), 2, "📤")
end)

SectionLabel(P8,"— Info",16)
local infoF = Instance.new("Frame", P8)
infoF.Size = UDim2.new(1,0,0,70); infoF.BackgroundColor3 = CurrentTheme.BG3
infoF.BorderSizePixel = 0; infoF.LayoutOrder = 17
Instance.new("UICorner", infoF).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", infoF).Color = CurrentTheme.Border
local infoLbl = Instance.new("TextLabel", infoF)
infoLbl.Size = UDim2.new(1,-16,1,0); infoLbl.Position = UDim2.new(0,8,0,0)
infoLbl.BackgroundTransparency = 1; infoLbl.TextColor3 = CurrentTheme.TextDim
infoLbl.Font = Enum.Font.Gotham; infoLbl.TextSize = 11
infoLbl.TextWrapped = true; infoLbl.TextXAlignment = Enum.TextXAlignment.Left
infoLbl.TextYAlignment = Enum.TextYAlignment.Center

local execName = "Unknown"
pcall(function() if identifyexecutor then execName = identifyexecutor() end end)
infoLbl.Text = "CyaHub v3.0  ·  @Cyaofc\nExecutor: " .. execName ..
    "\n" .. LocalPlayer.Name .. "  ·  ID " .. LocalPlayer.UserId ..
    "\nGame: " .. (game.Name ~= "" and game.Name or "?")

ActionButton(P8,"🗑","Destruir GUI",18,function()
    TweenService:Create(MainFrame,TweenInfo.new(0.2),{
        Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)
    }):Play()
    task.delay(0.25,function() ScreenGui:Destroy() end)
end,true)

-- ============================================================
-- MOBILE BUTTONS
-- ============================================================
local MobileGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
MobileGui.Name = "CyaMobile"; MobileGui.ResetOnSpawn = false; MobileGui.DisplayOrder = 1000

local mobileActions = {
    {"✈", function() State.Fly = not State.Fly; if State.Fly then StartFly() else StopFly() end; Notify(State.Fly and "Fly ON" or "Fly OFF") end},
    {"👻", function() State.NoClip = not State.NoClip; if State.NoClip then StartNoClip() else StopNoClip() end; Notify(State.NoClip and "NoClip ON" or "NoClip OFF") end},
    {"⬆", function() State.InfJump = not State.InfJump; Notify(State.InfJump and "InfJump ON" or "InfJump OFF") end},
    {"🛡", function() State.Godmode = not State.Godmode; ToggleGodmode(State.Godmode); Notify(State.Godmode and "God ON" or "God OFF") end},
    {"👁", function() State.ESP = not State.ESP; if State.ESP then CreateESP() else ClearESP() end; Notify(State.ESP and "ESP ON" or "ESP OFF") end},
    {"☀", function() State.Fullbright = not State.Fullbright; ToggleFullbright(State.Fullbright); Notify(State.Fullbright and "FB ON" or "FB OFF") end},
}

local mobileVisible = true
local mobileToggle  = Instance.new("TextButton", MobileGui)
mobileToggle.Size = UDim2.new(0,38,0,38); mobileToggle.Position = UDim2.new(0,6,0.5,-19)
mobileToggle.BackgroundColor3 = CurrentTheme.Accent; mobileToggle.Text = "☰"
mobileToggle.Font = Enum.Font.GothamBold; mobileToggle.TextSize = 16
mobileToggle.TextColor3 = Color3.new(1,1,1); mobileToggle.BorderSizePixel = 0
Instance.new("UICorner", mobileToggle).CornerRadius = UDim.new(0,8)

local mobileBtns = {}
for i, action in ipairs(mobileActions) do
    local mb = Instance.new("TextButton", MobileGui)
    mb.Size = UDim2.new(0,44,0,44)
    mb.Position = UDim2.new(0, 52 + (i-1)*52, 0.5, -22)
    mb.BackgroundColor3 = CurrentTheme.BG2; mb.Text = action[1]
    mb.Font = Enum.Font.Gotham; mb.TextSize = 20; mb.TextColor3 = Color3.new(1,1,1)
    mb.BorderSizePixel = 0
    Instance.new("UICorner", mb).CornerRadius = UDim.new(0,10)
    local ms = Instance.new("UIStroke", mb); ms.Color = CurrentTheme.Accent; ms.Thickness = 1
    mb.MouseButton1Click:Connect(action[2])
    table.insert(mobileBtns, mb)
end

mobileToggle.MouseButton1Click:Connect(function()
    mobileVisible = not mobileVisible
    for _, b in pairs(mobileBtns) do
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundTransparency = mobileVisible and 0 or 1,
            TextTransparency = mobileVisible and 0 or 1,
        }):Play()
    end
end)

-- ============================================================
-- KEYBIND DINÁMICO
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if State.ListeningForKey then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            State.ToggleKey     = input.KeyCode
            State.ToggleKeyName = tostring(input.KeyCode):gsub("Enum%.KeyCode%.","")
            State.ListeningForKey = false
            Notify("Tecla asignada: [" .. State.ToggleKeyName .. "]", Color3.fromRGB(100,255,140), 2, "⌨")
            if _G.CyaKeyLabel then _G.CyaKeyLabel.Text = "Tecla activa:  [" .. State.ToggleKeyName .. "]" end
            if _G.CyaKeyBtn then
                _G.CyaKeyBtn.Text = "  ⌨  Cambiar tecla (presiona una)"
                _G.CyaKeyBtn.BackgroundColor3 = CurrentTheme.BG3
            end
        end
        return
    end
    if input.KeyCode == State.ToggleKey then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            TweenService:Create(MainFrame, TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
                Size = UDim2.new(0,420,0,480)
            }):Play()
        end
    end
end)

-- ============================================================
-- INICIO
-- ============================================================
SetTab(1)
task.delay(2.2, function()
    Notify("CyaHub v3.0  ✦  [" .. State.ToggleKeyName .. "] para toggle", Color3.fromRGB(100,255,160), 5, "✦")
end)
print("[CyaHub v3.0] Cargado por " .. LocalPlayer.Name)
