local BUTTON = script.parent
local TRACK_INDEX = script:GetCustomProperty("TrackIndex")

local function OnClicked()
    Events.BroadcastToServer("Select Kart Scene", TRACK_INDEX)
end

BUTTON.clickedEvent:Connect(OnClicked)