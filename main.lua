local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local bulkRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ServerSideBulkPurchaseEvent")

print("--- ScriptRo: GHOST BART FINDER + BUYER ---")

-- 1. FORCE THE VALUE UNLOCKED (Your Logic)
pcall(function()
    player.skins.Bart[target].Value = "unlocked"
end)

-- 2. FIND IMAGE & ENABLE BUY BUTTON
local function findAndEnableBuy()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        -- YOUR SEARCH LOGIC: Look for ImageLabel with "Ghost" or "Bart"
        if v:IsA("ImageLabel") and (v.Name:find("Ghost") or (v.Parent and v.Parent.Name:find("Ghost"))) then
            print("ScriptRo: Found the Image! Path: " .. v:GetFullName())
            
            -- YOUR UNLOCK LOGIC: Force visible and remove locks
            v.Visible = true
            if v.Parent:IsA("GuiObject") then v.Parent.Visible = true end
            
            local lock = v.Parent:FindFirstChild("Lock") or v:FindFirstChild("Lock")
            if lock then lock.Visible = false end

            -- 3. THE BUY BUTTON LOGIC
            -- We look for an existing "Buy" button in the same frame
            local buyBtn = v.Parent:FindFirstChild("Buy") or v.Parent:FindFirstChildOfClass("TextButton")
            
            -- If no button exists, we create an invisible one over the image
            if not buyBtn then
                print("ScriptRo: No 'Buy' button found. Creating one over the image...")
                buyBtn = Instance.new("TextButton")
                buyBtn.Size = UDim2.new(1, 0, 1, 0)
                buyBtn.BackgroundTransparency = 1
                buyBtn.Text = "CLICK TO BUY"
                buyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
                buyBtn.TextStrokeTransparency = 0
                buyBtn.Parent = v -- Parent it to the image
            else
                print("ScriptRo: Found existing 'Buy' button. Hijacking it...")
                buyBtn.Visible = true
                buyBtn.Text = "BUY FOR 555" -- Visual indicator
            end

            -- 4. CONNECT THE PURCHASE (The part you needed)
            -- We disconnect old connections to ensure OUR buy logic runs
            local signal = buyBtn.MouseButton1Click:Connect(function()
                print("ScriptRo: BUY CLICKED! Sending Purchase Signal...")
                
                -- Visual Feedback
                v.ImageColor3 = Color3.fromRGB(0, 255, 0) 
                
                -- Fire the PURCHASE remote (for the 555 Quidz)
                if bulkRemote then
                    -- We fire it multiple times to ensure the server hears it
                    for i = 1, 15 do
                        bulkRemote:FireServer(tostring(target))
                    end
                else
                    warn("ScriptRo: Purchase Remote not found!")
                end
                
                -- Fire the EQUIP remote (just in case)
                game:GetService("ReplicatedStorage").Events.equipSkin:FireServer(target)
            end)

            -- Your Visual Feedback: Blue Highlight
            local highlight = Instance.new("SelectionBox")
            highlight.Adornee = v
            highlight.Color3 = Color3.fromRGB(0, 170, 255)
            highlight.Parent = v
            
            return true
        end
    end
end

-- Run it
if not findAndEnableBuy() then
    print("ScriptRo: Could not find the ImageLabel. Try opening the STORE menu first!")
end
