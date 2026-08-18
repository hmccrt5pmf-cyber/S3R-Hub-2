local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer

-- إنشاء الشاشة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "S3R_BerserkModern_UI"
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui or player:WaitForChild("PlayerGui")
end

-- النافذة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 380)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(245, 175, 55)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

-- خلفية الصورة
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "MangaBackground"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.ScaleType = Enum.ScaleType.Fit
BackgroundImage.Parent = MainFrame

local ImageCorner = Instance.new("UICorner")
ImageCorner.CornerRadius = UDim.new(0, 12)
ImageCorner.Parent = BackgroundImage

-- تحميل الصورة لمشغل Delta
task.spawn(function()
    local imageUrl = "https://i.imgur.com/YOUR_NEW_IMAGE.png" 
    
    if writefile and getcustomasset then
        local filename = "S3R_Berserk_Panels.png"
        if not isfile(filename) then
            local success, response = pcall(function()
                return game:HttpGet(imageUrl)
            end)
            if success then
                writefile(filename, response)
            end
        end
        if isfile(filename) then
            BackgroundImage.Image = getcustomasset(filename)
        end
    else
        BackgroundImage.Image = "rbxassetid://YOUR_DECID_HERE"
    end
end)

-- زر الإغلاق ✕
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0, 8)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 5
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- حاوية التحكم
local ControlsFrame = Instance.new("Frame")
ControlsFrame.Size = UDim2.new(1, 0, 1, 0)
ControlsFrame.BackgroundTransparency = 1
ControlsFrame.ZIndex = 3
ControlsFrame.Parent = MainFrame

local function createModernToggle(positionY, textTitle)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -28, 0, 44)
    Card.Position = UDim2.new(0, 14, 0, positionY)
    Card.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Card.BackgroundTransparency = 0.55
    Card.BorderSizePixel = 0
    Card.ZIndex = 4
    Card.Parent = ControlsFrame

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Text = textTitle
    Label.TextColor3 = Color3.fromRGB(240, 240, 245)
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.ZIndex = 4
    Label.Parent = Card

    local SwitchBtn = Instance.new("TextButton")
    SwitchBtn.Size = UDim2.new(0, 46, 0, 22)
    SwitchBtn.Position = UDim2.new(1, -56, 0.5, -11)
    SwitchBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    SwitchBtn.Text = ""
    SwitchBtn.BorderSizePixel = 0
    SwitchBtn.ZIndex = 4
    SwitchBtn.Parent = Card

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBtn

    local SwitchDot = Instance.new("Frame")
    SwitchDot.Size = UDim2.new(0, 16, 0, 16)
    SwitchDot.Position = UDim2.new(0, 3, 0.5, -8)
    SwitchDot.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
    SwitchDot.BorderSizePixel = 0
    SwitchDot.ZIndex = 5
    SwitchDot.Parent = SwitchBtn

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = SwitchDot

    return SwitchBtn, SwitchDot
end

local StaminaSwitch, StaminaDot = createModernToggle(180, "AUTO STAMINA FARM")
local JumpSwitch, JumpDot = createModernToggle(232, "AUTO JUMP FARM (13)")

-- حقوق S3R Dev
local AuthorRights = Instance.new("TextLabel")
AuthorRights.Size = UDim2.new(1, 0, 0, 20)
AuthorRights.Position = UDim2.new(0, 0, 1, -24)
AuthorRights.Text = "By: S3R Dev  |  All Rights Reserved ©"
AuthorRights.TextColor3 = Color3.fromRGB(245, 175, 55)
AuthorRights.TextSize = 11
AuthorRights.Font = Enum.Font.GothamBold
AuthorRights.BackgroundTransparency = 1
AuthorRights.ZIndex = 4
AuthorRights.Parent = ControlsFrame

-- زر الترس الدائري
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "S3R_CircleToggle"
ToggleButton.Size = UDim2.new(0, 42, 0, 42)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -21)
ToggleButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "⚙️"
ToggleButton.TextSize = 20
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(245, 175, 55)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==========================================
-- ** الأنظمة البرمجية **
-- ==========================================

local isStaminaFarming = false
local isJumpFarming = false

local function pressKey(keyCode)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
end

local function releaseKey(keyCode)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

-- 1. Stamina Farm
task.spawn(function()
    while true do
        if isStaminaFarming then
            pressKey(Enum.KeyCode.LeftShift)
            local keys = {Enum.KeyCode.W, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.A}

            for _, key in ipairs(keys) do
                if not isStaminaFarming then break end
                pressKey(key)
                
                local elapsed = 0
                while elapsed < 2.5 and isStaminaFarming do
                    task.wait(0.1)
                    elapsed = elapsed + 0.1
                end
                
                releaseKey(key)
            end

            releaseKey(Enum.KeyCode.LeftShift)

            if isStaminaFarming then
                local restTime = 0
                while restTime < 7 and isStaminaFarming do
                    task.wait(0.1)
                    restTime = restTime + 0.1
                end
            end
        else
            task.wait(0.5)
        end
    end
end)

-- 2. Auto Jump Farm (يظل ضاغط زر النط بدون ما يفكه طوال الـ 13 قفزة)
task.spawn(function()
    while true do
        if isJumpFarming then
            -- الضغط الاستمراري على زر Space
            pressKey(Enum.KeyCode.Space)
            
            -- الانتظار طوال فترة الـ 13 قفزة (حوالي 6.5 ثانية)
            local elapsed = 0
            while elapsed < 6.5 and isJumpFarming do
                task.wait(0.1)
                elapsed = elapsed + 0.1
            end
            
            -- فك الضغط عن زر Space لبدء الاستراحة
            releaseKey(Enum.KeyCode.Space)

            if isJumpFarming then
                local restTime = 0
                while restTime < 7 and isJumpFarming do
                    task.wait(0.1)
                    restTime = restTime + 0.1
                end
            end
        else
            task.wait(0.5)
        end
    end
end)

local function updateSwitchUI(switchBtn, switchDot, state)
    if state then
        switchBtn.BackgroundColor3 = Color3.fromRGB(245, 175, 55)
        switchDot.Position = UDim2.new(1, -19, 0.5, -8)
        switchDot.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    else
        switchBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        switchDot.Position = UDim2.new(0, 3, 0.5, -8)
        switchDot.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
    end
end

StaminaSwitch.MouseButton1Click:Connect(function()
    isStaminaFarming = not isStaminaFarming
    updateSwitchUI(StaminaSwitch, StaminaDot, isStaminaFarming)
    if not isStaminaFarming then
        releaseKey(Enum.KeyCode.LeftShift)
        releaseKey(Enum.KeyCode.W)
        releaseKey(Enum.KeyCode.S)
        releaseKey(Enum.KeyCode.D)
        releaseKey(Enum.KeyCode.A)
    end
end)

JumpSwitch.MouseButton1Click:Connect(function()
    isJumpFarming = not isJumpFarming
    updateSwitchUI(JumpSwitch, JumpDot, isJumpFarming)
    if not isJumpFarming then
        releaseKey(Enum.KeyCode.Space)
    end
end)
