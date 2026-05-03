local post = game:GetService("ReplicatedStorage").Assets.Remotes.POST
local cannonBall = workspace:FindFirstChild("Cannon")
local ct = workspace.Titans:FindFirstChild("Colossal_Titan")
local nape = ct and ct:FindFirstChild("Hitboxes") and ct.Hitboxes:FindFirstChild("Hit") and ct.Hitboxes.Hit:FindFirstChild("Nape")

print("CannonBall:", cannonBall)
print("Nape:", nape)

if cannonBall and nape then
    for i = 1, 5 do
        post:FireServer("S_Skills", "Impact", cannonBall, nape.Position)
        print("Hit", i)
        task.wait(0.1)
    end
end
