local INTERFACE = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Interface")
local cannon = INTERFACE:FindFirstChild("Cannon")
print("Cannon frame:", cannon)
if cannon then
    for _, v in ipairs(cannon:GetDescendants()) do
        print(" ", v.Name, v.ClassName)
    end
end

-- Interact_1 button
local interact1 = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Interact_1")
print("\nInteract_1:", interact1)
if interact1 then
    local icon = interact1:FindFirstChild("Icon", true)
    print("Icon:", icon)
end

-- Buttons frame
local buttons = INTERFACE:FindFirstChild("Buttons")
print("\nButtons:", buttons)
if buttons then
    for _, v in ipairs(buttons:GetDescendants()) do
        print(" ", v.Name, v.ClassName)
    end
end
