local cannons = workspace.Climbable.Walls.Wall.Cannons
for _, v in ipairs(cannons:GetChildren()) do
    print(v.Name, v.ClassName)
end
