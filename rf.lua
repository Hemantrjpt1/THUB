local ref = workspace.Climbable.Walls.Wall.Cannons.Reference
print("Reference value:", ref.Value)
print("Reference full path:", ref.Value and ref.Value:GetFullName())
if ref.Value then
    print("Ref children:")
    for _, c in ipairs(ref.Value:GetChildren()) do
        print("  ->", c.Name, c.ClassName)
    end
end
