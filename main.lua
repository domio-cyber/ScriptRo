local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local bulkRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ServerSideBulkPurchaseEvent")

print("--- ScriptRo: RESTORED ORIGINAL LOGIC ---")

-- 1. YOUR ORIGINAL LOGIC: Force the Value
pcall(function()
    player.skins.Bart[target].Value = "unlocked"
end)

-- 2. YOUR ORIGINAL LOGIC: Find and Hijack the Image
local function findAndBuyGhost()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("ImageLabel") and (v.Name:find("Ghost") or (v.Parent and v.Parent.Name:find("Ghost"))) then
            print("ScriptRo: Found the Image! Path: " .. v:GetFullName())
            
            -- Your logic: Force visible and clear locks
            v.Visible = true
            if v.Parent:IsA("GuiObject") then v.Parent.Visible = true end
            local lock = v.Parent:FindFirstChild("Lock") or v:FindFirstChild("Lock")
            if lock then lock.Visible = false end

            -- ADDED BUY TRIGGER: Creating the click area
            local buyTrigger = Instance.new("TextButton")
            buyTrigger.Size = UDim2.new(1, 0, 1, 0)
            buyTrigger.BackgroundTransparency = 1
            buyTrigger.Text = ""
            buyTrigger.Parent = v
            
            buyTrigger.MouseButton1Click:Connect(function()
                print("ScriptRo: Clicked! Sending 555 Quidz Purchase...")
                -- Fire the bulk purchase remote with the target name
                if bulkRemote then
                    bulkRemote:FireServer(tostring(target))
                end
                -- Your visual feedback
                v.ImageColor3 = Color3.fromRGB(0, 255, 0)
            end)
            
            -- Your visual feedback: Blue highlight
            local highlight = Instance.new("SelectionBox")
            highlight.Adornee = v
            highlight.Color3 = Color3.fromRGB(0, 170, 255)
            highlight.Parent = v
            
            return true
        end
    end
end

if not findAndBuyGhost() then
    print("ScriptRo: Could not find the Image. Make sure the menu is open!")
end
