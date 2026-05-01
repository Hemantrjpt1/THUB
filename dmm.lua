local HttpService = game:GetService("HttpService")
local output = {}
local MAX_DEPTH = 6
local SKIP_LARGE = 50

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
    return ok and pos and (" Pos:" .. tostring(pos.X) .. ", " .. tostring(pos.Y) .. ", " .. tostring(pos.Z)) or ""
end

local function dump(obj, depth, indent)
    if depth > MAX_DEPTH then return end
    local children = obj:GetChildren()
    local count = #children
    local skip = count > SKIP_LARGE
    
    local line = indent .. obj.Name .. " [" .. obj.ClassName .. "]"
        .. getAttrs(obj)
        .. getValue(obj)
        .. getPos(obj)
    
    if skip then
        line = line .. " (" .. count .. " children) [SKIPPED]"
        table.insert(output, line)
        return
    end
    
    table.insert(output, line)
    for _, child in ipairs(children) do
        dump(child, depth + 1, indent .. "  ")
    end
end

-- Workspace
table.insert(output, "\n=== WORKSPACE ===")
for _, obj in ipairs(workspace:GetChildren()) do
    dump(obj, 1, "")
end

-- PlayerGui
table.insert(output, "\n=== PLAYER GUI ===")
local pg = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
for _, obj in ipairs(pg:GetChildren()) do
    dump(obj, 1, "")
end

-- ReplicatedStorage remotes only
table.insert(output, "\n=== REPLICATED STORAGE (Remotes) ===")
local rs = game:GetService("ReplicatedStorage")
local remotes = rs:FindFirstChild("Assets") and rs.Assets:FindFirstChild("Remotes")
if remotes then
    for _, v in ipairs(remotes:GetDescendants()) do
        table.insert(output, "ReplicatedStorage.Assets.Remotes." .. v.Name .. " [" .. v.ClassName .. "]")
    end
end

local finalText = "=== COMPLETE DUMP ===\nPlaceId: " .. game.PlaceId .. "\nTime: " .. os.date() .. "\n" .. table.concat(output, "\n")

writefile("complete_dump.txt", finalText)
print("DONE! File saved: complete_dump.txt")
print("Total lines:", #output)
