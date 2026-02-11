print("ScriptRo: Attempting direct unlock without UI...")

local skinName = "Ghost Bart"
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("Events", 5) -- Waits 5 seconds for the folder

if events then
    -- 1. PURCHASE (The permanent save)
    events.purchaseSkin:FireServer(skinName)
    print("ScriptRo: Purchase signal sent!")
    
    -- 2. LOCAL UNLOCK (Updates your folder)
    local player = game.Players.LocalPlayer
    local skinValue = player:WaitForChild("skins"):WaitForChild("Bart"):FindFirstChild(skinName)
    if skinValue then
        skinValue.Value = "unlocked"
        print("ScriptRo: Folder value set to unlocked!")
    end
    
    -- 3. EQUIP (Wears it)
    events.equipSkin:FireServer(skinName)
    print("ScriptRo: Equip signal sent!")
else
    warn("ScriptRo: Could not find the Events folder in ReplicatedStorage!")
end
