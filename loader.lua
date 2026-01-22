
       --// Voytex Script v1.1.1
--// UI: Rayfield

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Voytex Script",
   LoadingTitle = "Voytex",
   LoadingSubtitle = "Rayfield Edition | v1.1.1",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Voytex",
      FileName = "VoytexConfig"
   },
   Discord = { Enabled = false },
   KeySystem = false
})

-- =====================
-- 🏠 MAIN TAB
-- =====================
local MainTab = Window:CreateTab("🏠 Main", 4483362458)

MainTab:CreateSection("🏠 Main Feature")

MainTab:CreateButton({
   Name = "🗿 Test Button",
   Callback = function()
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
      local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
      hum.WalkSpeed = state and 50 or 16
   end
})

MainTab:CreateSlider({
   Name = "🏃 Set Speed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
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
      game.Players.LocalPlayer.Character:BreakJoints()
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
      loadstring(game:HttpGet("https://raw.githubusercontent.com/nurvian/Catraz-HUB/refs/heads/main/Catraz/main.lua"))()
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
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end
})

ToolsTab:CreateButton({
   Name = "⚡ FPS Boost (Simple)",
   Callback = function()
      for _,v in pairs(game:GetDescendants()) do
         if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            v.Enabled = false
         end
      end

      Rayfield:Notify({
         Title = "Voytex",
         Content = "FPS Boost Applied 🗿",
         Duration = 4
      })
   end
})

-- =====================
-- 📌 STATUS TAB
-- =====================
local StatusTab = Window:CreateTab("📌 Status", 4483362458)

StatusTab:CreateSection("📌 Player / Game Status")

local plr = game.Players.LocalPlayer

StatusTab:CreateLabel("👤 Player : " .. plr.Name)
StatusTab:CreateLabel("🆔 UserId : " .. plr.UserId)
StatusTab:CreateLabel("🎮 PlaceId : " .. game.PlaceId)
StatusTab:CreateLabel("🌍 JobId : " .. game.JobId)
StatusTab:CreateLabel("📌 Executor : Unknown")

-- =====================
-- ⭐ CREDITS TAB
-- =====================
local CreditsTab = Window:CreateTab("⭐ Credits", 4483362458)

CreditsTab:CreateSection("⭐ Credits")

CreditsTab:CreateLabel("👑 Developer : Vortex Community")
CreditsTab:CreateLabel("🗿 Owner     : Voytex")
CreditsTab:CreateLabel("🧩 UI        : Rayfield")
CreditsTab:CreateLabel("📦 Version   : v1.1.1")
CreditsTab:CreateLabel("⚡ Status    : Stable")

-- =====================
-- ℹ️ INFO TAB
-- =====================
local InfoTab = Window:CreateTab("ℹ️ Info", 4483362458)

InfoTab:CreateSection("ℹ️ Script Information")

InfoTab:CreateLabel("📌 Script Name : Voytex Script")
InfoTab:CreateLabel("👑 Developer   : Vortex Community")
InfoTab:CreateLabel("🧩 UI Library  : Rayfield")
InfoTab:CreateLabel("📦 Version     : v1.1.1")
InfoTab:CreateLabel("🔄 Status      : Stable")

-- =====================
-- 📜 UPDATE LOG TAB
-- =====================
local UpdateTab = Window:CreateTab("📜 Update Log", 4483362458)

UpdateTab:CreateSection("📜 Changelog")

UpdateTab:CreateLabel("🔥 v1.1.1 (Latest)")
UpdateTab:CreateLabel("• Added emote style for tabs")
UpdateTab:CreateLabel("• Added 🧰 Tools Tab")
UpdateTab:CreateLabel("• Added 🌊 Tsunami Tab")
UpdateTab:CreateLabel("• Added ⚒️ The Forge Tab")
UpdateTab:CreateLabel("• UI Improvements + Clean Layout")

UpdateTab:CreateSection("📦 Old Versions")

UpdateTab:CreateLabel("v1.1.0")
UpdateTab:CreateLabel("• Added Tsunami Tab")
UpdateTab:CreateLabel("• Added The Forge Tab")
UpdateTab:CreateLabel("• Added Credits + Status")
UpdateTab:CreateLabel("• UI Improvements")

UpdateTab:CreateLabel("v1.0.0")
UpdateTab:CreateLabel("• Rayfield UI Base")
UpdateTab:CreateLabel("• WalkSpeed + Slider")
UpdateTab:CreateLabel("• Reset Character")
UpdateTab:CreateLabel("• Info Tab + Update Log Tab")

Rayfield:Notify({
   Title = "Voytex",
   Content = "Voytex Script v1.1.1 Loaded Successfully 🗿🔥",
   Duration = 5
})
