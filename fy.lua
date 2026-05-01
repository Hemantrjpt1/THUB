local vim = game:GetService("VirtualInputManager")

-- M1 click simulate karo (cannon fire)
vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)   -- left click down
task.wait(0.1)
vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)  -- left click up
print("M1 fired!")
