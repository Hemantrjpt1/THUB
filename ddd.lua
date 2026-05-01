local interact = workspace.Climbable.Walls.Wall.Cannons["1"].Interact
local hitbox = workspace.Climbable.Walls.Wall.Cannons["1"].Hitbox
local GuiService = game:GetService("GuiService")
local vim = game:GetService("VirtualInputManager")

-- Cannon ke paas jaao
local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
hrp.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 5, 0))
task.wait(0.5)

-- Frame 1 click karo
local frame = interact.Main["1"]
GuiService.SelectedObject = frame
task.wait(0.05)
vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
print("Fired!")
