local wall = workspace.Climbable.Walls.Wall
print("Wall children:")
for _, c in ipairs(wall:GetChildren()) do
    print(" ", c.Name, c.ClassName)
end

-- Cannons folder ke andar deep search
local cannons = wall.Cannons
print("\nCannons deep search:")
for _, v in ipairs(cannons:GetDescendants()) do
    if v.Name == "Hitbox" or v.Name == "Interact" or v.Name == "Fire" or v.Name == "Shoot" then
        print(" FOUND:", v:GetFullName(), v.ClassName)
    end
end
