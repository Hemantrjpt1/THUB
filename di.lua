-- Cannon Model "1" Deep Scanner
print("===== CANNON MODEL 1 =====")

local climbable = workspace:FindFirstChild("Climbable")
if climbable then
    local walls = climbable:FindFirstChild("Walls")
    if walls then
        for _, wall in ipairs(walls:GetChildren()) do
            local cannons = wall:FindFirstChild("Cannons")
            if cannons then
                local model1 = cannons:FindFirstChild("1")
                if model1 and model1:IsA("Model") then
                    print("Model '1' found in:", wall.Name)
                    print("Children:")
                    
                    local function scanModel(obj, depth)
                        depth = depth or 0
                        local indent = string.rep("  ", depth)
                        for _, child in ipairs(obj:GetChildren()) do
                            print(indent .. child.Name .. " [" .. child.ClassName .. "]")
                            if child:IsA("BasePart") then
                                print(indent .. "  Position:", child.Position)
                                print(indent .. "  ClickDetector:", child:FindFirstChild("ClickDetector") and "YES" or "NO")
                                print(indent .. "  ProximityPrompt:", child:FindFirstChild("ProximityPrompt") and "YES" or "NO")
                                -- Check for TouchInterest
                                if child:FindFirstChild("TouchInterest") then
                                    print(indent .. "  TouchInterest: YES")
                                end
                            end
                            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                                print(indent .. "  >>> REMOTE FOUND!")
                            end
                            if child:IsA("ClickDetector") then
                                print(indent .. "  >>> CLICK DETECTOR! MaxActivationDistance:", child.MaxActivationDistance)
                            end
                            if child:IsA("ProximityPrompt") then
                                print(indent .. "  >>> PROXIMITY PROMPT! ActionText:", child.ActionText)
                            end
                            if #child:GetChildren() > 0 and depth < 5 then
                                scanModel(child, depth + 1)
                            end
                        end
                    end
                    
                    scanModel(model1)
                    
                    -- Also check model's PrimaryPart
                    if model1.PrimaryPart then
                        print("\nPrimaryPart:", model1.PrimaryPart.Name)
                        print("PrimaryPart Position:", model1.PrimaryPart.Position)
                    end
                end
            end
        end
    end
end

-- Also check if player can interact with cannon
print("\n===== PLAYER DATA =====")
local char = lp.Character
if char then
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        print("Player Position:", hrp.Position)
        
        -- Check distance to cannon
        local climbable = workspace:FindFirstChild("Climbable")
        if climbable then
            local walls = climbable:FindFirstChild("Walls")
            if walls then
                for _, wall in ipairs(walls:GetChildren()) do
                    local cannons = wall:FindFirstChild("Cannons")
                    if cannons then
                        local model1 = cannons:FindFirstChild("1")
                        if model1 and model1.PrimaryPart then
                            local dist = (hrp.Position - model1.PrimaryPart.Position).Magnitude
                            print("Distance to cannon in", wall.Name .. ":", math.floor(dist))
                        end
                    end
                end
            end
        end
    end
end

print("===== SCAN COMPLETE =====")
