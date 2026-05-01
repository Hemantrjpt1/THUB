local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local buttons = PlayerGui.Interface.Buttons

-- Saare children
print("Buttons children:", #buttons:GetChildren())
for _, v in ipairs(buttons:GetDescendants()) do
    print(v.Name, v.ClassName, v.Visible)
end

-- Cannon frame
local cannon = PlayerGui.Interface.Cannon
print("Cannon visible:", cannon.Visible)
