local cannons = workspace.Climbable.Walls.Wall.Cannons
for _, c in ipairs(cannons:GetChildren()) do
    print(c.Name, c.ClassName)
    for _, cc in ipairs(c:GetChildren()) do
        print("  ->", cc.Name, cc.ClassName)
        for _, ccc in ipairs(cc:GetChildren()) do
            print("    ->", ccc.Name, ccc.ClassName)
        end
    end
end
