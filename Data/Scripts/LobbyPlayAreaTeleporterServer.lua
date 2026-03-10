

local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()

function OnInteract(trigger, player)
    Events.Broadcast("EnterLobbyPlayArea", player)
end

TRIGGER.interactedEvent:Connect(OnInteract)