local lp = game:GetService("Players").LocalPlayer
local PlayerGui = lp.PlayerGui
local vim = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")

-- Cannon ke paas jaao
local hitbox = workspace.Climbable.Walls.Wall.Cannons["1"].Hitbox
local hrp = lp.Character.HumanoidRootPart
hrp.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 3, 0))
task.wait(0.5)

-- Mount karo - Interact_1 ka Icon button
local interact1 = PlayerGui:FindFirstChild("Interact_1")
local icon = interact1 and interact1:FindFirstChild("Icon", true)
print("Icon:", icon)

if icon then
    GuiService.SelectedObject = icon
    task.wait(0.05)
    vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    print("Mount attempted!")
end

task.wait(1)

-- Cannon frame check
local cannonFrame = PlayerGui.Interface:FindFirstChild("Cannon")
print("Cannon visible:", cannonFrame and cannonFrame.Visible)

-- M1 fire - Buttons frame mein dhundho
local buttons = PlayerGui.Interface:FindFirstChild("Buttons")
print("Buttons:", buttons)
if buttons then
    for _, v in ipairs(buttons:GetDescendants()) do
        print(" ", v.Name, v.ClassName)
    end
end
