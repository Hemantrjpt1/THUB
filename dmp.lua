local HttpService = game:GetService("HttpService")
local output = {}
local MAX_DEPTH = 8

local function getAttrs(obj)
    local attrs = obj:GetAttributes()
    local out = {}
    for k, v in pairs(attrs) do
        table.insert(out, k .. "=" .. tostring(v))
    end
    return #out > 0 and (" {" .. table.concat(out, ", ") .. "}") or ""
end

local function getValue(obj)
    local ok, val = pcall(function()
        if obj:IsA("ValueBase") then return obj.Value end
    end)
    return ok and val ~= nil and (" = " .. tostring(val)) or ""
end

local function getPos(obj)
    local ok, pos = pcall(function()
        if obj:IsA("BasePart") then return obj.Position end
    end)
    return ok and pos and string.format(" Pos:%.2f,%.2f,%.2f", pos.X, pos.Y, pos.Z) or ""
end

local function dump(obj, depth, indent)
    if depth > MAX_DEPTH then return end
    local children = obj:GetChildren()
    local line = indent .. obj.Name .. " [" .. obj.ClassName .. "]"
        .. getAttrs(obj) .. getValue(obj) .. getPos(obj)
    table.insert(output, line)
    for _, child in ipairs(children) do
        dump(child, depth + 1, indent .. "  ")
    end
end

table.insert(output, "=== COLOSSAL_TITAN ===")
local titans = workspace:FindFirstChild("Titans")
local colossal = titans and titans:FindFirstChild("Colossal_Titan")
if colossal then
    dump(colossal, 1, "")
else
    table.insert(output, "NOT FOUND in Titans folder")
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name:lower():find("colossal") then
            table.insert(output, "FOUND: " .. v:GetFullName() .. " [" .. v.ClassName .. "]")
        end
    end
end

table.insert(output, "\n=== OBJECTIVE FOLDER ===")
local obj = workspace:FindFirstChild("Unclimbable") and workspace.Unclimbable:FindFirstChild("Objective")
if obj then dump(obj, 1, "") end

table.insert(output, "\n=== CANNONS ===")
local walls = workspace:FindFirstChild("Climbable") and workspace.Climbable:FindFirstChild("Walls")
if walls then
    for _, wall in ipairs(walls:GetChildren()) do
        local cannons = wall:FindFirstChild("Cannons")
        if cannons then
            table.insert(output, "Wall: " .. wall:GetFullName())
            dump(cannons, 1, "  ")
        end
    end
end

table.insert(output, "\n=== TITANS FOLDER ===")
if titans then
    for _, v in ipairs(titans:GetChildren()) do
        table.insert(output, v.Name .. " [" .. v.ClassName .. "]" .. getAttrs(v))
        if v.Name:lower():find("colossal") or v.Name:lower():find("boss") then
            dump(v, 1, "  ")
        end
    end
end

table.insert(output, "\n=== RS OBJECTIVES ===")
local rsObj = game:GetService("ReplicatedStorage"):FindFirstChild("Objectives")
if rsObj then dump(rsObj, 1, "") end

local final = table.concat(output, "\n")
writefile("colossal_dump.txt", final)
print("DONE! Lines:", #output)
print("File: colossal_dump.txt")
