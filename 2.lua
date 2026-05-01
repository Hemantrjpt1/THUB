-- Buttons folder scan
print("===== BUTTONS FOLDER =====")
local buttons = interface and interface:FindFirstChild("Buttons")
if buttons then
    print("Found! Children:")
    for _, child in ipairs(buttons:GetChildren()) do
        print("  " .. child.Name .. " [" .. child.ClassName .. "]")
        for _, btn in ipairs(child:GetDescendants()) do
            if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                print("    BTN: " .. btn.Name .. " | Text: " .. (btn.Text or "N/A") .. " | Visible: " .. tostring(btn.Visible))
            end
        end
    end
else
    print("Buttons folder NOT found in Interface")
end
