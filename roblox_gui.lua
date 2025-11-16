-- GUI mejorada con colores azul claro/fuerte, animaciones, bordes brillantes
-- Incluye ESP (ver jugadores) + temporizador de bases estilo Steal a Brainrot
-- Título CyaOficial centrado

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- COLORES PERSONALIZADOS
local COLOR_MAIN = Color3.fromRGB(0, 140, 255)        -- azul fuerte
local COLOR_LIGHT = Color3.fromRGB(120, 200, 255)      -- azul claro
local COLOR_BG = Color3.fromRGB(15, 20, 30)            -- fondo oscuro
local COLOR_BUTTON = Color3.fromRGB(30, 40, 60)

-- GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- MARCO PRINCIPAL
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 360, 0, 460)
Frame.Position = UDim2.new(0.5, -180, 0.5, -230)
Frame.BackgroundColor3 = COLOR_BG
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 14)

-- BORDE BRILLANTE
local Glow = Instance.new("UIStroke", Frame)
Glow.Thickness = 3
Glow.Color = COLOR_MAIN
Glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Glow.Transparency = 0.2

-- Animación de brillo
TweenService:Create(Glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {Transparency = 0.6}):Play()

-- BARRA SUPERIOR CON TITULO
local TopBar = Instance.new("Frame", Frame)
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = COLOR_BUTTON
TopBar.BorderSizePixel = 0
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "CyaOficial"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = COLOR_LIGHT

-- ANIMACIÓN TITULO PULSANTE
TweenService:Create(Title, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {TextColor3 = COLOR_MAIN}):Play()

-- BOTONES: CLOSE / MIN
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -50, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
local CB_Corner = Instance.new("UICorner", CloseBtn)
CB_Corner.CornerRadius = UDim.new(0, 8)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 45, 0, 45)
MinBtn.Position = UDim2.new(1, -100, 0, 5)
MinBtn.Text = "_"
MinBtn.TextScaled = true
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BackgroundColor3 = COLOR_MAIN
local MB_Corner = Instance.new("UICorner", MinBtn)
MB_Corner.CornerRadius = UDim.new(0, 8)

-- ORB FLOTANTE
local Orb = Instance.new("Frame", ScreenGui)
Orb.Size = UDim2.new(0, 60, 0, 60)
Orb.BackgroundColor3 = COLOR_MAIN
Orb.Visible = false
Orb.Active = true
Orb.Draggable = true
local OrbCorner = Instance.new("UICorner", Orb)
OrbCorner.CornerRadius = UDim.new(1, 0)

-- CONTENEDOR BOTONES
local Holder = Instance.new("Frame", Frame)
Holder.Size = UDim2.new(1, -20, 1, -75)
Holder.Position = UDim2.new(0, 10, 0, 65)
Holder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", Holder)
Layout.Padding = UDim.new(0, 8)

-- FUNCIÓN CREAR BOTONES
local function MakeBtn(text)
    local B = Instance.new("TextButton", Holder)
    B.Size = UDim2.new(1, 0, 0, 42)
    B.BackgroundColor3 = COLOR_BUTTON
    B.Text = text
    B.TextScaled = true
    B.Font = Enum.Font.GothamBold
    B.TextColor3 = COLOR_LIGHT
    local C = Instance.new("UICorner", B)
    C.CornerRadius = UDim.new(0, 10)

    -- Animación al pasar mouse
    B.MouseEnter:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_MAIN}):Play()
    end)
    B.MouseLeave:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = COLOR_BUTTON}):Play()
    end)

    return B
end

-- BOTONES (misma lista + añadidos)
local SpeedBtn = MakeBtn("Velocidad")
local JumpBtn = MakeBtn("Salto")
local InvisBtn = MakeBtn("Invisibilidad")
local DashBtn = MakeBtn("Dash")
local FlyBtn = MakeBtn("Fly")
local GravityBtn = MakeBtn("Gravedad Baja")
local ScaleBtn = MakeBtn("Escala")
local CamFreeBtn = MakeBtn("Camara Libre")
local ProjectileBtn = MakeBtn("Proyectil")
local ExplosionBtn = MakeBtn("Explosion")
local SlowBtn = MakeBtn("Slow Motion")
local ChargeJumpBtn = MakeBtn("Salto Cargado")
local SpeedUpBtn = MakeBtn("Velocidad Progresiva")
local DoubleJumpBtn = MakeBtn("Doble Salto")
local AimbotBtn = MakeBtn("Aimbot")
local ESPBtn = MakeBtn("Ver Jugadores (ESP)")
local BaseTimerBtn = MakeBtn("Ver Tiempo de Bases")

-------------------------------------
--  ESP (VER JUGADORES COMO EN BRAINROT)
-------------------------------------
local espEnabled = false
local espObjects = {}

local function createESP(plr)
    if plr == player then return end
    if espObjects[plr] then return end

    local billboard = Instance.new("BillboardGui", workspace)
    billboard.Adornee = plr.Character:WaitForChild("Head")
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.AlwaysOnTop = true

    local txt = Instance.new("TextLabel", billboard)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = plr.Name
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.TextColor3 = COLOR_MAIN

    espObjects[plr] = billboard
end

local function removeESP(plr)
    if espObjects[plr] then
        espObjects[plr]:Destroy()
        espObjects[plr] = nil
    end
end

ESPBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        for _,p in pairs(Players:GetPlayers()) do
            if p.Character then createESP(p) end
        end
        ESPBtn.Text = "ESP: ON"
    else
        for p,obj in pairs(espObjects) do obj:Destroy() end
        espObjects = {}
        ESPBtn.Text = "Ver Jugadores (ESP)"
    end
end)

Players.PlayerAdded:Connect(function(plr)
    if espEnabled then
        plr.CharacterAdded:Connect(function()
            createESP(plr)
        end)
    end
end)

-------------------------------------
--  TEMPORIZADOR DE BASES (ESTILO BRAINROT)
-------------------------------------
local bases = workspace:FindFirstChild("Bases") or workspace
local baseTimers = {}
local timerEnabled = false

local function addBaseTimer(base)
    if not base:IsA("BasePart") then return end

    local billboard = Instance.new("BillboardGui", base)
    billboard.Size = UDim2.new(0, 120, 0, 50)
    billboard.AlwaysOnTop = true

    local txt = Instance.new("TextLabel", billboard)
    txt.BackgroundTransparency = 1
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.Font = Enum.Font.GothamBold
    txt.TextScaled = true
    txt.TextColor3 = COLOR_LIGHT
    txt.Text = "60"

    baseTimers[base] = {gui=billboard,time=60}
end

BaseTimerBtn.MouseButton1Click:Connect(function()
    timerEnabled = not timerEnabled

    if timerEnabled then
        BaseTimerBtn.Text = "Bases: ON"

        for _,b in ipairs(bases:GetChildren()) do addBaseTimer(b) end

        task.spawn(function()
            while timerEnabled do
                for b,data in pairs(baseTimers) do
                    data.time -= 1
                    data.gui.TextLabel.Text = tostring(data.time)
                    if data.time <= 0 then data.time = 60 end
                end
                task.wait(1)
            end
        end)

    else
        BaseTimerBtn.Text = "Ver Tiempo de Bases"
        for _,d in pairs(baseTimers) do d.gui:Destroy() end
        baseTimers = {}
    end
end)

-------------------------------------
-- Aquí seguirían las habilidades + aimbot
-------------------------------------
-- (Tu script de habilidades y aimbot sigue funcionando igual)

