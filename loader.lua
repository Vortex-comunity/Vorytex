--// Voytex Script v1.3.0
--// UI: Rayfield
--// Theme: Crimson
--// Author: REYxNATE 🗿
--// Big Update: Full Tabs + Executor Detector + Auto Trade + Prank + History

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- =====================
-- 🔑 KEY SETTINGS
-- =====================
local KEY_ENABLED = true
local VOYTEX_KEY = "VOYTEX-2026"
local PASSED = false

-- =====================
-- 🪟 WINDOW
-- =====================
local Window = Rayfield:CreateWindow({
	Name = "Voytex Script",
	LoadingTitle = "Voytex",
	LoadingSubtitle = "Rayfield Edition | v1.3.0",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Voytex",
		FileName = "VoytexConfig"
	},
	Discord = { Enabled = false },
	KeySystem = false
})

-- =====================
-- 🔑 KEY TAB
-- =====================
local KeyTab = Window:CreateTab("🔑 Key", 4483362458)
KeyTab:CreateSection("🔑 Voytex Premium Access")

local inputKey = ""
local KeyStatus = KeyTab:CreateLabel("📌 Status : Waiting Key...")

KeyTab:CreateInput({
	Name = "🗝️ Enter Key",
	PlaceholderText = "Example: VOYTEX-2026",
	RemoveTextAfterFocusLost = false,
	Callback = function(text)
		inputKey = text
	end
})

KeyTab:CreateButton({
	Name = "✅ Submit Key",
	Callback = function()
		if not KEY_ENABLED then
			PASSED = true
			KeyStatus:Set("📌 Status : Key Disabled (Free Mode) ✅")
			return
		end

		if inputKey == VOYTEX_KEY then
			PASSED = true
			KeyStatus:Set("📌 Status : Key Correct ✅")

			Rayfield:Notify({
				Title = "Voytex",
				Content = "Key Correct ✅ Welcome Premium 🗿🔥",
				Duration = 3
			})
		else
			KeyStatus:Set("📌 Status : Key Wrong ❌")
			Rayfield:Notify({
				Title = "Voytex",
				Content = "Key Wrong ❌",
				Duration = 3
			})
		end
	end
})

KeyTab:CreateButton({
	Name = "📋 Copy Key",
	Callback = function()
		setclipboard(VOYTEX_KEY)
		Rayfield:Notify({Title="Voytex", Content="Key copied to clipboard ✅", Duration=3})
	end
})

KeyTab:CreateParagraph({
	Title = "📌 Note Key",
	Content = "Key ini buat Voytex Premium.\nKalau belum punya key, minta ke owner/admin."
})

-- =====================
-- 🔒 LOCK SYSTEM
-- =====================
local function LockedNotify()
	Rayfield:Notify({
		Title = "Voytex",
		Content = "🔒 Locked! Masukin key dulu 🗝️",
		Duration = 3
	})
end

local function IsUnlocked()
	if not KEY_ENABLED then return true end
	return PASSED == true
end

-- =====================
-- 🏠 MAIN TAB
-- =====================
local MainTab = Window:CreateTab("🏠 Main", 4483362458)
MainTab:CreateSection("🏠 Main Feature")

MainTab:CreateButton({
	Name = "🗿 Test Button",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		Rayfield:Notify({
			Title = "Voytex",
			Content = "Button works! 🗿",
			Duration = 4
		})
	end
})

MainTab:CreateToggle({
	Name = "⚡ WalkSpeed (Fast)",
	CurrentValue = false,
	Callback = function(state)
		if not IsUnlocked() then return LockedNotify() end
		local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state and 50 or 16
		end
	end
})

MainTab:CreateSlider({
	Name = "🏃 Set Speed",
	Range = {16, 200},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(value)
		if not IsUnlocked() then return LockedNotify() end
		local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = value
		end
	end
})

-- =====================
-- 👤 PLAYER TAB
-- =====================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSection("👤 Player")

PlayerTab:CreateButton({
	Name = "💀 Reset Character",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		if game.Players.LocalPlayer.Character then
			game.Players.LocalPlayer.Character:BreakJoints()
		end
	end
})

-- =====================
-- 🌊 TSUNAMI TAB
-- =====================
local TsunamiTab = Window:CreateTab("🌊 Tsunami", 4483362458)
TsunamiTab:CreateSection("🌊 Tsunami Script")

TsunamiTab:CreateButton({
	Name = "⚡ Execute Tsunami Script",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()
	end
})

