local getRemote = game:GetService("ReplicatedStorage").Assets.Remotes.GET

-- Cannon test exactly from log
local cannon = workspace.Climbable.Walls.Wall.Cannons["1"]
print("Cannon:", cannon)

local ok1 = pcall(function()
    getRemote:InvokeServer("Cannon", "Claim", cannon)
    print("Claim done")
end)

local ok2 = pcall(function()
    getRemote:InvokeServer("Cannon", "State", cannon, true)
    print("State done")
end)

task.wait(0.2)

local result
local ok3 = pcall(function()
    result = getRemote:InvokeServer("Cannon", "Shoot", {BarrelWood = 40, Base = 0})
    print("Shoot result:", result)
end)

print("ok1:", ok1, "ok2:", ok2, "ok3:", ok3)
