local player = game.Players.LocalPlayer
local target = "Ghost Bart"

print("--- ScriptRo: SCANNING FOR HIDDEN PURCHASE REMOTE ---")

-- 1. FIND THE REAL REMOTE (Bypassing the 'Not Found' error)
local realRemote = nil
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local name = v.Name:lower()
        if name:find("purchase") or name:find("buy") or name:find("skin") then
            print("ScriptRo: Found Potential Remote -> " .. v:GetFullName())
            realRemote = v
        end
    end
end

-- 2. HIJACK THE UI (Your Logic)
local function finalAttempt()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        if v:IsA("ImageLabel") and (v.Name:find("Ghost") or (v.Parent and v.Parent.Name:find("Ghost"))) then
            print("ScriptRo: Targeting Ghost Bart Image...")
            
            -- Force Visibility
            v.Visible = true
            if v.Parent:IsA("GuiObject") then v.Parent.Visible = true end
            
            -- Create the clickable area
            local btn = Instance.new("TextButton", v)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = "FORCE BUY"
            btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            btn.TextStrokeTransparency = 0
            
            btn.MouseButton1Click:Connect(function()
                if realRemote then
                    print("ScriptRo: Firing " .. realRemote.Name .. " for " .. target)
                    -- We fire the remote with the string and the price (555)
                    for i = 1, 10 do
                        realRemote:FireServer(tostring(target))
                        realRemote:FireServer(target)
                    end
                else
                    warn("ScriptRo: STILL NO REMOTE FOUND! Check F9 Console.")
                end
            end)
            
            return true
        end
    end
end

if not finalAttempt() then
    print("ScriptRo: Ghost Bart image not found. Open the STORE first!")
end
