local get = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local mt = getrawmetatable(get)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    if self == get then
        local args = {...}
        local out = {}
        for i, v in ipairs(args) do
            out[i] = type(v) == "table" and game:GetService("HttpService"):JSONEncode(v) or tostring(v)
        end
        print("GET:", table.concat(out, " | "))
    end
    return old(self, ...)
end
setreadonly(mt, true)
print("Hooked! Fire cannon manually now")
