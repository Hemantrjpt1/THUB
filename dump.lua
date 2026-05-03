--[[
    COMPLETE GAME DUMPER v3.0
    Dumps: Workspace, Lighting, ReplicatedStorage, ServerStorage, Players, Chat, etc.
    Requires: Executor with writefile, saveinstance, or getlns capabilities
--]]

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- Configuration
local DUMP_EVERYTHING = true  -- Dump ALL services
local SAVE_TO_FILE = true      -- Save to .rbxmx or .lua file
local DECOMPILE_SCRIPTS = true -- Get actual script source code

-- All services to dump
local SERVICES_TO_DUMP = {
    "Workspace",
    "Lighting",
    "ReplicatedStorage", 
    "ServerStorage",
    "ServerScriptService",
    "StarterGui",
    "StarterPack",
    "StarterPlayer",
    "Players",
    "SoundService",
    "Chat",
    "Selection",
    "CoreGui"  -- May be restricted
}

-- Function to get ALL instances recursively with properties
local function deepDump(instance, depth, maxDepth)
    depth = depth or 0
    maxDepth = maxDepth or 100
    if depth > maxDepth then return nil end
    
    local data = {
        Name = instance.Name,
        ClassName = instance.ClassName,
        Properties = {},
        Children = {},
        Scripts = {}
    }
    
    -- Get ALL properties (including hidden ones if executor supports)
    local success, props = pcall(function()
        return instance:GetProperties()
    end)
    
    if success and props then
        for _, prop in ipairs(props) do
            local success2, value = pcall(function()
                local val = instance[prop]
                
                -- Convert complex types to strings
                if typeof(val) == "Instance" then
                    return "Instance:" .. val.ClassName
                elseif typeof(val) == "CFrame" then
                    local x, y, z = val:GetComponents()
                    return string.format("CFrame(%f, %f, %f)", x, y, z)
                elseif typeof(val) == "Vector3" then
                    return string.format("Vector3(%f, %f, %f)", val.X, val.Y, val.Z)
                elseif typeof(val) == "Color3" then
                    return string.format("Color3(%f, %f, %f)", val.R, val.G, val.B)
                elseif typeof(val) == "BrickColor" then
                    return val.Name
                elseif typeof(val) == "EnumItem" then
                    return tostring(val)
                elseif typeof(val) == "table" then
                    return HttpService:JSONEncode(val)
                else
                    return tostring(val)
                end
            end)
            
            if success2 then
                data.Properties[prop] = value
            end
        end
    end
    
    -- Get script source code if it's a script
    if DECOMPILE_SCRIPTS and (instance:IsA("Script") or instance:IsA("LocalScript") or instance:IsA("ModuleScript")) then
        local success, source = pcall(function()
            return instance.Source
        end)
        if success and source then
            data.Scripts.Source = source
            data.Scripts.Disabled = instance.Disabled or false
        end
    end
    
    -- Recursively dump children
    for _, child in ipairs(instance:GetChildren()) do
        local childData = deepDump(child, depth + 1, maxDepth)
        if childData then
            table.insert(data.Children, childData)
        end
    end
    
    return data
end

-- Convert dump data to readable format
local function dataToString(data, indent)
    indent = indent or 0
    local spaces = string.rep("  ", indent)
    local output = {}
    
    table.insert(output, string.format("%s[%s] %s", spaces, data.ClassName, data.Name))
    
    -- Add properties
    if next(data.Properties) then
        table.insert(output, spaces .. "  Properties:")
        for prop, value in pairs(data.Properties) do
            local valueStr = tostring(value)
            if #valueStr > 100 then valueStr = valueStr:sub(1, 97) .. "..." end
            table.insert(output, string.format("%s    %s = %s", spaces, prop, valueStr))
        end
    end
    
    -- Add script source preview
    if data.Scripts and data.Scripts.Source then
        local preview = data.Scripts.Source:sub(1, 200):gsub("\n", "\\n")
        if #data.Scripts.Source > 200 then preview = preview .. "..." end
        table.insert(output, spaces .. "  Script Source (preview):")
        table.insert(output, spaces .. "    " .. preview)
    end
    
    -- Add children
    for _, child in ipairs(data.Children) do
        table.insert(output, dataToString(child, indent + 1))
    end
    
    return table.concat(output, "\n")
