-- SIMPLE COLOSSAL TEST - Step by Step
print("===== COLOSSAL TEST STARTED =====")

-- Step 1: Kill nearest titan
print("\n1. Finding titan...")
local titansFolder = workspace:FindFirstChild("Titans")
if titansFolder then
    for _, titan in ipairs(titansFolder:GetChildren()) do
        if not titan:GetAttribute("Killed") then
            local nape = titan.Hitboxes and titan.Hitboxes.Hit and titan.Hitboxes.Hit.Nape
            if nape then
                print("Found titan nape at:", nape.Position)
                
                -- TP to nape
                lp.Character.HumanoidRootPart.CFrame = CFrame.new(nape.Position + Vector3.new(0, 200, 30))
                task.wait(0.2)
                
                -- Attack
                print("Attacking...")
                for i = 1, 5 do
                    pcall(function()
                        getRemote:InvokeServer("Functions", "Attack") -- Try different remote
                    end)
                    pcall(function()
                        postRemote:FireServer("Attacks", "Slash", true)
                        postRemote:FireServer("Hitboxes", "Register", nape, 500)
                    end)
                    task.wait(0.05)
                end
                print("Titan attacked!")
                break
            end
        end
    end
end

-- Step 2: Go to cannon
print("\n2. Going to cannon...")
local cannon = workspace.Climbable.Walls.Wall.Cannons["1"]
if cannon then
    local hitbox = cannon:FindFirstChild("Hitbox")
    if hitbox then
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 5, 0))
        print("At cannon position:", hitbox.Position)
        task.wait(0.5)
        
        -- Step 3: Try mounting
        print("\n3. Trying to mount cannon...")
        
        -- Method 1: Click Interact_1 button
        local interact1 = PlayerGui:FindFirstChild("Interact_1")
        if interact1 then
            print("Interact_1 found, Visible:", interact1.Visible)
            
            -- Find clickable element
            for _, child in ipairs(interact1:GetDescendants()) do
                if child:IsA("ImageButton") or child:IsA("TextButton") then
                    print("Button found:", child.Name, "Visible:", child.Visible, "Active:", child.Active)
                    if child.Visible then
                        GuiService.SelectedObject = child
                        task.wait(0.05)
                        vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        print("Button clicked!")
                        break
                    end
                end
            end
        else
            print("Interact_1 NOT found!")
        end
        
        -- Also try BillboardGui on cannon
        local billboard = cannon:FindFirstChild("Interact")
        if billboard then
            print("BillboardGui found on cannon")
            for _, child in ipairs(billboard:GetDescendants()) do
                if child:IsA("ImageButton") or child:IsA("TextButton") then
                    print("Billboard button:", child.Name, "Visible:", child.Visible)
                end
            end
        end
        
        task.wait(0.5)
        
        -- Step 4: Try firing
        print("\n4. Trying to fire M1...")
        for i = 1, 5 do
            vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.02)
            vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            task.wait(0.02)
        end
        print("M1 fired 5 times")
    end
end

print("\n===== COLOSSAL TEST COMPLETE =====")
