local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Rey Exploit", 
    
    Accent = WindUI:Gradient({                                                  
        ["0"] = { Color = Color3.fromHex("#1f1f23"), Transparency = 0 },        
        ["100"]   = { Color = Color3.fromHex("#18181b"), Transparency = 0 },    
    }, {                                                                        
        Rotation = 0,                                                           
    }),                                                                         
    Dialog = Color3.fromHex("#161616"),
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Background = Color3.fromHex("#101010"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a1a1aa")
})
local Window = WindUI:CreateWindow({
    Title = "ReyExploit",
    Icon = "rbxassetid://106899268176689", 
    Author = "Rey X Mount",
    Folder = "ReyConfig",
    
    Size = UDim2.fromOffset(530, 300),
    MinSize = Vector2.new(320, 300),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = false,
})

Window:SetToggleKey(Enum.KeyCode.G)

WindUI:Notify({
    Title = "ReyLoader",
    Content = "Press G To Open/Close Menu!",
    Duration = 4, 
    Icon = "slack",
})

Window:EditOpenButton({
    Title = "VOTYEXCommunity",
    Icon = "rbxassetid://106899268176689",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = true,
    Enabled = true,
    Draggable = true,
})

Window:SetIconSize(35) 
Window:Tag({
    Title = "Premium",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 13, -- from 0 to 13
})
---------------- TAB ---------------

local Info = Window:Tab({
    Title = "Info",
    Icon = "info", 
    Locked = false,
})

local Player = Window:Tab({
    Title = "Player",
    Icon = "user", 
    Locked = false,
})

local Auto = Window:Tab({
    Title = "Auto Summit",
    Icon = "tent-tree", 
    Locked = false,
})

local Walk = Window:Tab({
    Title = "Auto Walk",
    Icon = "bug-play", 
    Locked = false,
})

local Teleport = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
    Locked = false,
})

local Tools = Window:Tab({
    Title = "Tools",
    Icon = "settings", 
    Locked = false,
})

local Danger = Window:Tab({
    Title = "Danger Menu",
    Icon = "skull", 
    Locked = false,
})

----------- END OF TAB -------------
local Section = Info:Section({ 
    Title = "Have Problem / Need Help? Join Server Now",
    Box = true,
    TextTransparency = 0.05,
    TextXAlignment = "Center",
    TextSize = 17, 
    Opened = true,
})

Info:Select()

local function copyLink(link, buttonTitle, notifTitle, notifContent)
    local Button = Info:Button({
        Title = buttonTitle or "Copy Link",
        Desc = "Klik untuk menyalin link",
        Locked = false,
        Callback = function()
            if setclipboard then
                setclipboard(link)
            end

            WindUI:Notify({
                Title = notifTitle or "Copied!",
                Content = notifContent or ("Link '" .. link .. "' berhasil dicopy ✅"),
                Duration = 3,
                Icon = "bell",
            })

            print("Link copied:", link) -- optional log
        end
    })

    return Button
end


copyLink(
    "https://discord.gg/TzepzgpY", 
    "Copy Discord Link",              
    "Discord Copied!",                 
    "Link berhasil disalin ke clipboard ✅" 
)

------------- END OF TAB DISCORD -------------------

local Section = Player:Section({ 
    Title = "Player Feature",
})

local WalkSpeedInput = Player:Input({
    Title = "Set WalkSpeed",
    Placeholder = "Masukkan angka, contoh: 50",
    Callback = function(value)
        WalkSpeedInput.Value = tonumber(value) or 16
    end
})


local WalkSpeedToggle = Player:Toggle({
    Title = "WalkSpeed",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if state then
           
            humanoid.WalkSpeed = WalkSpeedInput.Value or 16
        else
           
            humanoid.WalkSpeed = 16
        end
    end
})

Player:Space()
Player:Divider()

local InfiniteJumpConnection = nil

local InfiniteJumpToggle = Player:Toggle({
    Title = "Infinite Jump",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        
        if state then
            InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if InfiniteJumpConnection then
                InfiniteJumpConnection:Disconnect()
                InfiniteJumpConnection = nil
            end
        end
    end
})

local NoClipConnection = nil

