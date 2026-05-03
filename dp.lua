-- ULTIMATE DEEP DUMP - No Skipping Anything
-- Warning: Large file! May take time!

local HttpService = game:GetService("HttpService")

local function dumpDeep(obj, depth, path)
    depth = depth or 0
    path = path or obj.Name
    
    if depth > 15 then return "" end  -- Safety limit
    
    local result = ""
    local indent = string.rep("  ", depth)
    local children = obj:GetChildren()
    
    for _, child in ipairs(children) do
        local childPath = path .. "." .. child.Name
        
        result = result .. indent .. "[" .. child.ClassName .. "] " .. child.Name
        
        -- Attributes
        pcall(function()
            local attrs = child:GetAttributes()
            if attrs and next(attrs) then
                result = result .. " {"
                local first = true
                for k, v in pairs(attrs) do
                    if not first then result = result .. ", " end
                    result = result .. k .. "=" .. tostring(v)
                    first = false
                end
                result = result .. "}"
            end
        end)
        
        -- Properties
        if child:IsA("BasePart") then
            result = result .. " | Pos:" .. tostring(child.Position) .. " | Size:" .. tostring(child.Size)
        end
        if child:IsA("ValueBase") then
            result = result .. " | Value=" .. tostring(child.Value)
        end
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") or child:IsA("UnreliableRemoteEvent") then
            result = result .. " | REMOTE"
        end
        if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") then
            result = result .. " | SCRIPT"
        end
        
        result = result .. "\n"
        
        -- Recurse ALL children, no skip
        if #child:GetChildren() > 0 then
            result = result .. dumpDeep(child, depth + 1, childPath)
        end
    end
    return result
end

local services = {
    "Workspace", "Lighting", "ReplicatedStorage", "ServerStorage",
    "ServerScriptService", "StarterGui", "StarterPack", "StarterPlayer",
    "Players", "SoundService", "Chat", "Selection"
}

local fullDump = "=== ULTIMATE DEEP DUMP ===\n"
fullDump = fullDump .. "PlaceId: " .. game.PlaceId .. "\n"
fullDump = fullDump .. "Time: " .. os.date() .. "\n\n"

for _, svcName in ipairs(services) do
    fullDump = fullDump .. "\n" .. string.rep("=", 60) .. "\n"
    fullDump = fullDump .. "=== " .. svcName .. " ===\n"
    fullDump = fullDump .. string.rep("=", 60) .. "\n"
    
    pcall(function()
        local svc = game:GetService(svcName)
        fullDump = fullDump .. dumpDeep(svc, 0, svcName)
    end)
end

-- CoreGui
fullDump = fullDump .. "\n" .. string.rep("=", 60) .. "\n"
fullDump = fullDump .. "=== CoreGui ===\n"
fullDump = fullDump .. string.rep("=", 60) .. "\n"
pcall(function()
    fullDump = fullDump .. dumpDeep(game:GetService("CoreGui"), 0, "CoreGui")
end)

-- LocalPlayer Extra
fullDump = fullDump .. "\n" .. string.rep("=", 60) .. "\n"
fullDump = fullDump .. "=== LocalPlayer ===\n"
fullDump = fullDump .. string.rep("=", 60) .. "\n"
pcall(function()
    local lp = game:GetService("Players").LocalPlayer
    fullDump = fullDump .. dumpDeep(lp, 0, "LocalPlayer")
end)

-- Save
local fileName = "ultimate_dump_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
writefile(fileName, fullDump)
setclipboard(fullDump)

print("✅ Done! Size: " .. #fullDump .. " chars")
print("📁 File: " .. fileName)
