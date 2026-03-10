local TARGET_SCENE_NAME = "Select Kart Scene"

local function OnGoToRaceScene(player)
    if not Object.IsValid(player) then
        return
    end

    player:TransferToScene(TARGET_SCENE_NAME)
end

Events.ConnectForPlayer("Select Kart Scene", OnGoToRaceScene)