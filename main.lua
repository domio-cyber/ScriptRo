local player = game.Players.LocalPlayer
local target = "Ghost Bart"

print("--- ScriptRo: SCANNING ALL REMOTES ---")

-- 1. DYNAMIC REMOTE SEARCH (Fixes 'Remote not found' error)
local function findPurchaseRemote()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local name = v.Name:lower()
            -- Looking for common purchase/skin remote names
            if name:find("purchase") or name:find("buy") or name:find("skin") then
                print("ScriptRo: Found Potential Remote -> " .. v:GetFullName())
                return v
            end
        end
    end
    return nil
end

local pRemote = findPurchaseRemote()

-- 2. HIJACK THE STORE UI (Using your proven logic)
local function finalForceBuy()
    for _, v in pairs(player.PlayerGui:GetDescendants()) do
        -- Targeting the exact path found in your log
        if v:IsA("ImageLabel") and v.Name == "Vignette" and v.Parent.Name == target then
            print("ScriptRo: Targeting Ghost Bart... Creating Force-Buy Button.")
            
            -- Clear locks and make visible
            v.Visible = true
            if v.Parent:IsA("GuiObject") then v.Parent.Visible = true end
            
            -- Create the invisible button layer
            local btn = Instance.new("TextButton", v)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = "CLICK TO BUY"
            btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            btn.TextStrokeTransparency = 0
            
            btn.MouseButton1Click:Connect(function()
                if pRemote then
                    print("ScriptRo: Firing " .. pRemote.Name .. " for " .. target)
                    -- Hammer the remote to force the 555 Quidz deduction
                    for i = 1, 20 do
                        task.spawn(function()
                            pRemote:FireServer(tostring(target))
                        end)
                    end
                    v.ImageColor3 = Color3.fromRGB(0, 255, 0)
                else
                    warn("ScriptRo: NO REMOTE FOUND! Check Dex for 'Events' folder.")
                end
            end)
            
            -- Visual feedback from your logic
            local highlight = Instance.new("SelectionBox", v)
            highlight.Adornee = v
            highlight.Color3 = Color3.fromRGB(0, 170, 255)
            
            return true
        end
    end
end

if not finalForceBuy() then
    print("ScriptRo: Could not find image. Open the STORE menu first!")
end
