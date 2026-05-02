local getRemote = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local walls = workspace.Climbable.Walls:GetChildren()
local cannon = nil
for _, wall in ipairs(walls) do
    local c = wall:FindFirstChild("Cannons")
    if c and c:FindFirstChild("1") then
        cannon = c["1"]
        break
    end
end
print("Cannon:", cannon)

if cannon then
    getRemote:InvokeServer("Cannon", "Claim", cannon)
    getRemote:InvokeServer("Cannon", "State", cannon, true, nil)
    task.wait(0.1)
    for i = 1, 10 do
        local result = getRemote:InvokeServer("Cannon", "Shoot", {BarrelWood = 0, Base = 0})
        print("Shot", i, "result:", result)
        task.wait(0.1)
    end
end