local NoClipToggle = Player:Toggle({
    Title = "NoClip",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        
        if state then
            NoClipConnection = game:GetService("RunService").Stepped:Connect(function()
                local character = player.Character
                if character then
                    for _, part in ipairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end
            
            local character = player.Character
            if character then
                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

local NoFallToggle = Player:Toggle({
    Title = "No Fall Damage",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local heartbeat = game:GetService("RunService").Heartbeat
        local rstepped = game:GetService("RunService").RenderStepped
        local zeroVec = Vector3.new(0,0,0)
        local noFallConnection = nil
        local enabled = state

        local function enableNoFall(chr)
            local root = chr:WaitForChild("HumanoidRootPart", 5)
            if not root then return end

            noFallConnection = heartbeat:Connect(function()
                if not root.Parent then
                    if noFallConnection then
                        noFallConnection:Disconnect()
                        noFallConnection = nil
                    end
                    return
                end

                local oldvel = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = zeroVec
                rstepped:Wait()
                root.AssemblyLinearVelocity = oldvel
            end)
        end

        local function disableNoFall()
            if noFallConnection then
                noFallConnection:Disconnect()
                noFallConnection = nil
            end
        end

        if state then
            if player.Character then
                enableNoFall(player.Character)
            end
            player.CharacterAdded:Connect(function(char)
                if NoFallToggle.Value then
                    enableNoFall(char)
                end
            end)
        else
            disableNoFall()
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    textSize = 20,
    textStrokeTransparency = 0.6,
    yOffset = 2,
}

local currentName = "FyyOnTOP#1 👑"
local customGui
local conns = {}
local hiddenGuis = {}
local enabled = false

local function rainbowColor(t)
    local r = math.sin(t*2) * 127 + 128
    local g = math.sin(t*2 + 2) * 127 + 128
    local b = math.sin(t*2 + 4) * 127 + 128
    return Color3.fromRGB(r,g,b)
end

local function hideGuiIfTarget(gui)
    if (gui:IsA("BillboardGui") or gui:IsA("SurfaceGui")) and gui.Name ~= "FyyOnTOP#1" then
        if gui.Enabled ~= false then
            hiddenGuis[gui] = true
            gui.Enabled = false
        end
    end
end

local function restoreHiddenGuis()
    for gui in pairs(hiddenGuis) do
        if gui and gui.Parent then
            pcall(function()
                gui.Enabled = true
            end)
        end
    end
    hiddenGuis = {}
end

local function createNameTag(character)
    local head = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")
    if not head then return end

    if customGui then
        customGui:Destroy()
        customGui = nil
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FyyOnTOP#1"
    billboard.Adornee = head
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, CONFIG.yOffset, 0)
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = currentName
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = CONFIG.textSize
    label.TextStrokeTransparency = CONFIG.textStrokeTransparency
    label.TextColor3 = Color3.fromRGB(255,0,0)
    label.TextScaled = false
    label.Parent = billboard

    local t = 0
    local conn = RunService.RenderStepped:Connect(function(dt)
        if not billboard.Parent then
            pcall(function() conn:Disconnect() end)
            return
        end
        t = t + dt
        label.TextColor3 = rainbowColor(t)
        label.Text = currentName
    end)

    table.insert(conns, conn)
    customGui = billboard
end

local function hideDefaultNameTag(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        pcall(function()
            humanoid.NameDisplayDistance = 0
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end)
    end

    local head = character:FindFirstChild("Head")
    if head then
        for _, gui in ipairs(head:GetChildren()) do
            hideGuiIfTarget(gui)
        end
        local conn = head.ChildAdded:Connect(function(child)
            task.defer(function()
                hideGuiIfTarget(child)
            end)
        end)
        table.insert(conns, conn)
    end
end

local function disconnectAll()
    for i = #conns, 1, -1 do
        local c = conns[i]
        pcall(function() 
            if c and typeof(c) == "RBXScriptConnection" then
                c:Disconnect()
            end
        end)
        conns[i] = nil
    end
end

local function setEnabled(state)
    enabled = state
    if state then
        if LocalPlayer.Character then
            hideDefaultNameTag(LocalPlayer.Character)
            createNameTag(LocalPlayer.Character)
        end
    else
        disconnectAll()
        if customGui then
            customGui:Destroy()
            customGui = nil
        end
        restoreHiddenGuis()
    end
end

_G.SetMyVisualName = function(newName)
    currentName = tostring(newName)
    if enabled and LocalPlayer.Character then
        createNameTag(LocalPlayer.Character)
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if enabled then
        task.delay(1, function()
            if enabled and char:FindFirstChild("HumanoidRootPart") then
                hideDefaultNameTag(char)
                createNameTag(char)
            end
        end)
    end
end)

setEnabled(false)

local HideNameToggle = Player:Toggle({
    Title = "Hide Name",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        setEnabled(Value)
    end
})

local espEnabled = false
local espConnections = {}

-- Function untuk enable ESP
local function enableESPForPlayer(plr)
    local char = plr.Character
    if not char then return end
    
    -- Hapus ESP lama jika ada
    if char:FindFirstChild("FyyESP") then
        char.FyyESP:Destroy()
    end
    if char:FindFirstChild("Head") and char.Head:FindFirstChild("FyyNameBill") then
        char.Head.FyyNameBill:Destroy()
    end
    
    -- Buat Highlight
    local hl = Instance.new("Highlight")
    hl.Name = "FyyESP"
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char
    
    -- Buat Billboard
    if char:FindFirstChild("Head") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "FyyNameBill"
        billboard.Size = UDim2.new(0, 100, 0, 20)
        billboard.StudsOffset = Vector3.new(0, 3.5, 0)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 500
        
        local tl = Instance.new("TextLabel")
        tl.Size = UDim2.new(1, 0, 1, 0)
        tl.BackgroundTransparency = 1
        tl.Text = plr.Name
        tl.TextColor3 = Color3.new(1, 1, 1)
        tl.TextStrokeColor3 = Color3.new(0, 0, 0)
        tl.TextStrokeTransparency = 0
        tl.TextScaled = true
        tl.Font = Enum.Font.GothamBold
        tl.Parent = billboard
        
        billboard.Parent = char.Head
    end
end

-- Function untuk disable ESP player
local function disableESPForPlayer(plr)
    local char = plr.Character
    if char then
        if char:FindFirstChild("FyyESP") then
            char.FyyESP:Destroy()
        end
        if char:FindFirstChild("Head") and char.Head:FindFirstChild("FyyNameBill") then
            char.Head.FyyNameBill:Destroy()
        end
    end
end

-- Function untuk setup ESP semua player
local function setupESP()
    -- Setup existing players
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= game:GetService("Players").LocalPlayer then
            if espEnabled then
                if plr.Character then
                    enableESPForPlayer(plr)
                end
                
                -- Connect character added
                espConnections[plr] = plr.CharacterAdded:Connect(function(char)
                    task.wait(1)
                    enableESPForPlayer(plr)
                end)
            else
                disableESPForPlayer(plr)
                if espConnections[plr] then
                    espConnections[plr]:Disconnect()
                    espConnections[plr] = nil
                end
            end
        end
    end
    
    -- Setup new players
    espConnections.playerAdded = game:GetService("Players").PlayerAdded:Connect(function(plr)
        if espEnabled then
            espConnections[plr] = plr.CharacterAdded:Connect(function(char)
                task.wait(1)
                enableESPForPlayer(plr)
            end)
        end
    end)
end

-- Toggle utama ESP
local ESPToggle = Player:Toggle({
    Title = "Player ESP",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        espEnabled = state
        
        if espEnabled then
            -- Enable ESP
            setupESP()
            WindUI:Notify({
                Title = "Player ESP",
                Content = "ESP Enabled",
                Duration = 3
            })
        else
            -- Disable ESP
            for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                if plr ~= game:GetService("Players").LocalPlayer then
                    disableESPForPlayer(plr)
                end
            end
            
            -- Cleanup connections
            for plr, connection in pairs(espConnections) do
                if connection then
                    connection:Disconnect()
                end
            end
            espConnections = {}
            
            WindUI:Notify({
                Title = "Player ESP",
                Content = "ESP Disabled",
                Duration = 3
            })
        end
    end
})

local AntiLagButton = Player:Button({
    Title = "Apply Anti Lag",
    Desc = "Optimalkan game untuk mengurangi lag",
    Callback = function()
        WindUI:Notify({
            Title = "Anti Lag",
            Content = "Mengaplikasikan optimasi...",
            Duration = 2,
            Icon = "loader",
        })
        
        local Lighting = game:GetService("Lighting")
        local Workspace = game:GetService("Workspace")
        local player = game.Players.LocalPlayer
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) then
                obj.Material = Enum.Material.Plastic
            end
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Sparkles") or obj:IsA("Smoke") or obj:IsA("Fire") then
                obj.Enabled = false
            end
        end

        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("DepthOfFieldEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = false
            end
        end

        local camera = Workspace.CurrentCamera
        for _, obj in ipairs(camera:GetChildren()) do
            if obj:IsA("BlurEffect") then
                obj.Enabled = false
            end
        end

        local sky = Lighting:FindFirstChildOfClass("Sky")
        if sky then
            sky.CelestialBodiesShown = false
            sky.StarCount = 0
        end

        Lighting.GlobalShadows = false
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.FogEnd = 100000
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj.Enabled = false
            end
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Sound") then
                obj.Playing = false
            end
        end
        
        WindUI:Notify({
            Title = "Anti Lag",
            Content = "Optimasi berhasil diaplikasikan!",
            Duration = 3,
            Icon = "check",
        })
    end
})

Player:Space()
Player:Divider()

local Section = Player:Section({
    Title = "Gui External",
    Opened = true,
})

local FlyButton = Player:Button({
    Title = "Fly GUI",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()

        WindUI:Notify({
            Title = "Fly",
            Content = "Fly GUI berhasil dijalankan ✅",
            Duration = 3,
            Icon = "bell"
        })
    end
})

---------------- END OF PLAYER ------------------
local Section = Auto:Section({ 
    Title = "Auto Summit",
})

local running = false 

local ExpeditionToggle = Auto:Toggle({
    Title = "Expedition Antartika⚡",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        running = Value
        if Value then
            task.spawn(function()
                local currentPos = 1
                local lastDrink = tick()
                local lastRefill = 0
                local player = game.Players.LocalPlayer
                local Workspace = game:GetService("Workspace")

                local positions = {
                    Vector3.new(-3719, 225, 234),
                    Vector3.new(1790, 105, -138),
                    Vector3.new(5892, 321, -20),
                    Vector3.new(8992, 596, 103),
                    Vector3.new(11002, 549, 128),
                }

                local refillMap = {
                    [1] = "WaterRefill_Camp1",
                    [2] = "WaterRefill_Camp2",
                    [3] = "WaterRefill_Camp3",
                    [4] = "WaterRefill_Camp4",
                }

                local function TeleportTo(pos)
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = player.Character.HumanoidRootPart
                    local tempPart = Instance.new("Part")
                    tempPart.Anchored = true
                    tempPart.CanCollide = true
                    tempPart.Transparency = 1
                    tempPart.Size = Vector3.new(10,1,10)
                    tempPart.CFrame = CFrame.new(pos)
                    tempPart.Parent = Workspace
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0,5,0))
                    task.wait(1)
                    tempPart:Destroy()
                end

                local function SafeEquipBottle()
                    if not player.Character then return false end
                    
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if not humanoid then return false end
                    
                    local bottleInHand = player.Character:FindFirstChild("Water Bottle")
                    if bottleInHand then
                        return true
                    end
                    
                    local bottle = player.Backpack:FindFirstChild("Water Bottle")
                    if not bottle then
                        return false
                    end
                    
                    humanoid:EquipTool(bottle)
                    
                    local timeout = 2
                    local startTime = tick()
                    while tick() - startTime < timeout do
                        if bottle.Parent == player.Character then
                            return true
                        end
                        task.wait(0.1)
                    end
                    
                    return false
                end

                local function AutoDrink()
                    if not running then return end
                    
                    local char = player.Character
                    if not char then return end
                    
                    local bottle = char:FindFirstChild("Water Bottle")
                    
                    if not bottle then
                        local equipped = SafeEquipBottle()
                        if not equipped then
                            return
                        end
                        task.wait(0.3)
                    end
                    
                    bottle = char:FindFirstChild("Water Bottle")
                    if not bottle then
                        return
                    end
                    
                    if bottle:FindFirstChild("RemoteEvent") then
                        pcall(function()
                            bottle.RemoteEvent:FireServer()
                        end)
                    end
                end

                local function AutoRefill()
                    if not running then return end
                    local refillFolder = Workspace:FindFirstChild("Locally_Imported_Parts")
                    if not refillFolder then return end
                    local targetRefillName = refillMap[currentPos]
                    local refillPart = targetRefillName and refillFolder:FindFirstChild(targetRefillName)
                    
                    if refillPart then
                        local char = player.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        
                        local prevPos = hrp.Position
                        
                        TeleportTo(refillPart.Position + Vector3.new(0, 3, 0))
                        task.wait(1)
                        
                        TeleportTo(prevPos)
                        task.wait(1)
                    end
                end

                local function InitialEquip()
                    task.wait(3)
                    if running then
                        SafeEquipBottle()
                    end
                end

                player.CharacterAdded:Connect(function(char)
                    task.wait(3)
                    if running then
                        task.wait(1)
                        SafeEquipBottle()
                    end
                end)

                local function RunSummit()
                    local data = player:WaitForChild("Expedition Data", 10)
                    local coins = data and data:FindFirstChild("Coins")
                    local lastCoin = coins and coins.Value or 0
                    
                    InitialEquip()
                    TeleportTo(positions[currentPos])

                    while running do
                        local now = tick()
                        
                        if now - lastDrink >= 5 then
                            AutoDrink()
                            lastDrink = now
                        end

                        if now - lastRefill >= 20 then
                            AutoRefill()
                            lastRefill = now
                        end

                        if coins and coins.Value > lastCoin then
                            lastCoin = coins.Value
                            if currentPos >= #positions then
                                TeleportTo(Vector3.new(10952, 313, 122))
                                pcall(function() if player.Character then player.Character:BreakJoints() end end)
                                player.CharacterAdded:Wait()
                                task.wait(3)
                                currentPos = 1
                                TeleportTo(positions[currentPos])
                            else
                                currentPos = currentPos + 1
                                TeleportTo(positions[currentPos])
                            end
                        end

                        local charHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if charHRP then
                            charHRP.CFrame = charHRP.CFrame * CFrame.new(0,0,10)
                            task.wait(5)
                            if not running then break end
                            TeleportTo(positions[currentPos])
                            task.wait(5)
                        else
                            task.wait(1)
                        end
                    end
                end

                RunSummit()
            end)
        end
    end
})

local ravikaLoop = false

local RavikaToggle = Auto:Toggle({
    Title = "MT Ravika",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        ravikaLoop = Value
        if Value then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                
                local TeleportsRavika = {
                    Vector3.new(-785, 87, -652),
                    Vector3.new(-986, 184, -79),
                    Vector3.new(-955, 178, 807),
                    Vector3.new(796, 186, 876),
                    Vector3.new(971, 98, 136),
                    Vector3.new(982, 144, -535),
                    Vector3.new(401, 122, -230),
                    Vector3.new(47, 438, 40), 
                }

                local function TeleportTo(pos)
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = player.Character.HumanoidRootPart
                    local tempPart = Instance.new("Part")
                    tempPart.Anchored = true
                    tempPart.CanCollide = true
                    tempPart.Transparency = 1
                    tempPart.Size = Vector3.new(10,1,10)
                    tempPart.CFrame = CFrame.new(pos)
                    tempPart.Parent = workspace
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0,5,0))
                    task.wait(1)
                    tempPart:Destroy()
                end

                while ravikaLoop do
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                        player.CharacterAdded:Wait()
                        task.wait(1)
                    end

                    for i, pos in ipairs(TeleportsRavika) do
                        if not ravikaLoop then break end
                        TeleportTo(pos)

                        if i == 7 then
                            task.wait(30)
                        elseif i == 8 then
                            task.wait(3)
                            if ravikaLoop and player.Character then
                                pcall(function() player.Character:BreakJoints() end)
                                player.CharacterAdded:Wait()
                                player.Character:WaitForChild("HumanoidRootPart")
                            end
                            break
                        else
                            task.wait(5)
                        end
                    end
                end
            end)
        end
    end
})

local atinLoop = false

