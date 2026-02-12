local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local bulkRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ServerSideBulkPurchaseEvent")
local equipRemote = game:GetService("ReplicatedStorage").Events:FindFirstChild("equipSkin")

print("--- ScriptRo: ULTIMATE HIJACK & PURCHASE ACTIVE ---")

-- 1. ENHANCED VALUE & UI OVERRIDE
task.spawn(function()
    while true do
        pcall(function()
            -- Force the internal value to owned
            if player.skins.Bart:FindFirstChild(target) then
                player.skins.Bart[target].Value = "owned"
            end
            
            -- Find the "NOT OWNED" label and hijack it
            for _, v in pairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text == "NOT OWNED" then
                    v.Text = "FORCE BUYING..."
                    v.TextColor3 = Color3.fromRGB(255, 255, 0)
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 2. THE IMAGE-BASED PURCHASE HIJACK
local function finalHijack()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        -- Find the Ghost ImageLabel from your script
        if v:IsA("ImageLabel") and (v.Name:find("Ghost") or (v.Parent and v.Parent.Name:find("Ghost"))) then
            print("ScriptRo: Ghost Image Found. Launching Lag-Bypass...")
            
            -- Remove any 'Lock' or 'Offsale' overlays visually
            local lock = v.Parent:FindFirstChild("Lock") or v:FindFirstChild("Lock")
            if lock then lock:Destroy() end

            -- THE ENHANCEMENT: Hammer the server to spend 555 Quidz
            for i = 1, 50 do
                task.spawn(function()
                    if bulkRemote then bulkRemote:FireServer(tostring(target)) end
                    if equipRemote then equipRemote:FireServer(tostring(target)) end
                end)
            end
            
            -- Visual success feedback
            v.ImageColor3 = Color3.fromRGB(150, 255, 150)
            return true
        end
    end
end

-- Execute the hijack
if not finalHijack() then
    print("ScriptRo: Could not find the Ghost Image. Make sure the Inventory is open!")
end
