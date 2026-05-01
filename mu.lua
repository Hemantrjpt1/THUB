local get = game:GetService("ReplicatedStorage").Assets.Remotes.GET
local HttpService = game:GetService("HttpService")
local mt = getrawmetatable(get)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    if self == get then
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
        print("GET:", table.concat(out, " | "))
    end
    return old(self, ...)
end
setreadonly(mt, true)

-- POST bhi hook karo
local post = game:GetService("ReplicatedStorage").Assets.Remotes.POST
local mt2 = getrawmetatable(post)
local old2 = mt2.__namecall
setreadonly(mt2, false)
mt2.__namecall = function(self, ...)
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
    return old2(self, ...)
end
setreadonly(mt2, true)

print("Both hooked! Mount cannon and fire M1 now")
