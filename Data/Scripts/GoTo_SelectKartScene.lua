local BUTTON = script.parent

local function OnClicked()
    Events.BroadcastToServer("Select Kart Scene")
end

BUTTON.clickedEvent:Connect(OnClicked)