--[[
    Server bridge for main menu multiplayer action.
    Reuses existing lobby play area flow.
--]]

local function OnPlayMultiplayer(player)
    if not Object.IsValid(player) or not player:IsA("Player") then
        return
    end

    Events.Broadcast("EnterLobbyPlayArea", player)
end

Events.ConnectForPlayer("MainMenu_PlayMultiplayer", OnPlayMultiplayer)
