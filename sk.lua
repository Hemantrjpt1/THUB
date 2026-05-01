local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local buttons = PlayerGui.Interface:FindFirstChild("Buttons")
for _, v in ipairs(buttons:GetDescendants()) do
    print(v.Name, v.ClassName)
end
