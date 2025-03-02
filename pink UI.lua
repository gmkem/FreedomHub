local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- รีโมทอีเวนต์
local scooterRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1NoMoto1rVehicle1s")
local carRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Player1sCa1r")

-- UI
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.4, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 192, 203) -- สีชมพูพาสเทล
frame.BackgroundTransparency = 0.4 -- ทำให้โปร่งใส
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(255, 160, 180) -- สีชมพูอ่อน
title.BackgroundTransparency = 0.3 -- โปร่งใส
title.Text = "♡ Boombox Player ♡"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 45)
textBox.PlaceholderText = "Enter Music ID ♫"
textBox.Text = ""
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 16
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
textBox.BackgroundTransparency = 0.3
textBox.Parent = frame

local playButton = Instance.new("TextButton")
playButton.Size = UDim2.new(1, -20, 0, 30)
playButton.Position = UDim2.new(0, 10, 0, 85)
playButton.Text = "► Play"
playButton.Font = Enum.Font.GothamBold
playButton.TextSize = 18
playButton.TextColor3 = Color3.new(1, 1, 1)
playButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
playButton.BackgroundTransparency = 0.2
playButton.Parent = frame

local scooterActive = true
local carActive = false

local scooterButton = Instance.new("TextButton")
scooterButton.Size = UDim2.new(0.5, -15, 0, 30)
scooterButton.Position = UDim2.new(0, 10, 0, 130)
scooterButton.Text = "Scooter: ON"
scooterButton.Font = Enum.Font.Gotham
scooterButton.TextSize = 16
scooterButton.TextColor3 = Color3.new(1, 1, 1)
scooterButton.BackgroundColor3 = Color3.fromRGB(255, 140, 180)
scooterButton.BackgroundTransparency = 0.3
scooterButton.Parent = frame

local carButton = Instance.new("TextButton")
carButton.Size = UDim2.new(0.5, -15, 0, 30)
carButton.Position = UDim2.new(0.5, 5, 0, 130)
carButton.Text = "Car: OFF"
carButton.Font = Enum.Font.Gotham
carButton.TextSize = 16
carButton.TextColor3 = Color3.new(1, 1, 1)
carButton.BackgroundColor3 = Color3.fromRGB(200, 100, 150)
carButton.BackgroundTransparency = 0.5
carButton.Parent = frame

-- ปุ่มเปิด/ปิด UI (มุมขวาบน)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 80, 0, 30)
toggleButton.Position = UDim2.new(1, -90, 0, 10)
toggleButton.AnchorPoint = Vector2.new(1, 0) -- ยึดมุมขวาบน
toggleButton.Text = "🎵 Boombox"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 160, 180)
toggleButton.BackgroundTransparency = 0.2
toggleButton.Parent = screenGui

frame.Visible = false

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- เปลี่ยนสถานะ Scooter
scooterButton.MouseButton1Click:Connect(function()
    scooterActive = not scooterActive
    if scooterActive then
        scooterButton.Text = "Scooter: ON"
        scooterButton.BackgroundColor3 = Color3.fromRGB(255, 140, 180)
    else
        scooterButton.Text = "Scooter: OFF"
        scooterButton.BackgroundColor3 = Color3.fromRGB(200, 100, 150)
    end
end)

-- เปลี่ยนสถานะ Car
carButton.MouseButton1Click:Connect(function()
    carActive = not carActive
    if carActive then
        carButton.Text = "Car: ON"
        carButton.BackgroundColor3 = Color3.fromRGB(255, 140, 180)
    else
        carButton.Text = "Car: OFF"
        carButton.BackgroundColor3 = Color3.fromRGB(200, 100, 150)
    end
end)

-- ฟังก์ชันส่งเพลงไปยังเซิร์ฟเวอร์
playButton.MouseButton1Click:Connect(function()
    local musicID = textBox.Text
    if musicID ~= "" then
        if scooterActive then
            scooterRemote:FireServer("PickingScooterMusicText", musicID)
        end
        if carActive then
            carRemote:FireServer("PickingCarMusicText", musicID)
        end
    end
end)