local get = game:GetService("ReplicatedStorage").Assets.Remotes.GET

-- Sahi cannon dhundho
local cannon
for _, wall in ipairs(workspace.Climbable.Walls:GetChildren()) do
    local c = wall:FindFirstChild("Cannons")
    if c then
        for _, child in ipairs(c:GetChildren()) do
            if child:IsA("Model") then
                cannon = child
                break
            end
        end
    end
    if cannon then break end
end

print("Cannon:", cannon and cannon:GetFullName())

if cannon then
    get:InvokeServer("Cannon", "Claim", cannon)
    get:InvokeServer("Cannon", "State", cannon, true, nil)
    task.wait(0.2)
    for i = 1, 5 do
        get:InvokeServer("Cannon", "Shoot", {BarrelWood = 0, Base = 0})
        print("Fired", i)
        task.wait(0.5)
    end
end
