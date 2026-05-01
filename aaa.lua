local cannon = workspace.Climbable.Walls.Wall.Cannons["1"]
-- Deep search for ProximityPrompt, ClickDetector, or any Script
for _, v in ipairs(cannon:GetDescendants()) do
    if v:IsA("ProximityPrompt") or v:IsA("ClickDetector") or v:IsA("Script") or v:IsA("LocalScript") then
        print("FOUND:", v:GetFullName(), v.ClassName)
    end
end

-- Check attributes on cannon and hitbox
print("\nCannon attributes:")
for k, v in pairs(cannon:GetAttributes()) do
    print(" ", k, "=", v)
end

local hitbox = cannon:FindFirstChild("Hitbox")
if hitbox then
    print("Hitbox attributes:")
    for k, v in pairs(hitbox:GetAttributes()) do
        print(" ", k, "=", v)
    end
end
