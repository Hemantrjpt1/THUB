local walls = workspace.Climbable.Walls
for _, wall in ipairs(walls:GetChildren()) do
    print("Wall:", wall.Name)
    local cannons = wall:FindFirstChild("Cannons")
    if cannons then
        for _, c in ipairs(cannons:GetChildren()) do
            print("  Cannon:", c.Name, c.ClassName)
            if c:IsA("Model") then
                print("  PATH:", c:GetFullName())
            end
        end
    end
end
