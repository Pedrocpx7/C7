local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 1. CONFIGURAÇÕES
-- ==========================================
local Settings = {
    KillAuraEnabled = false,
    Aimbot360Enabled = false,
    VisibilityCheck = false,
    FriendCheck = true,
    AdminCheck = true,
    ShowFOV = true,
    FOV = 1000,
    Distance = 1000,
    KillAuraDelay = 0,

    -- Auto Equip (só age enquanto Kill Aura estiver ativo)
    AutoEquipEnabled = false,
    AutoEquipInterval = 0.1,
    MelhorArma = "Fuzil",

    -- Predição
    PredictionEnabled = false,
    PredictionTime = 0.10,

    -- Burst
    BurstEnabled = false,
    BurstCount = 3,
    BurstInterval = 0.04,

    -- Turbo
    TurboEnabled = true,
    TurboShots = 8,

    -- Desync (só age enquanto Kill Aura estiver ativo)
    DesyncEnabled = false,
    DesyncAmount = 2,

    -- Headless
    HeadlessEnabled = false,
    HeadlessDropDistance = 500,
    HeadlessState = nil,
}

local Keybinds = {
    KillAura = Enum.KeyCode.K,
    Aimbot360 = Enum.KeyCode.L,
    AutoEquip = Enum.KeyCode.J,
    Prediction = Enum.KeyCode.P,
    Burst = Enum.KeyCode.B,
    Turbo = Enum.KeyCode.T,
    Headless = Enum.KeyCode.H,
    Panic = Enum.KeyCode.End,
}

local Toggles = {} -- declarado cedo pra setKillAura poder sincronizar os visuais

-- ==========================================
-- 2. ESTADO DO KILL AURA (com sincronização)
-- ==========================================
local function setKillAura(value, source)
    if Settings.KillAuraEnabled == value then return end
    Settings.KillAuraEnabled = value

    if not value then
        -- Desync não tem efeito algum sem Kill Aura, então o toggle visual
        -- precisa acompanhar, senão fica "bugado" mostrando ligado à toa.
        if Settings.DesyncEnabled then
            Settings.DesyncEnabled = false
            if Toggles.Desync then Toggles.Desync.Set(false) end
        end
    end
end

-- ==========================================
-- 3. CACHE DE JOGADORES
-- ==========================================
local PlayerCache = {}
local PlayerList = {}

local function addPlayer(player)
    if player == LocalPlayer or PlayerCache[player] then return end
    local entry = { IsFriend = false, IsAdmin = false, Ready = false }
    PlayerCache[player] = entry
    table.insert(PlayerList, player)

    task.spawn(function()
        local okFriend, isFriend = pcall(function() return LocalPlayer:IsFriendsWith(player.UserId) end)
        entry.IsFriend = (okFriend and isFriend) and true or false
        local okRank, rank = pcall(function() return player:GetRankInGroup(game.CreatorId) end)
        entry.IsAdmin = (okRank and rank and rank >= 254) and true or false
        entry.Ready = true
    end)
end

local function removePlayer(player)
    if not PlayerCache[player] then return end
    PlayerCache[player] = nil
    local idx = table.find(PlayerList, player)
    if idx then table.remove(PlayerList, idx) end
end

for _, p in ipairs(Players:GetPlayers()) do addPlayer(p) end
Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

-- ==========================================
-- 4. BUSCA DOS MÓDULOS E REMOTES
-- ==========================================
local WeaponRaycastController = nil
local InventoryRemotes = ReplicatedStorage:WaitForChild("InventoryRemotes")
local InvActionEvt = InventoryRemotes:WaitForChild("InvActionEvt")

local hookedModules = setmetatable({}, { __mode = "k" })

