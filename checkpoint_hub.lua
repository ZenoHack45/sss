local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === Задержка 1 секунда перед запуском ===
task.wait(1)

-- === Иконка из ссылки ===
local logoAssetId = "rbxassetid://74562782" -- War Tycon

-- === Уведомления ===
local function createNotification(text, duration)
    duration = duration or 3
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 320, 0, 90)
    notification.Position = UDim2.new(0.5, -160, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 35)
    uiCorner.Parent = notification

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(455, 0, 0)
    uiStroke.Thickness = 3
    uiStroke.Parent = notification

    local glowEffect = Instance.new("ImageLabel")
    glowEffect.Name = "GlowEffect"
    glowEffect.Size = UDim2.new(1.2, 0, 1.2, 0)
    glowEffect.Position = UDim2.new(-0.1, 0, -0.1, 0)
    glowEffect.BackgroundTransparency = 1
    glowEffect.Image = "rbxassetid://5028857084"
    glowEffect.ImageColor3 = Color3.fromRGB(255, 0, 0)
    glowEffect.ImageTransparency = 0.7
    glowEffect.ZIndex = -1
    glowEffect.Parent = notification

    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "NotifIcon"
    iconImage.Size = UDim2.new(0, 60, 0, 60)
    iconImage.Position = UDim2.new(0, 15, 0.5, -30)
    iconImage.BackgroundTransparency = 1
    iconImage.Image = logoAssetId
    iconImage.Parent = notification

    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -90, 1, -20)
    notifText.Position = UDim2.new(0, 85, 0, 10)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 20
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.Parent = notification

    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    iconImage.ImageTransparency = 1
    glowEffect.ImageTransparency = 1

    TweenService:Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    TweenService:Create(notifText, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(iconImage, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    TweenService:Create(glowEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0.7}):Play()

    spawn(function()
        wait(duration)
        TweenService:Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        TweenService:Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1}):Play()
        TweenService:Create(notifText, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
        TweenService:Create(iconImage, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
        TweenService:Create(glowEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
        wait(0.6)
        notification:Destroy()
    end)
end

-- === Создаём GUI (с защитой от падения) ===
local screenGui = nil
pcall(function()
    screenGui = playerGui:FindFirstChild("FrontEvillGUI")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "FrontEvillGUI"
        screenGui.ResetOnSpawn = false

        if syn then
            syn.protect_gui(screenGui)
            screenGui.Parent = game:GetService("CoreGui")
        elseif gethui and gethui() then
            screenGui.Parent = gethui()
        else
            screenGui.Parent = playerGui
        end
    end
end)

if not screenGui then
    warn("❌ Не удалось создать ScreenGui")
    return
end

-- === Показываем основной GUI ===
local function showCheckpointHub()
    spawn(function()
        wait(0.5) -- Небольшая задержка для стабильности
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "CheckpointHub"
        mainFrame.Size = UDim2.new(0, 420, 0, 500)
        mainFrame.Position = UDim2.new(0.5, -210, 0.5, -250)
        mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        mainFrame.BorderSizePixel = 0
        mainFrame.Visible = false -- Скрыто при старте
        mainFrame.Parent = screenGui
        mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 20)
        uiCorner.Parent = mainFrame

        local uiStroke = Instance.new("UIStroke")
        uiStroke.Color = Color3.fromRGB(255, 0, 0)
        uiStroke.Thickness = 3
        uiStroke.Parent = mainFrame

        local frameGlow = Instance.new("ImageLabel")
        frameGlow.Name = "FrameGlow"
        frameGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
        frameGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
        frameGlow.BackgroundTransparency = 1
        frameGlow.Image = "rbxassetid://5028857084"
        frameGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
        frameGlow.ImageTransparency = 0.7
        frameGlow.ZIndex = -1
        frameGlow.Parent = mainFrame

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Size = UDim2.new(1, 0, 0, 40)
        titleLabel.Position = UDim2.new(0, 0, 0, 20)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        titleLabel.TextSize = 26
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = "Checkpoint System"
        titleLabel.TextXAlignment = Enum.TextXAlignment.Center
        titleLabel.Parent = mainFrame

        local bindLabel = Instance.new("TextButton")
        bindLabel.Name = "BindLabel"
        bindLabel.Size = UDim2.new(1, 0, 0, 30)
        bindLabel.Position = UDim2.new(0, 0, 0, 60)
        bindLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        bindLabel.BorderSizePixel = 0
        bindLabel.Text = "Bind: V"
        bindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        bindLabel.Font = Enum.Font.Gotham
        bindLabel.TextSize = 16
        bindLabel.TextXAlignment = Enum.TextXAlignment.Center
        bindLabel.Parent = mainFrame

        -- === Кнопка перезагрузки ===
        local reloadBtn = Instance.new("TextButton")
        reloadBtn.Name = "ReloadBtn"
        reloadBtn.Size = UDim2.new(0.2, 0, 0, 30)
        reloadBtn.Position = UDim2.new(0.4, 0, 0, 450)
        reloadBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        reloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        reloadBtn.TextSize = 14
        reloadBtn.Font = Enum.Font.Gotham
        reloadBtn.Text = "Reload"
        reloadBtn.TextXAlignment = Enum.TextXAlignment.Center
        reloadBtn.Parent = mainFrame

        local reloadCorner = Instance.new("UICorner")
        reloadCorner.CornerRadius = UDim.new(0, 8)
        reloadCorner.Parent = reloadBtn

        -- === 4 слота ===
        local slots = {}
        for i = 1, 4 do
            local slot = Instance.new("Frame")
            slot.Name = "Slot" .. i
            slot.Size = UDim2.new(0.8, 0, 0, 90)
            slot.Position = UDim2.new(0.1, 0, 0, 100 + (i - 1) * 100)
            slot.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            slot.BorderSizePixel = 2
            slot.BorderColor3 = Color3.fromRGB(255, 0, 0)
            slot.Parent = mainFrame

            local slotCorner = Instance.new("UICorner")
            slotCorner.CornerRadius = UDim.new(0, 12)
            slotCorner.Parent = slot

            -- Название
            local nameBox = Instance.new("TextBox")
            nameBox.Name = "NameBox"
            nameBox.Size = UDim2.new(0.4, -10, 0, 30)
            nameBox.Position = UDim2.new(0.02, 0, 0.1, 0)
            nameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameBox.TextSize = 14
            nameBox.Font = Enum.Font.Gotham
            nameBox.Text = "Slot " .. i
            nameBox.ClearTextOnFocus = false
            nameBox.TextXAlignment = Enum.TextXAlignment.Center
            nameBox.Parent = slot

            -- SAVE
            local saveBtn = Instance.new("TextButton")
            saveBtn.Name = "Save"
            saveBtn.Size = UDim2.new(0.2, 0, 0, 30)
            saveBtn.Position = UDim2.new(0.45, 0, 0.1, 0)
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            saveBtn.TextSize = 14
            saveBtn.Font = Enum.Font.Gotham
            saveBtn.Text = "SAVE"
            saveBtn.TextXAlignment = Enum.TextXAlignment.Center
            saveBtn.Parent = slot

            -- TP
            local tpBtn = Instance.new("TextButton")
            tpBtn.Name = "TP"
            tpBtn.Size = UDim2.new(0.2, 0, 0, 30)
            tpBtn.Position = UDim2.new(0.68, 0, 0.1, 0)
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.TextSize = 14
            tpBtn.Font = Enum.Font.Gotham
            tpBtn.Text = "TP"
            tpBtn.TextXAlignment = Enum.TextXAlignment.Center
            tpBtn.Parent = slot

-- SAVE
            local saveBtn = Instance.new("TextButton")
            saveBtn.Name = "Save"
            saveBtn.Size = UDim2.new(0.2, 0, 0, 30)
            saveBtn.Position = UDim2.new(0.45, 0, 0.1, 0)
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            saveBtn.TextSize = 14
            saveBtn.Font = Enum.Font.Gotham
            saveBtn.Text = "SAVE"
            saveBtn.TextXAlignment = Enum.TextXAlignment.Center
            saveBtn.Parent = slot

            -- TP
            local tpBtn = Instance.new("TextButton")
            tpBtn.Name = "TP"
            tpBtn.Size = UDim2.new(0.2, 0, 0, 30)
            tpBtn.Position = UDim2.new(0.68, 0, 0.1, 0)
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.TextSize = 14
            tpBtn.Font = Enum.Font.Gotham
            tpBtn.Text = "TP"
            tpBtn.TextXAlignment = Enum.TextXAlignment.Center
            tpBtn.Parent = slot

 -- Название
            local nameBox = Instance.new("TextBox")
            nameBox.Name = "NameBox"
            nameBox.Size = UDim2.new(0.4, -10, 0, 30)
            nameBox.Position = UDim2.new(0.02, 0, 0.1, 0)
            nameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameBox.TextSize = 14
            nameBox.Font = Enum.Font.Gotham
            nameBox.Text = "Slot " .. i
            nameBox.ClearTextOnFocus = false
            nameBox.TextXAlignment = Enum.TextXAlignment.Center
            nameBox.Parent = slot

            -- SAVE
            local saveBtn = Instance.new("TextButton")
            saveBtn.Name = "Save"
            saveBtn.Size = UDim2.new(0.2, 0, 0, 30)
            saveBtn.Position = UDim2.new(0.45, 0, 0.1, 0)
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            saveBtn.TextSize = 14
            saveBtn.Font = Enum.Font.Gotham
            saveBtn.Text = "SAVE"
            saveBtn.TextXAlignment = Enum.TextXAlignment.Center
            saveBtn.Parent = slot

            -- TP
            local tpBtn = Instance.new("TextButton")
            tpBtn.Name = "TP"
            tpBtn.Size = UDim2.new(0.2, 0, 0, 30)
            tpBtn.Position = UDim2.new(0.68, 0, 0.1, 0)
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.TextSize = 14
            tpBtn.Font = Enum.Font.Gotham
            tpBtn.Text = "TP"
            tpBtn.TextXAlignment = Enum.TextXAlignment.Center
            tpBtn.Parent = slot

-- SAVE
            local saveBtn = Instance.new("TextButton")
            saveBtn.Name = "Save"
            saveBtn.Size = UDim2.new(0.2, 0, 0, 30)
            saveBtn.Position = UDim2.new(0.45, 0, 0.1, 0)
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            saveBtn.TextSize = 14
            saveBtn.Font = Enum.Font.Gotham
            saveBtn.Text = "SAVE"
            saveBtn.TextXAlignment = Enum.TextXAlignment.Center
            saveBtn.Parent = slot

            -- TP
            local tpBtn = Instance.new("TextButton")
            tpBtn.Name = "TP"
            tpBtn.Size = UDim2.new(0.2, 0, 0, 30)
            tpBtn.Position = UDim2.new(0.68, 0, 0.1, 0)
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.TextSize = 14
            tpBtn.Font = Enum.Font.Gotham
            tpBtn.Text = "TP"
            tpBtn.TextXAlignment = Enum.TextXAlignment.Center
            tpBtn.Parent = slot

            slots[i] = {
                frame = slot,
                nameBox = nameBox,
                saveBtn = saveBtn,
                tpBtn = tpBtn,
                data = nil
            }
        end

        -- === Переменные ===
        local root = nil
        local humanoid = nil
        local currentBind = Enum.KeyCode.V
        local isChangingBind = false

        -- === Функция: найти персонажа ===
        local function updateCharacter()
            local char = player.Character
            if not char then
                char = player.CharacterAdded:Wait()
            end
            char:WaitForChild("HumanoidRootPart", 5)
            char:WaitForChild("Humanoid", 5)
            root = char.HumanoidRootPart
            humanoid = char.Humanoid
            createNotification("🔄 Персонаж перезагружен", 2)
        end

        -- === Перезагрузка (по кнопке) ===
        reloadBtn.MouseButton1Click:Connect(function()
            pcall(updateCharacter)
            createNotification("✅ Персонаж найден", 2)
        end)

        -- Автоматическая перезагрузка при респе
        player.CharacterAdded:Connect(function(char)
            wait(0.1)
            pcall(updateCharacter)
        end)

        -- Инициализация при старте
        pcall(updateCharacter)

        -- === Телепорт ===
        local function tpTo(data)
            if not root or not data then return end

            root.Anchored = true
            humanoid.AutoRotate = false

            root.CFrame = data.cframe
            Camera.CFrame = data.cameraCFrame

            root.AssemblyLinearVelocity = (data.state == Enum.HumanoidStateType.Freefall)
                and Vector3.new(0, -10, 0)
                or Vector3.new(0, 0, 0)

            wait()
            humanoid:ChangeState(data.state)

            spawn(function()
                wait(0.1)
                root.Anchored = false
                humanoid.AutoRotate = true
            end)

            createNotification("✅ Teleported to " .. data.name, 2)
        end

        -- === Обработка кнопок ===
        for i, slot in ipairs(slots) do
            slot.saveBtn.MouseButton1Click:Connect(function()
                if not root or not humanoid then
                    createNotification("❌ Персонаж не найден", 2)
                    return
                end
                local data = {
                    cframe = root.CFrame,
                    cameraCFrame = Camera.CFrame,
                    state = humanoid:GetState(),
                    name = slot.nameBox.Text
                }
                slot.data = data
                createNotification("💾 Saved: " .. data.name, 2)
            end)

            slot.tpBtn.MouseButton1Click:Connect(function()
                if slot.data then
                    tpTo(slot.data)
                else
                    createNotification("❌ No data in slot!", 2)
                end
            end)
        end

        -- === Смена бинда ===
        bindLabel.MouseButton1Click:Connect(function()
            if isChangingBind then return end
            isChangingBind = true
            bindLabel.Text = "Нажмите клавишу..."
            bindLabel.BackgroundColor3 = Color3.fromRGB(200, 100, 100)

            local conn
            conn = UserInputService.InputBegan:Connect(function(input)
                if isChangingBind and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentBind = input.KeyCode
                    bindLabel.Text = "Bind: " .. currentBind.Name
                    bindLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    isChangingBind = false
                    conn:Disconnect()
                end
            end)

            spawn(function()
                wait(10)
                if isChangingBind then
                    bindLabel.Text = "Bind: " .. currentBind.Name
                    bindLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    isChangingBind = false
                    if conn.Connected then conn:Disconnect() end
                end
            end)
        end)

        -- === Открытие/закрытие через V ===
        UserInputService.InputBegan:Connect(function(input)
            if isChangingBind then return end
            if input.KeyCode == currentBind then
                mainFrame.Visible = not mainFrame.Visible
            end
        end)

        -- === Перетаскивание GUI ===
        local dragging = false
        local dragStart = nil
        local startPos = nil

        local function updateInput(input)
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        titleLabel.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    updateInput(input)
                end
            end
        end)

        -- === Анимации ===
        spawn(function()
            while frameGlow.Parent do
                TweenService:Create(frameGlow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.5, Size = UDim2.new(1.12, 0, 1.12, 0)}):Play()
                wait(2.5)
                TweenService:Create(frameGlow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.8, Size = UDim2.new(1.08, 0, 1.08, 0)}):Play()
                wait(2.5)
            end
        end)

        -- Показываем GUI после 0.5 сек (чтобы не было конфликтов)
        wait(0.5)
        mainFrame.Visible = true
        createNotification("🔥 Checkpoint Hub Loaded!", 3)
    end)
end

-- Запуск через 1 секунду
task.spawn(function()
    task.wait(1)
    pcall(showCheckpointHub)
end)
