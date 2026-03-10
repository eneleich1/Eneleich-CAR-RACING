local playVFX = script.parent
local Reflection4 = script:GetCustomProperty("NatureThunderClapBoomSet01SFX"):WaitForObject()
local Reflection3 = script:GetCustomProperty("NatureThunderClapBoomSet01SFX_1"):WaitForObject()
local Reflection2 = script:GetCustomProperty("NatureThunderClapBoomSet01SFX_2"):WaitForObject()
local Reflection1 = script:GetCustomProperty("NatureThunderClapBoomSet01SFX_3"):WaitForObject()
local ThunderClose = script:GetCustomProperty("ThunderClose"):WaitForObject()

while true do
    Task.Wait(10)
    print("started thinking")
    local pickNumber = math.random(1,15)
    
    Task.Wait(pickNumber)
    
    if pickNumber <= 10 then
    print(pickNumber) 
    playVFX:Play()
    ThunderClose:Play()
    Reflection1:Play()
    Reflection2:Play()
    Reflection3:Play()
    Reflection4:Play()
    
   end
end
