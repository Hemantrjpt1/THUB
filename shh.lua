local getRemote = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local cannon = workspace.Climbable.Walls.Wall.Cannons["1"]
print("Cannon:", cannon)

getRemote:InvokeServer("Cannon", "Claim", cannon)
print("Claimed")
getRemote:InvokeServer("Cannon", "State", cannon, true)
print("State set")
task.wait(0.2)
local result = getRemote:InvokeServer("Cannon", "Shoot", {BarrelWood = 40, Base = 0})
print("Shoot result:", result)