local function resolveModule()
    local possiblePaths = {
        "Stuff.GunSys.Framework.WeaponRaycastController",
        "GunSys.Framework.WeaponRaycastController",
        "OrpheusShared.GunSys.Framework.WeaponRaycastController",
        "WeaponRaycastController"
    }
    for _, path in ipairs(possiblePaths) do
        local success, result = pcall(function()
            local current = ReplicatedStorage
            for part in string.gmatch(path, "[^%.]+") do
                current = current:FindFirstChild(part)
                if not current then return nil end
            end
            if current then return require(current) end
        end)
        if success and result and result.RaycastaGun then
            return result
        end
    end
    local success, result = pcall(function()
        local found = ReplicatedStorage:FindFirstChild("WeaponRaycastController", true)
        if found and found:IsA("ModuleScript") then return require(found) end
    end)
    if success and result and result.RaycastaGun then
        return result
    end
    return nil
end

-- ==========================================
-- 5. LÓGICA DE ALVO (KILL AURA)
-- ==========================================
local function isFriendOrAdmin(player)
    local entry = PlayerCache[player]
    if not entry then return false end
    if Settings.FriendCheck and entry.IsFriend then return true end
    if Settings.AdminCheck and entry.IsAdmin then return true end
    return false
end

local function hasLineOfSight(camera, targetPart)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character, targetPart.Parent }
    local origin = camera.CFrame.Position
    local dir = targetPart.Position - origin
    local ray = Workspace:Raycast(origin, dir, params)
    return ray == nil
end

local function isTargetDead(char, humanoid)
    if not humanoid or humanoid.Health <= 0 then return true end
    local bodyEffects = char:FindFirstChild("BodyEffects")
    if bodyEffects then
        local ko = bodyEffects:FindFirstChild("K.O")
        if ko and ko:IsA("BoolValue") and ko.Value == true then return true end
        local dead = bodyEffects:FindFirstChild("Dead")
        if dead and dead:IsA("BoolValue") and dead.Value == true then return true end
    end
    return false
end

local function getAimPosition(targetPart)
    local pos = targetPart.Position
    if Settings.PredictionEnabled then
        local root = targetPart.Parent and targetPart.Parent:FindFirstChild("HumanoidRootPart")
        if root then
            pos = pos + (root.AssemblyLinearVelocity * Settings.PredictionTime)
        end
    end
    return pos
end

local function findTarget(camera)
    local closest = nil

    if Settings.Aimbot360Enabled then
        local shortestDist3D = Settings.Distance
        for _, player in ipairs(PlayerList) do
            local char = player.Character
            if char and not isFriendOrAdmin(player) then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if not isTargetDead(char, humanoid) then
                    local targetPart = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                    if targetPart then
                        local aimPos = getAimPosition(targetPart)
                        local d = (aimPos - camera.CFrame.Position).Magnitude
                        if d <= shortestDist3D then
                            if not Settings.VisibilityCheck or hasLineOfSight(camera, targetPart) then
                                shortestDist3D = d
                                closest = targetPart
                            end
                        end
                    end
                end
            end
        end
        return closest
    end

    local screenCenter = camera.ViewportSize / 2
    local shortestDist = Settings.FOV

    for _, player in ipairs(PlayerList) do
        local char = player.Character
        if char and not isFriendOrAdmin(player) then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if not isTargetDead(char, humanoid) then
                local targetPart = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    local aimPos = getAimPosition(targetPart)
                    local distanceToPlayer = (aimPos - camera.CFrame.Position).Magnitude
                    if distanceToPlayer <= Settings.Distance then
                        local screenPos, onScreen = camera:WorldToViewportPoint(aimPos)
                        if onScreen and screenPos.Z > 0 then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                            if dist < shortestDist then
                                if not Settings.VisibilityCheck or hasLineOfSight(camera, targetPart) then
                                    shortestDist = dist
                                    closest = targetPart
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- ==========================================
-- 6. HOOK (SILENT AIM) + RE-HOOK  —  INTOCADO
--    (a manutenção automática continua: só o botão manual na UI saiu)
-- ==========================================
local function installHook(module)
    if not module or not module.RaycastaGun then return false end
    if hookedModules[module] then return false end

    local oldRaycastaGun = module.RaycastaGun

    module.RaycastaGun = function(self, ...)
        if Settings.KillAuraEnabled then
            local camera = self.Camera or Workspace.CurrentCamera
            if camera then
                local targetPart = findTarget(camera)
                if targetPart then
                    local origin = camera.CFrame.Position
                    local aimPos = getAimPosition(targetPart)
                    local dir = (aimPos - origin).Unit
                    -- Retorno mantido idêntico para não quebrar o silent aim
                    return self:ProcessHit(targetPart), aimPos, (origin - aimPos).Unit, dir
                end
            end
        end
        return oldRaycastaGun(self, ...)
    end

    hookedModules[module] = true
    return true
