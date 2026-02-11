-- Stability Check
print("ScriptRo: Attempting to load stable library...")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ScriptRo: Ghost Bart", "Midnight")

-- Create the Tab
local Tab = Window:NewTab("Skins")
local Section = Tab:NewSection("Bart Unlocker")

Section:NewButton("Unlock & Equip Ghost Bart", "Unlocks and wears it instantly", function()
    local skinName = "Ghost Bart"
    local events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
    
    -- 1. PURCHASE (The permanent save)
    events.purchaseSkin:FireServer(skinName)
    
    -- 2. LOCAL UNLOCK (Fixes the GUI)
    local player = game.Players.LocalPlayer
    local skinValue = player:WaitForChild("skins"):WaitForChild("Bart"):FindFirstChild(skinName)
    if skinValue then
        skinValue.Value = "unlocked"
    end
    
    -- 3. EQUIP (Wears it now)
    events.equipSkin:FireServer(skinName)
    
    print("ScriptRo: Ghost Bart Activated!")
end)

print("ScriptRo: GUI Loaded successfully!")
