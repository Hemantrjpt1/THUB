local titans = workspace:FindFirstChild("Titans")
print("Titans:", titans)
if titans then
    for _, v in ipairs(titans:GetChildren()) do
        print(" ->", v.Name, v.ClassName)
    end
end

local ws_obj = workspace:FindFirstChild("Unclimbable") and workspace.Unclimbable:FindFirstChild("Objective")
print("Objective folder:", ws_obj)
if ws_obj then
    for _, v in ipairs(ws_obj:GetChildren()) do
        print(" ->", v.Name, v.ClassName)
    end
end
