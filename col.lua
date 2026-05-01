-- Colossal Raid Deep Scanner
print("===== COLOSSAL RAID DEEP SCAN =====")

-- Check for Eren NPC
print("\n=== Eren NPC ===")
for _, v in ipairs(workspace:GetDescendants()) do
    if v.Name:find("Eren") or v.Name:find("eren") then
        print("Found:", v:GetFullName())
        if v:IsA("Model") then
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hrp then print("  Position:", hrp.Position) end
        end
    end
end

-- Check for Cannons
print("\n=== Cannons ===")
for _, v in ipairs(workspace:GetDescendants()) do
    if v.Name:find("Cannon") or v.Name:find("cannon") or v.Name:find("Canon") then
        print("Found:", v:GetFullName(), "| Class:", v.ClassName)
        if v:IsA("BasePart") then print("  Position:", v.Position) end
    end
end

-- Check Unclimbable for special objects
print("\n=== Unclimbable Special ===")
local unclimbable = workspace:FindFirstChild("Unclimbable")
if unclimbable then
    for _, child in ipairs(unclimbable:GetChildren()) do
        print("Unclimbable:", child.Name)
        if child.Name ~= "Trees" and child.Name ~= "Barriers" and child.Name ~= "Background" then
            for _, sub in ipairs(child:GetChildren()) do
                print("  Sub:", sub.Name, "| Class:", sub.ClassName)
            end
        end
    end
end

-- Check ReplicatedStorage for cannon remotes
print("\n=== Cannon Related ===")
local rs = game:GetService("ReplicatedStorage")
local assets = rs:FindFirstChild("Assets")
if assets then
    for _, v in ipairs(assets:GetDescendants()) do
        if v.Name:find("Cannon") or v.Name:find("Canon") or v.Name:find("Fire") then
            print("Found:", v:GetFullName())
        end
    end
end

-- Check Interface for cannon buttons/UI
print("\n=== Interface Cannon UI ===")
local interface = lp.PlayerGui:FindFirstChild("Interface")
if interface then
    for _, v in ipairs(interface:GetDescendants()) do
        if v:IsA("TextButton") or v:IsA("ImageButton") then
            if v.Visible then
                print("Button:", v.Name, "| Text:", v.Text or "N/A")
            end
        end
    end
end

print("===== SCAN COMPLETE =====")
