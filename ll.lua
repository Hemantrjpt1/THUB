local cannon = workspace.Climbable.Walls.Wall.Cannons:GetChildren()[1]
local cannonModel = cannon -- ya Reference.Value

-- Hitbox dhundho
local hitbox = cannonModel:FindFirstChild("Hitbox", true)
print("Hitbox:", hitbox and hitbox:GetFullName())

-- Interact dhundho
local interact = cannonModel:FindFirstChild("Interact", true)
print("Interact:", interact and interact:GetFullName())

-- UseButton se fire karo
if interact then
    local GuiService = game:GetService("GuiService")
    local vim = game:GetService("VirtualInputManager")
    GuiService.SelectedObject = interact
    task.wait(0.05)
    vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    print("Fired!")
end
