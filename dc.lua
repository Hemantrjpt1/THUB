-- Cannon Button Debug
print("===== CANNON BUTTON DEBUG =====")

local function findNearestCannon()
    local cannons = {}
    local climbable = workspace:FindFirstChild("Climbable")
    if climbable then
        local walls = climbable:FindFirstChild("Walls")
        if walls then
            for _, wall in ipairs(walls:GetChildren()) do
                local cannonFolder = wall:FindFirstChild("Cannons")
                if cannonFolder then
                    local model1 = cannonFolder:FindFirstChild("1")
                    if model1 and model1:IsA("Model") then
                        table.insert(cannons, model1)
                    end
                end
            end
        end
    end
    return cannons[1]
end

local cannon = findNearestCannon()
if not cannon then
    print("Cannon not found!")
    return
end

print("Cannon found:", cannon:GetFullName())

-- Check BillboardGui
local interact = cannon:FindFirstChild("Interact")
if interact and interact:IsA("BillboardGui") then
    print("\nBillboardGui found!")
    print("Enabled:", interact.Enabled)
    print("Active:", interact.Active)
    print("AlwaysOnTop:", interact.AlwaysOnTop)
    
    local main = interact:FindFirstChild("Main")
    if main then
        print("\nMain CanvasGroup children:")
        for _, child in ipairs(main:GetDescendants()) do
            if child:IsA("TextButton") or child:IsA("ImageButton") then
                print("  >>> BUTTON:", child.Name, "[" .. child.ClassName .. "]")
                print("      Text:", child.Text or "N/A")
                print("      Visible:", child.Visible)
                print("      Active:", child.Active)
                print("      Position:", child.Position)
                print("      Size:", child.Size)
                print("      Parent:", child.Parent:GetFullName())
            elseif child:IsA("Frame") then
                print("  Frame:", child.Name, "| Visible:", child.Visible, "| Children:", #child:GetChildren())
            end
        end
    end
end

-- Try clicking all possible buttons manually
print("\n===== MANUAL CLICK TEST =====")
local interact = cannon:FindFirstChild("Interact")
if interact then
    for _, obj in ipairs(interact:GetDescendants()) do
        if obj:IsA("TextButton") or obj:IsA("ImageButton") then
            if obj.Visible and obj.Active then
                print("Clicking:", obj.Name, "at", obj.AbsolutePosition)
                
                -- Method 1: VirtualInputManager
                GuiService.SelectedObject = obj
                task.wait(0.05)
                vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                
                print("  Method 1 done")
                
                task.wait(0.3)
            end
        end
    end
end

-- Also check if Hitbox part needs to be touched
print("\n===== HITBOX TOUCH TEST =====")
local hitbox = cannon:FindFirstChild("Hitbox")
if hitbox then
    print("Hitbox found:", hitbox.Position)
    print("CanCollide:", hitbox.CanCollide)
    print("Transparency:", hitbox.Transparency)
    
    -- Try touching hitbox with character
    local char = lp.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(hitbox.Position)
            print("Moved to hitbox position")
        end
    end
end

print("===== DEBUG COMPLETE =====")
