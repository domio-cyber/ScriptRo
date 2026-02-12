local player = game.Players.LocalPlayer
local targetSkin = "Ghost Bart"

-- Paths from your Explorer
local invSkins = player.PlayerGui.main.Seperate.Inventory.frame.Frame.Skins
local storeSkins = player.PlayerGui.main.Seperate.Store.frame.Frame.Skins
local remote = game:GetService("ReplicatedStorage").Events.equipSkin

print("--- ScriptRo: ULTIMATE INJECTOR ACTIVE ---")

-- 1. PERMANENT OWNED LOOP (Prevents resets while in-game)
task.spawn(function()
    while true do
        pcall(function()
            for _, v in pairs(player:GetDescendants()) do
                if v.Name == targetSkin and v:IsA("StringValue") then
                    v.Value = "owned"
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 2. CLEAN INJECTION (Fixes Scrolling & Clicking)
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
        
        -- FIX SCROLLING: Remove Store constraints
        if newIcon:IsA("GuiObject") then
            newIcon.Active = true
        end
        
        newIcon.Parent = invSkins
        
        -- FIX BUTTON: Make it clickable and Green
        local btn = newIcon:FindFirstChildOfClass("TextButton") or newIcon:FindFirstChild("Buy")
        if btn then
            btn.Text = "EQUIP GHOST"
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            btn.Active = true
            btn.Interactable = true -- Forces it to be clickable
            
            -- Make it actually equip when clicked
            btn.MouseButton1Click:Connect(function()
                remote:FireServer(targetSkin)
                btn.Text = "EQUIPPED"
                print("ScriptRo: Ghost Bart Equipped!")
            end)
        end
    end
end

-- Run it immediately
forceInventory()
