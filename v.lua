-- Colossal Raid Full Scanner - Save to File
local HttpService = game:GetService("HttpService")
local seen = {}

local function dumpStructure(obj, depth, maxDepth)
    depth = depth or 0
    maxDepth = maxDepth or 3
    if depth > maxDepth then return "" end
    if seen[obj] then return "" end
    seen[obj] = true
    
    local result = ""
    local indent = string.rep("  ", depth)
    
    for _, child in ipairs(obj:GetChildren()) do
        if child.Name == "Trees" or child.Name == "Leaves" or child.Name == "Barriers" then
            result = result .. indent .. child.Name .. " [skipped]\n"
        else
            result = result .. indent .. child.Name .. " [" .. child.ClassName .. "]"
            pcall(function()
                local attrs = child:GetAttributes()
                if attrs and next(attrs) then
                    result = result .. " {"
                    for k, v in pairs(attrs) do
                        result = result .. k .. "=" .. tostring(v) .. ", "
                    end
                    result = result .. "}"
                end
            end)
            result = result .. "\n"
            if #child:GetChildren() > 0 and depth < maxDepth then
                result = result .. dumpStructure(child, depth + 1, maxDepth)
            end
        end
    end
    return result
end

local fullDump = "=== COLOSSAL RAID SCAN ===\n"
fullDump = fullDump .. "PlaceId: " .. game.PlaceId .. "\n"
fullDump = fullDump .. "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n"

-- Workspace
seen = {}
fullDump = fullDump .. "=== WORKSPACE ===\n"
for _, child in ipairs(workspace:GetChildren()) do
    local depth = (child.Name == "Unclimbable" or child.Name == "Titans") and 3 or 1
    seen = {}
    fullDump = fullDump .. dumpStructure(child, 0, depth)
    fullDump = fullDump .. "\n"
end

-- Find Eren
fullDump = fullDump .. "\n=== EREN NPC ==="
pcall(function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if string.find(v.Name:lower(), "eren") then
            fullDump = fullDump .. "\nFound: " .. v:GetFullName()
            if v:IsA("Model") then
                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hrp then fullDump = fullDump .. " | Pos: " .. tostring(hrp.Position) end
            end
        end
    end
end)

-- Find Cannons
fullDump = fullDump .. "\n\n=== CANNONS ==="
pcall(function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if string.find(v.Name:lower(), "cannon") or string.find(v.Name:lower(), "canon") then
            fullDump = fullDump .. "\nFound: " .. v:GetFullName() .. " [" .. v.ClassName .. "]"
            if v:IsA("BasePart") then fullDump = fullDump .. " | Pos: " .. tostring(v.Position) end
        end
    end
end)

-- Remotes
fullDump = fullDump .. "\n\n=== REMOTES ===\n"
local rs = game:GetService("ReplicatedStorage")
for _, v in ipairs(rs:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("UnreliableRemoteEvent") then
        fullDump = fullDump .. v:GetFullName() .. " [" .. v.ClassName .. "]\n"
    end
end

-- Interface buttons
fullDump = fullDump .. "\n=== INTERFACE BUTTONS ===\n"
pcall(function()
    local interface = lp.PlayerGui:FindFirstChild("Interface")
    if interface then
        for _, v in ipairs(interface:GetDescendants()) do
            if (v:IsA("TextButton") or v:IsA("ImageButton")) and v.Visible then
                fullDump = fullDump .. v:GetFullName() .. " | Text: " .. (v.Text or "N/A") .. "\n"
            end
        end
    end
end)

-- Objectives from RS
fullDump = fullDump .. "\n=== RS OBJECTIVES ===\n"
pcall(function()
    local rsObj = rs:FindFirstChild("Objectives")
    if rsObj then
        for _, child in ipairs(rsObj:GetChildren()) do
            fullDump = fullDump .. child.Name .. " = " .. tostring(child.Value) .. "\n"
        end
    end
end)

-- Save file
local fileName = "colossal_raid_scan_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
writefile(fileName, fullDump)
setclipboard(fullDump)

print("✅ Scan saved: " .. fileName)
print("📋 Also copied to clipboard!")
print("📏 Size: " .. #fullDump .. " chars")
