-- Steal a Brainrot Multi-Script
-- Creado para automatizar las principales funciones del juego

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Configuración
local config = {
    autoCollectCash = true,
    autoSteal = true,
    autoLockBase = true,
    instantTake = true,
    noClip = false,
    hideBrainrot = true
}

-- Función para recolectar dinero automáticamente
local function autoCollectCash()
    while config.autoCollectCash do
        -- Buscar y recolectar dinero en el mapa
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin") then
                if obj:IsA("Model") or obj:IsA("Part") then
                    -- Teletransportarse al dinero
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = obj.CFrame
                        wait(0.5)
                        
                        -- Simular clic o proximidad
                        firetouchinterest(character.HumanoidRootPart, obj, 0)
                    end
                end
            end
        end
        wait(1)
    end
end

-- Función para robar brainrots automáticamente
local function autoStealBrainrots()
    while config.autoSteal do
        -- Buscar brainrots de otros jugadores
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("brainrot") and not obj:IsDescendantOf(character) then
                if obj:IsA("Model") or obj:IsA("Part") then
                    -- Teletransportarse al brainrot
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = obj.CFrame
                        wait(0.5)
                        
                        -- Simular robo
                        firetouchinterest(character.HumanoidRootPart, obj, 0)
                    end
                end
            end
        end
        wait(2)
    end
end

-- Función para bloquear base automáticamente
local function autoLockBase()
    while config.autoLockBase do
        -- Buscar botones o interfaces para bloquear base
        for _, obj in pairs(player.PlayerGui:GetChildren()) do
            if obj.Name:lower():find("base") or obj.Name:lower():find("lock") then
                -- Buscar botones dentro de la interfaz
                for _, button in pairs(obj:GetDescendants()) do
                    if button:IsA("TextButton") and button.Text:lower():find("lock") then
                        -- Simular clic en el botón
                        fireclickdetector(button)
                        wait(1)
                    end
                end
            end
        end
        wait(5)
    end
end

-- Función para activar NoClip
local function toggleNoClip()
    if config.noClip then
        -- Crear conexión para NoClip
        local noclipConnection
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid:ChangeState(11)
            end
        end)
        
        -- Limpiar al morir
        character.Humanoid.Died:Connect(function()
            noclipConnection:Disconnect()
        end)
    end
end

-- Función para ocultar brainrots
local function hideBrainrots()
    if config.hideBrainrot then
        while wait(5) do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:lower():find("brainrot") and not obj:IsDescendantOf(character) then
                    -- Hacer invisibles los brainrots de otros jugadores
                    if obj:IsA("Model") then
                        for _, part in pairs(obj:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = 1
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Función para toma instantánea
local function instantTake()
    if config.instantTake then
        -- Buscar y modificar la velocidad de toma
        for _, obj in pairs(character:GetChildren()) do
            if obj.Name:lower():find("tool") or obj.Name:lower():find("take") then
                -- Modificar valores para acelerar la toma
                for _, value in pairs(obj:GetDescendants()) do
                    if value:IsA("NumberValue") and value.Name:lower():find("speed") then
                        value.Value = 0.1
                    end
                    if value:IsA("IntValue") and value.Name:lower():find("time") then
                        value.Value = 1
                    end
                end
            end
        end
    end
end

-- Iniciar todas las funciones
spawn(autoCollectCash)
spawn(autoStealBrainrots)
spawn(autoLockBase)
toggleNoClip()
hideBrainrots()
instantTake()

-- Notificación
local message = Instance.new("Hint", workspace)
message.Text = "Script de Steal a Brainrot cargado correctamente"
wait(3)
message:Destroy()

print("Script de Steal a Brainrot activado")
print("Funciones activas:")
print("- Auto recolectar dinero: " .. tostring(config.autoCollectCash))
print("- Auto robar brainrots: " .. tostring(config.autoSteal))
print("- Auto bloquear base: " .. tostring(config.autoLockBase))
print("- NoClip: " .. tostring(config.noClip))
print("- Ocultar brainrots: " .. tostring(config.hideBrainrot))
print("- Toma instantánea: " .. tostring(config.instantTake))