end

-- SAVE USING EXECUTOR FUNCTIONS
local function saveDump(data, name)
    -- Try different executor methods
    local saved = false
    
    -- Method 1: writefile (Synapse, Krnl, ScriptWare)
    if writefile then
        local filename = name .. "_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".txt"
        writefile(filename, data)
        print("[+] Saved to: " .. filename)
        saved = true
    end
    
    -- Method 2: saveinstance (Synapse exclusive)
    if saveinstance then
        saveinstance()
        print("[+] Full game saved as .rbxmx file")
        saved = true
    end
    
    -- Method 3: Clipboard fallback
    if setclipboard and not saved then
        setclipboard(data)
        print("[+] Data copied to clipboard (use Notepad to save)")
        saved = true
    end
    
    if not saved then
        print("[!] No save method available - printing to console only")
    end
    
    return saved
end

-- MAIN DUMP EXECUTION
print("=" :rep(50))
print("STARTING COMPLETE GAME DUMP")
print("=" :rep(50))

local allGameData = {}
local totalInstances = 0

-- Dump each service
for _, serviceName in ipairs(SERVICES_TO_DUMP) do
    local service = game:FindFirstChild(serviceName)
    if service then
        print(string.format("\n[>] Dumping %s...", serviceName))
        local startTime = tick()
        
        local serviceData = deepDump(service)
        if serviceData then
            allGameData[serviceName] = serviceData
            -- Count instances (rough)
            local function countInstances(data)
                local count = 1
                for _, child in ipairs(data.Children or {}) do
                    count = count + countInstances(child)
                end
                return count
            end
            local instanceCount = countInstances(serviceData)
            totalInstances = totalInstances + instanceCount
            print(string.format("  [+] Dumped %d instances (%.2f seconds)", instanceCount, tick() - startTime))
        else
            print("  [!] Failed to dump " .. serviceName)
        end
    else
        print(string.format("  [-] Service %s not found", serviceName))
    end
end

-- Generate complete output
print("\n[>] Generating output...")
local finalOutput = {}
table.insert(finalOutput, "=" :rep(80))
table.insert(finalOutput, "COMPLETE GAME DUMP")
table.insert(finalOutput, "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
table.insert(finalOutput, "Place ID: " .. game.PlaceId)
table.insert(finalOutput, "Job ID: " .. game.JobId)
table.insert(finalOutput, "Dump Time: " .. os.date("%Y-%m-%d %H:%M:%S"))
table.insert(finalOutput, "Total Instances Dumped: " .. totalInstances)
table.insert(finalOutput, "=" :rep(80))
table.insert(finalOutput, "")

-- Add each service's dump
for serviceName, serviceData in pairs(allGameData) do
    table.insert(finalOutput, "")
    table.insert(finalOutput, "=" :rep(60))
    table.insert(finalOutput, "SERVICE: " .. serviceName)
    table.insert(finalOutput, "=" :rep(60))
    table.insert(finalOutput, dataToString(serviceData))
end

-- Add any instance executor can find
if DUMP_EVERYTHING then
    table.insert(finalOutput, "")
    table.insert(finalOutput, "=" :rep(60))
    table.insert(finalOutput, "ADDITIONAL INSTANCES")
    table.insert(finalOutput, "=" :rep(60))
    
    -- Try to dump coregui if accessible
    local coreGui = game:GetService("CoreGui")
    if coreGui then
        local coreData = deepDump(coreGui, 0, 3) -- Limit depth for coregui
        if coreData then
            table.insert(finalOutput, dataToString(coreData))
        end
    end
end

local fullDump = table.concat(finalOutput, "\n")

-- Save or display
local saved = saveDump(fullDump, "GameDump")

if not saved then
    print("\n" .. fullDump:sub(1, 10000)) -- Print first 10000 chars
    print("\n... (Output truncated, " .. #fullDump .. " total characters)")
end

print(string.format("\n[+] DUMP COMPLETE! Total: %d instances", totalInstances))
print("=" :rep(50))
