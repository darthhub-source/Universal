local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local UserInputService = game:GetService("UserInputService")
local DISPLAY_REFRESH = 0.08
local AIM_LOOP_DELAY = 0.03
local VIS_CHECK_DELAY = 0.12
local AIMBOT_UPDATE_INTERVAL = 0.03
local espTimer = 0
local aimTimer = 0
local visTimer = 0
local targetList = {}
local sightCache = {}
local PlayerList = {}
local Settings = {
    AimActive = false,
    IncludeTeammates = true,
    CheckObstructions = true,
    AimRange = 50,
    AimTargetBone = "Head",
    ShowRangeCircle = true,
    ESP = {
        BoxDraw = false,
        Highlight = false,
        PlayerName = false,
        ShowDistance = false,
        ShowTeammates = false
    },
    FlyMode = false,
    FlyRate = 50,
    NoCollision = false,
    BaseSpeed = 16,
    BaseJump = 50,
    UnlimitedJump = false,
    PickedTarget = nil,
    SavedLocation = nil
}
local ColorScheme = {
    Accent = Color3.fromRGB(45, 125, 255),
    Background = Color3.fromRGB(15, 20, 30),
    Shade = Color3.fromRGB(22, 48, 90),
    Text = Color3.fromRGB(235, 242, 255),
    Dimmed = Color3.fromRGB(145, 170, 205),
}
local LoadMessages = {
    "Starting Darth Scripts...",
    "Loading components...",
    "Building interface...",
    "Finishing up...",
}
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Darth Scripts",
    Icon = "crosshair",
    LoadingTitle = "Darth Scripts",
    LoadingSubtitle = "Universal Script",
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local Tabs = {
    Aimbot = Window:CreateTab("Aimbot", "crosshair"),
    Targeting = Window:CreateTab("Targeting", "locate-fixed"),
    Range = Window:CreateTab("Aimbot Range", "scan"),
    ESP = Window:CreateTab("ESP", "eye"),
    ESPInfo = Window:CreateTab("ESP Info", "badge-info"),
    Movement = Window:CreateTab("Movement", "move"),
    Character = Window:CreateTab("Character", "person-standing"),
    Teleport = Window:CreateTab("Teleport", "map-pin")
}

Tabs.Aimbot:CreateSection("Aimbot")
Tabs.Aimbot:CreateParagraph({
    Title = "Darth Scripts",
    Content = "Universal Aimbot"
})

Tabs.Aimbot:CreateToggle({
    Name = "Enable Aimbot",
    CurrentValue = Settings.AimActive,
    Callback = function(Value)
        Settings.AimActive = Value
    end
})

Tabs.Aimbot:CreateToggle({
    Name = "Lock Teammates",
    CurrentValue = Settings.IncludeTeammates,
    Callback = function(Value)
        Settings.IncludeTeammates = Value
    end
})

Tabs.Aimbot:CreateToggle({
    Name = "Check Walls",
    CurrentValue = Settings.CheckObstructions,
    Callback = function(Value)
        Settings.CheckObstructions = Value
    end
})

Tabs.Targeting:CreateSection("Target Selection")
Tabs.Targeting:CreateDropdown({
    Name = "Target Part",
    Options = {"Head", "Torso"},
    CurrentOption = {Settings.AimTargetBone},
    MultipleOptions = false,
    Callback = function(Option)
        Settings.AimTargetBone = typeof(Option) == "table" and Option[1] or Option
    end
})

Tabs.Range:CreateSection("Range")
Tabs.Range:CreateToggle({
    Name = "Show Range",
    CurrentValue = Settings.ShowRangeCircle,
    Callback = function(Value)
        Settings.ShowRangeCircle = Value
    end
})

Tabs.Range:CreateSlider({
    Name = "Aimbot Range",
    Range = {10, 500},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = Settings.AimRange,
    Callback = function(Value)
        Settings.AimRange = math.floor(Value + 0.5)
    end
})

Tabs.ESP:CreateSection("ESP Visuals")
Tabs.ESP:CreateParagraph({
    Title = "ESP Settings",
    Content = "Player visualization"
})

Tabs.ESP:CreateToggle({
    Name = "Box ESP",
    CurrentValue = Settings.ESP.BoxDraw,
    Callback = function(Value)
        Settings.ESP.BoxDraw = Value
    end
})

Tabs.ESP:CreateToggle({
    Name = "Outline ESP",
    CurrentValue = Settings.ESP.Highlight,
    Callback = function(Value)
        Settings.ESP.Highlight = Value
    end
})

