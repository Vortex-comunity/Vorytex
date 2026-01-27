--// Voytex Script Core
--// Author : REYxNATE
--// Protected by Junki
--// Status : Stable

-- =====================
-- 🛡️ SAFE EXEC START
-- =====================
task.wait(0.3)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =====================
-- 🔍 EXECUTOR CHECK (SAFE)
-- =====================
local function GetExecutor()
	local exe = "Unknown"
	pcall(function()
		if getexecutorname then
			exe = tostring(getexecutorname())
		elseif identifyexecutor then
			exe = tostring(identifyexecutor())
		end
	end)
	return exe
end

local EXECUTOR = GetExecutor()

-- =====================
-- 🚫 BLOCK UNSUPPORTED
-- =====================
if EXECUTOR == "Unknown" then
	return
end

-- =====================
-- 🪟 LOAD UI (DELAY SAFE)
-- =====================
task.wait(0.3)

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Voytex Script",
	LoadingTitle = "Voytex",
	LoadingSubtitle = "Protected Build",
	ConfigurationSaving = {
		Enabled = false
	},
	KeySystem = false
})

-- =====================
-- 🏠 MAIN TAB
-- =====================
local MainTab = Window:CreateTab("🏠 Main", 4483362458)
MainTab:CreateSection("Main")

MainTab:CreateButton({
	Name = "Test",
	Callback = function()
		Rayfield:Notify({
			Title = "Voytex",
			Content = "Core Loaded Successfully",
			Duration = 3
		})
	end
})

-- =====================
-- 🧰 TOOLS
-- =====================
local ToolsTab = Window:CreateTab("🧰 Tools", 4483362458)
ToolsTab:CreateButton({
	Name = "Rejoin",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
	end
})

-- =====================
-- 📌 STATUS (ANTI BLANK)
-- =====================
local StatusTab = Window:CreateTab("📌 Status", 4483362458)
StatusTab:CreateLabel("Player : " .. tostring(LocalPlayer.Name))
StatusTab:CreateLabel("Executor : " .. tostring(EXECUTOR))
StatusTab:CreateLabel("Status : Protected by Junki")

-- =====================
-- 🔔 LOADED
-- =====================
Rayfield:Notify({
	Title = "Voytex",
	Content = "Script Loaded (Junki Safe)",
	Duration = 4
})
