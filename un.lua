local cannons = workspace.Climbable.Walls.Wall.Cannons
print("Cannons count:", #cannons:GetChildren())
for _, cannon in ipairs(cannons:GetChildren()) do
    print("Cannon:", cannon.Name, cannon.ClassName)
    for _, c in ipairs(cannon:GetChildren()) do
        print("  ->", c.Name, c.ClassName)
    end
end
