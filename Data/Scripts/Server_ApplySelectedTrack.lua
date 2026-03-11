local API = require(script:GetCustomProperty("APIRaceTrack"))
local STORAGE_KEY = "SelectedTrackIndex"

function OnPlayerJoined(player)

    Task.Wait(1)

    local data = Storage.GetPlayerData(player)
    local selectedIndex = data[STORAGE_KEY]

    if not selectedIndex then
        return
    end

    local raceTracksIds = API.GetRaceTracks()

    if selectedIndex > #raceTracksIds then
        warn("Selected track index is invalid")
        return
    end

    local selectedRaceTrackId = raceTracksIds[selectedIndex]

    API.SetCurrentRaceTrackId(selectedRaceTrackId)

end

Game.playerJoinedEvent:Connect(OnPlayerJoined)