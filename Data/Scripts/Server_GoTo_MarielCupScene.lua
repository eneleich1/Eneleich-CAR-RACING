local TARGET_SCENE_NAME = "Mariel Cup Scene"

local function OnGoToRaceScene(player, trackIndex)
    if not Object.IsValid(player) then
        return
    end

    local data = Storage.GetPlayerData(player)
    Storage.SetPlayerData(player, data)

    player:TransferToScene(TARGET_SCENE_NAME)
end

Events.ConnectForPlayer("Mariel Cup Scene", OnGoToRaceScene)