end

local function rehook()
    local module = resolveModule()
    if not module then return false end
    WeaponRaycastController = module
    if hookedModules[module] then return true end
    return installHook(module)
end

task.spawn(function()
    for attempt = 1, 10 do
        if rehook() then return end
        task.wait(1)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    rehook()
end)

-- ==========================================
-- 7. KILL AURA + BURST + TURBO + DESYNC (LOOP)
--    Desync continua preso ao mesmo "if not Settings.KillAuraEnabled then
--    return end" lá em cima — fisicamente não roda sem Kill Aura.
-- ==========================================
local lastShootTime = 0
local isBursting = false

local function fireOnce(tool)
    pcall(function() mouse1click() end)
    pcall(function() tool:Activate() end)
end

local function shoot(tool)
    if Settings.BurstEnabled then
        if isBursting then return end
        isBursting = true
        task.spawn(function()
            for i = 1, Settings.BurstCount do
                local char = LocalPlayer.Character
                local currentTool = char and char:FindFirstChildOfClass("Tool")
                if not Settings.KillAuraEnabled or not currentTool then break end
                fireOnce(currentTool)
                if i < Settings.BurstCount then
                    task.wait(Settings.BurstInterval)
                end
            end
            isBursting = false
        end)
    else
        fireOnce(tool)
    end
end

RunService.RenderStepped:Connect(function()
    if not Settings.KillAuraEnabled then return end

    local cam = Workspace.CurrentCamera
    if not cam then return end

    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hum then return end

    -- DESYNC
    if Settings.DesyncEnabled then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local a = Settings.DesyncAmount
            root.CFrame = root.CFrame * CFrame.new(math.random(-a, a), 0, math.random(-a, a))
        end
    end

    -- AUTO SHOOT
    local targetPart = findTarget(cam)
    if targetPart then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            if Settings.TurboEnabled then
                for i = 1, Settings.TurboShots do
                    fireOnce(tool)
                end
                lastShootTime = tick()
            elseif tick() - lastShootTime >= Settings.KillAuraDelay then
                lastShootTime = tick()
                shoot(tool)
            end
        end
    end
end)

-- ==========================================
-- 7B. AUTO EQUIP — agora SÓ roda com Kill Aura ativo, de propósito
-- ==========================================
local equipRequestPending = false
local lastEquipRemoteCall = 0

RunService.Heartbeat:Connect(function()
    if not Settings.KillAuraEnabled then return end
    if not Settings.AutoEquipEnabled or Settings.MelhorArma == "" then return end

    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not char or not hum or not backpack then return end

    if char:FindFirstChild(Settings.MelhorArma) then return end

    local arma = backpack:FindFirstChild(Settings.MelhorArma)
    if arma then
        pcall(function() hum:EquipTool(arma) end)
        return
    end

    if equipRequestPending then return end
    local now = tick()
    if now - lastEquipRemoteCall < Settings.AutoEquipInterval then return end
    lastEquipRemoteCall = now
    equipRequestPending = true
    task.spawn(function()
        pcall(function()
            InvActionEvt:InvokeServer("semespacoinv", Settings.MelhorArma, nil, 1)
        end)
        equipRequestPending = false
    end)
end)

