local cannon = workspace.Climbable.Walls.Wall.Cannons["1"]
for _, v in ipairs(cannon:GetDescendants()) do
    print(v:GetFullName(), v.ClassName)
end
