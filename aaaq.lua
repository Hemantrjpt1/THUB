local getRemote = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local cannon = workspace.Climbable.Walls.Wall.Cannons["1"]
getRemote:InvokeServer("Cannon", "Claim", cannon)
getRemote:InvokeServer("Cannon", "State", cannon, true)
task.wait(0.2)
local result = getRemote:InvokeServer("Cannon", "Shoot", {BarrelWood = 40, Base = 0})
print("Result:", result)
