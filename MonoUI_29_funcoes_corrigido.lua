-- ============================================================
-- MonoUI — Kit Preto & Branco (Delta Executor Edition)
-- Cole no editor do Delta e execute. Script único, sem módulos.
-- ============================================================

-- ═══════════════ BOOT GUARD (Delta mobile) ═══════════════
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(0.5)

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer

-- ═══════════════ PALETA ═══════════════
local C = {
	bg       = Color3.fromRGB(8, 8, 8),
	panel    = Color3.fromRGB(20, 20, 20),
	panelHi  = Color3.fromRGB(36, 36, 36),
	panelLo  = Color3.fromRGB(14, 14, 14),
	stroke   = Color3.fromRGB(60, 60, 60),
	strokeHi = Color3.fromRGB(255, 255, 255),
	text     = Color3.fromRGB(255, 255, 255),
	textDim  = Color3.fromRGB(160, 160, 160),
	textMute = Color3.fromRGB(100, 100, 100),
}

-- ═══════════════ HELPERS ═══════════════
local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = radius or UDim.new(0, 8)
	c.Parent = parent
	return c
end

local function outline(parent, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color or C.strokeHi
	s.Thickness = thickness or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end

local function tween(inst, time, props)
	return TweenService:Create(inst, TweenInfo.new(time or 0.15), props):Play()
end

local function escapeRich(s)
	return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

-- ═══════════════ PARENT SEGURO (Delta) ═══════════════
local function safeParent()
	local ok, res = pcall(function() return gethui() end)
	if ok and res then return res end
	local ok2, cg = pcall(function() return game:GetService("CoreGui") end)
	if ok2 and cg then return cg end
	return player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui", 10)
end

local function makeGui(name)
	local gui = Instance.new("ScreenGui")
	gui.Name = name or "MonoUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.DisplayOrder = 999
	gui.Parent = safeParent()
	return gui
end

-- ═══════════════ LIMPEZA ═══════════════
for _, gui in ipairs(player.PlayerGui:GetChildren()) do
	if gui.Name == "MonoDemo" then gui:Destroy() end
end
pcall(function()
	local core = gethui and gethui() or game:GetService("CoreGui")
	for _, gui in ipairs(core:GetChildren()) do
		if gui.Name == "MonoDemo" then gui:Destroy() end
	end
end)

-- ═══════════════ BOTÃO ═══════════════
local function Button(parent, text, position, size)
	local btn = Instance.new("TextButton")
	btn.Name = "Button"
	btn.Parent = parent
	btn.Position = position or UDim2.new(0, 0, 0, 0)
	btn.Size = size or UDim2.new(0, 220, 0, 46)
	btn.BackgroundColor3 = C.panel
	btn.TextColor3 = C.text
	btn.Text = text or "BUTTON"
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.AutoButtonColor = false
	btn.BorderSizePixel = 0
	corner(btn, UDim.new(0, 10))
	local stroke = outline(btn, C.strokeHi, 1)

	local hovered = false
	local function paint(bg, fg, st)
		tween(btn, 0.15, { BackgroundColor3 = bg, TextColor3 = fg })
		stroke.Color = st
	end

	btn.MouseEnter:Connect(function() hovered = true;  paint(C.strokeHi, C.bg, C.strokeHi) end)
	btn.MouseLeave:Connect(function() hovered = false; paint(C.panel, C.text, C.strokeHi) end)
	btn.MouseButton1Down:Connect(function() paint(C.panelHi, C.text, C.text) end)
	btn.MouseButton1Up:Connect(function()
		if hovered then paint(C.strokeHi, C.bg, C.strokeHi)
		else paint(C.panel, C.text, C.strokeHi) end
	end)
	return btn
end

-- ═══════════════ INPUT ═══════════════
local function Input(parent, placeholder, position, width, height)
	local frame = Instance.new("Frame")
	frame.Parent = parent
	frame.Position = position or UDim2.new(0, 0, 0, 0)
	frame.Size = UDim2.new(0, width or 240, 0, height or 46)
	frame.BackgroundColor3 = C.panelLo
	frame.BorderSizePixel = 0
	corner(frame, UDim.new(0, 8))
	local stroke = outline(frame, C.stroke, 1)

	local field = Instance.new("TextBox")
	field.Parent = frame
	field.Size = UDim2.new(1, -24, 1, 0)
	field.Position = UDim2.new(0, 12, 0, 0)
	field.BackgroundTransparency = 1
	field.TextColor3 = C.text
	field.PlaceholderText = placeholder or ""
	field.PlaceholderColor3 = C.textMute
	field.Font = Enum.Font.Gotham
	field.TextSize = 14
	field.TextXAlignment = Enum.TextXAlignment.Left
	field.ClearTextOnFocus = false
	field.Text = ""

	field.Focused:Connect(function()
		tween(frame, 0.15, { BackgroundColor3 = C.panel })
		stroke.Color = C.strokeHi
	end)
	field.FocusLost:Connect(function()
		tween(frame, 0.15, { BackgroundColor3 = C.panelLo })
		stroke.Color = C.stroke
	end)
	return field, frame
end

-- ═══════════════ SLIDER ═══════════════
local function Slider(parent, min, max, initial, position, width)
	local container = Instance.new("Frame")
	container.Parent = parent
	container.Position = position or UDim2.new(0, 0, 0, 0)
	container.Size = UDim2.new(0, width or 260, 0, 30)
	container.BackgroundTransparency = 1

	local track = Instance.new("Frame")
	track.Parent = container
	track.Size = UDim2.new(1, -46, 0, 4)
	track.Position = UDim2.new(0, 0, 0.5, -2)
	track.BackgroundColor3 = C.stroke
	track.BorderSizePixel = 0
	corner(track, UDim.new(1, 0))

	local fill = Instance.new("Frame")
	fill.Parent = track
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = C.text
	fill.BorderSizePixel = 0
	corner(fill, UDim.new(1, 0))

	local handle = Instance.new("TextButton")
	handle.Parent = container
	handle.Size = UDim2.new(0, 16, 0, 16)
	handle.Position = UDim2.new(0, -8, 0.5, -8)
	handle.BackgroundColor3 = C.text
	handle.Text = ""
	handle.AutoButtonColor = false
	handle.BorderSizePixel = 0
	corner(handle, UDim.new(1, 0))

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Parent = container
	valueLabel.Size = UDim2.new(0, 40, 1, 0)
	valueLabel.Position = UDim2.new(1, -40, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(initial or min)
	valueLabel.TextColor3 = C.text
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 12
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right

	local dragging = false
	local onChange = nil

	local function updateFromX(screenX)
		local rel = math.clamp((screenX - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
		local value = math.floor(min + (max - min) * rel + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		handle.Position = UDim2.new(rel, -8, 0.5, -8)
		valueLabel.Text = tostring(value)
		if onChange then onChange(value) end
	end

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			updateFromX(input.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			updateFromX(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	task.defer(function()
		local rel = (initial - min) / math.max(max - min, 1)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		handle.Position = UDim2.new(rel, -8, 0.5, -8)
	end)

	local public = {}
	function public.OnChange(cb) onChange = cb end
	function public.GetValue() return tonumber(valueLabel.Text) end
	return public, container
end

-- ═══════════════ TOGGLE ═══════════════
local function Toggle(parent, text, position, width)
	local container = Instance.new("Frame")
	container.Parent = parent
	container.Position = position or UDim2.new(0, 0, 0, 0)
	container.Size = UDim2.new(0, width or 200, 0, 30)
	container.BackgroundTransparency = 1

	local label = Instance.new("TextLabel")
	label.Parent = container
	label.Size = UDim2.new(1, -54, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text or "Toggle"
	label.TextColor3 = C.text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local bg = Instance.new("TextButton")
	bg.Parent = container
	bg.Size = UDim2.new(0, 44, 0, 24)
	bg.Position = UDim2.new(1, -44, 0.5, -12)
	bg.BackgroundColor3 = C.panel
	bg.Text = ""
	bg.AutoButtonColor = false
	bg.BorderSizePixel = 0
	corner(bg, UDim.new(1, 0))
	local stroke = outline(bg, C.stroke, 1)

	local knob = Instance.new("Frame")
	knob.Parent = bg
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = UDim2.new(0, 3, 0.5, -9)
	knob.BackgroundColor3 = C.textDim
	knob.BorderSizePixel = 0
	corner(knob, UDim.new(1, 0))

	local enabled = false
	local onToggle = nil

	bg.MouseButton1Click:Connect(function()
		enabled = not enabled
		tween(knob, 0.2, {
			Position = enabled and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
			BackgroundColor3 = enabled and C.bg or C.textDim,
		})
		tween(bg, 0.2, { BackgroundColor3 = enabled and C.text or C.panel })
		stroke.Color = enabled and C.text or C.stroke
		if onToggle then onToggle(enabled) end
	end)

	local public = {}
	function public.OnToggle(cb) onToggle = cb end
	function public.GetState() return enabled end
	function public.Set(value, silent)
		value = value == true
		if enabled == value then return end
		enabled = value
		tween(knob, 0.2, {
			Position = enabled and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
			BackgroundColor3 = enabled and C.bg or C.textDim,
		})
		tween(bg, 0.2, { BackgroundColor3 = enabled and C.text or C.panel })
		stroke.Color = enabled and C.text or C.stroke
		if not silent and onToggle then onToggle(enabled) end
	end
	return public, container
end

-- MonoUI 29 | SINTONIA RP | cliente local
-- Os nomes dos objetos de farm foram identificados no arquivo fornecido.
-- Execute como script único. Nenhum login, chave ou carregamento remoto.
local env = (getgenv and getgenv()) or _G
if type(env.MonoUI29Cleanup) == "function" then pcall(env.MonoUI29Cleanup) end

local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local camera = workspace.CurrentCamera
local alive = true
local connections = {}
local function bind(signal, callback)
	local connection = signal:Connect(callback)
	table.insert(connections, connection)
	return connection
end

-- Bypass30 integrado uma vez para a UI inteira. Reexecuta a busca após respawn.
-- A busca e o hook são limitados ao ClientAC identificado no arquivo recebido.
local ac = {
	ready = false, scanning = false, lastFailure = nil,
	poisoned = setmetatable({}, {__mode = "k"}),
	hooked = setmetatable({}, {__mode = "k"}),
}
local function clientACFunctions()
	local filter = env.filtergc or (_G and _G.filtergc)
	if type(filter) ~= "function" or not debug or type(debug.info) ~= "function"
		or type(debug.getupvalues) ~= "function" then
		return nil, "Executor sem filtergc/debug.getupvalues"
	end
	local ok, functions = pcall(filter, "function", {
		Constants = {"FireServer", "bor", "clock"},
	}, false)
	if not ok or type(functions) ~= "table" then return nil, "Busca do ClientAC falhou" end
	local matches = {}
	for _, fn in ipairs(functions) do
		if type(fn) == "function" then
			local sourceOK, source = pcall(debug.info, fn, "s")
			if sourceOK and type(source) == "string" and source:sub(-9) == ".ClientAC" then
				table.insert(matches, fn)
			end
		end
	end
	return matches
end
local function attemptACBypass()
	local functions, reason = clientACFunctions()
	if not functions then return nil, reason end
	local hookFn = hookfunction or (syn and syn.hookfunction)
	local closureFn = newcclosure or (syn and syn.newcclosure)
	local changed = 0
	for _, fn in ipairs(functions) do
		local ok, upvalues = pcall(debug.getupvalues, fn)
		if ok and type(upvalues) == "table" then
			local target, teleportTable = upvalues[1], upvalues[4]
			if type(target) == "table" and type(teleportTable) == "table"
				and rawget(target, "Teleporte") == 1 then
				if not ac.poisoned[teleportTable] then
					local poisonOK = pcall(function()
						for key in pairs(target) do teleportTable[key] = math.huge end
					end)
					if poisonOK then ac.poisoned[teleportTable] = true; changed += 1 end
				end
			end
		end
		if type(hookFn) == "function" and type(closureFn) == "function" and not ac.hooked[fn] then
			local hookOK = pcall(hookFn, fn, closureFn(function(...) return nil end))
			if hookOK then ac.hooked[fn] = true; changed += 1 end
		end
	end
	return changed
end
local function ensureACBypass(force)
	if force then ac.ready = false end
	if ac.ready or ac.scanning or not alive then return end
	ac.scanning = true
	task.spawn(function()
		local reason
		for _ = 1, 120 do
			if not alive then break end
			local changed
			changed, reason = attemptACBypass()
			if changed and changed > 0 then ac.ready = true; break end
			if changed == nil then break end
			task.wait(0.25)
		end
		ac.scanning = false
		if not alive then return end
		if ac.ready then
			ac.lastFailure = nil
			print("[MonoUI29] Bypass30 aplicado ao ClientAC")
			if env.MonoUI29Status and env.MonoUI29Status.Parent then
				env.MonoUI29Status.Text = "Bypass30 aplicado. 29 funções disponíveis."
			end
		else
			local detail = tostring(reason or "ClientAC não encontrado")
			ac.lastFailure = detail
			warn("[MonoUI29] Bypass30 não aplicado: " .. detail)
			if env.MonoUI29Status and env.MonoUI29Status.Parent then
				env.MonoUI29Status.Text = "Bypass30 indisponível: " .. detail
			end
		end
	end)
end
ensureACBypass()

local function character()
	local model = player.Character
	return model, model and model:FindFirstChildOfClass("Humanoid"), model and model:FindFirstChild("HumanoidRootPart")
end
local function rootPosition()
	local _, _, root = character()
	return root and root.Position
end
local state = {
	Speed = false, Jump = false, InfiniteJump = false, Noclip = false,
	Fly = false, Fullbright = false, AntiAFK = false,
	ESP = false, ESPName = true, ESPDistance = true, ESPBox = true,
	ESPTracer = false, ESPHealth = false, ESPHighlight = false, ESPTeamFilter = true,
	Aimbot = false, FOVCircle = false, WallCheck = true, AimTeamCheck = true,
	FriendCheck = true, AimHead = true, SmoothAim = true,
	FarmParts = false, FarmGarbage = false, FarmFishing = false,
	AutoWeapons = false, AutoPrompts = false,
}
local settings = {speed = 40, jump = 90, fly = 60, fov = 120, maxDistance = 500,
	smooth = 15, espDistance = 1500, garbageCount = 20}
local originalLighting = {
	Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
	GlobalShadows = Lighting.GlobalShadows, Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient, FogEnd = Lighting.FogEnd,
}
local originalHumanoid = {}
local collision = setmetatable({}, {__mode = "k"})
local gui = makeGui("MonoUI29")
local overlay = Instance.new("Frame")
overlay.BackgroundTransparency = 1
overlay.Size = UDim2.fromScale(1, 1)
overlay.Parent = gui
local espObjects = {}

local function status(message)
	if env.MonoUI29Status and env.MonoUI29Status.Parent then
		env.MonoUI29Status.Text = message
	end
	print("[MonoUI29] " .. message)
end
local function setLighting(enabled)
	if enabled then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.new(1, 1, 1)
		Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
		Lighting.FogEnd = 1000000
	else
		for property, value in pairs(originalLighting) do pcall(function() Lighting[property] = value end) end
	end
end
local function applyHumanoid()
	local _, humanoid = character()
	if not humanoid then return end
	if not originalHumanoid[humanoid] then
		originalHumanoid[humanoid] = {WalkSpeed = humanoid.WalkSpeed,
			JumpPower = humanoid.JumpPower, UseJumpPower = humanoid.UseJumpPower}
	end
	local old = originalHumanoid[humanoid]
	humanoid.WalkSpeed = state.Speed and settings.speed or old.WalkSpeed
	humanoid.UseJumpPower = state.Jump or old.UseJumpPower
	humanoid.JumpPower = state.Jump and settings.jump or old.JumpPower
end
local flyVelocity, flyGyro
local function stopFly()
	if flyVelocity then flyVelocity:Destroy(); flyVelocity = nil end
	if flyGyro then flyGyro:Destroy(); flyGyro = nil end
end
local function updateFly()
	local _, humanoid, root = character()
	if not state.Fly or not root or not humanoid then stopFly(); return end
	if not camera then return end
	if not flyVelocity or flyVelocity.Parent ~= root then
		stopFly()
		flyVelocity = Instance.new("BodyVelocity")
		flyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		flyVelocity.Parent = root
		flyGyro = Instance.new("BodyGyro")
		flyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
		flyGyro.P = 10000
		flyGyro.Parent = root
	end
	local direction = humanoid.MoveDirection
	local vertical = 0
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical = 1 end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vertical = -1 end
	flyVelocity.Velocity = direction * settings.fly + Vector3.new(0, vertical * settings.fly, 0)
	flyGyro.CFrame = camera.CFrame
end
local function restoreCollision()
	for part, old in pairs(collision) do
		if part and part.Parent then pcall(function() part.CanCollide = old end) end
		collision[part] = nil
	end
end
local function updateNoclip()
	if not state.Noclip then return end
	local model = player.Character
	if not model then return end
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			if collision[part] == nil then collision[part] = part.CanCollide end
			part.CanCollide = false
		end
	end
end

local function sameTeam(other)
	return player.Team ~= nil and other.Team == player.Team
end
local friendCache = {}
local function isFriend(other)
	if friendCache[other.UserId] ~= nil then return friendCache[other.UserId] end
	local ok, result = pcall(function() return player:IsFriendsWith(other.UserId) end)
	friendCache[other.UserId] = ok and result or false
	return friendCache[other.UserId]
end
local function visibleTarget(part, model)
	if not state.WallCheck then return true end
	local origin = camera.CFrame.Position
	local ray = RaycastParams.new()
	ray.FilterType = Enum.RaycastFilterType.Exclude
	ray.FilterDescendantsInstances = {player.Character, camera}
	local hit = workspace:Raycast(origin, part.Position - origin, ray)
	return hit == nil or hit.Instance:IsDescendantOf(model)
end
local function bestTarget()
	local nearest, nearestScore
	local center = camera.ViewportSize / 2
	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player and (not state.AimTeamCheck or not sameTeam(other))
			and (not state.FriendCheck or not isFriend(other)) then
			local model = other.Character
			local humanoid = model and model:FindFirstChildOfClass("Humanoid")
			local part = model and (state.AimHead and model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart"))
			if humanoid and humanoid.Health > 0 and part then
				local distance = (camera.CFrame.Position - part.Position).Magnitude
				if distance <= settings.maxDistance then
					local point, onScreen = camera:WorldToViewportPoint(part.Position)
					local score = (Vector2.new(point.X, point.Y) - center).Magnitude
					if onScreen and score <= settings.fov and (not nearestScore or score < nearestScore)
						and visibleTarget(part, model) then
						nearest, nearestScore = part, score
					end
				end
			end
		end
	end
	return nearest
end
local circle = Instance.new("Frame")
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.BackgroundTransparency = 1
circle.Size = UDim2.fromOffset(settings.fov * 2, settings.fov * 2)
circle.Visible = false
circle.Parent = overlay
corner(circle, UDim.new(1, 0))
outline(circle, C.textDim, 1)
local function updateAim(dt)
	camera = workspace.CurrentCamera or camera
	if not camera then return end
	circle.Visible = state.FOVCircle
	circle.Position = UDim2.fromOffset(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
	circle.Size = UDim2.fromOffset(settings.fov * 2, settings.fov * 2)
	if not state.Aimbot then return end
	local part = bestTarget()
	if not part then return end
	local desired = CFrame.lookAt(camera.CFrame.Position, part.Position)
	local alpha = state.SmoothAim and math.clamp(dt * (settings.smooth / 2), 0, 1) or 1
	camera.CFrame = camera.CFrame:Lerp(desired, alpha)
end

local function createESP(other)
	local holder = Instance.new("BillboardGui")
	holder.Name = "MonoESP"
	holder.AlwaysOnTop = true
	holder.Size = UDim2.fromOffset(130, 185)
	holder.StudsOffset = Vector3.new(0, 0.3, 0)
	holder.Enabled = false
	holder.Parent = player:WaitForChild("PlayerGui")
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, -22, 1, -36)
	box.Position = UDim2.fromOffset(11, 22)
	box.BackgroundTransparency = 1
	box.Parent = holder
	outline(box, C.text, 1)
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 0, 20)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = C.text
	textLabel.TextStrokeTransparency = 0
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 12
	textLabel.Parent = holder
	local health = Instance.new("Frame")
	health.Position = UDim2.new(0, 4, 0, 22)
	health.Size = UDim2.new(0, 3, 0, 0)
	health.BackgroundColor3 = Color3.fromRGB(80, 255, 100)
	health.BorderSizePixel = 0
	health.Parent = holder
	local tracer = Instance.new("Frame")
	tracer.AnchorPoint = Vector2.new(0.5, 0.5)
	tracer.BackgroundColor3 = C.text
	tracer.BorderSizePixel = 0
	tracer.Visible = false
	tracer.Parent = overlay
	local highlight = Instance.new("Highlight")
	highlight.Name = "MonoHighlight"
	highlight.FillColor = C.text
	highlight.OutlineColor = C.text
	highlight.FillTransparency = 0.8
	highlight.Enabled = false
	highlight.Parent = workspace
	espObjects[other] = {holder = holder, box = box, label = textLabel,
		health = health, tracer = tracer, highlight = highlight}
	return espObjects[other]
end
local function removeESP(other)
	friendCache[other.UserId] = nil
	local item = espObjects[other]
	if not item then return end
	for _, object in pairs(item) do if typeof(object) == "Instance" then object:Destroy() end end
	espObjects[other] = nil
end
local function updateESP()
	camera = workspace.CurrentCamera or camera
	if not camera then return end
	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player then
			local item = espObjects[other] or createESP(other)
			local model = other.Character
			local humanoid = model and model:FindFirstChildOfClass("Humanoid")
			local root = model and model:FindFirstChild("HumanoidRootPart")
			local distance = root and (camera.CFrame.Position - root.Position).Magnitude or math.huge
			local show = state.ESP and humanoid and humanoid.Health > 0 and root
				and distance <= settings.espDistance and (not state.ESPTeamFilter or not sameTeam(other))
			item.holder.Enabled = show == true
			item.highlight.Enabled = show == true and state.ESPHighlight
			item.tracer.Visible = false
			if show then
				item.holder.Adornee = root
				item.highlight.Adornee = model
				item.box.Visible = state.ESPBox
				local label = {}
				if state.ESPName then table.insert(label, other.DisplayName) end
				if state.ESPDistance then table.insert(label, string.format("%dm", distance)) end
				item.label.Text = table.concat(label, " | ")
				item.health.Visible = state.ESPHealth
				item.health.Size = UDim2.new(0, 3, 0, 150 * humanoid.Health / math.max(1, humanoid.MaxHealth))
				if state.ESPTracer then
					local point, onScreen = camera:WorldToViewportPoint(root.Position)
					if onScreen then
						local start = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
						local finish = Vector2.new(point.X, point.Y)
						local delta = finish - start
						item.tracer.Size = UDim2.fromOffset(delta.Magnitude, 1)
						item.tracer.Position = UDim2.fromOffset((start.X + finish.X) / 2, (start.Y + finish.Y) / 2)
						item.tracer.Rotation = math.deg(math.atan2(delta.Y, delta.X))
						item.tracer.Visible = true
					end
				end
			end
		end
	end
end
bind(Players.PlayerRemoving, removeESP)

local function promptPosition(prompt)
	local parent = prompt and prompt.Parent
	if parent and parent:IsA("BasePart") then return parent.Position end
	if parent and parent:IsA("Attachment") then return parent.WorldPosition end
	return nil
end
local function usePrompt(prompt)
	if not prompt or not prompt.Parent or not prompt.Enabled then return false end
	if type(fireproximityprompt) == "function" then
		return pcall(fireproximityprompt, prompt)
	end
	local ok = pcall(function()
		prompt:InputHoldBegin()
		task.wait(math.max(0.1, prompt.HoldDuration + 0.1))
		prompt:InputHoldEnd()
	end)
	return ok
end
local function teleport(position)
	local model, humanoid, root = character()
	if not model or not root or not humanoid or humanoid.Health <= 0 then return false end
	model:PivotTo(CFrame.new(position + Vector3.new(0, 3, 0)))
	return true
end
local function nearestPrompt(filter, maxRange)
	local origin = rootPosition()
	if not origin then return nil end
	local best, distance
	for _, object in ipairs(workspace:GetDescendants()) do
		if object:IsA("ProximityPrompt") and object.Enabled and filter(object) then
			local position = promptPosition(object)
			local length = position and (position - origin).Magnitude
			if length and (not maxRange or length <= maxRange) and (not distance or length < distance) then
				best, distance = object, length
			end
		end
	end
	return best
end
local function moveAndPrompt(prompt)
	local position = promptPosition(prompt)
	if not position then return false end
	if not teleport(position) then return false end
	task.wait(0.18)
	return usePrompt(prompt)
end
local function partPrompt()
	local folder = workspace:FindFirstChild("FarmPartesDeArma")
	folder = folder and folder:FindFirstChild("Locais")
	if not folder then return nil end
	local origin = rootPosition()
	local best, distance
	for _, part in ipairs(folder:GetChildren()) do
		local prompt = part:IsA("BasePart") and part:FindFirstChild("Interagir")
		if prompt and prompt:IsA("ProximityPrompt") and prompt.Enabled and origin then
			local length = (part.Position - origin).Magnitude
			if not distance or length < distance then best, distance = prompt, length end
		end
	end
	return best
end
local function garbagePrompt()
	local folder = workspace:FindFirstChild("Lixeiro")
	local origin = rootPosition()
	if not folder or not origin then return nil end
	local best, distance
	for _, part in ipairs(folder:GetChildren()) do
		local prompt = part:IsA("BasePart") and part:FindFirstChild("PegarLixo")
		if prompt and prompt:IsA("ProximityPrompt") and prompt.Enabled and part.Transparency < 0.95 then
			local length = (part.Position - origin).Magnitude
			if not distance or length < distance then best, distance = prompt, length end
		end
	end
	return best
end
local function deliveryPrompt()
	local folder = workspace:FindFirstChild("EntregaLixo")
	local part = folder and folder:FindFirstChild("Lixeira")
	local prompt = part and part:FindFirstChild("EntregarLixo")
	return prompt and prompt:IsA("ProximityPrompt") and prompt.Enabled and prompt or nil
end
local function garbageCount()
	local inventory = player:FindFirstChild("Inv")
	local count = 0
	if inventory then
		for _, item in ipairs(inventory:GetChildren()) do
			if item.Name == "Saco de Lixo" then count += 1 end
		end
	end
	return count
end
local function ensureGarbageJob()
	if player.Team and player.Team.Name == "Lixeiro" then return true end
	local market = ReplicatedStorage:FindFirstChild("Mercadinho")
	local remote = market and market:FindFirstChild("PrefRemote")
	if not remote or not remote:IsA("RemoteEvent") then return false end
	local level = 1
	local module = market:FindFirstChild("PrefModule")
	if module then
		local ok, data = pcall(require, module)
		if ok and type(data) == "table" and type(data.Empregos) == "table" then
			for name, info in pairs(data.Empregos) do
				if tostring(name):lower() == "lixeiro" then level = tonumber(info.Level) or 1; break end
			end
		end
	end
	pcall(function() remote:FireServer("Lixeiro", level) end)
	task.wait(0.3)
	pcall(function() remote:FireServer("Lixeiro", level, true) end)
	return player.Team and player.Team.Name == "Lixeiro"
end
local function weaponPrompt()
	return nearestPrompt(function(prompt)
		local text = (prompt.Name .. " " .. prompt.ActionText .. " " .. prompt.ObjectText):lower()
		return text:find("arma", 1, true) or text:find("weapon", 1, true)
	end)
end
local function fishingPrompt()
	return nearestPrompt(function(prompt)
		local text = (prompt.Name .. " " .. prompt.ActionText .. " " .. prompt.ObjectText):lower()
		return text:find("pesc", 1, true) or text:find("fish", 1, true)
	end, 12)
end
local function equipRod()
	local model, humanoid = character()
	if not model or not humanoid then return nil end
	for _, folder in ipairs({model, player:FindFirstChild("Backpack")}) do
		if folder then
			for _, tool in ipairs(folder:GetChildren()) do
				if tool:IsA("Tool") then
					local name = tool.Name:lower()
					if name:find("vara", 1, true) or name:find("fishing", 1, true) then
						if tool.Parent ~= model then humanoid:EquipTool(tool) end
						return tool
					end
				end
			end
		end
	end
end
local farmToken = 0
local controls = {}
local function stopFarms(except)
	for _, key in ipairs({"FarmParts", "FarmGarbage", "FarmFishing", "AutoWeapons"}) do
		if key ~= except then
			state[key] = false
			if controls[key] then controls[key].Set(false, true) end
		end
	end
	farmToken += 1
	return farmToken
end
local function runFarm(key, worker)
	if not state[key] then farmToken += 1; return end
	local token = stopFarms(key)
	task.spawn(function()
		while alive and state[key] and token == farmToken do
			local ok, result = pcall(worker)
			if not ok then status("Erro em " .. key .. ": " .. tostring(result)); break end
			task.wait(result or 1)
		end
	end)
end
local collectedGarbage = 0
local function farmParts()
	local prompt = partPrompt()
	if not prompt then status("Aguardando partes de arma"); return 1.5 end
	if moveAndPrompt(prompt) then status("Interação com parte enviada"); return 15 end
	return 1.5
end
local function farmGarbage()
	if not ensureGarbageJob() then status("Emprego Lixeiro indisponível"); return 3 end
	local count = garbageCount()
	local hasInventory = player:FindFirstChild("Inv") ~= nil
	if count >= settings.garbageCount or (not hasInventory and collectedGarbage >= settings.garbageCount) then
		local prompt = deliveryPrompt()
		if prompt and moveAndPrompt(prompt) then collectedGarbage = 0; status("Lixo entregue") end
		return 1.2
	end
	local prompt = garbagePrompt()
	if prompt and moveAndPrompt(prompt) then collectedGarbage += 1; status("Lixo coletado " .. tostring(count + 1)) end
	return prompt and 0.7 or 1.5
end
local function farmFishing()
	local point = Vector3.new(-2593.61, 122.34, -3044.99)
	local position = rootPosition()
	if not position or (position - point).Magnitude > 10 then
		teleport(point)
		return 0.5
	end
	local prompt = fishingPrompt()
	if prompt then usePrompt(prompt); status("Pescando"); return 1 end
	local rod = equipRod()
	if rod then pcall(function() rod:Activate() end); status("Vara ativada") end
	return 1.5
end
local function farmWeapons()
	local prompt = weaponPrompt()
	if prompt then moveAndPrompt(prompt); status("Tentando coletar arma") end
	return prompt and 1 or 2
end
local promptBusy = false
local function autoPrompts()
	if promptBusy then return end
	promptBusy = true
	local prompt = nearestPrompt(function(item)
		local text = (item.Name .. " " .. item.ActionText):lower()
		return not text:find("entregar", 1, true)
	end, 8)
	if prompt then usePrompt(prompt) end
	promptBusy = false
end

local panel = Instance.new("Frame")
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.5)
panel.Size = UDim2.fromOffset(800, 560)
panel.BackgroundColor3 = C.bg
panel.BorderSizePixel = 0
panel.Parent = gui
corner(panel, UDim.new(0, 14))
outline(panel, C.stroke, 1)
local scale = Instance.new("UIScale")
scale.Parent = panel
local function resize()
	local current = workspace.CurrentCamera
	if current then
		local view = current.ViewportSize
		scale.Scale = math.clamp(math.min((view.X - 20) / 800, (view.Y - 20) / 560), 0.45, 1)
	end
end
resize()
if workspace.CurrentCamera then
	bind(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), resize)
end
bind(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
	camera = workspace.CurrentCamera
	resize()
	if camera then bind(camera:GetPropertyChangedSignal("ViewportSize"), resize) end
end)
local heading = Instance.new("TextLabel")
heading.Position = UDim2.fromOffset(20, 15)
heading.Size = UDim2.fromOffset(650, 28)
heading.BackgroundTransparency = 1
heading.Text = "MONO UI  •  SINTONIA RP"
heading.Font = Enum.Font.GothamBold
heading.TextSize = 20
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.TextColor3 = C.text
heading.Parent = panel
local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(20, 45)
subtitle.Size = UDim2.fromOffset(650, 18)
subtitle.BackgroundTransparency = 1
subtitle.Text = "29 funções  |  K abre/fecha  |  F liga/desliga fly"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextColor3 = C.textDim
subtitle.Parent = panel
local close = Button(panel, "×", UDim2.fromOffset(744, 16), UDim2.fromOffset(35, 30))
close.MouseButton1Click:Connect(function() panel.Visible = false end)
local openButton = Button(gui, "MONO", UDim2.fromOffset(12, 80), UDim2.fromOffset(72, 34))
openButton.TextSize = 11
openButton.MouseButton1Click:Connect(function() panel.Visible = not panel.Visible end)
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(16, 80)
sidebar.Size = UDim2.fromOffset(150, 430)
sidebar.BackgroundTransparency = 1
sidebar.Parent = panel
local pages = {}
local tabs = {}
for index, name in ipairs({"MOVIMENTO", "ESP", "AIMBOT", "FARM", "AÇÕES"}) do
	local tab = Button(sidebar, name, UDim2.fromOffset(0, (index - 1) * 52), UDim2.fromOffset(148, 42))
	tab.TextSize = 12
	tabs[name] = tab
	local page = Instance.new("ScrollingFrame")
	page.Name = name
	page.Position = UDim2.fromOffset(182, 82)
	page.Size = UDim2.fromOffset(600, 430)
	page.BackgroundColor3 = C.panelLo
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 4
	page.ScrollBarImageColor3 = C.textDim
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.CanvasSize = UDim2.new()
	page.Visible = index == 1
	page.Parent = panel
	corner(page, UDim.new(0, 10))
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = page
	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 12)
	padding.PaddingBottom = UDim.new(0, 12)
	padding.PaddingLeft = UDim.new(0, 15)
	padding.PaddingRight = UDim.new(0, 15)
	padding.Parent = page
	pages[name] = page
	tab.MouseButton1Click:Connect(function()
		for otherName, otherPage in pairs(pages) do otherPage.Visible = otherName == name end
	end)
end
local function addTitle(page, textValue)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 0, 26)
	label.BackgroundTransparency = 1
	label.Text = textValue
	label.TextColor3 = C.text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 15
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = pages[page]
end
local count = 0
local function addToggle(page, key, label, callback)
	count += 1
	local control, frame = Toggle(pages[page], string.format("%02d  %s", count, label), nil, 558)
	frame.Size = UDim2.new(1, -10, 0, 32)
	control.OnToggle(function(enabled)
		ensureACBypass()
		state[key] = enabled
		if callback then callback(enabled) end
	end)
	controls[key] = control
	if state[key] then control.Set(true, true) end
	return control
end
local function addButton(page, label, callback)
	count += 1
	local button = Button(pages[page], string.format("%02d  %s", count, label), nil, UDim2.new(1, -10, 0, 40))
	button.MouseButton1Click:Connect(function()
		ensureACBypass()
		callback()
	end)
	return button
end
local function addSlider(page, label, key, low, high)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -10, 0, 48)
	row.BackgroundTransparency = 1
	row.Parent = pages[page]
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 0, 16)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = label
	textLabel.TextColor3 = C.textDim
	textLabel.Font = Enum.Font.Gotham
	textLabel.TextSize = 12
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = row
	local slider, sliderFrame = Slider(row, low, high, settings[key], UDim2.fromOffset(0, 18), 525)
	sliderFrame.Size = UDim2.new(1, -12, 0, 28)
	slider.OnChange(function(value)
		ensureACBypass()
		settings[key] = value
		applyHumanoid()
	end)
end

addTitle("MOVIMENTO", "Jogador")
addToggle("MOVIMENTO", "Speed", "WalkSpeed", applyHumanoid) -- 1
addSlider("MOVIMENTO", "Velocidade", "speed", 16, 250)
addToggle("MOVIMENTO", "Jump", "JumpPower", applyHumanoid) -- 2
addSlider("MOVIMENTO", "Força do pulo", "jump", 50, 150)
addToggle("MOVIMENTO", "InfiniteJump", "Pulo infinito") -- 3
addToggle("MOVIMENTO", "Noclip", "Noclip", function(value) if not value then restoreCollision() end end) -- 4
addToggle("MOVIMENTO", "Fly", "Fly", function(value) if not value then stopFly() end end) -- 5
addSlider("MOVIMENTO", "Velocidade fly", "fly", 16, 100)
addToggle("MOVIMENTO", "Fullbright", "Fullbright", setLighting) -- 6
addToggle("MOVIMENTO", "AntiAFK", "Anti AFK") -- 7

addTitle("ESP", "Visualização de jogadores")
addToggle("ESP", "ESP", "Ativar ESP") -- 8
addToggle("ESP", "ESPName", "Nome") -- 9
addToggle("ESP", "ESPDistance", "Distância") -- 10
addToggle("ESP", "ESPBox", "Caixa") -- 11
addToggle("ESP", "ESPTracer", "Tracer") -- 12
addToggle("ESP", "ESPHealth", "Barra de vida") -- 13
addToggle("ESP", "ESPHighlight", "Highlight") -- 14
addToggle("ESP", "ESPTeamFilter", "Filtrar mesmo time") -- 15
addSlider("ESP", "Distância máxima", "espDistance", 100, 5000)

addTitle("AIMBOT", "Mira pela câmera")
addToggle("AIMBOT", "Aimbot", "Ativar aimbot") -- 16
addToggle("AIMBOT", "FOVCircle", "Círculo FOV") -- 17
addToggle("AIMBOT", "WallCheck", "Wall check") -- 18
addToggle("AIMBOT", "AimTeamCheck", "Filtrar mesmo time") -- 19
addToggle("AIMBOT", "FriendCheck", "Filtrar amigos") -- 20
addToggle("AIMBOT", "AimHead", "Mirar na cabeça") -- 21
addToggle("AIMBOT", "SmoothAim", "Mira suave") -- 22
addSlider("AIMBOT", "Raio FOV", "fov", 20, 400)
addSlider("AIMBOT", "Distância máxima", "maxDistance", 50, 2000)
addSlider("AIMBOT", "Suavidade", "smooth", 1, 100)

addTitle("FARM", "Rotinas SINTONIA RP")
addToggle("FARM", "FarmParts", "Farm de partes", function(v) runFarm("FarmParts", farmParts) end) -- 23
addToggle("FARM", "FarmGarbage", "Farm lixeiro", function(v) runFarm("FarmGarbage", farmGarbage) end) -- 24
addSlider("FARM", "Sacos por entrega", "garbageCount", 1, 20)
addToggle("FARM", "FarmFishing", "Farm pesca", function(v) runFarm("FarmFishing", farmFishing) end) -- 25
addToggle("FARM", "AutoWeapons", "Auto coletar armas", function(v) runFarm("AutoWeapons", farmWeapons) end) -- 26
addToggle("FARM", "AutoPrompts", "Auto interagir perto") -- 27

addTitle("AÇÕES", "Teleporte rápido")
addButton("AÇÕES", "TP para arma mais próxima", function() -- 28
	local prompt = weaponPrompt()
	if prompt and promptPosition(prompt) then teleport(promptPosition(prompt)); status("TP para arma")
	else status("Nenhuma arma com prompt encontrada") end
end)
addButton("AÇÕES", "TP para lixeiro", function() -- 29
	if teleport(Vector3.new(-1216.14, 129.42, -5183.68)) then status("TP para lixeiro") end
end)

local statusLabel = Instance.new("TextLabel")
statusLabel.Position = UDim2.fromOffset(20, 528)
statusLabel.Size = UDim2.fromOffset(740, 18)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ac.ready and "Bypass30 aplicado. 29 funções disponíveis."
	or (ac.lastFailure and ("Bypass30 indisponível: " .. ac.lastFailure)
	or "Bypass30: verificando ClientAC. 29 funções disponíveis.")
statusLabel.TextColor3 = C.textDim
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = panel
env.MonoUI29Status = statusLabel

local espClock, promptClock = 0, 0
bind(RunService.Heartbeat, function(dt)
	if not alive then return end
	if state.Speed or state.Jump then applyHumanoid() end
	updateFly()
	updateNoclip()
	espClock += dt
	if espClock >= 0.12 then espClock = 0; updateESP() end
	promptClock += dt
	if state.AutoPrompts and promptClock >= 1 then promptClock = 0; task.spawn(autoPrompts) end
end)
bind(RunService.RenderStepped, updateAim)
bind(UserInputService.JumpRequest, function()
	if state.InfiniteJump then
		local _, humanoid = character()
		if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)
bind(player.Idled, function()
	if state.AntiAFK then
		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new(0, 0))
		end)
	end
end)
bind(UserInputService.InputBegan, function(input, consumed)
	if consumed then return end
	if input.KeyCode == Enum.KeyCode.K then panel.Visible = not panel.Visible end
	if input.KeyCode == Enum.KeyCode.F then controls.Fly.Set(not controls.Fly.GetState()) end
end)
bind(player.CharacterAdded, function()
	stopFly()
	for part in pairs(collision) do collision[part] = nil end
	ensureACBypass(true)
	task.wait(1)
	if alive then applyHumanoid() end
end)

env.MonoUI29Cleanup = function()
	if not alive then return end
	alive = false
	farmToken += 1
	stopFly()
	restoreCollision()
	setLighting(false)
	for humanoid, old in pairs(originalHumanoid) do
		if humanoid and humanoid.Parent then
			pcall(function()
				humanoid.WalkSpeed = old.WalkSpeed
				humanoid.JumpPower = old.JumpPower
				humanoid.UseJumpPower = old.UseJumpPower
			end)
		end
	end
	for _, connection in ipairs(connections) do connection:Disconnect() end
	for other in pairs(espObjects) do removeESP(other) end
	gui:Destroy()
	env.MonoUI29Status = nil
	env.MonoUI29Cleanup = nil
end
print("[MonoUI29] Carregado com " .. tostring(count) .. " funções")
