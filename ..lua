local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local cannon = PlayerGui.Interface.Cannon
print("Cannon visible:", cannon.Visible)

-- Saare children aur unka visible status
for _, v in ipairs(cannon:GetDescendants()) do
    local ok, vis = pcall(function() return v.Visible end)
    print(v.Name, v.ClassName, ok and tostring(vis) or "N/A")
end