-- ==========================================
-- 7C. HEADLESS — quebra o Motor6D de verdade e move o Head real por física
--     (lembrete: só pode replicar pra outros clientes se a rede permitir;
--     não funciona contra aimbots que caem pro HumanoidRootPart)
-- ==========================================
local function findRig(char)
    local torso = char:FindFirstChild("Torso")
    local neck = torso and torso:FindFirstChild("Neck")
    if neck and neck:IsA("Motor6D") then
        return torso, neck
    end

    local upperTorso = char:FindFirstChild("UpperTorso")
    neck = upperTorso and upperTorso:FindFirstChild("Neck")
    if neck and neck:IsA("Motor6D") then
        return upperTorso, neck
    end

    return nil, nil
end

local function goHeadless(char)
    local torso, neck = findRig(char)
    local head = char:FindFirstChild("Head")
    if not torso or not neck or not head then return nil end

    local state = {
        torso = torso,
        neck = neck,
        head = head,
        neckPart0 = neck.Part0,
        neckPart1 = neck.Part1,
        neckC0 = neck.C0,
        neckC1 = neck.C1,
        headCanCollide = head.CanCollide,
        headAnchored = head.Anchored,
        headMassless = head.Massless,
    }

    neck.Part0 = nil
    neck.Part1 = nil

    head.CanCollide = false
    head.Massless = true
    head.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    head.CFrame = torso.CFrame * CFrame.new(0, -Settings.HeadlessDropDistance, 0)

    return state
end

local function undoHeadless(state)
    if not state then return end
    local neck, head, torso = state.neck, state.head, state.torso

    if head and head.Parent then
        head.CanCollide = state.headCanCollide
        head.Massless = state.headMassless
        head.Anchored = state.headAnchored
    end

    if neck and neck.Parent then
        neck.Part0 = state.neckPart0
        neck.Part1 = state.neckPart1
        neck.C0 = state.neckC0
        neck.C1 = state.neckC1
    end

    if head and torso and head.Parent and torso.Parent then
        head.CFrame = torso.CFrame * CFrame.new(0, 1.5, 0)
    end
end

local function setHeadless(enabled)
    Settings.HeadlessEnabled = enabled
    local char = LocalPlayer.Character
    if not char then return end

    if enabled then
        if not Settings.HeadlessState then
            Settings.HeadlessState = goHeadless(char)
        end
    else
        undoHeadless(Settings.HeadlessState)
        Settings.HeadlessState = nil
    end
end

RunService.Heartbeat:Connect(function()
    if not Settings.HeadlessEnabled then return end
    local state = Settings.HeadlessState
    if not state or not state.head or not state.head.Parent then return end
    local head, torso = state.head, state.torso
    if not torso or not torso.Parent then return end

    local desired = torso.CFrame * CFrame.new(0, -Settings.HeadlessDropDistance, 0)
    if (head.Position - desired.Position).Magnitude > 2 then
        head.CFrame = desired
        head.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    Settings.HeadlessState = nil
    if Settings.HeadlessEnabled then
        task.wait(0.5)
        setHeadless(true)
    end
end)

-- ==========================================
-- 8. FOV E TRACER
-- ==========================================
local DrawGui = Instance.new("ScreenGui")
DrawGui.Name = "KarpaDrawGui"
DrawGui.ResetOnSpawn = false
DrawGui.IgnoreGuiInset = true
pcall(function() DrawGui.Parent = game:GetService("CoreGui") end)
if not DrawGui.Parent then DrawGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local fovFrame = Instance.new("Frame")
fovFrame.BackgroundTransparency = 1
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.fromScale(0.5, 0.5)
fovFrame.Visible = false
fovFrame.Parent = DrawGui
Instance.new("UICorner", fovFrame).CornerRadius = UDim.new(1, 0)
local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 1.5
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Parent = fovFrame

