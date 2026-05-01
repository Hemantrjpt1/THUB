-- Sirf Interface Buttons scan
print("===== ALL VISIBLE BUTTONS =====")
local interface = lp.PlayerGui:FindFirstChild("Interface")
if interface then
    for _, child in ipairs(interface:GetDescendants()) do
        if (child:IsA("TextButton") or child:IsA("ImageButton")) and child.Visible then
            print(child:GetFullName())
            print("  Text:", child.Text or "N/A")
            print("  Size:", child.AbsoluteSize)
            print("  Position:", child.AbsolutePosition)
            print("---")
        end
    end
end
