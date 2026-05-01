local cannon1 = workspace.Climbable.Walls.Wall.Cannons["1"]
local interact = cannon1:FindFirstChild("Interact")
local hitbox = cannon1:FindFirstChild("Hitbox")
print("Interact:", interact)
print("Hitbox:", hitbox)
print("Hitbox position:", hitbox and hitbox.Position)

-- UseButton se fire karo
local GuiService = game:GetService("GuiService")
local vim = game:GetService("VirtualInputManager")

-- Pehle cannon ke paas teleport karo
local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
hrp.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 5, 0))
task.wait(0.5)

GuiService.SelectedObject = interact
task.wait(0.05)
vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
print("Fired!")
