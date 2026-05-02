local walls = workspace.Climbable.Walls:GetChildren()
for i, wall in ipairs(walls) do
    print(i, wall.Name, wall.ClassName)
    local cannons = wall:FindFirstChild("Cannons")
    if cannons then
        print("  Cannons found:")
        for _, c in ipairs(cannons:GetChildren()) do
            print("   ->", c.Name, c.ClassName)
        end
    end
end