-- =====================
-- ⚒️ THE FORGE TAB
-- =====================
local ForgeTab = Window:CreateTab("⚒️ The Forge", 4483362458)
ForgeTab:CreateSection("🔥 The Forge Script")

ForgeTab:CreateButton({
	Name = "⚡ Execute The Forge",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/nurvian/Catraz-HUB/refs/heads/main/Catraz/main.lua"))()
	end
})

-- =====================
-- 🎣 FISCH TAB
-- =====================
local FischTab = Window:CreateTab("🎣 Fisch", 4483362458)
FischTab:CreateSection("🎣 Fisch Script")

FischTab:CreateButton({
	Name = "⚡ Execute Fisch Script",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/KAN-FISCH/tesss/refs/heads/main/gunung/fish.lua"))()
	end
})

-- =====================
-- 🧰 TOOLS TAB
-- =====================
local ToolsTab = Window:CreateTab("🧰 Tools", 4483362458)
ToolsTab:CreateSection("🧰 Utilities")

ToolsTab:CreateButton({
	Name = "🔄 Rejoin Server",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
	end
})

ToolsTab:CreateButton({
	Name = "⚡ FPS Boost 2.0",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		for _, v in pairs(game:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Decal") or v:IsA("Shadow") then
				v.Enabled = false
			end
		end
		Rayfield:Notify({Title="Voytex", Content="FPS Boost Applied 🗿", Duration=4})
	end
})

-- =====================
-- 💱 AUTO TRADE TAB (UNIVERSAL)
-- =====================
local AutoTradeTab = Window:CreateTab("💱 Auto Trade", 4483362458)
AutoTradeTab:CreateSection("💱 Universal Auto Trade")

local targetPlayer = ""
AutoTradeTab:CreateInput({
	Name = "🎯 Target Player",
	PlaceholderText = "Enter Player Name",
	Callback = function(text)
		targetPlayer = text
	end
})

AutoTradeTab:CreateButton({
	Name = "⚡ Start Trade",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		if targetPlayer == "" then
			Rayfield:Notify({Title="Auto Trade", Content="Please enter target player ⚠️", Duration=3})
			return
		end
		Rayfield:Notify({Title="Auto Trade", Content="Pretending to trade with "..targetPlayer.." 🗿", Duration=3})
	end
})

-- =====================
-- 🤡 PRANK TAB (FAKE KICK SAFE)
-- =====================
local PrankTab = Window:CreateTab("🤡 Prank", 4483362458)
PrankTab:CreateSection("🤡 Troll Feature (Fake Only)")

PrankTab:CreateButton({
	Name = "💀 Fake Kick (Savage) [SAFE]",
	Callback = function()
		if not IsUnlocked() then return LockedNotify() end
		pcall(function()
			local old = game:GetService("CoreGui"):FindFirstChild("VoytexFakeKick")
			if old then old:Destroy() end
		end)
		local gui = Instance.new("ScreenGui")
		gui.Name = "VoytexFakeKick"
		gui.ResetOnSpawn = false
		gui.IgnoreGuiInset = true
		gui.Parent = game:GetService("CoreGui")
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1,0,1,0)
		frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
		frame.Parent = gui
		local title = Instance.new("TextLabel")
		title.Size = UDim2.new(1,0,0,80)
		title.Position = UDim2.new(0,0,0,40)
		title.BackgroundTransparency = 1
		title.Text = "Disconnected"
		title.TextScaled = true
		title.Font = Enum.Font.GothamBold
		title.TextColor3 = Color3.fromRGB(255,255,255)
		title.Parent = frame
		local msg = Instance.new("TextLabel")
		msg.Size = UDim2.new(1,-80,0,220)
		msg.Position = UDim2.new(0,40,0,140)
		msg.BackgroundTransparency = 1
		msg.TextWrapped = true
		msg.TextYAlignment = Enum.TextYAlignment.Top
		msg.Text = "HACK SEMUA GAME 🗿🔥\nMau ngehack? mikir dulu 😹"
		msg.TextScaled = true
		msg.Font = Enum.Font.Gotham
		msg.TextColor3 = Color3.fromRGB(200,200,200)
		msg.Parent = frame
		local closeBtn = Instance.new("TextButton")
		closeBtn.Size = UDim2.new(0,220,0,55)
		closeBtn.Position = UDim2.new(0.5,-110,1,-120)
		closeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
		closeBtn.Text = "Close (Fake)"
		closeBtn.TextScaled = true
		closeBtn.Font = Enum.Font.GothamBold
		closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
		closeBtn.Parent = frame
		closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
	end
})

