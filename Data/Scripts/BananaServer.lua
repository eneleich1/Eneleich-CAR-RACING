local TRIGGER = script.parent:FindDescendantByName("Trigger")

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
    script.parent:Destroy()
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)