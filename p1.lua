local titans = workspace.Titans
local colossalTitan = titans and titans:FindFirstChild("Colossal_Titan")
print("colossalTitan:", colossalTitan)

local ws_obj = workspace.Unclimbable.Objective
local defendErenObj = ws_obj:FindFirstChild("Defend_Eren_2")
local colossalBossObj = ws_obj:FindFirstChild("Colossal_Boss")
print("defendErenObj:", defendErenObj)
print("colossalBossObj:", colossalBossObj)

-- Agar dono hain toh Phase 1 hona chahiye
if colossalTitan and defendErenObj then
    print("PHASE 1 DETECTED - should work!")
else
    print("NOT DETECTED - something missing")
end
