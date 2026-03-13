local BUTTON = script.parent
local TARGET_SCENE_NAME = script:GetCustomProperty("TargetSceneName")

local function OnClicked()
    Events.BroadcastToServer(TARGET_SCENE_NAME, TRACK_INDEX)
end

BUTTON.clickedEvent:Connect(OnClicked)