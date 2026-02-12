local player = game.Players.LocalPlayer
local targetSkin = "Ghost Bart"

-- Paths from your Explorer
local invSkins = player.PlayerGui.main.Seperate.Inventory.frame.Frame.Skins
local storeSkins = player.PlayerGui.main.Seperate.Store.frame.Frame.Skins

print("--- ScriptRo: PERMANENT OWNED STATUS ACTIVE ---")

-- 1. LOCK THE VALUE TO "owned"
task.spawn(function()
    while true do
        pcall(function()
            for _, v in pairs(player:GetDescendants()) do
                if v.Name == targetSkin and v:IsA("StringValue") then
                    v.Value = "owned" -- Now matches your Frozen Bart
                end
            end
        end)
        task.wait(0.3)
    end
end)

-- 2. FORCE INTO INVENTORY
local function forceInventory()
    local storeIcon = nil
    for _, v in pairs(storeSkins:GetChildren()) do
        if v.Name:find("Ghost") or v:FindFirstChild(targetSkin) then
            storeIcon = v
            break
        end
    end

    if storeIcon and not invSkins:FindFirstChild(targetSkin) then
        local newIcon = storeIcon:Clone()
        newIcon.Name = targetSkin
        newIcon.Parent = invSkins
        
        local btn = newIcon:FindFirstChildOfClass("TextButton") or newIcon:FindFirstChild("Buy")
        if btn then
            btn.Text = "EQUIPPED"
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        end
    end
end

-- Run it
forceInventory()
