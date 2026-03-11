local STORAGE_KEY = "SelectedTrackIndex"

local function OnPlayerJoined(player)
    Task.Wait(1)

    local data = Storage.GetPlayerData(player)
    warn("DEBUG SelectedTrackIndex = " .. tostring(data[STORAGE_KEY]))
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)