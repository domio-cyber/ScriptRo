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
                -- We target the specific value you found in Dex
                if v.Name == targetSkin and v:IsA("StringValue") then
                    if v.Value ~= "owned" then
                        v.Value = "owned"
                        print("ScriptRo: Ghost Bart is now OWNED!")
                    end
                end
            end
        end)
        task.wait(0.5) -- Checks every half second to keep it "owned"
    end
end)

-- 2. CLONE TO INVENTORY
local function forceInventory()
    -- Wait for the store to be loaded
    local storeIcon = nil
    for _, v in pairs(storeSkins:GetChildren()) do
        if v.Name:find("Ghost") or v:FindFirstChild(targetSkin) then
            storeIcon = v
            break
        end
    end

    if storeIcon then
        -- Remove the old "Offsale" icon if it's there
        if invSkins:FindFirstChild(targetSkin) then
            invSkins[targetSkin]:Destroy()
        end
        
        -- Inject the new "Owned" icon
        local newIcon = storeIcon:Clone()
        newIcon.Name = targetSkin
        newIcon.Parent = invSkins
        
        -- Set the Button to green "EQUIPPED" like Frozen Bart
        local btn = newIcon:FindFirstChildOfClass("TextButton") or newIcon:FindFirstChild("Buy")
        if btn then
            btn.Text = "EQUIPPED"
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        end
        print("ScriptRo: Icon injected into Inventory!")
    end
end

-- Run injection once, then again if you open/close menus
forceInventory()
player.PlayerGui.main.Seperate.Inventory.Changed:Connect(forceInventory)
