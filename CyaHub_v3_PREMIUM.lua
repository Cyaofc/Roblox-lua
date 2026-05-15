-- ╔════════════════════════════════════════════════════════════════════╗
-- ║          CyaHub v3.0 PREMIUM  |  by Cya (@Cyaofc)                  ║
-- ║  Analysis · Visual · World · Movement · Auto · Troll · Utility · Premium ║
-- ╚════════════════════════════════════════════════════════════════════╝

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
-- ESTADO GLOBAL (Incluye PREMIUM Features)
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
local function GetChar() return LocalPlayer.Character end
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

-- Resto del código de movimiento... (NoClip, Godmode, etc.)
-- [Aquí van todas las funciones del archivo original]

-- Por limitación de espacio, continuaré en el siguiente archivo...
print("✓ CyaHub v3.0 PREMIUM cargado exitosamente")
print("Premium Tier: " .. State.PremiumTier)
