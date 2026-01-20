-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Window
local Window = Rayfield:CreateWindow({
   Name = "Voytex Script",
   LoadingTitle = "Voytex",
   LoadingSubtitle = "Rayfield Edition",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Voytex",
      FileName = "VoytexConfig"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local InfoTab = Window:CreateTab("Info", 4483362458)
local UpdateTab = Window:CreateTab("Update Log", 4483362458)

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
      if state then
         hum.WalkSpeed = 50
      else
         hum.WalkSpeed = 16
      end
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
-- INFO TAB
-- =====================
InfoTab:CreateSection("Script Information")

InfoTab:CreateLabel("📌 Script Name : Voytex Script")
InfoTab:CreateLabel("👑 Developer   : Vortex Community")
InfoTab:CreateLabel("🧩 UI Library  : Rayfield")
InfoTab:CreateLabel("📦 Version     : v1.0.0")
InfoTab:CreateLabel("🔄 Status      : Stable")

-- =====================
-- UPDATE LOG TAB
-- =====================
UpdateTab:CreateSection("Changelog")

UpdateTab:CreateLabel("📦 v1.0.0 - Initial Release")
UpdateTab:CreateLabel("• Rayfield UI")
UpdateTab:CreateLabel("• WalkSpeed Toggle")
UpdateTab:CreateLabel("• Speed Slider")
UpdateTab:CreateLabel("• Player Reset")
UpdateTab:CreateLabel("• Info Tab")
UpdateTab:CreateLabel("• Update Log Tab")

-- Notify on load
Rayfield:Notify({
   Title = "Voytex",
   Content = "Script Loaded Successfully",
   Duration = 5
})
