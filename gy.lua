local lp = game:GetService("Players").LocalPlayer
local getRemote = game:GetService("ReplicatedStorage").Assets.Remotes.GET

local mapData = getRemote:InvokeServer("Data", "Copy")
print("mapData:", mapData)

local slotIndex = lp:GetAttribute("Slot")
print("Slot:", slotIndex)

local slotData = slotIndex and mapData and mapData.Slots and mapData.Slots[slotIndex]
print("slotData:", slotData)

local ws_obj = workspace.Unclimbable:FindFirstChild("Objective")
print("ws_ObjectiveFolder:", ws_obj)
