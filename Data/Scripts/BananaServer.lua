local TRIGGER = script.parent:FindDescendantByName("Trigger")
local VELOCITY_MULTIPLIER_ON_HIT = script:GetCustomProperty("VelocityMultiplierOnHit")

local hasBeenTriggered = false

local function OnBeginOverlap(trigger, other)
    if hasBeenTriggered then
        return
    end

    if not Object.IsValid(other) then
        return
    end

    if other.name ~= "Go Kart" then
        return
    end

    hasBeenTriggered = true

    local currentVelocity = other:GetVelocity()
    other:SetVelocity(currentVelocity * VELOCITY_MULTIPLIER_ON_HIT)

    script.parent:Destroy()
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)