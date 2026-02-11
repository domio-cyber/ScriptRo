local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local targetSkin = "Ghost Bart"

-- 1. THE "UNLOCKER" (Data)
-- This loop forces the game to think you own it 60 times a second
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local skinValue = player:WaitForChild("skins"):WaitForChild("Bart"):FindFirstChild(targetSkin)
            if skinValue and skinValue.Value ~= "unlocked" then
                skinValue.Value = "unlocked"
            end
        end)
    end
end)

-- 2. THE "GUI FIXER" (Visuals)
-- This forces the menu to show "EQUIP" instead of "BUY"
runService.RenderStepped:Connect(function()
    pcall(function()
        local skinsUI = player.PlayerGui.main.Seperate.Skins
        
        -- Fix the big button at the bottom
        local buyBtn = skinsUI.Selected:FindFirstChild("Buy")
        local priceLabel = skinsUI.Selected:FindFirstChild("TextLabel")
        
        if buyBtn and buyBtn.Visible then
            buyBtn.Text = "EQUIP"
            buyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green
        end
        
        if priceLabel and priceLabel.Text ~= "OWNED" then
            priceLabel.Text = "OWNED"
            priceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        -- Fix the little icon in the grid
        for _, icon in pairs(skinsUI.Barts:GetChildren()) do
            if icon.Name == targetSkin or (icon:FindFirstChild("Title") and icon.Title.Text == targetSkin) then
                if icon:FindFirstChild("Lock") then icon.Lock.Visible = false end
                if icon:FindFirstChild("Price") then icon.Price.Visible = false end
            end
        end
    end)
end)

-- 3. THE "EQUIPPER" (Function)
-- Makes the 'Buy' button actually equip the skin
local function setupButton()
    local buyBtn = player.PlayerGui.main.Seperate.Skins.Selected:FindFirstChild("Buy")
    if buyBtn then
        -- Disconnect old connections to stop it from trying to buy
        for _, conn in pairs(getconnections(buyBtn.MouseButton1Click)) do
            conn:Disable()
        end
        
        -- Add our new connection
        buyBtn.MouseButton1Click:Connect(function()
            game:GetService("ReplicatedStorage").Events.equipSkin:FireServer(targetSkin)
            print("Force-Equipped " .. targetSkin)
        end)
    end
end

-- Run the button setup every few seconds in case the menu refreshes
task.spawn(function()
    while task.wait(1) do
        pcall(setupButton)
    end
end)

print("--- GHOST BART PERMANENTLY UNLOCKED (CLIENT-SIDE) ---")
