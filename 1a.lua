local colossal = workspace:FindFirstChild("Colossal_Titan")
if colossal then
    local fake = colossal:FindFirstChild("Fake")
    print("Fake:", fake)
    if fake then
        local head = fake:FindFirstChild("Head")
        print("Head:", head)
        if head then
            print("Header:", head:FindFirstChild("Header"))
        end
    end
end
