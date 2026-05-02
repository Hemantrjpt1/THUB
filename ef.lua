local cannon = workspace.Climbable.Walls:GetChildren()[2].Cannons["1"]
print("Cannon parts:")
for i, v in ipairs(cannon:GetDescendants()) do
    if v:IsA("BasePart") then
        print(i, v.Name, v:GetFullName())
    end
end