-- =====================
-- 📌 STATUS TAB (FULL FIX + EXECUTOR READER)
-- =====================
local StatusTab = Window:CreateTab("📌 Status", 4483362458)
StatusTab:CreateSection("📌 Player / Game Status")

local plr = game.Players.LocalPlayer
local function SafeText(v)
	local ok,res = pcall(function() return tostring(v) end)
	if not ok then return "N/A" end
	if res == "" or res == "nil" then return "N/A" end
	return res
end

local function DetectExecutor()
	local exe = "Unknown"
	pcall(function()
		if getexecutorname then exe = SafeText(getexecutorname()) end
		if identifyexecutor then exe = SafeText(identifyexecutor()) end
	end)
	if exe == "Unknown" or exe == "N/A" then
		if _G.ArceusX then exe = "Arceus X" end
		if _G.DeltaExecutor or _G.DELTA then exe = "Delta" end
		if syn then exe = "Synapse X" end
		if KRNL_LOADED then exe = "KRNL" end
		if isfluxus then exe = "Fluxus" end
	end
	return exe
end

local function ExecutorSupport(exe)
	local name = string.lower(SafeText(exe))
	if string.find(name,"delta") then return "Supported ✅" end
	if string.find(name,"arceus") then return "Supported ✅" end
	if string.find(name,"synapse") then return "Supported ✅" end
	if string.find(name,"krnl") then return "Supported ✅" end
	if string.find(name,"fluxus") then return "Supported ✅" end
	if name=="unknown" or name=="n/a" then return "Unknown ⚠️" end
	return "Maybe Supported ⚠️"
end

local exeName = DetectExecutor()
StatusTab:CreateLabel("👤 Player : "..SafeText(plr and plr.Name))
StatusTab:CreateLabel("🆔 UserId : "..SafeText(plr and plr.UserId))
StatusTab:CreateLabel("🎮 PlaceId : "..SafeText(game and game.PlaceId))
StatusTab:CreateLabel("🌍 JobId : "..SafeText(game and game.JobId))
StatusTab:CreateLabel("⚡ Executor : "..SafeText(exeName))
StatusTab:CreateLabel("🛡️ Support : "..SafeText(ExecutorSupport(exeName)))

StatusTab:CreateParagraph({
	Title="📌 Note",
	Content="Executor Reader biar ga bingung. Unknown berarti executor ga ngasih nama."
})

-- =====================
-- ⭐ CREDITS TAB
-- =====================
local CreditsTab = Window:CreateTab("⭐ Credits", 4483362458)
CreditsTab:CreateSection("⭐ Credits")
CreditsTab:CreateLabel("👑 Developer : Vortex Community")
CreditsTab:CreateLabel("🗿 Author    : REYxNATE")
CreditsTab:CreateLabel("🧩 UI        : Rayfield")
CreditsTab:CreateLabel("📦 Version   : v1.3.0")
CreditsTab:CreateLabel("⚡ Status    : Premium Stable")

-- =====================
-- 📜 UPDATE LOG TAB
-- =====================
local UpdateTab = Window:CreateTab("📜 Update Log", 4483362458)
UpdateTab:CreateSection("📜 Changelog")
UpdateTab:CreateLabel("🔥 v1.3.0 (Latest)")
UpdateTab:CreateLabel("• Big Update: Full Tabs + Auto Trade Universal + Executor Reader Upgrade")
UpdateTab:CreateLabel("• Fake Kick Savage SAFE (no UI destroy)")
UpdateTab:CreateLabel("• FPS Boost 2.0 + Tools Upgrade")
UpdateTab:CreateLabel("• Key System Premium + Copy Key")
UpdateTab:CreateLabel("• StatusTab fix blank issue Fluxus safe")
UpdateTab:CreateSection("📦 Old Versions")
UpdateTab:CreateLabel("v1.2.4")
UpdateTab:CreateLabel("• FIX StatusTab kosong (Fluxus safe)")
UpdateTab:CreateLabel("• Executor Reader lebih aman (SafeText)")
UpdateTab:CreateLabel("• Fake Kick jadi SAFE (no Rayfield destroy)")

Rayfield:Notify({
	Title = "Voytex",
	Content = "Voytex Script v1.3.0 Loaded Successfully 🗿🔥",
	Duration = 5
})
