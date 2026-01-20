-- Rayfield UI (STABLE)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Window
local Window = Rayfield:CreateWindow({
   Name = "Voytex Script",
   LoadingTitle = "Voytex",
   LoadingSubtitle = "Rayfield UI",
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

-- Tab
local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- Section
local MainSection = MainTab:CreateSection("Main Feature")

-- Button
Rayfield:Notify({
   Title = "Voytex",
   Content = "Rayfield UI Loaded!",
   Duration = 5
})

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

-- WalkSpeed Toggle
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

-- Speed Slider
MainTab:CreateSlider({
   Name = "Set Speed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
   end
})

-- Player
PlayerTab:CreateButton({
   Name = "Reset Character",
   Callback = function()
      game.Players.LocalPlayer.Character:BreakJoints()
   end
})
