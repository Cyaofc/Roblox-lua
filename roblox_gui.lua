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

-- SISTEMA DE PESTAÑAS
local Tabs = Instance.new("Frame", Frame)
Tabs.Size = UDim2.new(1, 0, 0, 40)
Tabs.Position = UDim2.new(0, 0, 1, -40)
Tabs.BackgroundTransparency = 1
local TabLayout = Instance.new("UIListLayout", Tabs)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 6)

local function MakeTab(name)
    local T = Instance.new("TextButton", Tabs)
    T.Size = UDim2.new(0, 110, 1, 0)
    T.Text = name
    T.TextScaled = true
    T.Font = Enum.Font.GothamBold
    T.TextColor3 = COLOR_LIGHT
    T.BackgroundColor3 = COLOR_BUTTON
    local C = Instance.new("UICorner", T)
    C.CornerRadius = UDim.new(0, 8)
    return T
end

local TabMain = MakeTab("General")
local TabBrainrot = MakeTab("Brainrot")

-- CONTENEDORES DE CONTENIDO
local HolderGeneral = Holder
local HolderBrainrot = Instance.new("Frame", Frame)
HolderBrainrot.Size = UDim2.new(1, -20, 1, -75)
HolderBrainrot.Position = UDim2.new(0, 10, 0, 65)
HolderBrainrot.BackgroundTransparency = 1
HolderBrainrot.Visible = false

local LayoutBrainrot = Instance.new("UIListLayout", HolderBrainrot)
LayoutBrainrot.Padding = UDim.new(0, 8)

-- FUNCIÓN CAMBIO DE PESTAÑAS
TabMain.MouseButton1Click:Connect(function()
    HolderGeneral.Visible = true
    HolderBrainrot.Visible = false
end)

TabBrainrot.MouseButton1Click:Connect(function()
    HolderGeneral.Visible = false
    HolderBrainrot.Visible = true
end)

-- BOTONES BRAINROT
local AutoBrainrotBtn = Instance.new("TextButton", HolderBrainrot)
AutoBrainrotBtn.Size = UDim2.new(1, 0, 0, 42)
AutoBrainrotBtn.BackgroundColor3 = COLOR_BUTTON
AutoBrainrotBtn.Text = "Comprar Mejor Brainrot (AUTO)"
AutoBrainrotBtn.TextScaled = true
AutoBrainrotBtn.Font = Enum.Font.GothamBold
AutoBrainrotBtn.TextColor3 = COLOR_LIGHT
local AB_Corner = Instance.new("UICorner", AutoBrainrotBtn)
AB_Corner.CornerRadius = UDim.new(0, 10)

-- NUEVO: Comprar Brainrots del vendedor actual
local VendorBrainrotBtn = Instance.new("TextButton", HolderBrainrot)
VendorBrainrotBtn.Size = UDim2.new(1, 0, 0, 42)
VendorBrainrotBtn.BackgroundColor3 = COLOR_BUTTON
VendorBrainrotBtn.Text = "Comprar Brainrots del Vendedor"
VendorBrainrotBtn.TextScaled = true
VendorBrainrotBtn.Font = Enum.Font.GothamBold
VendorBrainrotBtn.TextColor3 = COLOR_LIGHT
local VB_Corner = Instance.new("UICorner", VendorBrainrotBtn)
VB_Corner.CornerRadius = UDim.new(0, 10)

local function animateBtn(B)
    B.MouseEnter:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_MAIN}):Play()
    end)
    B.MouseLeave:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = COLOR_BUTTON}):Play()
    end)
end

animateBtn(AutoBrainrotBtn)
animateBtn(VendorBrainrotBtn)

-- SISTEMAS
local autoBrainrot = false
local function purchaseBestBrainrot() print("Comprando mejor brainrot...") end
local function purchaseVendorBrainrots()
    print("Comprando brainrots del vendedor actual...")
    -- Aquí puedes decirme cómo se llama el vendedor en tu juego y lo integro real
end

AutoBrainrotBtn.MouseButton1Click:Connect(function()
    autoBrainrot = not autoBrainrot
    AutoBrainrotBtn.Text = autoBrainrot and "AUTO: ON" or "Comprar Mejor Brainrot (AUTO)"
    if autoBrainrot then
        task.spawn(function()
            while autoBrainrot do purchaseBestBrainrot() task.wait(5) end
        end)
    end
end)