local tracerLine = Instance.new("Frame")
tracerLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
tracerLine.BorderSizePixel = 0
tracerLine.Visible = false
tracerLine.AnchorPoint = Vector2.new(0.5, 0.5)
tracerLine.Parent = DrawGui

RunService.RenderStepped:Connect(function()
    local cam = Workspace.CurrentCamera
    if not cam then return end

    if Settings.KillAuraEnabled and Settings.ShowFOV and not Settings.Aimbot360Enabled then
        fovFrame.Size = UDim2.fromOffset(Settings.FOV * 2, Settings.FOV * 2)
        fovFrame.Visible = true
    else
        fovFrame.Visible = false
    end

    if Settings.KillAuraEnabled then
        local targetPart = findTarget(cam)
        if targetPart then
            local aimPos = getAimPosition(targetPart)
            local screenPos, onScreen = cam:WorldToViewportPoint(aimPos)
            if onScreen and screenPos.Z > 0 then
                local startPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                local endPos = Vector2.new(screenPos.X, screenPos.Y)
                local delta = endPos - startPos
                local dist = delta.Magnitude
                local angle = math.deg(math.atan2(delta.Y, delta.X))
                local midPoint = startPos + (delta / 2)
                tracerLine.Position = UDim2.fromOffset(midPoint.X, midPoint.Y)
                tracerLine.Size = UDim2.fromOffset(dist, 2)
                tracerLine.Rotation = angle
                tracerLine.Visible = true
            else
                tracerLine.Visible = false
            end
        else
            tracerLine.Visible = false
        end
    else
        tracerLine.Visible = false
    end
end)

-- ==========================================
-- 9. UI
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KarpaKillAuraUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -280)
MainFrame.Size = UDim2.new(0, 300, 0, 560)
local function fitMobile()
    local viewport = Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize or Vector2.new(800, 600)
    MainFrame.Size = UDim2.fromOffset(math.min(340, math.max(250, viewport.X - 24)), math.min(560, math.max(260, viewport.Y - 36)))
    MainFrame.Position = UDim2.fromOffset(math.max(12, (viewport.X - MainFrame.AbsoluteSize.X) / 2), math.max(12, (viewport.Y - MainFrame.AbsoluteSize.Y) / 2))
end
task.defer(fitMobile)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(60, 60, 60)
UIStroke.Thickness = 1

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Kill Aura TURBO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UIPadding", Title).PaddingLeft = UDim.new(0, 15)

local Divider = Instance.new("Frame")
Divider.Parent = MainFrame
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Divider.BorderSizePixel = 0
Divider.Position = UDim2.new(0, 0, 0, 40)
Divider.Size = UDim2.new(1, 0, 0, 1)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.BackgroundTransparency = 1
Scroll.Position = UDim2.new(0, 0, 0, 45)
Scroll.Size = UDim2.new(1, 0, 1, -70)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollBarThickness = 6
Scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.ScrollingEnabled = true
Scroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable

local UIListLayout = Instance.new("UIListLayout", Scroll)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local scrollPadding = Instance.new("UIPadding", Scroll)
scrollPadding.PaddingTop = UDim.new(0, 5)
scrollPadding.PaddingBottom = UDim.new(0, 10)

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end)

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Parent = MainFrame
KeyLabel.BackgroundTransparency = 1
KeyLabel.Position = UDim2.new(0, 0, 1, -22)
KeyLabel.Size = UDim2.new(1, 0, 0, 18)
KeyLabel.Font = Enum.Font.Gotham
KeyLabel.Text = "K=Aura L=360 J=Equip P=Pred B=Burst T=Turbo H=Headless | END=PANIC"
KeyLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
KeyLabel.TextSize = 9
KeyLabel.TextXAlignment = Enum.TextXAlignment.Center

