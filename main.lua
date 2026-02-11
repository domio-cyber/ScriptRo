local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/PitchyATree/roblox-ui-libs/main/SlapBlock/Lib.lua'))()
local window = library:Window("ScriptRo: Ghost Bart")

window:Button("Unlock & Equip Ghost Bart", function()
    local skinName = "Ghost Bart"
    local events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
    
    -- 1. FIRE THE PURCHASE (Saves to DataStore forever)
    -- We use the exact name found in your Dex screenshot
    events.purchaseSkin:FireServer(skinName)
    
    -- 2. LOCAL UNLOCK (Makes the UI in your screenshot show 'OWNED')
    local player = game.Players.LocalPlayer
    local skinValue = player:WaitForChild("skins"):WaitForChild("Bart"):FindFirstChild(skinName)
    if skinValue then
        skinValue.Value = "unlocked"
    end
    
    -- 3. FIRE THE EQUIP (Puts the skin on you right now)
    events.equipSkin:FireServer(skinName)
    
    print("Ghost Bart sequence finished. Check your menu!")
end)
