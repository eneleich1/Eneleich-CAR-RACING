local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()

function OnBeginOverlap(trigger, other)
    if other:IsA("Vehicle") then
        other = other.driver
        if not Object.IsValid(other) then
            return
        end
    end

    if other:IsA("Player") then
        Events.Broadcast("RestorePlayerOnTrack", other)
    end
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)