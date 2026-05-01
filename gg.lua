-- Find cannon interact button in Interface
print("===== INTERFACE BUTTONS DEBUG =====")

local interface = lp.PlayerGui:FindFirstChild("Interface")
if interface then
    print("Interface found!")
    
    -- Check for Buttons folder
    local buttons = interface:FindFirstChild("Buttons")
    if buttons then
        print("\nButtons folder found!")
        print("Visible:", buttons.Visible)
        print("Children count:", #buttons:GetChildren())
        
        for _, child in ipairs(buttons:GetDescendants()) do
            if child:IsA("TextButton") or child:IsA("ImageButton") or child:IsA("CanvasGroup") or child:IsA("Frame") then
                print("  [" .. child.ClassName .. "]", child.Name, "| Visible:", child.Visible)
            end
        end
    else
        print("Buttons folder NOT found!")
    end
    
    -- Search ALL buttons in Interface
    print("\n===== ALL VISIBLE BUTTONS IN INTERFACE =====")
    for _, child in ipairs(interface:GetDescendants()) do
        if (child:IsA("TextButton") or child:IsA("ImageButton")) and child.Visible then
            print("  Button:", child.Name, "| Text:", child.Text or "No Text", "| Parent:", child.Parent.Name)
        end
    end
    
    -- Check specific path: Interface > Buttons > any frame > button
    print("\n===== DEEP SEARCH BUTTONS =====")
    local buttonsFrame = interface:FindFirstChild("Buttons")
    if buttonsFrame then
        for _, frame in ipairs(buttonsFrame:GetChildren()) do
            print("Frame:", frame.Name, "| Class:", frame.ClassName, "| Visible:", frame.Visible)
            for _, btn in ipairs(frame:GetDescendants()) do
                if (btn:IsA("TextButton") or btn:IsA("ImageButton")) and btn.Visible then
                    print("  >>> BUTTON:", btn:GetFullName())
                    print("      Text:", btn.Text or "N/A")
                end
            end
        end
    end
end

print("===== DEBUG COMPLETE =====")
