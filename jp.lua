--[[
    Bas isko copy karo aur execute karo.
    Auto Colossal Raid toggle UI mein dikhega.
]]

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local vim = game:GetService("VirtualInputManager")

local PlayerGui = lp:WaitForChild("PlayerGui")
local Interface = PlayerGui:WaitForChild("Interface")
local remotesFolder = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Remotes")
local getRemote = remotesFolder:WaitForChild("GET")

-- Configuration
getgenv().AutoColossalRaid = false
getgenv().ColossalRaidSettings = {
    Enabled = false,
    AutoMount = true,
    AutoFire = true,
    FireDelay = 1.5,
    MaxDistance = 300,
    OnlyWhenAlive = true,
    UnmountAfterDeath = true,
}

-- Detect Colossal Raid
local function isColossalRaid()
    if game.PlaceId ~= 13379349730 then return false end
    
    local objectiveFolder = workspace:FindFirstChild("Objective")
    if objectiveFolder and objectiveFolder:FindFirstChild("Colossal_Boss") then
        return true
    end
    
    local colossal = workspace:FindFirstChild("Colossal_Titan")
    if colossal and colossal:GetAttribute("Type") == "Colossal" then
        return true
    end
    
    return false
end

-- Get Nape position
local function getNapePosition()
    local colossal = workspace:FindFirstChild("Colossal_Titan")
    if not colossal then return nil end
    
    local hitboxes = colossal:FindFirstChild("Hitboxes")
    if hitboxes then
        local hit = hitboxes:FindFirstChild("Hit")
        if hit then
            local nape = hit:FindFirstChild("Nape")
            if nape and nape:IsA("BasePart") then
                return nape.Position
            end
        end
    end
    
    local hrp = colossal:FindFirstChild("HumanoidRootPart")
    if hrp then
        return hrp.Position + Vector3.new(0, 60, 0)
    end
    
    return nil
end

-- Find cannons
local function findCannons()
    local cannons = {}
    
    local climbable = workspace:FindFirstChild("Climbable")
    if climbable then
        local walls = climbable:FindFirstChild("Walls")
        if walls then
            local wall = walls:FindFirstChild("Wall")
            if wall then
                local cannonsFolder = wall:FindFirstChild("Cannons")
                if cannonsFolder then
                    for _, child in ipairs(cannonsFolder:GetChildren()) do
                        local hitbox = child:FindFirstChild("Hitbox")
                        if hitbox and hitbox:IsA("BasePart") then
                            table.insert(cannons, {
                                Model = child,
                                Hitbox = hitbox,
                                Position = hitbox.Position,
                                Name = child.Name
                            })
                        end
                    end
                end
            end
        end
    end
    
    return cannons
end

-- Mount cannon
local function mountCannon(cannonHitbox)
    if not cannonHitbox then return false end
    
    local char = lp.Character
    if not char then return false end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    hrp.CFrame = CFrame.new(cannonHitbox.Position + Vector3.new(0, 3, 0))
    task.wait(0.3)
    
    local interact1 = PlayerGui:FindFirstChild("Interact_1")
    if interact1 then
        local icon = interact1:FindFirstChild("Icon", true)
        if icon then
            GuiService.SelectedObject = icon
            task.wait(0.05)
            vim:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            vim:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            task.wait(0.5)
            return true
        end
    end
    
    return false
end

-- Check if mounted
local function isMountedOnCannon()
    local cannonFrame = Interface:FindFirstChild("Cannon")
    return cannonFrame and cannonFrame.Visible == true
end

-- Fire cannon
local function fireCannon()
    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait(0.05)
    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    return true
end

-- Main loop
local colossalRaidRunning = false
local lastFireTime = 0

local function startColossalRaid()
    if colossalRaidRunning then return end
    colossalRaidRunning = true
    
    task.spawn(function()
        print("[Colossal Raid] Started")
        
        while getgenv().AutoColossalRaid and colossalRaidRunning do
            if not isColossalRaid() then
                task.wait(3)
                continue
            end
            
            -- Mount if needed
            if getgenv().ColossalRaidSettings.AutoMount and not isMountedOnCannon() then
                local napePos = getNapePosition()
                if napePos then
                    local cannons = findCannons()
                    for _, cannon in ipairs(cannons) do
                        local dist = (cannon.Position - napePos).Magnitude
                        if dist <= getgenv().ColossalRaidSettings.MaxDistance then
                            mountCannon(cannon.Hitbox)
                            break
                        end
                    end
                end
                task.wait(1)
                continue
            end
            
            -- Auto fire
            if getgenv().ColossalRaidSettings.AutoFire and isMountedOnCannon() then
                local now = os.clock()
                if now - lastFireTime >= getgenv().ColossalRaidSettings.FireDelay then
                    fireCannon()
                    lastFireTime = now
                    print("[Colossal Raid] Fired!")
                    
                    -- Multi-hit: 3 shots rapid
                    task.wait(0.05)
                    fireCannon()
                    task.wait(0.05)
                    fireCannon()
                end
            end
            
            task.wait(0.5)
        end
        
        colossalRaidRunning = false
        print("[Colossal Raid] Stopped")
    end)
end

local function stopColossalRaid()
    colossalRaidRunning = false
    getgenv().AutoColossalRaid = false
end

-- Simple console commands
getgenv().StartColossal = startColossalRaid
getgenv().StopColossal = stopColossalRaid

print("=== AUTO COLOSSAL RAID LOADED ===")
print("Commands:")
print("  StartColossal() - Start auto raid")
print("  StopColossal()  - Stop auto raid")
print("  getgenv().AutoColossalRaid = true/false")
print("==================================")

-- Optional: Auto-start if toggled
if getgenv().AutoColossalRaid then
    startColossalRaid()
end

