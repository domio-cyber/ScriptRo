local player = game.Players.LocalPlayer
local targetSkin = "Ghost Bart"

-- 1. Persistent Value Unlocker
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local skinVal = player:WaitForChild("skins"):WaitForChild("Bart"):FindFirstChild(targetSkin)
            if skinVal and skinVal.Value ~= "unlocked" then
                skinVal.Value = "unlocked"
            end
        end)
    end
end)

-- 2. Grid Icon Hijacker (Makes it selectable)
local function refreshIcons()
    pcall(function()
        local scrollingFrame = player.PlayerGui.main.Seperate.Skins.Barts
        for _, icon in pairs(scrollingFrame:GetChildren()) do
            -- Look for the Ghost Bart icon
            if icon.Name == targetSkin or (icon:FindFirstChild("Title") and icon.Title.Text == targetSkin) then
                
                -- Hide the Lock/Price overlays so you can see the skin
                if icon:FindFirstChild("Lock") then icon.Lock.Visible = false end
                if icon:FindFirstChild("Price") then icon.Price.Visible = false end
                if icon:FindFirstChild("Locked") then icon.Locked.Visible = false end
                
                -- Visual feedback that it's unlocked
                icon.BackgroundColor3 = Color3.fromRGB(85, 255, 127) -- Light Green
            end
        end
    end)
end

-- 3. The "Selection" panel Fixer (Hides the Buy button if it appears)
task.spawn(function()
    while task.wait(0.2) do
        refreshIcons()
        pcall(function()
            local selectedPanel = player.PlayerGui.main.Seperate.Skins.Selected
            local buyBtn = selectedPanel:FindFirstChild("Buy")
            local priceTxt = selectedPanel:FindFirstChild("TextLabel")
            
            -- If Ghost Bart is selected, we hide the Buy button so it doesn't block you
            if buyBtn and buyBtn.Visible then
                buyBtn.Visible = false
                if priceTxt then priceTxt.Text = "OWNED" end
            end
        end)
    end
end)

print("ScriptRo: Selection Mode Active. Just click the Ghost Bart icon in the grid!")
