-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--                DARTH HUB â€” LOADING SCREEN
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local Theme = {
    Primary     = Color3.fromHex("#7775F2"),
    Secondary   = Color3.fromHex("#ECA201"),
    Background  = Color3.fromRGB(10, 14, 28),
    Gradient    = Color3.fromHex("#257AF7"),
    Text        = Color3.fromRGB(210, 230, 255),
    Muted       = Color3.fromRGB(120, 160, 200),
}

local Messages = {
    "Connecting to Darth Hub...",
    "Loading modules...",
    "Preparing interface...",
    "Almost there...",
}

local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DarthHubLoader"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = CoreGui

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.Size = UDim2.new(0, 0, 0, 0)
container.BackgroundColor3 = Theme.Background
container.BorderSizePixel = 0
container.Parent = screenGui
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 18)

local grad = Instance.new("UIGradient", container)
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Background),
    ColorSequenceKeypoint.new(1, Theme.Gradient),
})
grad.Rotation = 100

local stroke = Instance.new("UIStroke", container)
stroke.Color = Theme.Primary
stroke.Thickness = 2
stroke.Transparency = 0.3

local glow = Instance.new("UIStroke", container)
glow.Color = Theme.Primary
glow.Thickness = 6
glow.Transparency = 1
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local logo = Instance.new("Frame", container)
logo.AnchorPoint = Vector2.new(0.5, 0)
logo.Position = UDim2.new(0.5, 0, 0, 28)
logo.Size = UDim2.new(0, 64, 0, 64)
logo.BackgroundColor3 = Theme.Primary
logo.BorderSizePixel = 0
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 16)

local logoText = Instance.new("TextLabel", logo)
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "W"
logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
logoText.TextSize = 32
logoText.Font = Enum.Font.GothamBold

local title = Instance.new("TextLabel", container)
title.Size = UDim2.new(1, -40, 0, 32)
title.Position = UDim2.new(0, 20, 0, 100)
title.BackgroundTransparency = 1
title.Text = "Darth Hub"
title.TextColor3 = Theme.Text
title.TextSize = 24
title.Font = Enum.Font.GothamBold

local subtitle = Instance.new("TextLabel", container)
subtitle.Size = UDim2.new(1, -40, 0, 18)
subtitle.Position = UDim2.new(0, 20, 0, 132)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Universal Scripts"
subtitle.TextColor3 = Theme.Muted
subtitle.TextSize = 13
subtitle.Font = Enum.Font.Gotham

local barBg = Instance.new("Frame", container)
barBg.Size = UDim2.new(1, -60, 0, 6)
barBg.Position = UDim2.new(0, 30, 0, 168)
barBg.BackgroundColor3 = Theme.Gradient
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Theme.Primary
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local barGrad = Instance.new("UIGradient", barFill)
barGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Primary),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 160, 255)),
})

local shine = Instance.new("Frame", barFill)
shine.Size = UDim2.new(0.3, 0, 1, 0)
shine.Position = UDim2.new(-0.3, 0, 0, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.5
shine.BorderSizePixel = 0

local statusText = Instance.new("TextLabel", container)
statusText.Size = UDim2.new(1, -40, 0, 18)
statusText.Position = UDim2.new(0, 20, 0, 190)
statusText.BackgroundTransparency = 1
statusText.Text = Messages[1]
statusText.TextColor3 = Theme.Muted
statusText.TextSize = 12
statusText.Font = Enum.Font.Code

local percentText = Instance.new("TextLabel", container)
percentText.Size = UDim2.new(1, -40, 0, 18)
percentText.Position = UDim2.new(0, 20, 0, 210)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Theme.Primary
percentText.TextSize = 14
percentText.Font = Enum.Font.GothamBold
percentText.TextTransparency = 1

for _, c in ipairs(container:GetDescendants()) do
    if c:IsA("TextLabel") and c ~= percentText then c.TextTransparency = 1
    elseif c:IsA("Frame") and c ~= barFill and c ~= shine then c.BackgroundTransparency = 1
    elseif c:IsA("UIStroke") then c.Transparency = 1 end
end

local shineRunning = true
task.spawn(function()
    while shineRunning do
        shine.Position = UDim2.new(-0.3, 0, 0, 0)
        TweenService:Create(shine, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Position = UDim2.new(1.3, 0, 0, 0) }):Play()
        task.wait(1.2)
    end
end)

TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = 16 }):Play()
local intro = TweenService:Create(container, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 380, 0, 250) })
intro:Play()
intro.Completed:Wait()

