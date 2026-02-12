local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local storeSkins = player.PlayerGui.main.Seperate.Store.frame.Frame.Skins
local invSkins = player.PlayerGui.main.Seperate.Inventory.frame.Frame.Skins

print("--- ScriptRo: QUIDZ LAG-BYPASS ACTIVE ---")

-- 1. LOCK VALUE TO 'owned'
task.spawn(function()
    while true do
        pcall(function()
            player.skins.Bart["Ghost Bart"].Value = "owned"
        end)
        task.wait(0.1)
    end
end)

-- 2. REBUILD THE STORE ICON WITH BYPASS
local function buildStoreBypass()
    local storeIcon = nil
    for _, v in pairs(storeSkins:GetChildren()) do
        if v.Name:find("Ghost") or v:FindFirstChild(target) then
            storeIcon = v
            break
        end
    end

    if storeIcon then
        local newIcon = storeIcon:Clone()
        newIcon.Name = "GhostBypass"
        newIcon.Parent = invSkins
        
        -- Fix the UI so it doesn't break scrolling
        for _, obj in pairs(newIcon:GetDescendants()) do
            if obj:IsA("UIConstraint") then obj:Destroy() end
        end
        newIcon.Size = UDim2.new(0, 110, 0, 110)

        local buyBtn = newIcon:FindFirstChild("Buy") or newIcon:FindFirstChildOfClass("TextButton")
        if buyBtn then
            buyBtn.Text = "BUY!! (555 Q)"
            buyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            
            buyBtn.MouseButton1Click:Connect(function()
                buyBtn.Text = "BYPASSING..."
                -- Sending 50 rapid requests to force a Quidz deduction
                for i = 1, 50 do
                    task.spawn(function()
                        for _, remote in pairs(game:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("buy") or remote.Name:lower():find("purchase")) then
                                remote:FireServer(target)
                            end
                        end
                    end)
                    task.wait(0.01)
                end
                buyBtn.Text = "BOUGHT!"
                buyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            end)
        end
    end
end

buildStoreBypass()
