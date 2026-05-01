-- COMPLETE WORKSPACE + GUI DUMP
local HttpService = game:GetService("HttpService")
local lp = game:GetService("Players").LocalPlayer
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
        -- Skip massive repetitive folders
        if child.Name == "Trees" or child.Name == "Leaves" or child.Name == "Barriers" or child.Name == "Buildings" or child.Name == "Walls" or child.Name == "Pine" or child.Name == "Oak" then
            result = result .. indent .. child.Name .. " [" .. child.ClassName .. "] (" .. #child:GetChildren() .. " children) [SKIPPED]\n"
        else
            result = result .. indent .. child.Name .. " [" .. child.ClassName .. "]"
            
            -- Show attributes
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
            
            -- Show position for BaseParts
            if child:IsA("BasePart") then
                result = result .. " Pos:" .. tostring(child.Position)
            end
            
            result = result .. "\n"
            
            -- Go deeper
            if #child:GetChildren() > 0 and depth < maxDepth then
                result = result .. dumpStructure(child, depth + 1, maxDepth)
            end
        end
    end
    return result
end

-- Special dump for GUI
local function dumpGUI(obj, depth)
    depth = depth or 0
    if depth > 8 then return "" end
    local result = ""
    local indent = string.rep("  ", depth)
    for _, child in ipairs(obj:GetChildren()) do
        result = result .. indent .. child.Name .. " [" .. child.ClassName .. "]"
        if child:IsA("TextButton") or child:IsA("ImageButton") then
            result = result .. " Text='" .. (child.Text or "NIL") .. "' Visible=" .. tostring(child.Visible) .. " Active=" .. tostring(child.Active)
        end
        if child:IsA("Frame") or child:IsA("CanvasGroup") or child:IsA("ScreenGui") then
            result = result .. " Visible=" .. tostring(child.Visible) .. " Enabled=" .. tostring(child.Enabled)
        end
        result = result .. "\n"
        if #child:GetChildren() > 0 then
            result = result .. dumpGUI(child, depth + 1)
        end
    end
    return result
end

local fullDump = "=== COMPLETE DUMP ===\n"
fullDump = fullDump .. "PlaceId: " .. game.PlaceId .. "\n"
fullDump = fullDump .. "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n"

-- Workspace
seen = {}
fullDump = fullDump .. "=== WORKSPACE ===\n"
for _, child in ipairs(workspace:GetChildren()) do
    if child.Name == "Unclimbable" or child.Name == "Titans" or child.Name == "Live" or child.Name == "Points" or child.Name == "Climbable" then
        fullDump = fullDump .. dumpStructure(child, 0, 4)
    else
        fullDump = fullDump .. child.Name .. " [" .. child.ClassName .. "]\n"
    end
end

-- PlayerGui
fullDump = fullDump .. "\n=== PLAYER GUI ===\n"
pcall(function()
    local pg = lp:FindFirstChild("PlayerGui")
    if pg then
        fullDump = fullDump .. dumpGUI(pg)
    end
end)

-- ReplicatedStorage
fullDump = fullDump .. "\n=== REPLICATED STORAGE (Remotes) ===\n"
local rs = game:GetService("ReplicatedStorage")
for _, v in ipairs(rs:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("UnreliableRemoteEvent") then
        fullDump = fullDump .. v:GetFullName() .. " [" .. v.ClassName .. "]\n"
    end
end

-- Save
local fileName = "colossal_complete_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
writefile(fileName, fullDump)
setclipboard(fullDump)

print("✅ Saved: " .. fileName)
print("📋 Copied to clipboard!")
print("📏 Size: " .. #fullDump .. " chars")
