local post = game:GetService("ReplicatedStorage").Assets.Remotes.POST
local cannonBall = workspace:FindFirstChild("Cannon")
local ct = workspace.Titans:FindFirstChild("Colossal_Titan")
local nape = ct and ct.Hitboxes.Hit.Nape

print("CannonBall:", cannonBall)
print("Nape:", nape)
print("Nape pos:", nape and nape.Position)

if cannonBall and nape then
    post:FireServer("S_Skills", "Impact", cannonBall, nape.Position)
    print("Fired!")
end
