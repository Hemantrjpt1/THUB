-- Cannon dhundho
local function findCannons()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name:lower():find("cannon") then
            print(v:GetFullName(), v.ClassName)
        end
    end
end
findCannons()