local AtinToggle = Auto:Toggle({
    Title = "MT Atin",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        atinLoop = Value
        if Value then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                local TeleportService = game:GetService("TeleportService")
                
                local ATIN_SUMMIT = {
                    Vector3.new(625, 1799, 3433),
                    Vector3.new(777, 2184, 3934)
                }

                local function TeleportTo(pos)
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = player.Character.HumanoidRootPart
                    local tempPart = Instance.new("Part")
                    tempPart.Anchored = true
                    tempPart.CanCollide = true
                    tempPart.Transparency = 1
                    tempPart.Size = Vector3.new(10,1,10)
                    tempPart.CFrame = CFrame.new(pos)
                    tempPart.Parent = workspace
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0,5,0))
                    task.wait(1)
                    tempPart:Destroy()
                end

                local function showCountdown(seconds, text)
                    for i = seconds, 1, -1 do
                        if not atinLoop then break end
                        WindUI:Notify({
                            Title = "MT Atin Countdown",
                            Content = text .. " starting in " .. i .. " seconds...",
                            Duration = 1,
                            Icon = "clock",
                        })
                        task.wait(1)
                    end
                end

                local function serverHop()
                    local Http = game:GetService("HttpService")
                    local TPS = game:GetService("TeleportService")
                    local API = "https://games.roblox.com/v1/games/"

                    local _place = game.PlaceId
                    local _servers = API.._place.."/servers/Public?sortOrder=Asc&limit=100"
                    
                    local function ListServers(cursor)
                        local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                        return Http:JSONDecode(Raw)
                    end

                    local Server, Next
                    repeat
                        local Servers = ListServers(Next)
                        Server = Servers.data
                        Next = Servers.nextPageCursor
                    until Next

                    local Random = Server[math.random(1, #Server)]
                    TPS:TeleportToPlaceInstance(_place, Random.id, player)
                end

                while atinLoop do
                    showCountdown(3, "MT Atin")

                    TeleportTo(ATIN_SUMMIT[1])
                    task.wait(2)

                    if not atinLoop then break end

                    TeleportTo(ATIN_SUMMIT[2])
                    task.wait(3)

                    if not atinLoop then break end

                    WindUI:Notify({
                        Title = "MT Atin",
                        Content = "Server hopping...",
                        Duration = 3,
                        Icon = "refresh-cw",
                    })
                    serverHop()
                    task.wait(10)
                end
            end)
        end
    end
})

local sibuatanLoop = false

local SibuatanToggle = Auto:Toggle({
    Title = "MT Sibuatan",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        sibuatanLoop = Value
        if Value then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                local TeleportService = game:GetService("TeleportService")
                
                local SIBUATAN_SUMMIT = Vector3.new(5394, 8109, 2207)

                local function TeleportTo(pos)
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = player.Character.HumanoidRootPart
                    local tempPart = Instance.new("Part")
                    tempPart.Anchored = true
                    tempPart.CanCollide = true
                    tempPart.Transparency = 1
                    tempPart.Size = Vector3.new(10,1,10)
                    tempPart.CFrame = CFrame.new(pos)
                    tempPart.Parent = workspace
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0,5,0))
                    task.wait(1)
                    tempPart:Destroy()
                end

                local function showCountdown(seconds, text)
                    for i = seconds, 1, -1 do
                        if not sibuatanLoop then break end
                        WindUI:Notify({
                            Title = "MT Sibuatan Countdown",
                            Content = text .. " starting in " .. i .. " seconds...",
                            Duration = 1,
                            Icon = "clock",
                        })
                        task.wait(1)
                    end
                end

                local function serverHop()
                    local Http = game:GetService("HttpService")
                    local TPS = game:GetService("TeleportService")
                    local API = "https://games.roblox.com/v1/games/"

                    local _place = game.PlaceId
                    local _servers = API.._place.."/servers/Public?sortOrder=Asc&limit=100"
                    
                    local function ListServers(cursor)
                        local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                        return Http:JSONDecode(Raw)
                    end

                    local Server, Next
                    repeat
                        local Servers = ListServers(Next)
                        Server = Servers.data
                        Next = Servers.nextPageCursor
                    until Next

                    local Random = Server[math.random(1, #Server)]
                    TPS:TeleportToPlaceInstance(_place, Random.id, player)
                end

                while sibuatanLoop do
                    -- Hitungan mundur sekali di awal
                    showCountdown(3, "MT Sibuatan")

                    -- Teleport ke posisi summit
                    TeleportTo(SIBUATAN_SUMMIT)
                    task.wait(3)

                    if not sibuatanLoop then break end

                    -- Server Hop
                    WindUI:Notify({
                        Title = "MT Sibuatan",
                        Content = "Server hopping...",
                        Duration = 3,
                        Icon = "refresh-cw",
                    })
                    serverHop()
                    task.wait(10)
                end
            end)
        end
    end
})

local SibayakLoop = false

local SibayakToggle = Auto:Toggle({
    Title = "MT Sibayak",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        SibayakLoop = Value
        if Value then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                
                local TeleportsSibayak = {
                    Vector3.new(-3348, 59, -4741),
                    Vector3.new(-2163, 241, -4849),
                    Vector3.new(-1994, 496, -4824),
                    Vector3.new(-1584, 578, -4579),
                    Vector3.new(-1521, 555, -5000),
                    Vector3.new(-801, 545, -5374),
                    Vector3.new(319, 856, -4444),
                    Vector3.new(1091, 987, -5308),
                    Vector3.new(1576, 1279, -5595), 
                }
                local FallPos = Vector3.new(1637, 1412, -5588)

                local function waitForHRP(character, timeout)
                    local startTime = tick()
                    while tick() - startTime < timeout do
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if hrp then return hrp end
                        task.wait(0.1)
                    end
                    return nil
                end

                local function NaturalMoveTo(targetPos, duration)
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = player.Character.HumanoidRootPart
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if not humanoid then return end
                    
                    local startPos = hrp.Position
                    local startTime = tick()
                    
                    while tick() - startTime < duration and SibayakLoop do
                        local alpha = (tick() - startTime) / duration
                        local currentPos = startPos:Lerp(targetPos, alpha)
                        hrp.CFrame = CFrame.new(currentPos, targetPos)
                        task.wait()
                    end
                    
                    hrp.CFrame = CFrame.new(targetPos)
                end

                local function StepLoop(steps, condition)
                    for i = 1, steps do
                        if not condition() then break end
                        task.wait(1)
                    end
                end

                while SibayakLoop do
                    for i, pos in ipairs(TeleportsSibayak) do
                        if not SibayakLoop then break end
                        local character = player.Character or player.CharacterAdded:Wait()
                        local hrp = waitForHRP(character, 5)
                        if not hrp then break end
                        
                        hrp.CFrame = CFrame.new(pos)
                        task.wait(5)
                        
                        local forwardPos = pos + hrp.CFrame.LookVector * 10
                        NaturalMoveTo(forwardPos, 2.5) 
                        
                        NaturalMoveTo(pos, 2.5) 
                        
                        StepLoop(3, function() return SibayakLoop end)
                        
                        if i == #TeleportsSibayak and SibayakLoop then
                            hrp.CFrame = CFrame.new(FallPos.X, FallPos.Y + 300, FallPos.Z)
                            player.CharacterAdded:Wait()
                            task.wait(1)
                        end
                    end
                end
            end)
        end
    end
})

local LauserLoop = false

local LauserToggle = Auto:Toggle({
    Title = "MT Lauser",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        LauserLoop = Value
        if Value then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                
                local TeleportsLauser = {
                    Vector3.new(992, 207, 1042),
                    Vector3.new(57, 397, 732),
                    Vector3.new(421, 873, 195),
                    Vector3.new(400, 1094, -127),
                    Vector3.new(512, 1251, -779),
                    Vector3.new(871, 1144, -1003), 
                }
                local FallPosLauser = Vector3.new(900, 1300, -1000)

                local function waitForHRP(character, timeout)
                    local startTime = tick()
                    while tick() - startTime < timeout do
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if hrp then return hrp end
                        task.wait(0.1)
                    end
                    return nil
                end

                local function StepLoop(steps, condition)
                    for i = 1, steps do
                        if not condition() then break end
                        task.wait(1)
                    end
                end

                while LauserLoop do
                    for i, pos in ipairs(TeleportsLauser) do
                        if not LauserLoop then break end
                        local character = player.Character or player.CharacterAdded:Wait()
                        local hrp = waitForHRP(character, 5)
                        if not hrp then break end
                        hrp.CFrame = CFrame.new(pos)
                        task.wait(0.5)
                        StepLoop(3, function() return LauserLoop end)
                        if i == #TeleportsLauser and LauserLoop then
                            hrp.CFrame = CFrame.new(FallPosLauser.X, FallPosLauser.Y + 300, FallPosLauser.Z)
                            player.CharacterAdded:Wait()
                            task.wait(1)
                        end
                    end
                end
            end)
        end
    end
})

local LawakLoop = false

local LawakToggle = Auto:Toggle({
    Title = "MT Lawak",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        LawakLoop = Value
        if not Value then return end
        task.spawn(function()
            local player = game.Players.LocalPlayer
            
            local LawakPositions = {
                Vector3.new(-251, 30, 18),
                Vector3.new(-191, 177, 247),
                Vector3.new(280, 341, -272),
                Vector3.new(409, 406, 161),
                Vector3.new(450, 391, -69),
                Vector3.new(530, 568, -314),
                Vector3.new(1441, 1129, -1300),
                Vector3.new(1794, 1478, -1961),
                Vector3.new(2872, 2625, -1882),
            }
            local LawakEnd = Vector3.new(2886, 2622, -1814)

            local function waitForHRP(character, timeout)
                local startTime = tick()
                while tick() - startTime < timeout do
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    if hrp then return hrp end
                    task.wait(0.1)
                end
                return nil
            end

            while LawakLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = waitForHRP(character, 5)
                local humanoid = character:FindFirstChild("Humanoid")
                if not hrp or not humanoid then break end
                task.wait(0.5)
                for i, pos in ipairs(LawakPositions) do
                    if not LawakLoop then break end
                    if hrp and hrp.Parent and humanoid then
                        hrp.CFrame = CFrame.new(pos)
                        if i == #LawakPositions then
                            task.wait(2)
                            local backward = -hrp.CFrame.LookVector * 30
                            humanoid:MoveTo(hrp.Position + backward)
                            humanoid.MoveToFinished:Wait()
                            task.wait(1)
                            hrp.CFrame = CFrame.new(LawakEnd)
                            task.wait(5)
                        else
                            task.wait(2)
                        end
                    end
                end
            end
        end)
    end
})

