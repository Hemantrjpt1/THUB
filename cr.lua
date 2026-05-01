-- FINAL COLOSSAL TEST - Fixed
local lp = game:GetService("Players").LocalPlayer
local PlayerGui = lp:WaitForChild("PlayerGui")
local vim = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")

print("===== COLOSSAL TEST =====")

task.wait(1)

if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
    print("Character not loaded! Waiting...")
    repeat task.wait(1) until lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
end

local root = lp.Character.HumanoidRootPart

-- Step 1: Kill titan
print("\n1. Killing titan...")
local titansFolder = workspace:FindFirstChild("Titans")
if titansFolder then
    for _, titan in ipairs(titansFolder:GetChildren()) do
        if not titan:IsA("Model") then continue end
        if titan:GetAttribute("Killed") then continue end
        
        local nape = titan:FindFirstChild("Hitboxes")
        if nape then nape = nape:FindFirstChild("Hit") end
        if nape then nape = nape:FindFirstChild("Nape") end
        
        if nape then
            root.CFrame = CFrame.new(nape.Position + Vector3.new(0, 200, 30))
            task.wait(0.2)
            
            for i = 1, 5 do
                pcall(function()
                    game:GetService("ReplicatedStorage").Assets.Remotes.POST:FireServer("Attacks", "Slash", true)
                    game:GetService("ReplicatedStorage").Assets.Remotes.POST:FireServer("Hitboxes", "Register", nape, 1000)
                end)
                task.wait(0.03)
            end
            print("Titan hit!")
            break
        end
    end
end

-- Step 2: Cannon
print("\n2. Cannon...")
local climbable = workspace:FindFirstChild("Climbable")
if climbable then
    local walls = climbable:FindFirstChild("Walls")
    if walls then
        for _, wall in ipairs(walls:GetChildren()) do
            local cannons = wall:FindFirstChild("Cannons")
            if cannons then
                local cannonModel = cannons:FindFirstChild("1")
                if cannonModel then
                    local hitbox = cannonModel:FindFirstChild("Hitbox")
                    if hitbox then
                        root.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 5, 0))
                        task.wait(0.5)
                        
                        -- Mount
                        local interact1 = PlayerGui:FindFirstChild("Interact_1")
                        if interact1 then
                            print("Interact_1 found!")
                            for _, btn in ipairs(interact1:GetDescendants()) do
                                if (btn:IsA("ImageButton") or btn:IsA("TextButton")) and btn.Visible then
                                    print("Button:", btn.Name)
                                    GuiService.SelectedObject = btn
                                    task.wait(0.05)
                                    vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                                    vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                                    print("Mounted!")
                                    break
                                end
                            end
                        else
                            print("Interact_1 NOT found!")
                        end
                        
                        task.wait(0.3)
                        
                        -- Fire M1
                        for i = 1, 20 do
                            vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            task.wait(0.01)
                        end
                        print("Fired 20 times!")
                    end
                end
            end
        end
    end
end

print("\n===== TEST DONE =====")
