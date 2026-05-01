-- TITAN ATTACK TEST - Different methods
local lp = game:GetService("Players").LocalPlayer
local getRemote = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local postRemote = game:GetService("ReplicatedStorage").Assets.Remotes.POST

print("===== TITAN ATTACK TEST =====")

-- Character wait
repeat task.wait(0.5) until lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
local root = lp.Character.HumanoidRootPart

-- Find titan nape
local nape = nil
local titansFolder = workspace:FindFirstChild("Titans")
if titansFolder then
    for _, titan in ipairs(titansFolder:GetChildren()) do
        if not titan:IsA("Model") then continue end
        if titan:GetAttribute("Killed") then continue end
        
        local hb = titan:FindFirstChild("Hitboxes")
        if hb then
            local hit = hb:FindFirstChild("Hit")
            if hit then
                nape = hit:FindFirstChild("Nape")
                if nape then break end
            end
        end
    end
end

if not nape then
    print("No titan found!")
    return
end

print("Nape found at:", nape.Position)

-- TP to nape
root.CFrame = CFrame.new(nape.Position + Vector3.new(0, 200, 30))
task.wait(0.3)

-- TRY METHOD 1: Slash + Register
print("\nMethod 1: Slash + Register")
for i = 1, 3 do
    pcall(function()
        postRemote:FireServer("Attacks", "Slash", true)
        postRemote:FireServer("Hitboxes", "Register", nape, 500)
    end)
    print("  Hit", i)
    task.wait(0.1)
end

task.wait(0.5)

-- TRY METHOD 2: Different arguments
print("\nMethod 2: Direct Register")
for i = 1, 3 do
    pcall(function()
        postRemote:FireServer("Hitboxes", "Register", nape)
    end)
    print("  Hit", i)
    task.wait(0.1)
end

task.wait(0.5)

-- TRY METHOD 3: Invoke GET
print("\nMethod 3: GET remote")
for i = 1, 3 do
    pcall(function()
        getRemote:InvokeServer("Attacks", "Slash")
    end)
    print("  Hit", i)
    task.wait(0.1)
end

task.wait(0.5)

-- TRY METHOD 4: Spear explode
print("\nMethod 4: Spear explode")
for i = 1, 3 do
    pcall(function()
        postRemote:FireServer("Spears", "S_Explode", nape.Position)
    end)
    print("  Hit", i)
    task.wait(0.1)
end

print("\n===== TEST DONE =====")
print("Check if titan took damage from any method!")
