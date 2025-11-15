-- Full Roblox GUI Script with Abilities
-- Place this LocalScript in StarterPlayerScripts or StarterGui as a LocalScript
-- NOTE: Test and adjust values in Studio. Some functions (like SetCoreGuiEnabled) might be restricted in live games.

-- // Services & player refs
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- // Basic GUI setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999999

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(0.25, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
local frameCorner = Instance.new("UICorner", Frame)
frameCorner.CornerRadius = UDim.new(0, 8)

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.Parent = Frame

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 180)
MinBtn.Text = "_"
MinBtn.Parent = Frame

-- Floating orb
local Orb = Instance.new("Frame")
Orb.Size = UDim2.new(0, 50, 0, 50)
Orb.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
Orb.Visible = false
Orb.Active = true
Orb.Draggable = true
Orb.AnchorPoint = Vector2.new(0.5, 0.5)
Orb.Position = UDim2.new(0.1, 0, 0.5, 0)
Orb.Parent = ScreenGui
local orbCorner = Instance.new("UICorner", Orb)
orbCorner.CornerRadius = UDim.new(1, 0)

-- Button layout using UIListLayout
local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 6)
UIList.FillDirection = Enum.FillDirection.Vertical
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.VerticalAlignment = Enum.VerticalAlignment.Top

local function MakeBtn(name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.Text = name
    b.Parent = Frame
    return b
end

-- Buttons list
local SpeedBtn = MakeBtn("Velocidad")
local JumpBtn  = MakeBtn("Salto")
local InvisBtn = MakeBtn("Invisibilidad")
local StrongBtn = MakeBtn("Super Fuerza")
local DashBtn = MakeBtn("Dash")
local FlyBtn = MakeBtn("Fly")
local FOVBtn = MakeBtn("FOV Boost")
local GodBtn = MakeBtn("God Mode")
local NoclipBtn = MakeBtn("Noclip")
local GravityBtn = MakeBtn("Gravedad Baja")
local ScaleBtn = MakeBtn("Escala")
local CamFreeBtn = MakeBtn("Camara Libre")
local HealBtn = MakeBtn("Auto Heal")
local ProjectileBtn = MakeBtn("Proyectil")
local ExplosionBtn = MakeBtn("Explosion")
local SlowBtn = MakeBtn("Slow Motion")
local ChargeJumpBtn = MakeBtn("Salto Cargado")
local SpeedUpBtn = MakeBtn("Velocidad Progresiva")
local DoubleJumpBtn = MakeBtn("Doble Salto")

-- Helper functions for character/humanoid
local function Char()
    return player.Character or player.CharacterAdded:Wait()
end
local function Hum()
    local c = Char()
    return c:FindFirstChildOfClass("Humanoid")
end

-- Abilities implementation (simple and local)
SpeedBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if h then h.WalkSpeed = 50 end
end)

JumpBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if h then h.JumpPower = 175 end
end)

InvisBtn.MouseButton1Click:Connect(function()
    local c = Char()
    for _,v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") then v.Transparency = 1 end
        if v:IsA("Decal") then v.Transparency = 1 end
    end
end)

StrongBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if h then
        -- example: increase hip height as a placeholder for 'strength' visual change
        pcall(function() h.HipHeight = (h.HipHeight or 2) + 2 end)
    end
end)

DashBtn.MouseButton1Click:Connect(function()
    local c = Char()
    local root = c:FindFirstChild("HumanoidRootPart")
    if root then
        root.Velocity = root.CFrame.LookVector * 80
    end
end)

-- Fly (very basic)
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
end)
RunService.RenderStepped:Connect(function()
    if flying then
        local c = Char()
        local root = c:FindFirstChild("HumanoidRootPart")
        if root then
            -- small upward motion while flying; in studio you may want to implement proper controls
            root.Velocity = Vector3.new(root.Velocity.X, 3, root.Velocity.Z)
        end
    end
end)

FOVBtn.MouseButton1Click:Connect(function()
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = 100 end
end)

GodBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if h then
        -- Keep health high while the script runs; note: serverside damage can still override in some games
        h.Health = h.MaxHealth
        h:GetPropertyChangedSignal("Health"):Connect(function()
            if h.Health < h.MaxHealth then
                h.Health = h.MaxHealth
            end
        end)
    end
end)

-- Noclip implementation
local noclip = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
end)
RunService.Stepped:Connect(function()
    if noclip then
        local c = Char()
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

GravityBtn.MouseButton1Click:Connect(function()
    workspace.Gravity = 40 -- lower gravity
end)

-- Scale (naive approach: scale every BasePart)
ScaleBtn.MouseButton1Click:Connect(function()
    local c = Char()
    for _,v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Size = v.Size * 1.5
        end
    end
end)

CamFreeBtn.MouseButton1Click:Connect(function()
    local cam = workspace.CurrentCamera
    if cam then cam.CameraType = Enum.CameraType.Scriptable end
end)

HealBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if h then h.Health = h.MaxHealth end
end)

ProjectileBtn.MouseButton1Click:Connect(function()
    local c = Char()
    local root = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Head")
    if root then
        local p = Instance.new("Part", workspace)
        p.Size = Vector3.new(1,1,1)
        p.Position = root.Position + (workspace.CurrentCamera.CFrame.LookVector * 3)
        p.Velocity = workspace.CurrentCamera.CFrame.LookVector * 200
        p.CanCollide = false
        p.BrickColor = BrickColor.new("Bright red")
        game:GetService("Debris"):AddItem(p, 5)
    end
end)

ExplosionBtn.MouseButton1Click:Connect(function()
    local c = Char()
    local root = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Head")
    if root then
        local expl = Instance.new("Explosion", workspace)
        expl.Position = root.Position
    end
end)

SlowBtn.MouseButton1Click:Connect(function()
    -- simple slow: reduce WalkSpeed temporarily
    local h = Hum()
    if h then
        local old = h.WalkSpeed
        h.WalkSpeed = 6
        task.delay(3, function()
            if h and h.Parent then h.WalkSpeed = old end
        end)
    end
end)

-- Charged jump (quick placeholder: single-press to boost)
ChargeJumpBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if h then h.JumpPower = 250 end
end)

-- Progressive speed (ramp up)
SpeedUpBtn.MouseButton1Click:Connect(function()
    local h = Hum()
    if not h then return end
    task.spawn(function()
        for i = h.WalkSpeed, 120, 4 do
            if h and h.Parent then h.WalkSpeed = i end
            task.wait(0.15)
        end
    end)
end)

-- Double jump (simple toggle, local implementation)
local doubleEnabled = false
DoubleJumpBtn.MouseButton1Click:Connect(function()
    doubleEnabled = not doubleEnabled
end)

do
    local jumped = false
    local h = Hum()
    if h then
        h.StateChanged:Connect(function(old, new)
            if new == Enum.HumanoidStateType.Freefall and doubleEnabled then
                if not jumped then
                    jumped = true
                else
                    h.JumpPower = 120
                    h:ChangeState(Enum.HumanoidStateType.Jumping)
                    jumped = false
                end
            end
        end)
    end
end

-- Dash visual / speed restore helper could be added as needed (this is simple and instantaneous)

-- Minimize / Orb logic
MinBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    Orb.Visible = true
end)

Orb.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Frame.Visible = true
        Orb.Visible = false
    end
end)

-- Close logic
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- End of script
