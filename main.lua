local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local bulkRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ServerSideBulkPurchaseEvent")
local equipRemote = game:GetService("ReplicatedStorage").Events:FindFirstChild("equipSkin")

-- 1. FORCE UI TO SHOW AS OWNED LOCALLY
pcall(function()
    player.skins.Bart[target].Value = "owned"
end)

local function setupForceBuy()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        -- Find the Ghost Bart ImageLabel from your script
        if v:IsA("ImageLabel") and (v.Name:find("Ghost") or v.Parent.Name:find("Ghost")) then
            print("ScriptRo: Found Target! Path: " .. v:GetFullName())
            
            -- UNLOCK THE CLICK: Remove blockers sitting on the button
            local parentFrame = v.Parent
            for _, child in pairs(parentFrame:GetDescendants()) do
                if child:IsA("TextLabel") and (child.Text:find("NOT OWNED") or child.Text:find("OFFSALE")) then
                    child:Destroy() -- Kill the text blocker
                end
                if child.Name == "Lock" or child.Name == "Overlay" then
                    child.Visible = false -- Hide the gray lock
                end
            end

            -- CREATE THE "FORCE BUY" BUTTON
            -- Instead of just firing once, we make the image itself the button
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = v
            
            btn.MouseButton1Click:Connect(function()
                print("ScriptRo: BUY BUTTON CLICKED! Hammering Server...")
                
                -- The "Not a string" fix: Using tostring() to satisfy the server
                local fixedTarget = tostring(target)
                
                -- Hammer the purchase AND equip events simultaneously
                for i = 1, 30 do
                    task.spawn(function()
                        if bulkRemote then bulkRemote:FireServer(fixedTarget) end
                        if equipRemote then equipRemote:FireServer(fixedTarget) end
                    end)
                end
                
                v.ImageColor3 = Color3.fromRGB(0, 255, 0) -- Turn green on click
            end)

            -- Visual feedback from your script: Blue Highlight
            local highlight = Instance.new("SelectionBox")
            highlight.Adornee = v
            highlight.Color3 = Color3.fromRGB(0, 170, 255)
            highlight.Parent = v
            
            print("ScriptRo: Setup Complete. CLICK THE GHOST BART IMAGE TO BUY!")
            return true
        end
    end
end

-- Run it
if not setupForceBuy() then
    print("ScriptRo
