-- Full Roblox GUI Script with Abilities -- This script creates a draggable GUI, close/minimize, floating orb, and many abilities. -- Place in a LocalScript under StarterPlayerScripts or StarterGui.

-- // GUI Creation local Players = game:GetService("Players") local player = Players.LocalPlayer local mouse = player:GetMouse() local UIS = game:GetService("UserInputService") local RunService = game:GetService("RunService") local StarterGui = game:GetService("StarterGui")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

local ScreenGui = Instance.new("ScreenGui") ScreenGui.Parent = player:WaitForChild("PlayerGui") ScreenGui.ResetOnSpawn = false ScreenGui.IgnoreGuiInset = true

-- Force on top layer ScreenGui.DisplayOrder = 999999999

-- Main Frame local Frame = Instance.new("Frame") Frame.Size = UDim2.new(0, 300, 0, 350) Frame.Position = UDim2.new(0.25, 0, 0.25, 0) Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Frame.Active = true Frame.Draggable = true Frame.Parent = ScreenGui

-- Close Button local CloseBtn = Instance.new("TextButton") CloseBtn.Size = UDim2.new(0, 30, 0, 30) CloseBtn.Position = UDim2.new(1, -35, 0, 5) CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) CloseBtn.Text = "X" CloseBtn.Parent = Frame

-- Minimize Button local MinBtn = Instance.new("TextButton") MinBtn.Size = UDim2.new(0, 30, 0, 30) MinBtn.Position = UDim2.new(1, -70, 0, 5) MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 180) MinBtn.Text = "_" MinBtn.Parent = Frame

-- Floating orb local Orb = Instance.new("Frame") Orb.Size = UDim2.new(0, 50, 0, 50) Orb.BackgroundColor3 = Color3.fromRGB(255, 170, 0) Orb.Visible = false Orb.Active = true Orb.Draggable = true Orb.AnchorPoint = Vector2.new(0.5, 0.5) Orb.Position = UDim2.new(0.1, 0, 0.5, 0) Orb.Parent = ScreenGui local UIC = Instance.new("UICorner", Orb) UIC.CornerRadius = UDim.new(1,0)

-- Ability buttons container local UIList = Instance.new("UIListLayout", Frame) UIList.Padding = UDim.new(0, 6) UIList.FillDirection = Enum.FillDirection.Vertical UIList.SortOrder = Enum.SortOrder.LayoutOrder

local function MakeBtn(name) local b = Instance.new("TextButton") b.Size = UDim2.new(1,-10,0,30) b.BackgroundColor3 = Color3.fromRGB(50,50,50) b.Text = name b.Parent = Frame return b end

-- Buttons local SpeedBtn = MakeBtn("Velocidad") local JumpBtn  = MakeBtn("Salto") local InvisBtn = MakeBtn("Invisibilidad") local StrongBtn = MakeBtn("Super Fuerza") local DashBtn = MakeBtn("Dash") local FlyBtn = MakeBtn("Fly") local FOVBtn = MakeBtn("FOV Boost") local GodBtn = MakeBtn("God Mode") local NoclipBtn = MakeBtn("Noclip") local GravityBtn = MakeBtn("Gravedad Baja") local ScaleBtn = MakeBtn("Escala") local CamFreeBtn = MakeBtn("Camara Libre") local HealBtn = MakeBtn("Auto Heal") local ProjectileBtn = MakeBtn("Proyectil") local ExplosionBtn = MakeBtn("Explosion") local SlowBtn = MakeBtn("Slow Motion") local ChargeJumpBtn = MakeBtn("Salto Cargado") local SpeedUpBtn = MakeBtn("Velocidad Progresiva") local DoubleJumpBtn = MakeBtn("Doble Salto")

-- // Character references local function Char() return player.Character or player.CharacterAdded:Wait() end local function Hum() return Char():WaitForChild("Humanoid") end

-- // Ability logic SpeedBtn.MouseButton1Click:Connect(function() Hum().WalkSpeed = 50 end)

JumpBtn.MouseButton1Click:Connect(function() Hum().JumpPower = 175 end)

InvisBtn.MouseButton1Click:Connect(function() for _,p in pairs(Char():GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end if p:IsA("Decal") then p.Transparency = 1 end end end)

StrongBtn.MouseButton1Click:Connect(function() Hum().HipHeight = 4 end)

DashBtn.MouseButton1Click:Connect(function() local h = Hum() h.WalkSpeed = 150 task.delay(0.7,function() h.WalkSpeed = 16 end) end)

local flying = false FlyBtn.MouseButton1Click:Connect(function() flying = not flying end) RunService.RenderStepped:Connect(function() if flying then Char():SetPrimaryPartCFrame(Char().PrimaryPart.CFrame + Vector3.new(0,0.4,0)) end end)

FOVBtn.MouseButton1Click:Connect(function() workspace.CurrentCamera.FieldOfView = 100 end)

GodBtn.MouseButton1Click:Connect(function() Hum().Health = math.huge end)

local noclip = false NoclipBtn.MouseButton1Click:Connect(function() noclip = not noclip end) RunService.Stepped:Connect(function() if noclip then for _,v in pairs(Char():GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end)

GravityBtn.MouseButton1Click:Connect(function() workspace.Gravity = 60 end)

ScaleBtn.MouseButton1Click:Connect(function() Char():ScaleTo(1.5) end)

CamFreeBtn.MouseButton1Click:Connect(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable end)

HealBtn.MouseButton1Click:Connect(function() Hum().Health = Hum().MaxHealth end)

ProjectileBtn.MouseButton1Click:Connect(function() local p = Instance.new("Part", workspace) p.Size = Vector3.new(1,1,1) p.Position = Char().PrimaryPart.Position + Char().PrimaryPart.CFrame.LookVector * 3 p.Velocity = Char().PrimaryPart.CFrame.LookVector * 200 p.CanCollide = false end)

ExplosionBtn.MouseButton1Click:Connect(function() Instance.new("Explosion", workspace).Position = Char().PrimaryPart.Position end)

SlowBtn.MouseButton1Click:Connect(function() Hum().WalkSpeed = 5 end)

local charging = false ChargeJumpBtn.MouseButton1Click:Connect(function() charging = true task.wait(1) if charging then Hum().JumpPower = 250 end end)

SpeedUpBtn.MouseButton1Click:Connect(function() task.spawn(function() for i=16,120,4 do Hum().WalkSpeed = i task.wait(0.2) end end) end)

local DJenabled = false DoubleJumpBtn.MouseButton1Click:Connect(function() DJenabled = not DJenabled end)

local canDouble = true Hum().StateChanged:Connect(function(old,new) if DJenabled and new == Enum.HumanoidStateType.Jumping then if canDouble then canDouble = false else Hum():ChangeState(Enum.HumanoidStateType.Jumping) canDouble = true end end end)

-- Minimize logic MinBtn.MouseButton1Click:Connect(function() Frame.Visible = false Orb.Visible = true end)

Orb.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then Frame.Visible = true Orb.Visible = false end end)

-- Close logic CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