local XYZLoop = false

local function waitForHRP(char, timeout)
    local t = 0
    repeat
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        task.wait(0.1)
        t = t + 0.1
    until t >= timeout
    return nil
end

local function getCheckpoint(name)
    local success, result = pcall(function()
        return workspace.Checkpoints:WaitForChild(name, 10) 
    end)
    return success and result or nil
end

local function getSummitPart()
    local success, result = pcall(function()
        return workspace:WaitForChild("SummitPart", 10) 
    end)
    return success and result or nil
end


local function getSummitReturnPad()
    local success, result = pcall(function()
        return workspace:WaitForChild("SummitReturnPad", 10) 
    end)
    return success and result or nil
end

local CPDelays = {
    13,   
    25,   
    15,   
    40,   
    53,   
    3     
}

local function getCheckpointPosition(checkpointModel)
    if checkpointModel and checkpointModel:IsA("Model") then
        local primaryPart = checkpointModel.PrimaryPart
        if primaryPart then
            return primaryPart.Position
        end
        
        for _, part in ipairs(checkpointModel:GetChildren()) do
            if part:IsA("BasePart") then
                return part.Position
            end
        end
    end
    return nil
end

local YahayukToggle = Auto:Toggle({
    Title = "MT Yahayuk V1",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        XYZLoop = Value
        if not Value then return end

        task.spawn(function()
            local player = game.Players.LocalPlayer
            
            while XYZLoop do
                local checkpointsFolder
                local success = pcall(function()
                    checkpointsFolder = workspace:WaitForChild("Checkpoints", 10)
                end)
                
                if not success or not checkpointsFolder then
                    break
                end

                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = waitForHRP(character, 5)
                if not hrp then break end

                for i = 1, 5 do
                    if not XYZLoop then break end

                    character = player.Character or player.CharacterAdded:Wait()
                    hrp = waitForHRP(character, 5)
                    if not hrp then break end

                    local checkpointModel = getCheckpoint("CP" .. i)
                    
                    if not checkpointModel then
                        break
                    end

                    if checkpointModel:IsA("Model") and player.Character and player.Character == character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local checkpointPos = getCheckpointPosition(checkpointModel)
                        
                        if checkpointPos then
                            hrp.CFrame = CFrame.new(checkpointPos)

                            local delayTime = CPDelays[i] or 3
                            
                            if delayTime > 0 then
                                local startTime = os.clock()
                                while os.clock() - startTime < delayTime and XYZLoop do
                                    local remaining = math.ceil(delayTime - (os.clock() - startTime))
                                    WindUI:Notify({
                                        Title = "MT Yahayuk V1",
                                        Content = "CP " .. i .. " - Tunggu: " .. remaining .. " detik",
                                        Duration = 1,
                                        Icon = "clock",
                                    })
                                    task.wait(1)
                                end
                            end
                        else
                            break
                        end
                    else
                        break
                    end
                end

                if XYZLoop then
                    character = player.Character or player.CharacterAdded:Wait()
                    hrp = waitForHRP(character, 5)
                    local summitPart = getSummitPart()
                    
                    if hrp and summitPart and summitPart:IsA("BasePart") and player.Character and player.Character == character then
                        hrp.CFrame = summitPart.CFrame
                        
                        local summitDelay = CPDelays[6] or 3
                        if summitDelay > 0 then
                            local startTime = os.clock()
                            while os.clock() - startTime < summitDelay and XYZLoop do
                                local remaining = math.ceil(summitDelay - (os.clock() - startTime))
                                WindUI:Notify({
                                    Title = "MT Yahayuk V1",
                                    Content = "Summit - Tunggu: " .. remaining .. " detik",
                                    Duration = 1,
                                    Icon = "mountain",
                                })
                                task.wait(1)
                            end
                        end
                    end
                end

                if XYZLoop then
                    character = player.Character or player.CharacterAdded:Wait()
                    hrp = waitForHRP(character, 5)
                    local returnPad = getSummitReturnPad()
                    
                    if hrp and returnPad and returnPad:IsA("BasePart") and player.Character and player.Character == character then
                        hrp.CFrame = returnPad.CFrame
                        
                        -- Tunggu 3 detik di return pad
                        local waitTime = 3
                        if waitTime > 0 then
                            local startTime = os.clock()
                            while os.clock() - startTime < waitTime and XYZLoop do
                                local remaining = math.ceil(waitTime - (os.clock() - startTime))
                                WindUI:Notify({
                                    Title = "MT Yahayuk V1",
                                    Content = "Return - Tunggu: " .. remaining .. " detik",
                                    Duration = 1,
                                    Icon = "refresh-cw",
                                })
                                task.wait(1)
                            end
                        end
                    end
                end
            end
        end)
    end
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local DaunPositions = {
    Vector3.new(-622, 249, -384),
    Vector3.new(-1203, 261, -487),
    Vector3.new(-1399, 578, -950),
    Vector3.new(-1701, 816, -1399),
    Vector3.new(-3233, 1714, -2562),
}

local DaunLoop = false

local function waitForHRP(char, timeout)
    local t = 0
    repeat
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        task.wait(0.1)
        t = t + 0.1
    until t >= timeout
    return nil
end

local function showTimerCountdown(seconds, label)
    for i = seconds, 1, -1 do
        if not DaunLoop then
            WindUI:Notify({
                Title = "MT Daun",
                Content = "❌ Dihentikan",
                Duration = 2,
                Icon = "x",
            })
            return
        end
        WindUI:Notify({
            Title = "MT Daun",
            Content = label .. " - Tunggu: " .. i .. " detik",
            Duration = 1,
            Icon = "clock",
        })
        task.wait(1)
    end
end

local DaunToggle = Auto:Toggle({
    Title = "MT Daun",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        DaunLoop = Value
        if not Value then return end

        task.spawn(function()
            local player = Players.LocalPlayer
            while DaunLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = waitForHRP(character, 5)
                if not hrp then break end

                task.wait(0.5)

                for i, pos in ipairs(DaunPositions) do
                    if not DaunLoop then break end
                    if hrp and hrp.Parent then
                        pcall(function()
                            hrp.CFrame = CFrame.new(pos)
                        end)

                        if i == #DaunPositions then
                            showTimerCountdown(2, "✅ CP " .. i .. " (Terakhir)")
                        elseif i == 3 or i == 4 then
                            local delay = math.random(90, 120)
                            showTimerCountdown(delay, " CP " .. i .. " (Random)")
                        else
                            showTimerCountdown(60, " CP " .. i)
                        end
                    end
                end

                if DaunLoop and player.Character then
                    local oldChar = player.Character
                    pcall(function() player.Character:BreakJoints() end)
                    repeat
                        task.wait(0.1)
                    until player.Character ~= oldChar and player.Character:FindFirstChild("HumanoidRootPart")
                    task.wait(0.5)
                end
            end
        end)
    end
})

local CkptwPositions = {
    Vector3.new(512, 160, -531),
    Vector3.new(388, 309, -186),
    Vector3.new(101, 411, 617),
    Vector3.new(11, 600, 998),
    Vector3.new(873, 864, 581),
    Vector3.new(1618, 1079, 158),
    Vector3.new(2970, 1527, 709),
    Vector3.new(1945, 1743, 1224),
    Vector3.new(1802, 1981, 2159),
}

local player = game:GetService("Players").LocalPlayer
local CkptwLoop = false

local function waitForHRP(char, timeout)
    local t = 0
    repeat
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        task.wait(0.1)
        t = t + 0.1
    until t >= timeout
    return nil
end

local function showTimer(seconds, label)
    for i = seconds, 1, -1 do
        if not CkptwLoop then
            WindUI:Notify({
                Title = "MT Ckptw",
                Content = "❌ Dihentikan",
                Duration = 2,
                Icon = "x",
            })
            return
        end
        
        WindUI:Notify({
            Title = "MT Ckptw",
            Content = label .. " -  Tunggu: " .. i .. " detik",
            Duration = 1,
            Icon = "clock",
        })
        task.wait(1)
    end
end

local CkptwToggle = Auto:Toggle({
    Title = "MT Ckptw",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        CkptwLoop = Value
        if not Value then return end

        task.spawn(function()
            while CkptwLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = waitForHRP(character, 5)
                if not hrp then 
                    break 
                end
                
                for i, pos in ipairs(CkptwPositions) do
                    if not CkptwLoop then break end
                    
                    if player.Character and player.Character == character and player.Character:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = CFrame.new(pos)

                        if i == #CkptwPositions then
                            showTimer(3, "CP " .. i .. " (Terakhir)")
                        else
                            showTimer(30, "CP " .. i)
                        end
                    else
                        break
                    end
                end

                if CkptwLoop and player.Character then
                    local oldChar = player.Character
                    pcall(function() 
                        player.Character:BreakJoints() 
                    end)
                    
                    local startTime = os.clock()
                    while player.Character == oldChar and os.clock() - startTime < 10 do
                        if not CkptwLoop then break end
                        task.wait(0.1)
                    end
                    
                    if CkptwLoop then
                        showTimer(2, "Respawn")
                    end
                end
            end
        end)
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function getCharParts()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")
    return char, hrp, humanoid
end

local function fireTouch(part1, part2)
    if not part1 or not part2 then return end
    pcall(function()
        firetouchinterest(part1, part2, 0)
        task.wait(0.15)
        firetouchinterest(part1, part2, 1)
    end)
end

local noclipConn
local function enableNoclip(char)
    if noclipConn then noclipConn:Disconnect() end
    noclipConn = RunService.Stepped:Connect(function()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

local function moveForward(hrp, humanoid, studs)
    local targetPos = hrp.Position + (hrp.CFrame.LookVector * studs)
    humanoid:MoveTo(targetPos)
    humanoid.MoveToFinished:Wait()
end

local function getSummitTrigger(index)
    local found = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "SummitTrigger" then
            table.insert(found, obj)
        end
    end
    return found[index]
end

local function getCheckpoint(num)
    local cp
    repeat
        local cps = workspace:FindFirstChild("Checkpoints")
        if cps then
            cp = cps:FindFirstChild("Checkpoint"..num)
        end
        if not cp then
            task.wait(1)
        end
    until cp
    return cp
end


local AutoFarmEnabled = false

local ArunikaToggle = Auto:Toggle({
    Title = "MT Arunika",
    Type = "Toggle",
    Default = false,
	Locked = false, 
    Callback = function(Value)
        AutoFarmEnabled = Value

        if AutoFarmEnabled then
            task.spawn(function()
                while AutoFarmEnabled do
                    local char, hrp, humanoid = getCharParts()
                    enableNoclip(char)

                    moveForward(hrp, humanoid, 15)
                    task.wait(0.5)

                    hrp.CFrame = CFrame.new(-376, 23, -246)
                    task.wait(1)

                    moveForward(hrp, humanoid, 15)
                    task.wait(3)

                    
                    for i = 1, 5 do
                        if not AutoFarmEnabled then break end
                        local checkpoint = getCheckpoint(i)

                        fireTouch(hrp, checkpoint)
                        task.wait(2)

                        if char and char.Parent then
                            char:BreakJoints()
                        end
                        char = player.CharacterAdded:Wait()
                        hrp = char:WaitForChild("HumanoidRootPart")
                        humanoid = char:WaitForChild("Humanoid")

                        enableNoclip(char)
                        task.wait(0.5)

                        moveForward(hrp, humanoid, 25)
                        task.wait(2)
                    end

                    if not AutoFarmEnabled then break end

                    local waitTime = 180
                    for t = waitTime, 1, -1 do
                        if not AutoFarmEnabled then
                            WindUI:Notify({
                                Title = "MT Arunika",
                                Content = "Dihentikan",
                                Duration = 2,
                                Icon = "x",
                            })
                            break
                        end
                        WindUI:Notify({
                            Title = "MT Arunika",
                            Content = "Tunggu: " .. t .. " detik",
                            Duration = 1,
                            Icon = "clock",
                        })
                        task.wait(1)
                    end

                    if not AutoFarmEnabled then break end

                    local summit = getSummitTrigger(2)
                    if summit then
                        fireTouch(hrp, summit)
                    end

                    if char and char.Parent then
                        char:BreakJoints()
                    end

                    task.wait(4)
                end
            end)
        end
    end
})

local YagatawPositions = {
    Vector3.new(-420, 191, 557),
    Vector3.new(-626, 579, 1136),
    Vector3.new(-900, 690, 1222),
    Vector3.new(-909, 819, 1760),
    Vector3.new(-476, 886, 1701),
    Vector3.new(-379, 1041, 2066),
    Vector3.new(-751, 1525, 2057),
    Vector3.new(-479, 1633, 2271),
    Vector3.new(2, 2493, 2044)
}

local player = game:GetService("Players").LocalPlayer
local YagatawLoop = false


local function waitForHRP(char, timeout)
    local t = 0
    repeat
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        task.wait(0.1)
        t = t + 0.1
    until t >= timeout
    return nil
end


local function walkForwardAndBack(hrp, studs, step, delay)
    local forward = hrp.CFrame.LookVector.Unit
    local origin = hrp.CFrame.Position
    
    for d = 1, studs, step do
        if not YagatawLoop then return end
        hrp.CFrame = CFrame.new(origin + forward * d, origin + forward * (d+1))
        task.wait(delay)
    end
    
    for d = studs, 0, -step do
        if not YagatawLoop then return end
        hrp.CFrame = CFrame.new(origin + forward * d, origin + forward * (d+1))
        task.wait(delay)
    end
end

local function showTimer(seconds, label)
    for i = seconds, 1, -1 do
        if not YagatawLoop then
            WindUI:Notify({
                Title = "MT Yagataw",
                Content = "Dihentikan",
                Duration = 2,
                Icon = "x",
            })
            return
        end
        WindUI:Notify({
            Title = "MT Yagataw",
            Content = label .. " - Tunggu: " .. i .. " detik",
            Duration = 1,
            Icon = "clock",
        })
        task.wait(1)
    end
end

local YagatawToggle = Auto:Toggle({
    Title = "MT Yagataw",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        YagatawLoop = Value
        if not Value then return end

        task.spawn(function()
            while YagatawLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = waitForHRP(character, 5)
                if not hrp then break end
                task.wait(0.5)

                for i, pos in ipairs(YagatawPositions) do
                    if not YagatawLoop then break end
                    if hrp and hrp.Parent then
                        
                        hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
                        task.wait(3) 

                        walkForwardAndBack(hrp, 15, 1, 0.05)

                        if i == #YagatawPositions then
                            showTimer(2, "CP " .. i .. " (Terakhir)")
                        else
                            showTimer(90, "CP " .. i)
                        end
                    end
                end

                if YagatawLoop and player.Character then
                    local oldChar = player.Character
                    pcall(function() oldChar:BreakJoints() end)
                    repeat task.wait(0.1) until player.Character ~= oldChar and player.Character:FindFirstChild("HumanoidRootPart")
                    task.wait(0.5)
                end
            end
        end)
    end
})


local player = game:GetService("Players").LocalPlayer

local KonohaPositions = {
    Vector3.new(47, 162, -911),
    Vector3.new(812, 285, -577),
    Vector3.new(772, 517, -379),
    Vector3.new(154, 473, -10),
    Vector3.new(-78, 473, 387),
    Vector3.new(179, 581, 708),
    Vector3.new(338, 585, 820),
    Vector3.new(582, 669, 736),
    Vector3.new(991, 789, 1007),
    Vector3.new(794, 809, 625),
    Vector3.new(926, 1001, 605),
}

local KonohaLoop = false

local function waitForHRP(char, timeout)
    local t = 0
    repeat
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        task.wait(0.1)
        t = t + 0.1
    until t >= timeout
    return nil
end

local function showTimer(seconds, label)
    for i = seconds, 1, -1 do
        if not KonohaLoop then
            WindUI:Notify({
                Title = "MT Konoha",
                Content = "Dihentikan",
                Duration = 2,
                Icon = "x",
            })
            return
        end
        WindUI:Notify({
            Title = "MT Konoha",
            Content = label .. " - Tunggu: " .. i .. " detik",
            Duration = 1,
            Icon = "clock",
        })
        task.wait(1)
    end
end

local KonohaToggle = Auto:Toggle({
    Title = "MT Konoha",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        KonohaLoop = Value
        if not Value then return end

        task.spawn(function()
            while KonohaLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = waitForHRP(character, 5)
                if not hrp then break end
                task.wait(0.5)

                for i, pos in ipairs(KonohaPositions) do
                    if not KonohaLoop then break end
                    if hrp and hrp.Parent then
                        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                        task.wait(3) 

                        if i == #KonohaPositions then
                            showTimer(3, "CP " .. i .. " (Terakhir)")
                        else
                            showTimer(32, "CP " .. i)
                        end
                    end
                end

                if KonohaLoop and player.Character then
                    local oldChar = player.Character
                    pcall(function() oldChar:BreakJoints() end)
                    repeat
                        task.wait(0.1)
                    until player.Character ~= oldChar and player.Character:FindFirstChild("HumanoidRootPart")
                    task.wait(0.5)
                end
            end
        end)
    end
})


local HellExpeditionLoop = false

local HellExpeditionToggle = Auto:Toggle({
    Title = "Hell Expedition",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        HellExpeditionLoop = Value
        if not Value then return end

        task.spawn(function()
            local player = game.Players.LocalPlayer

            local summitPositions = {
                Vector3.new(-147, 201, 259),
                Vector3.new(152, 250, 424),
                Vector3.new(510, 349, 293),
                Vector3.new(566, 410, -314),
                Vector3.new(-216, 545, -697),
                Vector3.new(-650, 537, -646),
                Vector3.new(-598, 449, -8),
                Vector3.new(-763, 429, 425),
                Vector3.new(-423, 433, 512),
                Vector3.new(306, 353, 681),
                Vector3.new(727, 614, 862),
                Vector3.new(1252, 822, 427),
                Vector3.new(1510, 1193, 114),
                Vector3.new(995, 1194, -10),
                Vector3.new(-1130, 1221, -65),
                Vector3.new(-1627, 1301, -32)
            }

            local interactPosition = Vector3.new(-1871, 1313, -145)

            local function teleportTo(pos)
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = CFrame.new(pos)
                end
            end

            local function skipTime()
                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and HellExpeditionLoop then
                        local promptName = string.lower(prompt.Name)
                        local parentName = string.lower(prompt.Parent.Name)
                        
                        if string.find(promptName, "time") or 
                           string.find(promptName, "skip") or 
                           string.find(parentName, "time") or 
                           string.find(parentName, "skip") then
                            
                            pcall(function()
                                for i = 1, 5 do
                                    fireproximityprompt(prompt)
                                    task.wait(0.2)
                                end
                                return true
                            end)
                        end
                    end
                end
                return false
            end

            local function interactInFront()
                local character = player.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then
                    return false
                end

                local hrp = character.HumanoidRootPart
                local characterPos = hrp.Position
                local lookVector = hrp.CFrame.LookVector
                local frontPosition = characterPos + (lookVector * 5)

                local foundPrompt = false

                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and HellExpeditionLoop then
                        local promptParent = prompt.Parent
                        if not promptParent:IsA("BasePart") then  end

                        local promptPos = promptParent.Position
                        local distance = (promptPos - frontPosition).Magnitude

                        if distance <= 6 then
                            pcall(function()
                                local holdTime = prompt.HoldDuration or 0
                                if holdTime > 0 then
                                    fireproximityprompt(prompt, 1, true)
                                    task.wait(holdTime + 0.2)
                                    fireproximityprompt(prompt, 1, false)
                                else
                                    fireproximityprompt(prompt)
                                end
                                foundPrompt = true
                            end)
                        end
                    end
                end

                return foundPrompt
            end

            while HellExpeditionLoop do
                for _, pos in ipairs(summitPositions) do
                    if not HellExpeditionLoop then break end
                    teleportTo(pos)
                    task.wait(1)
                end

                if HellExpeditionLoop then
                    teleportTo(interactPosition)
                    task.wait(0.5)
                    
                    local timeSkipped = false
                    for attempt = 1, 5 do
                        if not HellExpeditionLoop then break end
                        timeSkipped = skipTime()
                        if timeSkipped then break end
                        task.wait(0.5)
                    end
                    
                    task.wait(1)
                    
                    local frontInteracted = false
                    for attempt = 1, 8 do
                        if not HellExpeditionLoop then break end
                        frontInteracted = interactInFront()
                        if frontInteracted then break end
                        task.wait(0.5)
                    end
                    
                    task.wait(2)
                end
            end
        end)
    end
})

local HanamiPositions = {
    Vector3.new(510, 141, -111),
    Vector3.new(360, 195, -613),
    Vector3.new(-115, 169, -467),
    Vector3.new(-934, 346, -512),
    Vector3.new(-1278, 478, -330),
    Vector3.new(-1976, 610, 132),
    Vector3.new(-2766, 670, 44),
    Vector3.new(-2451, 850, -458),
    Vector3.new(-2394, 119, -1229),
    Vector3.new(-1877, 253, -2040),
    Vector3.new(-3589, 438, -2404),
    Vector3.new(-2653, 686, -2231),
    Vector3.new(-1995, 682, -2227),
    Vector3.new(-1856, 1045, -2729), 
}

local MTHanamiloop = false

local HanamiToggle = Auto:Toggle({
    Title = "MT Hanami",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        MTHanamiloop = Value
        if not Value then return end

        task.spawn(function()
            local player = game:GetService("Players").LocalPlayer
            while MTHanamiloop do
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                task.wait(0.5)

                for i, pos in ipairs(HanamiPositions) do
                    if not MTHanamiloop then break end
                    hrp.CFrame = CFrame.new(pos)
                    task.wait(3)

                    if i == #HanamiPositions then
                        task.wait(3) 
                        hrp.CFrame = CFrame.new(HanamiPositions[1])
                        break 
                    end
                end
            end
        end)
    end
})


local SumbingLoop = false

local sumbingPositions = {
    Vector3.new(-228, 442, 2140),
    Vector3.new(-426, 850, 3172),
    Vector3.new(3, 1270, 4048),
    Vector3.new(-1102, 1554, 4876),
    Vector3.new(-895, 1951, 5360)
}

local SumbingToggle = Auto:Toggle({
    Title = "MT Sumbing",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        SumbingLoop = Value
        if not Value then return end

        task.spawn(function()
            local TweenService = game:GetService("TweenService")
            local player = game.Players.LocalPlayer
            
            while SumbingLoop do
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    for _, pos in pairs(sumbingPositions) do
                        if not SumbingLoop then break end
                        local hrp = character.HumanoidRootPart
                        local goal = {CFrame = CFrame.new(pos)}
                        local tweenInfo = TweenInfo.new(0.15)
                        local tween = TweenService:Create(hrp, tweenInfo, goal)
                        tween:Play()
                        tween.Completed:Wait()
                        task.wait(5)
                    end

                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part:Destroy()
                        end
                    end

                    repeat 
                        task.wait() 
                        character = player.Character 
                    until character and character:FindFirstChild("HumanoidRootPart")
                    
                    task.wait(3)
                end
            end
        end)
    end
})


local BukitRamenLoop = false

local BukitRamenPositions = {
    Vector3.new(-600, 275, -2085),
    Vector3.new(554, 293, -2470),
    Vector3.new(356, 280, -1292),
    Vector3.new(-99, 283, -1270),
    Vector3.new(-623, 48, -613),
    Vector3.new(-638, 121, -204),
    Vector3.new(-213, 146, -169),
    Vector3.new(25, 84, 39),
    Vector3.new(365, 16, -537),
    Vector3.new(544, 65, 104),
    Vector3.new(646, 189, 254),
    Vector3.new(704, 241, 377),
    Vector3.new(718, 313, 451),
    Vector3.new(289, 185, 749),
    Vector3.new(-200, 395, 864),
    Vector3.new(-1037, 498, 841)
}

local StartPosition = Vector3.new(-567, 275, -3378)

local BukitRamenToggle = Auto:Toggle({
    Title = "MT Bukit Ramen",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        BukitRamenLoop = Value
        if not Value then return end

        task.spawn(function()
            local player = game.Players.LocalPlayer
            
            while BukitRamenLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = character:WaitForChild("HumanoidRootPart")
                
                for i, pos in ipairs(BukitRamenPositions) do
                    if not BukitRamenLoop then break end
                    hrp.CFrame = CFrame.new(pos)
                    task.wait(3)
                end

                if BukitRamenLoop then
                    hrp.CFrame = CFrame.new(StartPosition)
                    task.wait(3)
                end
            end
        end)
    end
})


local player = game:GetService("Players").LocalPlayer

local teleportPositions = {
    Vector3.new(154, 202, -900),
    Vector3.new(462, 295, -613),
    Vector3.new(270, 314, -291),
    Vector3.new(-410, 22, 523),
    Vector3.new(-287, 586, -437)
}

local JawaLoop = false

local JawaToggle = Auto:Toggle({
    Title = "MT Jawa",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        JawaLoop = Value
        if not Value then return end

        task.spawn(function()
            while JawaLoop do
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:WaitForChild("Humanoid")
                local hrp = character:WaitForChild("HumanoidRootPart")

                for i, pos in ipairs(teleportPositions) do
                    if not JawaLoop then break end
                    task.wait(1)
                    if hrp then
                        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                    end
                end

                if not JawaLoop then break end

                task.wait(2)
                humanoid.Health = 0

                character = player.CharacterAdded:Wait()
                humanoid = character:WaitForChild("Humanoid")
                hrp = character:WaitForChild("HumanoidRootPart")
            end
        end)
    end
})

---------------------- END OF AUTO SUMMIT ----------------
local Section = Walk:Section({ 
    Title = "Auto Walk",
})

local AutoWalkArunikaExecuted = false

local AutoWalkArunikaButton = Walk:Button({
    Title = "Auto Walk Arunika",
    Desc = "Jalankan script Auto Walk Arunika",
    Callback = function()
        if AutoWalkArunikaExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkArunikaExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Arunika Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/ARUNIKA%20UNIVERSAL.txt"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Arunika Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkDaunExecuted = false

local AutoWalkDaunButton = Walk:Button({
    Title = "Auto Walk Daun",
    Desc = "Jalankan script Auto Walk Daun",
    Callback = function()
        if AutoWalkDaunExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Daun Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkDaunExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Daun Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/DAUN%20UNIVERSAL.txt"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Daun Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkYahayukExecuted = false

local AutoWalkYahayukButton = Walk:Button({
    Title = "Auto Walk Yahayuk",
    Desc = "Jalankan script Auto Walk Yahayuk",
    Callback = function()
        if AutoWalkYahayukExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Yahayuk Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkYahayukExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Yahayuk Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/YAHAYUK%20UNIV.txt"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Yahayuk Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkAtinExecuted = false

local AutoWalkAtinButton = Walk:Button({
    Title = "Auto Walk Atin",
    Desc = "Jalankan script Auto Walk Atin",
    Callback = function()
        if AutoWalkAtinExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Atin Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkAtinExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Atin Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/atin.txt"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Atin Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkAgeExecuted = false

local AutoWalkAgeButton = Walk:Button({
    Title = "Auto Walk Age",
    Desc = "Jalankan script Auto Walk Age",
    Callback = function()
        if AutoWalkAgeExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Age Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkAgeExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Age Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/AGE%20UNIVERSAL.txt"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Age Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkAnehExecuted = false

local AutoWalkAnehButton = Walk:Button({
    Title = "Auto Walk Aneh",
    Desc = "Jalankan script Auto Walk Aneh",
    Callback = function()
        if AutoWalkAnehExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Aneh Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkAnehExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Aneh Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/YahayukOnly/refs/heads/main/mount%20aneh.txt"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Aneh Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkYNTKTSExecuted = false

local AutoWalkYNTKTSButton = Walk:Button({
    Title = "Auto Walk YNTKTS",
    Desc = "Jalankan script Auto Walk YNTKTS",
    Callback = function()
        if AutoWalkYNTKTSExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk YNTKTS Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkYNTKTSExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk YNTKTS Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyybisnis4-gif/walkss/refs/heads/main/YNTKTS"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk YNTKTS Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkPengangguranExecuted = false

local AutoWalkPengangguranButton = Walk:Button({
    Title = "Auto Walk Pengangguran",
    Desc = "Jalankan script Auto Walk Pengangguran",
    Callback = function()
        if AutoWalkPengangguranExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Pengangguran Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Pengangguran Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/PremKeySystemXd/refs/heads/main/MT%20NGANGGUR"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Pengangguran Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkKotaButton = Walk:Button({
    Title = "Auto Walk Kota Bukan Gunung",
    Desc = "Jalankan script Auto Walk Kota Bukan Gunung",
    Callback = function()
        if AutoWalkKotaExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkKotaExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Kota Bukan Gunung Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/kota%20bukan%20gunung.lua"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk Kota Bukan Gunung Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})


local AutoWalkMULUExecuted = false

local AutoWalkMULUButton = Walk:Button({
    Title = "Auto Walk MT MULU",
    Desc = "Jalankan script Auto Walk MT MULU",
    Callback = function()
        if AutoWalkMULUExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk MT MULU Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkMULUExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk MT MULU Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/MT%20MULU"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk MT MULU Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})

local AutoWalkkawahxecuted = false

local AutoWalkkawahButton = Walk:Button({
    Title = "Auto Walk MT KAWAH",
    Desc = "Jalankan script Auto Walk MT KAWAH",
    Callback = function()
        if AutoWalkkawahExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk MT KAWAH Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkkawahExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk MT KAWAH Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/age/refs/heads/main/kawah"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk MT KAWAH Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})

local AutoWalkFUNNYexecuted = false

local AutoWalkFUNNYButton = Walk:Button({
    Title = "Auto Walk MT FUNNY",
    Desc = "Jalankan script Auto Walk MT FUNNY",
    Callback = function()
        if AutoWalkFUNNYExecuted then
            WindUI:Notify({
                Title = "Auto Walk",
                Content = "Auto Walk MT FUNNY Sudah Di Jalankan Tidak Bisa Di Jalankan Lagi",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        AutoWalkFUNNYExecuted = true
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk MT FUNNY Sedang Dijalankan...",
            Duration = 3,
            Icon = "loader",
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fyywannafly-sudo/PremKeySystemXd/refs/heads/main/mt%20funny.lua"))()
        
        task.wait(2)
        
        WindUI:Notify({
            Title = "Auto Walk",
            Content = "Auto Walk MT FUNNY Sudah DiJalankan",
            Duration = 3,
            Icon = "check",
        })
    end
})

Walk:Space()
Walk:Divider()

local Section = Walk:Section({ 
    Title = "Feature Yahayuk",
})

local BigCPButton = Walk:Button({
    Title = "Perbesar CP Yahayuk",
    Desc = "Jalankan Menu Ini Di CP4",
    Callback = function()
        local scaleFactor = 7
        local checkpoints = workspace:FindFirstChild("Checkpoints")

        if not checkpoints then
            WindUI:Notify({
                Title = "Perbesar CP Yahayuk",
                Content = "Checkpoints tidak ditemukan",
                Duration = 3,
                Icon = "x",
            })
            return
        end

        local successCount = 0
        
        -- Perbesar Checkpoints
        for i = 1, 5 do
            local cp = checkpoints:FindFirstChild("CP" .. i)
            if cp then
                local touchPart = cp:FindFirstChild("TouchPart")
                if touchPart and touchPart:IsA("BasePart") then
                    local oldSize = touchPart.Size
                    local oldCFrame = touchPart.CFrame

                    touchPart.Size = oldSize * scaleFactor
                    touchPart.CFrame = oldCFrame

                    successCount = successCount + 1
                end
            end
        end

        -- Hapus part-part di GlobalTeleport
        local partsToRemove = {
            "PARTB",
            "PARTC"
        }

        local removedCount = 0
        local globalTeleport = workspace:FindFirstChild("GlobalTeleport")
        
        if globalTeleport then
            for _, partName in ipairs(partsToRemove) do
                local part = globalTeleport:FindFirstChild(partName)
                if part then
                    part:Destroy()
                    removedCount = removedCount + 1
                end
            end
        end

        WindUI:Notify({
            Title = "Perbesar CP Yahayuk",
            Content = successCount .. " CP berhasil diperbesar x" .. scaleFactor .. " dan " .. removedCount .. " part berhasil dihapus",
            Duration = 3,
            Icon = "check",
        })
    end
})

------------ END OF AUTO WALK ---------------
local Section = Teleport:Section({ 
    Title = "Select Player & Teleport",
})

local selectedPlayer = nil

local function createPlayerDropdown()
    local players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    
    if #players == 0 then
        players = {"No other players"}
    end
    
    local dropdown = Teleport:Dropdown({
        Title = "Teleport to Player",
        Values = players,
        Value = players[1],
        Callback = function(selected)
            selectedPlayer = selected
        end
    })
    
    selectedPlayer = players[1]
    return dropdown
end

local playerDropdown = createPlayerDropdown()

local TeleportPlayerButton = Teleport:Button({
    Title = "Teleport to Selected Player",
    Desc = "Teleport ke player yang dipilih",
    Callback = function()
        if not selectedPlayer or selectedPlayer == "No other players" then
            WindUI:Notify({
                Title = "Teleport Player",
                Content = "Pilih player yang valid terlebih dahulu!",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
        local player = game.Players.LocalPlayer
        
        if not targetPlayer then
            WindUI:Notify({
                Title = "Teleport Player",
                Content = "Player '" .. selectedPlayer .. "' tidak ditemukan!",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            WindUI:Notify({
                Title = "Teleport Player",
                Content = "Karakter player '" .. selectedPlayer .. "' tidak ditemukan!",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            WindUI:Notify({
                Title = "Teleport Player",
                Content = "Karakter kamu tidak ditemukan!",
                Duration = 3,
                Icon = "x",
            })
            return
        end
        
        local targetPos = targetPlayer.Character.HumanoidRootPart.Position
        local hrp = player.Character.HumanoidRootPart
        local tempPart = Instance.new("Part")
        tempPart.Anchored = true
        tempPart.CanCollide = true
        tempPart.Transparency = 1
        tempPart.Size = Vector3.new(10,1,10)
        tempPart.CFrame = CFrame.new(targetPos)
        tempPart.Parent = workspace
        hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,5,0))
        task.wait(1)
        tempPart:Destroy()
        
        WindUI:Notify({
            Title = "Teleport Player",
            Content = "Berhasil teleport ke " .. selectedPlayer,
            Duration = 3,
            Icon = "user-check",
        })
    end
})

local RefreshPlayerListButton = Teleport:Button({
    Title = "Refresh Player List",
    Desc = "Refresh daftar player",
    Callback = function()
        playerDropdown:Remove()
        playerDropdown = createPlayerDropdown()
        
        WindUI:Notify({
            Title = "Player List",
            Content = "Daftar player diperbarui",
            Duration = 2,
            Icon = "refresh-cw",
        })
    end
})

game.Players.PlayerAdded:Connect(function()
    task.wait(1)
    playerDropdown:Remove()
    playerDropdown = createPlayerDropdown()
end)

game.Players.PlayerRemoving:Connect(function()
    task.wait(1)
    playerDropdown:Remove()
    playerDropdown = createPlayerDropdown()
end)

Teleport:Space()
Teleport:Divider()

local Section = Teleport:Section({ 
    Title = "Save Position & Back Position",
})

local savedPosition = nil

local SavePosButton = Teleport:Button({
    Title = "Save Position",
    Desc = "Simpan posisi saat ini",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            savedPosition = player.Character.HumanoidRootPart.Position
            WindUI:Notify({
                Title = "SavePos",
                Content = "Posisi berhasil disimpan!",
                Duration = 3,
                Icon = "save",
            })
        else
            WindUI:Notify({
                Title = "SavePos",
                Content = "Karakter tidak ditemukan",
                Duration = 3,
                Icon = "x",
            })
        end
    end
})

local BackPosButton = Teleport:Button({
    Title = "Back to Position",
    Desc = "Kembali ke posisi yang disimpan",
    Callback = function()
        local player = game.Players.LocalPlayer
        if savedPosition and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            WindUI:Notify({
                Title = "SavePos",
                Content = "Berhasil teleport ke posisi!",
                Duration = 3,
                Icon = "arrow-left",
            })
        else
            WindUI:Notify({
                Title = "SavePos",
                Content = "Posisi belum disimpan atau karakter tidak ditemukan",
                Duration = 3,
                Icon = "x",
            })
        end
    end
})

Teleport:Space()
Teleport:Divider()

local Section = Teleport:Section({ 
    Title = "Teleport Tool",
})

local TeleportToolButton = Teleport:Button({
    Title = "Teleport Tool",
    Desc = "Buat tool untuk teleport dengan klik",
    Callback = function()
        local player = game.Players.LocalPlayer
        local backpack = player:WaitForChild("Backpack")
        
        for _, v in ipairs(backpack:GetChildren()) do 
            if v:IsA("Tool") and v.Name == "Click Teleport" then 
                v:Destroy() 
            end 
        end 
        
        if player.Character then 
            for _, v in ipairs(player.Character:GetChildren()) do 
                if v:IsA("Tool") and v.Name == "Click Teleport" then 
                    v:Destroy() 
                end 
            end 
        end
        
        local function TeleportTo(pos)
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local hrp = player.Character.HumanoidRootPart
            local tempPart = Instance.new("Part")
            tempPart.Anchored = true
            tempPart.CanCollide = true
            tempPart.Transparency = 1
            tempPart.Size = Vector3.new(10,1,10)
            tempPart.CFrame = CFrame.new(pos)
            tempPart.Parent = workspace
            hrp.CFrame = CFrame.new(pos + Vector3.new(0,5,0))
            task.wait(1)
            tempPart:Destroy()
        end
        
        local tool = Instance.new("Tool")
        tool.Name = "Click Teleport"
        tool.RequiresHandle = false
        tool.CanBeDropped = false
        tool.Parent = backpack
        
        tool.Equipped:Connect(function(mouse)
            local m = mouse or player:GetMouse()
            local activatedConn
            activatedConn = tool.Activated:Connect(function()
                TeleportTo(m.Hit.p + Vector3.new(0,3,0))
            end)
            tool.Unequipped:Connect(function()
                if activatedConn then 
                    activatedConn:Disconnect() 
                end
            end)
        end)
        
        WindUI:Notify({
            Title = "Teleport Tool",
            Content = "Tool teleport berhasil dibuat! Cek backpack kamu.",
            Duration = 3,
            Icon = "tool",
        })
    end
})

--------------- END OF TELEPORT ---------------

local Section = Tools:Section({ 
    Title = "Frezze Object & Full Bright",
})

local FreezeToggle = false
local OriginalStates = {}
local FreezeDistance = 100

task.spawn(function()
    while task.wait(0.3) do
        if FreezeToggle and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local charPos = player.Character.HumanoidRootPart.Position
            local nearbyParts = workspace:GetPartBoundsInRadius(charPos, FreezeDistance)
            local stillNear = {}
            for _, part in ipairs(nearbyParts) do
                if part and part:IsA("BasePart") then
                    local model = part:FindFirstAncestorOfClass("Model")
                    if model and Players:GetPlayerFromCharacter(model) then
                    else
                        stillNear[part] = true
                        if OriginalStates[part] == nil then OriginalStates[part] = part.Anchored end
                        pcall(function()
                            part.Anchored = true
                            part.Velocity = Vector3.zero
                            part.RotVelocity = Vector3.zero
                        end)
                    end
                end
            end
            for part, anchoredState in pairs(OriginalStates) do
                if not stillNear[part] then
                    if part and part.Parent then pcall(function() part.Anchored = anchoredState end) end
                    OriginalStates[part] = nil
                end
            end
        end
    end
end)

local FreezeToggleWindUI = Tools:Toggle({
    Title = "Freeze Object",
    Type = "Toggle",
	Desc = "Frezze Objek Yang Bergoyang",
    Default = false,
    Callback = function(Value)
        FreezeToggle = Value
        if not Value then
            for part, anchoredState in pairs(OriginalStates) do
                if part and part.Parent then
                    pcall(function() part.Anchored = anchoredState end)
                end
            end
            OriginalStates = {}
        end
    end
})

local FreezeSlider = Tools:Slider({
    Title = "Freeze Radius",
    Step = 10,
    Value = {
        Min = 0,
        Max = 500,
        Default = 100,
    },
    Callback = function(Value)
        FreezeDistance = Value
    end
})

Tools:Space()
Tools:Divider()

local FullBrightEnabled = false
local savedLighting = nil
local FullBrightLoopConn = nil
local currentBrightness = 2
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local FullBrightToggle = Tools:Toggle({
    Title = "Full Bright Loop",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        FullBrightEnabled = Value
        if Value then
            if not savedLighting then
                savedLighting = {
                    Brightness = Lighting.Brightness,
                    ClockTime = Lighting.ClockTime,
                    FogEnd = Lighting.FogEnd,
                    GlobalShadows = Lighting.GlobalShadows,
                    OutdoorAmbient = Lighting.OutdoorAmbient
                }
            end
            if not FullBrightLoopConn then
                FullBrightLoopConn = RunService.RenderStepped:Connect(function()
                    Lighting.Brightness = currentBrightness
                    Lighting.ClockTime = 12
                    Lighting.FogEnd = 1e6
                    Lighting.GlobalShadows = false
                    Lighting.OutdoorAmbient = Color3.new(1,1,1)
                end)
            end
        else
            if FullBrightLoopConn then 
                FullBrightLoopConn:Disconnect()
                FullBrightLoopConn = nil 
            end
            if savedLighting then
                Lighting.Brightness = savedLighting.Brightness
                Lighting.ClockTime = savedLighting.ClockTime
                Lighting.FogEnd = savedLighting.FogEnd
                Lighting.GlobalShadows = savedLighting.GlobalShadows
                Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient
                savedLighting = nil
            end
        end
    end
})

local BrightnessSlider = Tools:Slider({
    Title = "Adjust Brightness",
    Step = 0.2,
    Value = {
        Min = 0,
        Max = 10,
        Default = 2,
    },
    Callback = function(Value)
        currentBrightness = Value
        if FullBrightEnabled then 
            Lighting.Brightness = currentBrightness 
        end
    end
})

Tools:Space()
Tools:Divider()

local AntiAFK_Enabled = false

local AntiAFKToggle = Tools:Toggle({
    Title = "Anti AFK",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        AntiAFK_Enabled = Value
        if not Value then return end

        task.spawn(function()
            local vu = game:GetService("VirtualUser")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer

            player.Idled:Connect(function()
                if not AntiAFK_Enabled then return end
                pcall(function()
                    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(1)
                    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end)
            end)

            while AntiAFK_Enabled do
                local cam = workspace.CurrentCamera
                if cam then
                    cam.CFrame = CFrame.Angles(0, math.rad(10), 0)
                end
                task.wait(60)
            end
        end)
    end
})

local RespawnButton = Tools:Button({
    Title = "Respawn",
    Desc = "Respawn karakter kamu",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:BreakJoints()
            WindUI:Notify({
                Title = "Respawn",
                Content = "Karakter berhasil di-respawn",
                Duration = 3,
                Icon = "refresh-cw",
            })
        end
    end
})

local RejoinButton = Tools:Button({
    Title = "Rejoin",
    Desc = "Rejoin server yang sama",
    Callback = function()
        WindUI:Notify({
            Title = "Rejoin",
            Content = "Sedang rejoin server...",
            Duration = 3,
            Icon = "rotate-cw",
        })
        
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        TeleportService:Teleport(placeId, game.Players.LocalPlayer)
    end
})

local ServerHopButton = Tools:Button({
    Title = "ServerHop",
    Desc = "Pindah ke server lain",
    Callback = function()
        WindUI:Notify({
            Title = "ServerHop",
            Content = "Mencari server baru...",
            Duration = 3,
            Icon = "server",
        })
        
        local function serverHop()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            
            local placeId = game.PlaceId
            local servers = {}
            local nextCursor = ""
            
            -- Dapatkan list server
            repeat
                local success, result = pcall(function()
                    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
                    if nextCursor ~= "" then
                        url = url .. "&cursor=" .. nextCursor
                    end
                    local response = game:HttpGet(url)
                    return Http:JSONDecode(response)
                end)
                
                if success and result and result.data then
                    for _, server in ipairs(result.data) do
                        if server.playing < server.maxPlayers and server.id ~= game.JobId then
                            table.insert(servers, server)
                        end
                    end
                    nextCursor = result.nextPageCursor or ""
                else
                    nextCursor = ""
                end
            until nextCursor == "" or #servers >= 50
            
            if #servers > 0 then
                local randomServer = servers[math.random(1, #servers)]
                WindUI:Notify({
                    Title = "ServerHop",
                    Content = "Menemukan server! Teleporting...",
                    Duration = 2,
                    Icon = "check",
                })
                
                task.wait(1)
                
                TPS:TeleportToPlaceInstance(placeId, randomServer.id, player)
            else
                WindUI:Notify({
                    Title = "ServerHop",
                    Content = "Tidak ada server lain yang ditemukan",
                    Duration = 3,
                    Icon = "x",
                })
            end
        end
        
        local success, error = pcall(serverHop)
        if not success then
            WindUI:Notify({
                Title = "ServerHop Error",
                Content = "Gagal: " .. tostring(error),
                Duration = 5,
                Icon = "x",
            })
        end
    end
})

--------------- END OF TOOLS ---------------

local Section = Danger:Section({ 
    Title = "Enjoy Exploit!!",
})

local SkidFlingButton = Danger:Button({
    Title = "Fling All",
    Desc = "Fling semua player di server",
    Callback = function()
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        
        local function GetPlayer(Name)
            Name = Name:lower()
            if Name == "all" or Name == "others" then
                return true
            elseif Name == "random" then
                local GetPlayers = Players:GetPlayers()
                if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
                return GetPlayers[math.random(#GetPlayers)]
            elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
                for _,x in next, Players:GetPlayers() do
                    if x ~= Player then
                        if x.Name:lower():match("^"..Name) then
                            return x;
                        elseif x.DisplayName:lower():match("^"..Name) then
                            return x;
                        end
                    end
                end
            else
                return
            end
        end
        
        local function SkidFling(TargetPlayer)
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Humanoid and Humanoid.RootPart

            local TCharacter = TargetPlayer.Character
            local THumanoid
            local TRootPart
            local THead
            local Accessory
            local Handle

            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
            end
            if THumanoid and THumanoid.RootPart then
                TRootPart = THumanoid.RootPart
            end
            if TCharacter:FindFirstChild("Head") then
                THead = TCharacter.Head
            end
            if TCharacter:FindFirstChildOfClass("Accessory") then
                Accessory = TCharacter:FindFirstChildOfClass("Accessory")
            end
            if Accessory and Accessory:FindFirstChild("Handle") then
                Handle = Accessory.Handle
            end

            if Character and Humanoid and RootPart then
                if RootPart.Velocity.Magnitude < 50 then
                    getgenv().OldPos = RootPart.CFrame
                end
                if THead then
                    workspace.CurrentCamera.CameraSubject = THead
                elseif not THead and Handle then
                    workspace.CurrentCamera.CameraSubject = Handle
                elseif THumanoid and TRootPart then
                    workspace.CurrentCamera.CameraSubject = THumanoid
                end
                if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                    return
                end
                
                local FPos = function(BasePart, Pos, Ang)
                    RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                    RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end
                
                local SFBasePart = function(BasePart)
                    local TimeToWait = 2
                    local Time = tick()
                    local Angle = 0

                    repeat
                        if RootPart and THumanoid then
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle = Angle + 100

                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                                task.wait()

                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                            end
                        else
                            break
                        end
                    until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
                end
                
                workspace.FallenPartsDestroyHeight = 0/0
                
                local BV = Instance.new("BodyVelocity")
                BV.Name = "EpixVel"
                BV.Parent = RootPart
                BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                
                if TRootPart and THead then
                    if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                        SFBasePart(THead)
                    else
                        SFBasePart(TRootPart)
                    end
                elseif TRootPart and not THead then
                    SFBasePart(TRootPart)
                elseif not TRootPart and THead then
                    SFBasePart(THead)
                elseif not TRootPart and not THead and Accessory and Handle then
                    SFBasePart(Handle)
                else
                    return
                end
                
                BV:Destroy()
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = Humanoid
                
                repeat
                    RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                    Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                    Humanoid:ChangeState("GettingUp")
                    table.foreach(Character:GetChildren(), function(_, x)
                        if x:IsA("BasePart") then
                            x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                        end
                    end)
                    task.wait()
                until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
                workspace.FallenPartsDestroyHeight = getgenv().FPDH
            else
                return
            end
        end
        
        if not getgenv().Welcome then
            WindUI:Notify({
                Title = "Fling All",
                Content = "Enjoy!",
                Duration = 3,
                Icon = "zap",
            })
        end
        getgenv().Welcome = true
        
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.UserId ~= 1414978355 then
                    SkidFling(x)
                end
            end
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local config = {
    radius = 99999,
    height = 99999,
    rotationSpeed = 99999,
    attractionStrength = 99999,
}

local ringPartsEnabled = false
local parts = {}

local function scanAllParts()
    parts = {}
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(LocalPlayer.Character) then
            table.insert(parts, part)
        end
    end
end

RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    
    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local tornadoCenter = humanoidRootPart.Position
        
        for _, part in pairs(parts) do
            if part and part.Parent and not part.Anchored then
                part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0)
                part.CanCollide = false
                
                local pos = part.Position
                local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
                local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
                local newAngle = angle + math.rad(config.rotationSpeed)
                local targetPos = Vector3.new(
                    tornadoCenter.X + math.cos(newAngle) * math.min(config.radius, distance),
                    tornadoCenter.Y + (config.height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / config.height)))),
                    tornadoCenter.Z + math.sin(newAngle) * math.min(config.radius, distance)
                )
                local directionToTarget = (targetPos - part.Position).Unit
                part.Velocity = directionToTarget * config.attractionStrength
            end
        end
    end
end)

local TornadoToggle = Danger:Toggle({
    Title = "Terbangkan Part",
    Desc = "If Not Work Wait Until Scan Finish",
    Type = "Toggle",
    Default = false,

    Callback = function(state)
        ringPartsEnabled = state
        
        if state then
            scanAllParts()
            WindUI:Notify({
                Title = "Tornado",
                Content = "Tornado diaktifkan - " .. #parts .. " part terbang!",
                Duration = 3,
                Icon = "wind",
            })
        else
            for _, part in pairs(parts) do
                if part and part.Parent then
                    part.CustomPhysicalProperties = nil
                    part.CanCollide = true
                    part.Velocity = Vector3.new(0, 0, 0)
                end
            end
            parts = {}
            WindUI:Notify({
                Title = "Tornado",
                Content = "Tornado dimatikan",
                Duration = 3,
                Icon = "x",
            })
        end
    end
})

workspace.DescendantAdded:Connect(function(part)
    if ringPartsEnabled and part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(LocalPlayer.Character) then
        if not table.find(parts, part) then
            table.insert(parts, part)
        end
    end
end)
