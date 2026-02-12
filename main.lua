local player = game.Players.LocalPlayer
local target = "Ghost Bart"

-- Path to the Store UI you found
local storeSkins = player.PlayerGui.main.Seperate.Store.frame.Frame.Skins
local invSkins = player.PlayerGui.main.Seperate.Inventory.frame.Frame.Skins

print("--- ScriptRo: STORE-MIMIC BYPASS ACTIVE ---")

-- 1. LOCK LOCAL VALUE TO 'OWNED'
task.spawn(function()
    while true do
        pcall(function()
            player.skins.Bart["Ghost Bart"].Value = "owned"
        end)
        task.wait(0.1)
    end
end)

-- 2. CREATE THE STORE-BUY INTERFACE
local function createStoreBypass()
    -- Find the original Ghost Bart image in the store
    local storeIcon = nil
    for _, v in pairs(storeSkins:GetChildren()) do
        if v.Name:find("Ghost") or v:FindFirstChild(target) then
            storeIcon = v
            break
        end
    end

    if storeIcon then
        local newIcon = storeIcon:Clone()
        newIcon.Name = "GhostBypassIcon"
        newIcon.Parent = invSkins -- Put it in inventory so you can find it easily
        
        -- Find the "Buy" button inside that icon and inject our Lag Bypass
        local buyBtn = newIcon:FindFirstChild("Buy") or newIcon:FindFirstChildOfClass("TextButton")
        if buyBtn then
            buyBtn.Text = "BUY!! (LAG BYPASS)"
            buyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            buyBtn.Active = true
            
            buyBtn.MouseButton1Click:Connect(function()
                buyBtn.Text = "PURCHASING..."
                
                -- The Lag Bypass Hammer: Sends 30 requests to force a currency deduction
                for i = 1, 30 do
                    task.spawn(function()
                        for _, remote in pairs(game:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("buy") or remote.Name:lower():find("purchase")) then
                                remote:FireServer(target)
                            end
                        end
                    end)
                    task.wait(0.
