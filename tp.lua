-- SIMPLE COLOSSAL TEST - FIXED
print("===== COLOSSAL TEST STARTED =====")

-- Step 1: Kill nearest titan
print("\n1. Finding ti...")
local titansFolder = workspace:FindFirstChild("Titans")
if titansFolder then
    for _, titan in ipairs(titansFolder:GetChildren()) do
        -- Skip non-Model objects (like Highlight)
        if not titan:IsA("Model") then 
            print("Skipping:", titan.Name, "| Class:", titan.ClassName)
            continue 
        end
        if titan:GetAttribute("Killed") then continue end
        
        -- Safe nape find
        local nape = nil
        pcall(function()
            local hitboxes = titan:FindFirstChild("Hitboxes")
            if hitboxes then
                local hit = hitboxes:FindFirstChild("Hit")
                if hit then
                    nape = hit:FindFirstChild("Nape")
                end
            end
        end)
        
        if nape then
            print("Found titan nape at:", nape.Position)
            -- Rest of code...
            break
        end
    end
end

-- Same for cannon - check if model exists
print("\n2. Going to cannon...")
local climbable = workspace:FindFirstChild("Climbable")
if climbable then
    local walls = climbable:FindFirstChild("Walls")
    if walls then
        for _, wall in ipairs(walls:GetChildren()) do
            if wall:IsA("Model") then
                local cannons = wall:FindFirstChild("Cannons")
                if cannons then
                    local cannonModel = cannons:FindFirstChild("1")
                    if cannonModel and cannonModel:IsA("Model") then
                        local hitbox = cannonModel:FindFirstChild("Hitbox")
                        if hitbox then
                            print("Cannon found at:", hitbox.Position)
                            lp.Character.HumanoidRootPart.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 5, 0))
                            task.wait(0.5)
                            break
                        end
                    end
                end
            end
        end
    end
end

print("\n===== TEST COMPLETE =====")
