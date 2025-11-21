-- Botón: Volar
local flyBtn = newButton("Volar", 200)
local flying = false
local flySpeed = 4
local bodyGyro, bodyVelocity

function startFly()
    local char = lp.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flying = true

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = hrp
end

function stopFly()
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        flyBtn.Text = "Volar (ON)"
        startFly()
    else
        flyBtn.Text = "Volar (OFF)"
        stopFly()
    end
end)

-- Movimiento del vuelo (WASD JEJE)
game:GetService("RunService").Heartbeat:Connect(function()
    if flying and lp.Character and bodyGyro and bodyVelocity then
        local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame

            local move = Vector3.new(0, 0, 0)
            local input = UserInputService

            if input:IsKeyDown(Enum.KeyCode.W) then
                move = move + workspace.CurrentCamera.CFrame.LookVector
            end
            if input:IsKeyDown(Enum.KeyCode.S) then
                move = move - workspace.CurrentCamera.CFrame.LookVector
            end
            if input:IsKeyDown(Enum.KeyCode.A) then
                move = move - workspace.CurrentCamera.CFrame.RightVector
            end
            if input:IsKeyDown(Enum.KeyCode.D) then
                move = move + workspace.CurrentCamera.CFrame.RightVector
            end
            if input:IsKeyDown(Enum.KeyCode.Space) then
                move = move + Vector3.new(0, 1, 0)
            end
            if input:IsKeyDown(Enum.KeyCode.LeftControl) then
                move = move + Vector3.new(0, -1, 0)
            end

            bodyVelocity.Velocity = move * flySpeed * 20
        end
    end
end)
