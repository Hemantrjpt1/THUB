-- Cannon fire karo manually UI se, phir ye run karo
task.wait(0.5) -- fire karne ke baad
for _, v in ipairs(workspace:GetChildren()) do
    if v.Name:lower():find("cannon") or v.Name:lower():find("ball") or v.Name:lower():find("bullet") or v.Name:lower():find("projectile") then
        print("FOUND:", v.Name, v.ClassName, v:GetFullName())
    end
end
