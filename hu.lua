-- Poore workspace mein Colossal dhundho
local function findColossal(parent, depth)
    if depth > 5 then return end
    for _, v in ipairs(parent:GetChildren()) do
        if v.Name:lower():find("colossal") or v.Name:lower():find("bertholdt") then
            print("FOUND:", v:GetFullName(), v.ClassName)
        end
        findColossal(v, depth + 1)
    end
end
findColossal(workspace, 0)

-- Characters folder check
local chars = workspace:FindFirstChild("Characters")
if chars then
    for _, v in ipairs(chars:GetChildren()) do
        print("Character:", v.Name, v.ClassName)
    end
end
