local player = game.Players.LocalPlayer
local target = "Ghost Bart"
local bulkRemote = game:GetService("ReplicatedStorage"):FindFirstChild("ServerSideBulkPurchaseEvent")

print("--- ScriptRo: STORE SLOT HIJACK ACTIVE ---")

-- 1. TARGET THE STORE SLOTS
local function hijackStoreSlot()
    pcall(function()
        -- Path found in your Dex: Store -> frame -> Frame -> Skins
        local storeSkins = player.PlayerGui.main.Seperate.Store.frame.Frame.Skins
        local firstSlot = storeSkins:FindFirstChildOfClass("Frame") or storeSkins:FindFirstChildOfClass("ImageButton")
        
        if firstSlot then
            print("ScriptRo: Slot Found. Forcing Ghost Bart...")
            
            -- Change the Name and Text
            firstSlot.Name = target
            local label = firstSlot:FindFirstChildOfClass("TextLabel") or firstSlot:FindFirstChild("Name")
            if label then label.Text = target end
            
            -- Change the Image to Ghost Bart's icon
            local icon = firstSlot:FindFirstChildOfClass("ImageLabel") or firstSlot
            if icon:IsA("ImageLabel") or icon:IsA("ImageButton") then
                icon.Image = "rbxassetid://15214040713" -- Ghost Bart Asset ID
            end

            -- 2. MAKE IT BUYABLE
            -- We find the 'Buy' button in the Selected frame or on the slot itself
            local buyBtn = firstSlot:FindFirstChild("Buy") or firstSlot:FindFirstChildOfClass("TextButton")
            
            if not buyBtn then
                -- If no button exists, we make the whole slot a button
                buyBtn = Instance.new("TextButton")
                buyBtn.Size = UDim2.new(1, 0, 1, 0)
                buyBtn.BackgroundTransparency = 1
                buyBtn.Text = ""
                buyBtn.Parent = firstSlot
            end

            buyBtn.MouseButton1Click:Connect(function()
                print("ScriptRo: Attempting to buy " .. target .. " for 555 Quidz...")
                
                -- Hammer the remote 30 times with the string to force it
                for i = 1, 30 do
                    task.spawn(function()
                        if bulkRemote then 
                            bulkRemote:FireServer(tostring(target)) 
                        end
                    end)
                end
                
                -- Visual Feedback
                firstSlot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            end)
            
            print("ScriptRo: Ghost Bart is now in the store! Click the slot to buy.")
        else
            print("ScriptRo: Could not find any slots in the store. Is the Store menu open?")
        end
    end)
end

hijackStoreSlot()
