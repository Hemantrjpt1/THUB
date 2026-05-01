-- Cannon Debug Scanner
print("===== CANNON DEBUG =====")

-- Find cannons
local climbable = workspace:FindFirstChild("Climbable")
if climbable then
    local walls = climbable:FindFirstChild("Walls")
    if walls then
        for _, wall in ipairs(walls:GetChildren()) do
            local cannons = wall:FindFirstChild("Cannons")
            if cannons then
                print("Found Cannons in:", wall.Name)
                print("Cannons type:", cannons.ClassName)
                print("Children count:", #cannons:GetChildren())
                
                for _, obj in ipairs(cannons:GetChildren()) do
                    print("  Child:", obj.Name, "| Class:", obj.ClassName)
                    
                    -- Check if it's clickable
                    if obj:IsA("BasePart") then
                        print("    Position:", obj.Position)
                        print("    CanCollide:", obj.CanCollide)
                        print("    Transparency:", obj.Transparency)
                    end
                    
                    -- Check for ClickDetector
                    if obj:FindFirstChild("ClickDetector") then
                        print("    HAS ClickDetector!")
                    end
                    
                    -- Check for ProximityPrompt
                    if obj:FindFirstChild("ProximityPrompt") then
                        print("    HAS ProximityPrompt!")
                    end
                end
            end
        end
    end
end

-- Check Colossal Titan hitboxes
print("\n=== COLOSSAL HITBOXES ===")
local colossal = workspace:FindFirstChild("Colossal_Titan")
if colossal then
    local hitboxes = colossal:FindFirstChild("Hitboxes")
    if hitboxes then
        local hit = hitboxes:FindFirstChild("Hit")
        if hit then
            for _, part in ipairs(hit:GetChildren()) do
                print("Hit Part:", part.Name, "| Position:", part.Position)
            end
        end
        local detect = hitboxes:FindFirstChild("Detect")
        if detect then
            print("\nDetect Parts:")
            for _, part in ipairs(detect:GetChildren()) do
                print("  ", part.Name, "| Position:", part.Position)
            end
        end
    end
end

-- Check if Interface mein koi cannon button hai
print("\n=== INTERFACE CANNON UI ===")
local interface = lp.PlayerGui:FindFirstChild("Interface")
if interface then
    for _, v in ipairs(interface:GetDescendants()) do
        if v:IsA("TextButton") or v:IsA("ImageButton") then
            print("Button:", v.Name, "| Text:", v.Text or "N/A", "| Visible:", v.Visible)
        end
    end
end

print("===== CANNON DEBUG END =====")
