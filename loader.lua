local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Voytex Script",
   LoadingTitle = "Voytex",
   LoadingSubtitle = "Rayfield Edition",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Voytex",
      FileName = "VoytexConfig"
   },
   Discord = { Enabled = false },
   KeySystem = false
})

-- Tabs
local MainTab    = Window:CreateTab("Main", 4483362458)
local PlayerTab  = Window:CreateTab("Player", 4483362458)
local TsunamiTab = Window:CreateTab("Tsunami", 4483362458)
local StatusTab  = Window:CreateTab("Status", 4483362458)
local CreditsTab = Window:CreateTab("Credits", 4483362458)
local InfoTab    = Window:CreateTab("Info", 4483362458)
local UpdateTab  = Window:CreateTab("Update Log", 4483362458)

-- =====================
-- MAIN TAB
-- =====================
MainTab:CreateSection("Main Feature")

MainTab:CreateButton({
   Name = "Test Button",
   Callback = function()
      Rayfield:Notify({
         Title = "Voytex",
         Content = "Button works!",
         Duration = 4
      })
   end
})

MainTab:CreateToggle({
   Name = "WalkSpeed",
   CurrentValue = false,
   Callback = function(state)
      local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
      hum.WalkSpeed = state and 50 or 16
   end
})

MainTab:CreateSlider({
   Name = "Set Speed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
   end
})

-- =====================
-- PLAYER TAB
-- =====================
PlayerTab:CreateSection("Player")

PlayerTab:CreateButton({
   Name = "Reset Character",
   Callback = function()
      game.Players.LocalPlayer.Character:BreakJoints()
   end
})

-- =====================
-- TSUNAMI TAB
-- =====================
TsunamiTab:CreateSection("Tsunami Script")

TsunamiTab:CreateButton({
   Name = "Execute Tsunami Script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()
   end
})

-- =====================
-- STATUS TAB
-- =====================
StatusTab:CreateSection("Player / Game Status")

local plr = game.Players.LocalPlayer
StatusTab:CreateLabel("👤 Player : " .. plr.Name)
StatusTab:CreateLabel("🆔 UserId : " .. plr.UserId)
StatusTab:CreateLabel("🎮 PlaceId : " .. game.PlaceId)
StatusTab:CreateLabel("🌍 JobId : " .. game.JobId)
StatusTab:CreateLabel("📌 Executor : Unknown")

-- =====================
-- CREDITS TAB
-- =====================
CreditsTab:CreateSection("Credits")

CreditsTab:CreateLabel("👑 Developer : Vortex Community")
CreditsTab:CreateLabel("🗿 Owner     : Voytex")
CreditsTab:CreateLabel("🧩 UI        : Rayfield")
CreditsTab:CreateLabel("📦 Version   : v1.1.0")
CreditsTab:CreateLabel("⚡ Status    : Stable")

-- =====================
-- INFO TAB
-- =====================
InfoTab:CreateSection("Script Information")

InfoTab:CreateLabel("📌 Script Name : Voytex Script")
InfoTab:CreateLabel("👑 Developer   : Vortex Community")
InfoTab:CreateLabel("🧩 UI Library  : Rayfield")
InfoTab:CreateLabel("📦 Version     : v1.1.0")
InfoTab:CreateLabel("🔄 Status      : Stable")

-- =====================
-- UPDATE LOG TAB
-- =====================
UpdateTab:CreateSection("Changelog")

UpdateTab:CreateLabel("🔥 v1.1.0 (Latest)")
UpdateTab:CreateLabel("• Added Tsunami Tab")
UpdateTab:CreateLabel("• Added Tsunami Script Execute Button")
UpdateTab:CreateLabel("• Added Credits Tab")
UpdateTab:CreateLabel("• Added Status Tab")
UpdateTab:CreateLabel("• UI Improvements")

UpdateTab:CreateSection("Old Versions")

UpdateTab:CreateLabel("📦 v1.0.0")
UpdateTab:CreateLabel("• Added Rayfield UI")
UpdateTab:CreateLabel("• WalkSpeed Toggle + Slider")
UpdateTab:CreateLabel("• Reset Character")
UpdateTab:CreateLabel("• Info Tab + Update Log Tab")

Rayfield:Notify({
   Title = "Voytex",
   Content = "Script Loaded Successfully 🗿",
   Duration = 5
})
         