local function CreateToggle(text, layoutOrder, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = Scroll
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.LayoutOrder = layoutOrder
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = Frame
    ToggleBtn.AnchorPoint = Vector2.new(1, 0.5)
    ToggleBtn.Position = UDim2.new(1, 0, 0.5, 0)
    ToggleBtn.Size = UDim2.new(0, 45, 0, 22)
    ToggleBtn.BackgroundColor3 = default and Color3.fromRGB(60, 120, 255) or Color3.fromRGB(50, 50, 50)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Text = ""
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    local Circle = Instance.new("Frame", ToggleBtn)
    Circle.AnchorPoint = Vector2.new(0.5, 0.5)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = default and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
    local state = default

    local function apply(newState)
        state = newState
        if state then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
            Circle:TweenPosition(UDim2.new(0.75, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Circle:TweenPosition(UDim2.new(0.25, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1)
        end
        callback(state)
    end
    ToggleBtn.MouseButton1Click:Connect(function() apply(not state) end)
    return { Set = apply, Get = function() return state end }
end

local function CreateSlider(text, layoutOrder, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = Scroll
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, -10, 0, 45)
    Frame.LayoutOrder = layoutOrder
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.5, 0, 0, 20)
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    local ValLabel = Instance.new("TextLabel")
    ValLabel.Parent = Frame
    ValLabel.AnchorPoint = Vector2.new(1, 0)
    ValLabel.Position = UDim2.new(1, 0, 0, 0)
    ValLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ValLabel.Size = UDim2.new(0, 45, 0, 20)
    ValLabel.Font = Enum.Font.Gotham
    ValLabel.Text = tostring(default)
    ValLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ValLabel.TextSize = 12
    Instance.new("UICorner", ValLabel).CornerRadius = UDim.new(0, 4)
    local SliderBg = Instance.new("Frame")
    SliderBg.Parent = Frame
    SliderBg.Position = UDim2.new(0, 0, 0, 30)
    SliderBg.Size = UDim2.new(1, 0, 0, 6)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBg.BorderSizePixel = 0
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)
    local Fill = Instance.new("Frame")
    Fill.Parent = SliderBg
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    local SliderBtn = Instance.new("TextButton")
    SliderBtn.Parent = Frame
    SliderBtn.Position = UDim2.new(0, 0, 0, 27)
    SliderBtn.Size = UDim2.new(1, 0, 0, 12)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""
    local dragging = false
    local activeTouch = nil
    local function updateFromX(x)
        local width = SliderBg.AbsoluteSize.X
        if width <= 0 then return end
        local relX = math.clamp((x - SliderBg.AbsolutePosition.X) / width, 0, 1)
        local value = min + (max - min) * relX
        if max - min >= 10 then value = math.floor(value) end
        Fill.Size = UDim2.new(relX, 0, 1, 0)
        ValLabel.Text = tostring(value)
        callback(value)
    end
    SliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            activeTouch = input
            dragging = true
            updateFromX(input.Position.X)
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateFromX(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input == activeTouch or (not activeTouch and input.UserInputType == Enum.UserInputType.MouseMovement) then
            updateFromX(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input == activeTouch then
            activeTouch = nil
            dragging = false
        elseif not activeTouch and input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local function CreateTextbox(text, layoutOrder, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = Scroll
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, -10, 0, 50)
    Frame.LayoutOrder = layoutOrder
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    local Box = Instance.new("TextBox")
    Box.Parent = Frame
    Box.Position = UDim2.new(0, 0, 0, 20)
    Box.Size = UDim2.new(1, 0, 0, 26)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Box.BorderSizePixel = 0
    Box.Font = Enum.Font.Gotham
    Box.PlaceholderText = "Nome EXATO da arma (ex: FuzilNinja)"
    Box.Text = default
    Box.TextColor3 = Color3.fromRGB(230, 230, 230)
    Box.TextSize = 13
    Box.ClearTextOnFocus = false
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
    Box.FocusLost:Connect(function()
        callback(Box.Text)
    end)
    return Box
end

Toggles.KillAura = CreateToggle("KILL AURA (Silent + Auto Shoot) [K]", 1, Settings.KillAuraEnabled, function(state)
    setKillAura(state, "toggle GUI")
end)
Toggles.Aimbot360 = CreateToggle("MODO 360° (ignora FOV) [L]", 2, Settings.Aimbot360Enabled, function(state) Settings.Aimbot360Enabled = state end)
Toggles.AutoEquip = CreateToggle("AUTO EQUIP (só com Kill Aura) [J]", 3, Settings.AutoEquipEnabled, function(state) Settings.AutoEquipEnabled = state end)
CreateTextbox("Nome da arma (Auto Equip)", 4, Settings.MelhorArma, function(text)
    Settings.MelhorArma = text
    print("[Karpa] Auto Equip agora mira: " .. tostring(text))
end)

Toggles.Turbo = CreateToggle("TURBO (ignora delay, spam por frame) [T]", 5, Settings.TurboEnabled, function(state) Settings.TurboEnabled = state end)
CreateSlider("Tiros por frame (Turbo)", 6, 1, 50, Settings.TurboShots, function(val) Settings.TurboShots = val end)
CreateSlider("Delay do Kill Aura (ms, só sem Turbo)", 7, 0, 500, Settings.KillAuraDelay * 1000, function(val) Settings.KillAuraDelay = val / 1000 end)
CreateSlider("Distância do alvo", 8, 50, 99999, Settings.Distance, function(val) Settings.Distance = val end)
CreateSlider("FOV (Tamanho do Círculo)", 9, 10, 9999, Settings.FOV, function(val) Settings.FOV = val end)

Toggles.ShowFOV = CreateToggle("Mostrar FOV", 10, Settings.ShowFOV, function(state) Settings.ShowFOV = state end)
Toggles.Visibility = CreateToggle("Visibility Check", 11, Settings.VisibilityCheck, function(state) Settings.VisibilityCheck = state end)
Toggles.Friend = CreateToggle("Friend Check", 12, Settings.FriendCheck, function(state) Settings.FriendCheck = state end)
Toggles.Admin = CreateToggle("Admin / Staff Check", 13, Settings.AdminCheck, function(state) Settings.AdminCheck = state end)

Toggles.Prediction = CreateToggle("PREDIÇÃO (Mira futura) [P]", 14, Settings.PredictionEnabled, function(state) Settings.PredictionEnabled = state end)
CreateSlider("Lead da predição (ms)", 15, 10, 300, Settings.PredictionTime * 1000, function(val) Settings.PredictionTime = val / 1000 end)

Toggles.Burst = CreateToggle("BURST (só se Turbo desligado) [B]", 16, Settings.BurstEnabled, function(state) Settings.BurstEnabled = state end)
CreateSlider("Qtd. do Burst", 17, 2, 50, Settings.BurstCount, function(val) Settings.BurstCount = val end)
CreateSlider("Intervalo do Burst (ms)", 18, 5, 200, Settings.BurstInterval * 1000, function(val) Settings.BurstInterval = val / 1000 end)

Toggles.Desync = CreateToggle("DESYNC (só com Kill Aura)", 19, Settings.DesyncEnabled, function(state)
    if state and not Settings.KillAuraEnabled then
        Toggles.Desync.Set(false)
        return
    end
    Settings.DesyncEnabled = state
end)
CreateSlider("Desync Força", 20, 1, 15, Settings.DesyncAmount, function(val) Settings.DesyncAmount = val end)

Toggles.Headless = CreateToggle("HEADLESS (quebra junta + joga a cabeça longe) [H]", 21, Settings.HeadlessEnabled, function(state)
    setHeadless(state)
end)
CreateSlider("Distância que a cabeça vai (studs)", 22, 50, 2000, Settings.HeadlessDropDistance, function(val)
    Settings.HeadlessDropDistance = val
end)

-- Sem botões de utilidade adicionais

local RageButton = Instance.new("TextButton")
RageButton.Parent = Scroll
RageButton.LayoutOrder = 23
RageButton.Size = UDim2.new(1, -10, 0, 36)
RageButton.BackgroundColor3 = Color3.fromRGB(70, 20, 20)
RageButton.BorderSizePixel = 0
RageButton.Font = Enum.Font.GothamBold
RageButton.Text = "🔥 RAGE MODE (liga tudo no talo) 🔥"
RageButton.TextColor3 = Color3.fromRGB(255, 220, 220)
RageButton.TextSize = 13
Instance.new("UICorner", RageButton).CornerRadius = UDim.new(0, 6)

RageButton.MouseButton1Click:Connect(function()
    setKillAura(true, "RAGE MODE")
    Toggles.KillAura.Set(true)

    Settings.Aimbot360Enabled = true
    Settings.VisibilityCheck = false
    Settings.Distance = 99999
    Settings.FOV = 9999
    Settings.KillAuraDelay = 0
    Settings.TurboEnabled = true
    Settings.TurboShots = 50
    Settings.BurstEnabled = true
    Settings.BurstCount = 50
    Settings.BurstInterval = 0.005
    Settings.PredictionEnabled = true
    Settings.PredictionTime = 0.3
    Settings.DesyncEnabled = true
    Settings.DesyncAmount = 15
    Settings.AutoEquipEnabled = true

    Toggles.Aimbot360.Set(true)
    Toggles.Turbo.Set(true)
    Toggles.Burst.Set(true)
    Toggles.Prediction.Set(true)
    Toggles.Desync.Set(true)
    Toggles.AutoEquip.Set(true)
    Toggles.Headless.Set(true)

    print("[Karpa] RAGE MODE ativado — tudo no máximo")
end)

-- Controle de emergência acessível por toque no Android.
local PanicButton = Instance.new("TextButton")
PanicButton.Name = "MobilePanic"
PanicButton.Parent = ScreenGui
PanicButton.AnchorPoint = Vector2.new(1, 1)
PanicButton.Position = UDim2.new(1, -16, 1, -16)
PanicButton.Size = UDim2.fromOffset(108, 42)
PanicButton.BackgroundColor3 = Color3.fromRGB(130, 35, 35)
PanicButton.TextColor3 = Color3.new(1, 1, 1)
PanicButton.Font = Enum.Font.GothamBold
PanicButton.TextSize = 13
PanicButton.Text = "DESATIVAR"
Instance.new("UICorner", PanicButton).CornerRadius = UDim.new(0, 8)
PanicButton.Activated:Connect(function()
    Toggles.KillAura.Set(false)
    if Toggles.Headless then Toggles.Headless.Set(false) end
end)

-- ==========================================
-- 10. KEYBINDS
-- ==========================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if UserInputService:GetFocusedTextBox() then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    if input.KeyCode == Keybinds.Panic then
        Toggles.KillAura.Set(false)
        return
    end

    if input.KeyCode == Keybinds.KillAura then
        Toggles.KillAura.Set(not Settings.KillAuraEnabled)
    elseif input.KeyCode == Keybinds.Aimbot360 then
        Toggles.Aimbot360.Set(not Settings.Aimbot360Enabled)
    elseif input.KeyCode == Keybinds.AutoEquip then
        Toggles.AutoEquip.Set(not Settings.AutoEquipEnabled)
    elseif input.KeyCode == Keybinds.Prediction then
        Toggles.Prediction.Set(not Settings.PredictionEnabled)
    elseif input.KeyCode == Keybinds.Burst then
        Toggles.Burst.Set(not Settings.BurstEnabled)
    elseif input.KeyCode == Keybinds.Turbo then
        Toggles.Turbo.Set(not Settings.TurboEnabled)
    elseif input.KeyCode == Keybinds.Headless then
        Toggles.Headless.Set(not Settings.HeadlessEnabled)
    end
end)

print("[Karpa] Script TURBO carregado. K=Aura L=360 J=Equip P=Pred B=Burst T=Turbo H=Headless | END=PANIC")