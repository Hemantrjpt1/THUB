local post = game:GetService("ReplicatedStorage").Assets.Remotes.POST
local HttpService = game:GetService("HttpService")

local mt = getrawmetatable(post)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    if self == post then
        local args = {...}
        local out = {}
        for i, v in ipairs(args) do
            if type(v) == "table" then
                local ok, j = pcall(HttpService.JSONEncode, HttpService, v)
                out[i] = ok and j or tostring(v)
            elseif typeof(v) == "Vector3" or typeof(v) == "CFrame" then
                out[i] = tostring(v)
            else
                out[i] = tostring(v)
            end
        end
        print("POST:", table.concat(out, " | "))
    end
    return old(self, ...)
end
setreadonly(mt, true)
print("POST Hooked! Fire cannon manually now")