Tabs.ESPInfo:CreateSection("ESP Information")
Tabs.ESPInfo:CreateToggle({
    Name = "Player Name",
    CurrentValue = Settings.ESP.PlayerName,
    Callback = function(Value)
        Settings.ESP.PlayerName = Value
    end
})

Tabs.ESPInfo:CreateToggle({
    Name = "Distance",
    CurrentValue = Settings.ESP.ShowDistance,
    Callback = function(Value)
        Settings.ESP.ShowDistance = Value
    end
})

Tabs.ESPInfo:CreateToggle({
    Name = "Show Teammates",
    CurrentValue = Settings.ESP.ShowTeammates,
    Callback = function(Value)
        Settings.ESP.ShowTeammates = Value
    end
})

Tabs.Movement:CreateSection("Flight")
Tabs.Movement:CreateToggle({
    Name = "Enable Fly",
    CurrentValue = Settings.FlyMode,
    Callback = function(Value)
        Settings.FlyMode = Value
    end
})

Tabs.Movement:CreateSlider({
    Name = "Fly Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = " speed",
    CurrentValue = Settings.FlyRate,
    Callback = function(Value)
        Settings.FlyRate = math.floor(Value + 0.5)
    end
})

Tabs.Movement:CreateToggle({
    Name = "No Clip",
    CurrentValue = Settings.NoCollision,
    Callback = function(Value)
        Settings.NoCollision = Value
    end
})

Tabs.Character:CreateSection("Character")
Tabs.Character:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = " speed",
    CurrentValue = Settings.BaseSpeed,
    Callback = function(Value)
        Settings.BaseSpeed = math.floor(Value + 0.5)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.BaseSpeed
        end
    end
})

Tabs.Character:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    Suffix = " power",
    CurrentValue = Settings.BaseJump,
    Callback = function(Value)
        Settings.BaseJump = math.floor(Value + 0.5)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Settings.BaseJump
        end
    end
})

Tabs.Character:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = Settings.UnlimitedJump,
    Callback = function(Value)
        Settings.UnlimitedJump = Value
    end
})

