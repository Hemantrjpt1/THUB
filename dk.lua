local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local vim = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")

-- Mount karo
local hitbox = workspace.Climbable.Walls.Wall.Cannons["1"].Hitbox
local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
hrp.CFrame = CFrame.new(hitbox.Position + Vector3.new(0, 3, 0))
task.wait(0.5)

local icon = PlayerGui:FindFirstChild("Interact_1", true) and PlayerGui:FindFirstChild("Icon", true)
GuiService.SelectedObject = icon
task.wait(0.05)
vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
task.wait(0.5)

-- Ab saare visible UI elements print karo
for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") then
        if gui.Enabled then
            print("GUI:", gui.Name)
            for _, v in ipairs(gui:GetDescendants()) do
                if v:IsA("TextButton") or v:IsA("ImageButton") then
                    if v.Visible then
                        print("  VISIBLE BUTTON:", v:GetFullName(), v.Text or "")
                    end
                end
            end
        end
    end
end
