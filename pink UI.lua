-- UI Library Full Script
local UI = {}

-- Create Button Function
function UI:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0, 200, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 24
    button.Parent = parent

    button.MouseButton1Click:Connect(callback)
    return button
end

-- Create Panel Function
function UI:CreatePanel(parent)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 400, 0, 600)
    panel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    panel.BackgroundTransparency = 0.3
    panel.Parent = parent

    -- Add UIListLayout for automatic position management
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 10)
    layout.Parent = panel

    return panel
end

-- Create Tabs
function UI:CreateTabs(parent, tabs, callback)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 400, 0, 50)
    tabContainer.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    tabContainer.Parent = parent

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tabLayout.Parent = tabContainer

    local currentTab
    for _, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Text = tabName
        tabButton.Size = UDim2.new(0, 100, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 20
        tabButton.Parent = tabContainer

        tabButton.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            end
            tabButton.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
            currentTab = tabButton
            callback(tabName)
        end)
    end

    return tabContainer
end

-- Create Notification
function UI:CreateNotification(parent, text, duration)
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 400, 0, 50)
    notification.Position = UDim2.new(0.5, -200, 0, -100)
    notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notification.BackgroundTransparency = 0.8
    notification.Parent = parent

    local message = Instance.new("TextLabel")
    message.Text = text
    message.Size = UDim2.new(1, 0, 1, 0)
    message.BackgroundTransparency = 1
    message.TextColor3 = Color3.fromRGB(0, 0, 0)
    message.Font = Enum.Font.Gotham
    message.TextSize = 20
    message.Parent = notification

    -- Animation to show the notification
    notification.Position = UDim2.new(0.5, -200, 0, 10)
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -200, 0, 80)}):Play()

    -- Close animation
    wait(duration)
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -200, 0, -100)}):Play()
    wait(0.5)
    notification:Destroy()
end

-- Create Loading Screen
function UI:CreateLoadingScreen(parent)
    local loadingScreen = Instance.new("Frame")
    loadingScreen.Size = UDim2.new(1, 0, 1, 0)
    loadingScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    loadingScreen.BackgroundTransparency = 0.5
    loadingScreen.Parent = parent

    local loadingText = Instance.new("TextLabel")
    loadingText.Text = "Loading..."
    loadingText.Size = UDim2.new(0, 200, 0, 50)
    loadingText.Position = UDim2.new(0.5, -100, 0.5, -25)
    loadingText.BackgroundTransparency = 1
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.Font = Enum.Font.Gotham
    loadingText.TextSize = 30
    loadingText.Parent = loadingScreen

    return loadingScreen
end

-- Theme Manager
function UI:SetTheme(theme)
    -- Set UI components based on theme
    if theme == "Light" then
        return Color3.fromRGB(255, 255, 255)
    elseif theme == "Dark" then
        return Color3.fromRGB(30, 30, 30)
    elseif theme == "Pink" then
        return Color3.fromRGB(255, 182, 193)
    else
        return Color3.fromRGB(240, 240, 240)
    end
end

-- Function to Close UI with Animation
function UI:CloseUI(uiElement)
    game:GetService("TweenService"):Create(uiElement, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    wait(0.5)
    uiElement:Destroy()
end

-- Function to Open UI with Animation
function UI:OpenUI(parent, uiElement)
    uiElement.Parent = parent
    uiElement.BackgroundTransparency = 1
    game:GetService("TweenService"):Create(uiElement, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
end

-- Handle Multiple Windows
function UI:CreateMultipleWindows(parent, windows)
    local windowContainer = Instance.new("Frame")
    windowContainer.Size = UDim2.new(0, 600, 0, 400)
    windowContainer.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    windowContainer.Parent = parent

    -- Automatically generate buttons for each window
    for _, window in ipairs(windows) do
        local windowButton = Instance.new("TextButton")
        windowButton.Text = window.name
        windowButton.Size = UDim2.new(0, 100, 0, 40)
        windowButton.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
        windowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        windowButton.Font = Enum.Font.Gotham
        windowButton.TextSize = 18
        windowButton.Parent = windowContainer

        windowButton.MouseButton1Click:Connect(function()
            -- Handle window activation
            print("Switching to window: " .. window.name)
        end)
    end

    return windowContainer
end

return UI