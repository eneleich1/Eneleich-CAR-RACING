local TARGET_SCENE_NAME = "Select Kart Scene"
local STORAGE_KEY = "SelectedTrackIndex"

local function OnGoToRaceScene(player, trackIndex)
    if not Object.IsValid(player) then
        return
    end

    local data = Storage.GetPlayerData(player)
    data[STORAGE_KEY] = trackIndex
    Storage.SetPlayerData(player, data)

    player:TransferToScene(TARGET_SCENE_NAME)
end

Events.ConnectForPlayer("Select Kart Scene", OnGoToRaceScene)