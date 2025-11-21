--// SOLARA-STYLE FLOATING GUI
--// Hecho por ChatGPT para CyaOfc 😈

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Crear ScreenGui en el Core (encima de todo, como Solara)
local gui = Instance.new("ScreenGui")
gui.Name = "SolaraGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

if gethui then
	gui.Parent = gethui()
else
	gui.Parent = game.CoreGui
end

-- Ventana principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 240)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ZIndex = 10
main.Parent = gui

-- Esquinas redondas
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 12)

-- Topbar estilo Solara
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 32)
topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topbar.BorderSizePixel = 0
topbar.ZIndex = 11
topbar.Parent = main

local topcorner = Instance.new("UICorner", topbar)
topcorner.CornerRadius = UDim.new(0, 12)

-- Título Solara
local title = Instance.new("TextLabel")
title.Text = "Solara GUI • CyaOfc"
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextSize = 16
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamSemibold
title.ZIndex = 12
title.Parent = topbar

-- Botón cerrar (X)
local close = Instance.new("TextButton")
close.Text = "✕"
close.Size = UDim2.new(0, 32, 0, 32)
close.Position = UDim2.new(1, -32, 0, 0)
close.TextSize = 20
close.BackgroundTransparency = 1
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.Font = Enum.Font.GothamBold
close.ZIndex = 12
close.Parent = topbar

-- Botón minimizar (—)
local minimize = Instance.new("TextButton")
minimize.Text = "—"
minimize.Size = UDim2.new(0, 32, 0, 32)
minimize.Position = UDim2.new(1, -64, 0, 0)
minimize.TextSize = 28
minimize.BackgroundTransparency = 1
minimize.TextColor3 = Color3.fromRGB(160, 160, 160)
minimize.Font = Enum.Font.GothamBold
minimize.ZIndex = 12
minimize.Parent = topbar

-- Círculo flotante cuando está minimizado
local bubble = Instance.new("Frame")
bubble.Size = UDim2.new(0, 60, 0, 60)
bubble.Position = UDim2.new(0.85, 0, 0.5, 0)
bubble.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bubble.Visible = false
bubble.ZIndex = 50
bubble.Active = true
bubble.Draggable = true
bubble.Parent = gui

local bubbleCorner = Instance.new("UICorner", bubble)
bubbleCorner.CornerRadius = UDim.new(1, 0)

local bubbleText = Instance.new("TextLabel")
bubbleText.Text = "GUI"
bubbleText.Size = UDim2.new(1, 0, 1, 0)
bubbleText.BackgroundTransparency = 1
bubbleText.TextColor3 = Color3.fromRGB(255, 255, 255)
bubbleText.TextSize = 18
bubbleText.Font = Enum.Font.GothamBold
bubbleText.Parent = bubble

-- Minimizar
minimize.MouseButton1Click:Connect(function()
	main.Visible = false
	bubble.Visible = true
end)

-- Restaurar desde burbuja
bubble.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		main.Visible = true
		bubble.Visible = false
	end
end)

-- Cerrar GUI
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Contenedor de botones
local buttons = Instance.new("Frame")
buttons.Size = UDim2.new(1, -20, 1, -50)
buttons.Position = UDim2.new(0, 10, 0, 40)
buttons.BackgroundTransparency = 1
buttons.ZIndex = 10
buttons.Parent = main

-- Función para crear botones estilo Solara
function newButton(text, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 40)
	b.Position = UDim2.new(0, 0, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.TextSize = 16
	b.Font = Enum.Font.GothamSemibold
	b.ZIndex = 10
	
	local c = Instance.new("UICorner", b)
	c.CornerRadius = UDim.new(0, 10)

	b.Parent = buttons
	return b
end

-- Botón: Velocidad
local speedBtn = newButton("Velocidad", 0)
speedBtn.MouseButton1Click:Connect(function()
	lp.Character.Humanoid.WalkSpeed = 40
end)

-- Botón: Salto
local jumpBtn = newButton("Salto Alto", 50)
jumpBtn.MouseButton1Click:Connect(function()
	lp.Character.Humanoid.JumpPower = 150
end)

-- Botón: Super Fuerza (extra)
local powerBtn = newButton("Super Fuerza", 100)
powerBtn.MouseButton1Click:Connect(function()
	lp.Character.Humanoid.HipHeight = 5
end)

-- Botón: Noclip
local noclipBtn = newButton("Noclip", 150)
local noclip = false
noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	if noclip then
		noclipBtn.Text = "Noclip (ON)"
	else
		noclipBtn.Text = "Noclip (OFF)"
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if noclip and lp.Character then
		for _, v in pairs(lp.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)