Tabs.Teleport:CreateSection("Teleport")
Tabs.Teleport:CreateButton({
    Name = "TP To Nearest",
    Callback = function()
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        local root = character.HumanoidRootPart
        local closestTarget, closestDistance = nil, math.huge
        for player, _ in pairs(PlayerList) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (root.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = player
                end
            end
        end
        if closestTarget and closestTarget.Character and closestTarget.Character:FindFirstChild("HumanoidRootPart") then
            Settings.SavedLocation = root.CFrame
            root.CFrame = closestTarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end
})

Tabs.Teleport:CreateButton({
    Name = "Return Location",
    Callback = function()
        if not Settings.SavedLocation then return end
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = Settings.SavedLocation
        end
    end
})

Rayfield:Notify({
    Title = "Nimzo Scripts",
    Content = "Universal interface loaded.",
    Duration = 4
})

local ESPStorage = {}
local function AttachESP(player)
    if player == LocalPlayer then return end
    local function SetupChar(character)
        local rootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not rootPart then return end
        if ESPStorage[player] then
            for _, resource in pairs(ESPStorage[player]) do
                if typeof(resource) == "Instance" then pcall(function() resource:Destroy() end) end
            end
        end
        local Box = Instance.new("BoxHandleAdornment", Workspace)
        Box.Adornee = character
        Box.Size = Vector3.new(4, 6, 2)
        Box.AlwaysOnTop = true
        Box.ZIndex = 5
        Box.Transparency = 0.6
        local Outline = Instance.new("Highlight", Workspace)
        Outline.Adornee = character
        Outline.FillTransparency = 1
        Outline.OutlineTransparency = 0
        Outline.OutlineColor = ColorScheme.Accent
        Outline.Enabled = false
        local NameTag = Instance.new("BillboardGui", Workspace)
        NameTag.Adornee = rootPart
        NameTag.Size = UDim2.new(0, 120, 0, 40)
        NameTag.StudsOffset = Vector3.new(0, 3, 0)
        NameTag.AlwaysOnTop = true
        local TagText = Instance.new("TextLabel", NameTag)
        TagText.Size = UDim2.new(1, 0, 1, 0)
        TagText.BackgroundTransparency = 1
        TagText.Font = Enum.Font.GothamBold
        TagText.TextSize = 12
        ESPStorage[player] = {Box = Box, Outline = Outline, Tag = NameTag, Label = TagText, Root = rootPart, Char = character}
    end
    if player.Character then SetupChar(player.Character) end
    player.CharacterAdded:Connect(SetupChar)
end
local function RegisterPlayer(player)
    if player ~= LocalPlayer then PlayerList[player] = true; AttachESP(player) end
end
local function UnregisterPlayer(player)
    PlayerList[player] = nil
    sightCache[player] = nil
    if ESPStorage[player] then
        for _, resource in pairs(ESPStorage[player]) do
            if typeof(resource) == "Instance" then pcall(function() resource:Destroy() end) end
        end
        ESPStorage[player] = nil
    end
end
for _, player in ipairs(Players:GetPlayers()) do RegisterPlayer(player) end
Players.PlayerAdded:Connect(RegisterPlayer)
Players.PlayerRemoving:Connect(UnregisterPlayer)
UserInputService.JumpRequest:Connect(function()
    if Settings.UnlimitedJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)
RunService.RenderStepped:Connect(function()
    if Settings.FlyMode then
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then return end
        local root = character.HumanoidRootPart
        local human = character.Humanoid
        human.PlatformStand = true
        local view = Camera.CFrame
        local moveVector = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector += view.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector -= view.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector -= view.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector += view.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVector -= Vector3.new(0, 1, 0) end
        root.AssemblyLinearVelocity = moveVector * Settings.FlyRate
    else
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.PlatformStand = false
        end
    end
    if Settings.NoCollision then
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)
RunService.RenderStepped:Connect(function(delta)
    visTimer += delta
    espTimer += delta
    aimTimer += delta
    local CheckVision = visTimer >= VIS_CHECK_DELAY
    local RefreshESP = espTimer >= DISPLAY_REFRESH
    local RefreshAim = aimTimer >= AIMBOT_UPDATE_INTERVAL
    if CheckVision then visTimer = 0 end
    if RefreshESP then espTimer = 0 end
    if RefreshAim then aimTimer = 0 end
    local CameraPos = Camera.CFrame.Position
    local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if RefreshESP then
        for player, _ in pairs(PlayerList) do
            local data = ESPStorage[player]
            if data and data.Char and data.Root then
                local human = data.Char:FindFirstChild("Humanoid")
                if human and human.Health > 0 then
                    local ShowThis = not SameTeam(player) or Settings.ESP.ShowTeammates
                    local ColorCode = GetTeamColor(player)
                    data.Box.Visible = Settings.ESP.BoxDraw and ShowThis
                    data.Box.Color3 = ColorCode
                    data.Outline.Enabled = Settings.ESP.Highlight and ShowThis
                    data.Outline.OutlineColor = ColorCode
                    local TagActive = ShowThis and (Settings.ESP.PlayerName or Settings.ESP.ShowDistance)
                    data.Tag.Enabled = TagActive
                    if TagActive then
                        local DisplayText = ""
                        if Settings.ESP.PlayerName then DisplayText = player.Name end
                        if Settings.ESP.ShowDistance then
                            local Range = DistanceBetween(CameraPos, data.Root.Position)
                            DisplayText = DisplayText ~= "" and DisplayText .. " [" .. Range .. "]" or Range .. " studs"
                        end
                        data.Label.Text = DisplayText
                        data.Label.TextColor3 = ColorCode
                    end
                else
                    data.Box.Visible = false
                    data.Outline.Enabled = false
                    data.Tag.Enabled = false
                end
            end
        end
    end
    if RangeCircle then
        RangeCircle.Visible = Settings.ShowRangeCircle
        RangeCircle.Radius = Settings.AimRange
        RangeCircle.Position = ScreenCenter
    end
    if RefreshAim then
        targetList = {}
        for player, _ in pairs(PlayerList) do
            local character = player.Character
            if character then
                local human = character:FindFirstChild("Humanoid")
                local bone = character:FindFirstChild(Settings.AimTargetBone == "Head" and "Head" or "HumanoidRootPart")
                if human and human.Health > 0 and bone then
                    if not (Settings.IncludeTeammates and SameTeam(player)) then
                        local ScreenPos, OnScreen = Camera:WorldToViewportPoint(bone.Position)
                        if OnScreen then
                            local Offset = (Vector2.new(ScreenPos.X, ScreenPos.Y) - ScreenCenter).Magnitude
                            if Offset <= Settings.AimRange then
                                table.insert(targetList, {Bone = bone, Distance = Offset, Owner = player})
                            end
                        end
                    end
                end
            end
        end
        table.sort(targetList, function(a, b) return a.Distance < b.Distance end)
    end
    if Settings.AimActive and #targetList > 0 then
        for index = 1, #targetList do
            local Target = targetList[index]
            if Settings.CheckObstructions then
                if CheckVision then sightCache[Target.Owner] = CanSee(Target.Bone) end
                if not sightCache[Target.Owner] then continue end
            end
            Camera.CFrame = CFrame.lookAt(CameraPos, Target.Bone.Position)
            break
        end
    end
end)