VendorBrainrotBtn.MouseButton1Click:Connect(function()
    purchaseVendorBrainrots()
end)
local AutoBrainrotBtn = Instance.new("TextButton", HolderBrainrot)
AutoBrainrotBtn.Size = UDim2.new(1, 0, 0, 42)
AutoBrainrotBtn.BackgroundColor3 = COLOR_BUTTON
AutoBrainrotBtn.Text = "Comprar Mejor Brainrot (AUTO)"
AutoBrainrotBtn.TextScaled = true
AutoBrainrotBtn.Font = Enum.Font.GothamBold
AutoBrainrotBtn.TextColor3 = COLOR_LIGHT
local AB_Corner = Instance.new("UICorner", AutoBrainrotBtn)
AB_Corner.CornerRadius = UDim.new(0, 10)

-- ANIMACIONES
AutoBrainrotBtn.MouseEnter:Connect(function()
    TweenService:Create(AutoBrainrotBtn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_MAIN}):Play()
end)
AutoBrainrotBtn.MouseLeave:Connect(function()
    TweenService:Create(AutoBrainrotBtn, TweenInfo.new(0.3), {BackgroundColor3 = COLOR_BUTTON}):Play()
end)

-- SISTEMA DE AUTO-COMPRA (PLACEHOLDER)
local autoBrainrot = false

local function purchaseBestBrainrot()
    -- Este apartado se debe personalizar dependiendo del juego
    -- Aquí solo está la estructura lista para integrarse al sistema real del juego
    print("Intentando comprar el mejor brainrot...")

    -- Ejemplo: detectar tienda
    local shop = workspace:FindFirstChild("Shop")
    if shop then
        for _,item in ipairs(shop:GetChildren()) do
            if item:FindFirstChild("Price") then
                -- aquí se colocaría la compra real
            end
        end
    end
end

AutoBrainrotBtn.MouseButton1Click:Connect(function()
    autoBrainrot = not autoBrainrot
    AutoBrainrotBtn.Text = autoBrainrot and "AUTO: ON" or "Comprar Mejor Brainrot (AUTO)"

    if autoBrainrot then
        task.spawn(function()
            while autoBrainrot do
                purchaseBestBrainrot()
                task.wait(5)
            end
        end)
    end
end)

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
Title.TextScaled = false
Title.TextSize = 26 -- tamaño reducido
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
--  TEMPORIZADOR DE BASES (REPARADO)
-------------------------------------
local basesFolder = workspace:FindFirstChild("Bases")
local baseTimers = {}
local timerEnabled = false

local function addBaseTimer(obj)
    if not obj:IsA("BasePart") then return end

    local billboard = Instance.new("BillboardGui", obj)
    billboard.Size = UDim2.new(0, 120, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Adornee = obj

    local txt = Instance.new("TextLabel", billboard)
    txt.BackgroundTransparency = 1
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.Font = Enum.Font.GothamBold
    txt.TextScaled = true
    txt.TextColor3 = COLOR_LIGHT
    txt.Text = "60"

    baseTimers[obj] = {gui = billboard, text = txt, time = 60}
end

BaseTimerBtn.MouseButton1Click:Connect(function()
    timerEnabled = not timerEnabled

    if timerEnabled then
        BaseTimerBtn.Text = "Bases: ON"

        -- Buscar bases reales
        if basesFolder then
            for _,b in ipairs(basesFolder:GetChildren()) do
                if b:IsA("BasePart") then addBaseTimer(b) end
            end
        else
            -- Si no existe carpeta, buscar bases por nombre
            for _,obj in ipairs(workspace:GetChildren()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("base") then
                    addBaseTimer(obj)
                end
            end
        end

        -- Iniciar temporizador
        task.spawn(function()
            while timerEnabled do
                for base, data in pairs(baseTimers) do
                    if data.text then
                        data.time -= 1
                        data.text.Text = tostring(data.time)
                        if data.time <= 0 then data.time = 60 end
                    end
                end
                task.wait(1)
            end
        end)

    else
        BaseTimerBtn.Text = "Ver Tiempo de Bases"
        for _,d in pairs(baseTimers) do
            if d.gui then d.gui:Destroy() end
        end
        baseTimers = {}
    end
end)
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
