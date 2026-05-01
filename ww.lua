local cannons = workspace.Climbable.Walls.Wall.Cannons
print("Total cannons:", #cannons:GetChildren())
for _, c in ipairs(cannons:GetChildren()) do
    print(" Cannon:", c.Name, c.ClassName)
    if c:IsA("Model") or c:IsA("Folder") then
        local hitbox = c:FindFirstChild("Hitbox")
        print("   Hitbox pos:", hitbox and hitbox.Position)
    end
end