for _, c in ipairs(container:GetDescendants()) do
    if c:IsA("TextLabel") then
        TweenService:Create(c, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
    elseif c:IsA("Frame") and c ~= shine then
        TweenService:Create(c, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
    elseif c:IsA("UIStroke") and c ~= glow then
        TweenService:Create(c, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 0.3 }):Play()
    end
    task.wait(0.015)
end

TweenService:Create(shine, TweenInfo.new(0.5), { BackgroundTransparency = 0.5 }):Play()

local currentProgress = 0
for i, msg in ipairs(Messages) do
    local textOut = TweenService:Create(statusText, TweenInfo.new(0.15), { TextTransparency = 1 })
    textOut:Play()
    textOut.Completed:Wait()
    statusText.Text = msg
    TweenService:Create(statusText, TweenInfo.new(0.2), { TextTransparency = 0 }):Play()
    local targetProgress = ({0.25, 0.50, 0.75, 1.00})[i]
    local duration = 0.4
    local startProgress = currentProgress
    local stepAmount = targetProgress - startProgress
    for t = 0, 1, 0.02 do
        local eased = t * t * (3 - 2 * t)
        local progress = startProgress + (stepAmount * eased)
        barFill.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = string.format("%.0f%%", progress * 100)
        task.wait(duration / 50)
    end
    currentProgress = targetProgress
    task.wait(0.15)
end

barFill.Size = UDim2.new(1, 0, 1, 0)
percentText.Text = "100%"
statusText.Text = "Complete!"
TweenService:Create(glow, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Transparency = 0.5 }):Play()
task.wait(0.35)
shineRunning = false

TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Size = 0 }):Play()
local outro = TweenService:Create(container, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Size = UDim2.new(0, 0, 0, 0) })
for _, c in ipairs(container:GetDescendants()) do
    if c:IsA("TextLabel") then TweenService:Create(c, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
    elseif c:IsA("Frame") then TweenService:Create(c, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    elseif c:IsA("UIStroke") then TweenService:Create(c, TweenInfo.new(0.3), { Transparency = 1 }):Play() end
end
outro:Play()
outro.Completed:Wait()
screenGui:Destroy()

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--                  DARTH HUB â€” MAIN SCRIPT
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local u8 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

local color3 = Color3.fromHex("#7775F2")
local color3_2 = Color3.fromHex("#ECA201")
local color3_3 = Color3.fromHex("#83889E")
local color3_4 = Color3.fromHex("#257AF7")
local color3_5 = Color3.fromHex("#EF4F1D")
local color3_6 = Color3.fromHex("#FF69B4")
local color3_7 = Color3.fromHex("#FF8C00")
local color3_8 = Color3.fromHex("#FFD700")

local new = UDim.new
local CreateWindow = u8.CreateWindow
local v23 = new(1, 0)
local colorSequence = ColorSequence.new(Color3.fromHex("#30FF6A"), Color3.fromHex("#e7ff2f"))

local t2 = {
	Title = "Open Script Library",
	CornerRadius = v23,
	StrokeThickness = 3,
	Enabled = true,
	Draggable = true,
	OnlyMobile = false,
	Color = colorSequence
}

local Window = CreateWindow(u8, {
	Title = "Darth Hub",
	Folder = "DarthHub",
	Icon = "solar:folder-2-bold-duotone",
	NewElements = true,
	OpenButton = t2,
	Topbar = {
		Height = 44,
		ButtonsType = "Mac"
	}
})

local function AddScript(tab, name, desc, icon, url, cat)
	tab:Button({
		Title = name,
		Desc = desc or "Click to load",
		Icon = icon or "play",
		Callback = function()
			if not url or url == "" then
				u8:Notify({Title = "Info", Content = "URL not provided for " .. name, Duration = 3})
				return
			end
			local ok, err = pcall(function()
				loadstring(game:HttpGet(url))()
			end)
			if ok then
				u8:Notify({Title = cat or "Loaded", Content = name .. " loaded successfully!", Duration = 3})
			else
				u8:Notify({Title = "Error", Content = "Failed to load " .. name .. ": " .. tostring(err):sub(1, 60), Duration = 5})
			end
		end
	})
	tab:Space()
end

-- UNIVERSAL TAB
local Universal = Window:Tab({Title = "Universal", Icon = "solar:home-2-bold", IconColor = color3_3, IconShape = "Square"})
Universal:Section({Title = "Universal Scripts", TextSize = 18})
AddScript(Universal, "Infinite Yield", "Admin commands script", "terminal", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "Universal")
AddScript(Universal, "Dex Explorer", "Game explorer", "search", "https://raw.githubusercontent.com/infyiff/backup/main/dex.lua", "Universal")
AddScript(Universal, "Universal Aimbot", "Good aimbot for FPS games", "crosshair", "https://raw.githubusercontent.com/Sabscripterhahaha/Universal/refs/heads/main/Universal", "Universal")
AddScript(Universal, "Hitbox Expander", "Expands player hitboxes", "plane", "https://pastefy.app/vnXSigC1/raw", "Universal")
AddScript(Universal, "Universal ESP", "See through walls", "eye", "https://pastefy.app/KMJTFNsg/raw", "Universal")
AddScript(Universal, "Cryonix Hub", "Lots of scripts", "search", "", "Universal")
AddScript(Universal, "Chat Bypasser", "Bypasses chat filters", "star", "", "Universal")

-- MURDER MYSTERY 2 TAB
local MurderMystery2 = Window:Tab({Title = "Murder Mystery 2", Icon = "solar:danger-triangle-bold", IconColor = color3_5, IconShape = "Square"})
MurderMystery2:Section({Title = "Best MM2 Scripts", TextSize = 18})
AddScript(MurderMystery2, "Vertex (Keyless)", "Complete MM2 hub â€” Aimbot, ESP, Auto Farm, Teleport", "crosshair", "https://raw.smokingscripts.org/vertex.lua", "Murder Mystery 2")
AddScript(MurderMystery2, "YARHM (Keyless)", "Aimbot, Silent Aim, ESP, Auto Shoot", "target", "https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/yarhm.lua", "Murder Mystery 2")
AddScript(MurderMystery2, "Kuni Hub (Keyless)", "ESP, Auto Farm, Teleport, Box Spawner", "coins", "https://gitlab.com/rlbx-scripts/elysium/-/raw/main/mm2-visual", "Murder Mystery 2")
AddScript(MurderMystery2, "Moon Deity (Key)", "Full MM2 â€” Aimbot, ESP, Dupe, Teleport", "eye", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader", "Murder Mystery 2")
AddScript(MurderMystery2, "Forge Hub (Key)", "Aimbot, ESP, Auto Farm, Utilities", "zap", "https://api.luarmor.net/files/v3/loaders/d5ed1fbd4301b1d18d75153c5b47181d.lua", "Murder Mystery 2")
AddScript(MurderMystery2, "Syl Hub (Key)", "ESP, Aimbot, Walkspeed, Jump Power", "zap", "https://raw.githubusercontent.com/de-ishi/syl/refs/heads/main/mainLoader", "Murder Mystery 2")
AddScript(MurderMystery2, "Nike Hub", "Aimbot, Silent ESP, No Recoil, More", "zap", "https://pastefy.app/xkn36s9B/raw", "Murder Mystery 2")
AddScript(MurderMystery2, "Freeze Trade / Trade Control", "Freeze trade & prevent scam", "snowflake", "https://pastefy.app/ZR2AxdTO/raw", "Murder Mystery 2")
AddScript(MurderMystery2, "Item Spawner", "Spawn any weapon / item", "star", "https://raw.githubusercontent.com/Wonik99/library-hub/refs/heads/main/BestScript", "Murder Mystery 2")
MurderMystery2:Space({Columns = 2})

MurderMystery2:Section({Title = "Weapon Tools", TextSize = 18})
local u33
pcall(function()
	if LocalPlayer.PlayerGui:FindFirstChild("MainGUI") then
		if LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Inventory") then
			u33 = LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main
		else
			u33 = LocalPlayer.PlayerGui.MainGUI.Lobby.Screens.Inventory.Main
		end
	end
end)

local function GetRandomBox()
	local ok, res = pcall(function() return require(ReplicatedStorage.Database.Sync.MysteryBox) end)
	if not ok or not res or next(res) == nil then return "StandardBox" end
	local t = {}
	for k, _ in pairs(res) do table.insert(t, k) end
	return t[math.random(1, #t)]
end

local function SpawnWeapon(name)
	if not name or name == "" then
		u8:Notify({Title = "Error", Content = "Enter a valid weapon name", Icon = "solar:close-circle-bold", Duration = 3})
		return
	end
	pcall(function()
		local BoxMod = require(ReplicatedStorage.Modules.BoxModule)
		local ItemDB = require(ReplicatedStorage.Database.Sync.Item)
		if ItemDB[name] then
			BoxMod.OpenBox(GetRandomBox(), name)
			pcall(function()
				local env = getsenv and getsenv(LocalPlayer.PlayerGui.MainGUI.Inventory.NewItem)
				if env and env._G and env._G.NewItem then
					env._G.NewItem(name, nil, nil, "Weapons", 1)
				end
			end)
			u8:Notify({Title = "Success", Content = "Spawned: " .. name, Icon = "solar:check-circle-bold", Duration = 3})
		else
			u8:Notify({Title = "Error", Content = "Weapon not found: " .. name, Icon = "solar:close-circle-bold", Duration = 3})
		end
	end)
end

local function DupeItem(name, count)
	task.wait(math.random(1, 3))
	if not u33 then return end
	count = tonumber(count) or 1
	for _ = 1, count do
		for _, c in pairs(u33.Weapons.Items.Container:GetChildren()) do
			for _, c2 in pairs(c.Container:GetChildren()) do
				local isSeasonal = c2.Name == "Christmas" or c2.Name == "Halloween"
				local target = isSeasonal and c2.Container or c.Container
				for _, c3 in pairs(target:GetChildren()) do
					if c3:IsA("Frame") and c3.ItemName and c3.ItemName.Label and c3.ItemName.Label.Text == name then
						local amt = c3.Container and c3.Container.Amount
						if amt then
							if amt.Text == "" or amt.Text == "None" then
								amt.Text = "x2"
							else
								local n = tonumber(string.match(amt.Text, "x(%d+)"))
								if n then amt.Text = "x" .. tostring(n + 1) end
							end
						end
					end
				end
			end
		end
	end
end

local function DupeAll()
	task.wait(math.random(3, 5))
	if not u33 then return end
	for _, c in pairs(u33.Weapons.Items.Container:GetChildren()) do
		for _, c2 in pairs(c.Container:GetChildren()) do
			local isSeasonal = c2.Name == "Christmas" or c2.Name == "Halloween"
			local target = isSeasonal and c2.Container or c.Container
			for _, c3 in pairs(target:GetChildren()) do
				if c3:IsA("Frame") and c3.ItemName and c3.ItemName.Label then
					local txt = c3.ItemName.Label.Text
					if txt ~= "Default Knife" and txt ~= "Default Gun" then
						local amt = c3.Container and c3.Container.Amount
						if amt then
							if amt.Text == "" or amt.Text == "None" then
								amt.Text = "x2"
							else
								local n = tonumber(string.match(amt.Text, "x(%d+)"))
								if n then amt.Text = "x" .. tostring(n * 2) end
							end
						end
					end
				end
			end
		end
	end
	if u33.Pets and u33.Pets.Items and u33.Pets.Items.Container and u33.Pets.Items.Container.Current then
		for _, c in pairs(u33.Pets.Items.Container.Current.Container:GetChildren()) do
			if c:IsA("Frame") and c.Container and c.Container.Amount then
				local amt = c.Container.Amount
				if amt.Text == "" or amt.Text == "None" then
					amt.Text = "x2"
				else
					local n = tonumber(string.match(amt.Text, "x(%d+)"))
					if n then amt.Text = "x" .. tostring(n * 2) end
				end
			end
		end
	end
end

local function MatchStr(a, b)
	if not a or not b then return false end
	return string.lower(string.gsub(string.gsub(a, "_G_%d%d%d%d", ""), "_K_%d%d%d%d", "")):find(string.lower(b), 1, true) ~= nil
end

local function ChangeVisual(from, to)
	if not from or from == "" or not to or to == "" then
		u8:Notify({Title = "Error", Content = "Fill both fields!", Duration = 3})
		return
	end
	pcall(function()
		local ItemDB = require(ReplicatedStorage.Database.Sync.Item)
		local f, t = {}, {}
		for k, _ in pairs(ItemDB) do
			if MatchStr(k, from) then table.insert(f, k) end
			if MatchStr(k, to) then table.insert(t, k) end
		end
		if #f > 0 and #t > 0 then
			for _, src in ipairs(f) do
				for _, dst in ipairs(t) do
					ItemDB[src] = {}
					for k, v in pairs(ItemDB[dst]) do ItemDB[src][k] = v end
					pcall(function() ReplicatedStorage.Remotes.Inventory.Equip:FireServer(dst) end)
				end
			end
			u8:Notify({Title = "Success", Content = "Weapon visual changed!", Icon = "solar:check-circle-bold", Duration = 3})
		else
			u8:Notify({Title = "Error", Content = "Weapon not found!", Icon = "solar:close-circle-bold", Duration = 3})
		end
	end)
end

local function VisualTradeActive()
	local gui = LocalPlayer.PlayerGui:FindFirstChild("TradeGUI") or LocalPlayer.PlayerGui:FindFirstChild("TradeGUI_Phone")
	if gui and gui.Enabled then
		task.wait(1)
		u8:Notify({Title = "Trade Scam Active", Content = "Items are now visual only!", Icon = "solar:danger-bold", Duration = 5})
	else
		u8:Notify({Title = "Error", Content = "Open a trade first!", Icon = "solar:close-circle-bold", Duration = 5})
	end
end

local weaponName = ""
MurderMystery2:Paragraph({Title = "Weapon Spawner", Desc = "Spawn any weapon by name (e.g. CandyBlade)"})
MurderMystery2:Input({Flag = "MM2WeaponName", Title = "Weapon Name", Desc = "Enter item name", Placeholder = "e.g. Lightbringer", Callback = function(s) weaponName = s end})
MurderMystery2:Button({Title = "Spawn Weapon", Icon = "solar:star-bold", Color = color3_7, Callback = function()
	SpawnWeapon(weaponName)
end})
MurderMystery2:Space()

local dupeName = ""
local dupeCount = 1
MurderMystery2:Paragraph({Title = "Weapon Duplication", Desc = "Visual duplication only"})
MurderMystery2:Input({Flag = "MM2DupeName", Title = "Weapon Name", Placeholder = "e.g. Lightbringer", Callback = function(s) dupeName = s end})
MurderMystery2:Input({Flag = "MM2DupeAmt", Title = "Duplicate Count", Placeholder = "1", Value = "1", Callback = function(s) dupeCount = tonumber(s) or 1 end})
MurderMystery2:Button({Title = "Duplicate Weapon", Icon = "solar:layers-bold", Color = color3_8, Callback = function()
	if dupeName == "" then u8:Notify({Title = "Error", Content = "Enter a weapon name!", Duration = 3}) return end
	u8:Notify({Title = "Duplicating", Content = "Duping " .. dupeName .. "...", Icon = "solar:hourglass-bold", Duration = 2})
	DupeItem(dupeName, dupeCount)
	u8:Notify({Title = "Complete", Content = "Duplicated " .. dupeName .. "!", Icon = "solar:check-circle-bold", Duration = 3})
end})
MurderMystery2:Button({Title = "Duplicate All", Desc = "Weapons & pets", Icon = "solar:archive-bold", Color = color3, Callback = function()
	u8:Notify({Title = "Duplicating", Content = "Duping inventory...", Icon = "solar:hourglass-bold", Duration = 2})
	DupeAll()
	u8:Notify({Title = "Complete", Content = "Inventory duplicated!", Icon = "solar:check-circle-bold", Duration = 3})
end})
MurderMystery2:Space()

local visFrom, visTo = "", ""
MurderMystery2:Paragraph({Title = "Visual Changer", Desc = "Change weapon appearance"})
MurderMystery2:Input({Flag = "VisFrom", Title = "Replace This", Placeholder = "e.g. Blossom", Callback = function(s) visFrom = s end})
MurderMystery2:Input({Flag = "VisTo", Title = "Appearance", Placeholder = "e.g. Chroma", Callback = function(s) visTo = s end})
MurderMystery2:Button({Title = "Apply Visual", Icon = "solar:magic-stick-bold", Color = color3_4, Callback = function()
	ChangeVisual(visFrom, visTo)
end})
MurderMystery2:Space()

local tradeToggle = false
MurderMystery2:Paragraph({Title = "Visual Trade", Desc = "Make trade items visual only"})
MurderMystery2:Toggle({Flag = "VisTradeToggle", Title = "Enable Visual Trade", Default = false, Callback = function(b)
	tradeToggle = b
	u8:Notify({Title = "Visual Trade", Content = b and "Enabled!" or "Disabled!", Icon = b and "solar:shield-check-bold" or "solar:shield-cross-bold", Duration = 2})
end})
MurderMystery2:Button({Title = "Activate Trade Scam", Icon = "solar:danger-bold", Color = color3_5, Callback = function()
	if not tradeToggle then u8:Notify({Title = "Error", Content = "Enable toggle first!", Duration = 3}) return end
	VisualTradeActive()
end})

-- SAB TAB
local SAB = Window:Tab({Title = "Steal A Brainrot", Icon = "solar:ghost-bold", IconColor = Color3.fromHex("#9D4EDD"), IconShape = "Square"})
SAB:Section({Title = "SAB Scripts", TextSize = 18})
AddScript(SAB, "Auto Moreiera #1", "High-tier bot join", "eye", "", "SAB")
AddScript(SAB, "Auto Moreiera #2", "High-tier bot join", "eye", "", "SAB")
AddScript(SAB, "Trax Spawner (Key)", "Brainrot spawner", "zap", "", "SAB")
AddScript(SAB, "Rift Hub (Keyless)", "OP SAB hub", "zap", "", "SAB")
AddScript(SAB, "Chili Hub (Keyless)", "Desync utilities", "zap", "", "SAB")
AddScript(SAB, "Lemon Hub (Keyless)", "PvP desync", "zap", "", "SAB")

-- ADOPT ME TAB
local ADM = Window:Tab({Title = "Adopt Me", Icon = "solar:heart-bold", IconColor = color3_6, IconShape = "Square"})
ADM:Section({Title = "Adopt Me Scripts", TextSize = 18})
AddScript(ADM, "Trade Scam / Freeze", "Visual trade scam", "snowflake", "", "ADM")
AddScript(ADM, "House Cloner", "Clone houses", "copy", "", "ADM")
AddScript(ADM, "Candy Egg Auto Farm", "Sugarfest event", "egg", "", "ADM")
AddScript(ADM, "Pet Duplicator", "Duplicate pets", "copy", "", "ADM")
AddScript(ADM, "Pet Spawner", "Spawn tradeable pets", "sparkles", "", "ADM")
AddScript(ADM, "Rampage Hub (Key)", "Auto-farm & minigames", "zap", "", "ADM")
AddScript(ADM, "Ragesploit Hub (Key)", "Auto-farm & utilities", "snowflake", "", "ADM")

-- MISC TAB
local Misc = Window:Tab({Title = "Misc", Icon = "solar:settings-bold", IconColor = color3_2, IconShape = "Square"})
Misc:Section({Title = "Utilities", TextSize = 18})
Misc:Button({Title = "Anti AFK", Icon = "clock", Callback = function()
	Players.LocalPlayer.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
	u8:Notify({Title = "Anti AFK", Content = "Enabled â€” no idle kick", Duration = 3})
end})
Misc:Space()
Misc:Button({Title = "Rejoin", Icon = "refresh-cw", Callback = function()
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
end})
Misc:Space()
Misc:Button({Title = "Server Hop", Icon = "shuffle", Callback = function()
	local placeId = game.PlaceId
	local jobId = game.JobId
	local list, cursor = {}, ""
	repeat
		local ok, res = pcall(function()
			local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s", placeId, cursor)
			return HttpService:JSONDecode(game:HttpGet(url))
		end)
		if ok and res then
			cursor = res.nextPageCursor or ""
			for _, s in pairs(res.data or {}) do
				if s.id ~= jobId and s.playing < s.maxPlayers then
					table.insert(list, s)
				end
			end
		end
	until cursor == "" or #list >= 10
	if #list > 0 then
		TeleportService:TeleportToPlaceInstance(placeId, list[math.random(1, #list)].id, Players.LocalPlayer)
	else
		u8:Notify({Title = "Server Hop", Content = "No servers found!", Duration = 3})
	end
end})
Misc:Space()

local walkSpeed = 16
Misc:Slider({Title = "Walk Speed", Min = 16, Max = 200, Default = 16, Callback = function(v)
	walkSpeed = v
	local c = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
	if c then c.WalkSpeed = v end
end})
Players.LocalPlayer.CharacterAdded:Connect(function(c)
	task.wait(0.5)
	local h = c:FindFirstChild("Humanoid")
	if h then h.WalkSpeed = walkSpeed end
end)
Misc:Space()

local jumpPower = 50
Misc:Slider({Title = "Jump Power", Min = 50, Max = 300, Default = 50, Callback = function(v)
	jumpPower = v
	local c = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
	if c then c.JumpPower = v end
end})
Players.LocalPlayer.CharacterAdded:Connect(function(c)
	task.wait(0.5)
	local h = c:FindFirstChild("Humanoid")
	if h then h.JumpPower = jumpPower end
end)

u8:Notify({Title = "Darth Hub Loaded", Content = "Welcome! Select a tab to begin.", Icon = "solar:check-circle-bold", Duration = 5})
