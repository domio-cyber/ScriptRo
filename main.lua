local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local bulkRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ServerSideBulkPurchaseEvent")
local equipRemote = game:GetService("ReplicatedStorage").Events:FindFirstChild("equipSkin")

print("--- ScriptRo: IMAGE-DEX HYBRID ACTIVE ---")

-- 1. FORCE THE VALUE & UI TEXT
task.spawn(function()
    while true do
        pcall(function()
            -- Forcing value to 'unlocked' per your request, then 'owned' for the server check
            player.skins.Bart[target].Value = "owned"
            
            -- Locally wipe out the "NOT OWNED" label
            for _, v in pairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text == "NOT OWNED" then
                    v.Text = "READY"
                    v.TextColor3 = Color3.fromRGB(0, 255, 255)
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 2. THE HIJACK & FORCE-BUY
local function finalHijack()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        -- Your logic: Targeting the Ghost ImageLabel
        if v:IsA("ImageLabel") and (v.Name:find("Ghost") or (v.Parent and v.Parent.Name:find("Ghost"))) then
            print("ScriptRo: Image Found! Path: " .. v:GetFullName())
            
            -- Clear Lock Overlays
            v.Visible = true
            local lock = v.Parent:FindFirstChild("Lock") or v:FindFirstChild("Lock")
            if lock then lock.Visible = false end

            -- THE DEX FIX: Targeting the SkinBuyingManager's signal
            local fixedTarget = tostring(target)
            
            print("ScriptRo: Bypassing Click... Launching Lag-Bypass...")
            for i = 1, 60 do
                task.spawn(function()
                    if bulkRemote then bulkRemote:FireServer(fixedTarget) end
                    if equipRemote then equipRemote:FireServer(fixedTarget) end
                end)
            end
            
            -- Visual feedback: Blue Highlight from your script
            local highlight = Instance.new("SelectionBox")
            highlight.Adornee = v
            highlight.Color3 = Color3.fromRGB(0, 170, 255)
            highlight.Parent = v
            
            return true
        end
    end
end

-- Execution
if not finalHijack() then
    print("ScriptRo: Ghost Image not found. Open the Inventory or Store frame!")
end
