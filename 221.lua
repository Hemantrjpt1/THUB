local get = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local titans = workspace:FindFirstChild("Titans")
local colossal = titans and titans:FindFirstChild("Colossal_Titan")
local colossalHRP = colossal and colossal:FindFirstChild("HumanoidRootPart")

local cannon
for _, wall in ipairs(workspace.Climbable.Walls:GetChildren()) do
    local c = wall:FindFirstChild("Cannons")
    if c then
        for _, child in ipairs(c:GetChildren()) do
            if child:IsA("Model") then cannon = child break end
        end
    end
    if cannon then break end
end

local barrelWood = cannon and cannon:FindFirstChild("Barrel", true)
local base = cannon and cannon:FindFirstChild("Base", true)
print("BarrelWood:", barrelWood and barrelWood:GetFullName())
print("Base:", base and base:GetFullName())
print("Colossal HRP pos:", colossalHRP and colossalHRP.Position)

-- Try firing with actual part references
if cannon and colossalHRP then
    get:InvokeServer("Cannon", "Claim", cannon)
    get:InvokeServer("Cannon", "State", cannon, true, nil)
    task.wait(0.2)
    local result = get:InvokeServer("Cannon", "Shoot", {
        BarrelWood = barrelWood,
        Base = base
    })
    print("Result:", result)
end
