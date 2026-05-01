local interact = workspace.Climbable.Walls.Wall.Cannons["1"].Interact
print("Interact children:")
for _, c in ipairs(interact:GetDescendants()) do
    print(" ", c.Name, c.ClassName)
end
