local readyPlayers = {}

function OnPlayerReady(player)

    readyPlayers[player] = true
    print(player.name .. " is READY")

    local totalPlayers = #Game.GetPlayers()
    local readyCount = 0

    for p,_ in pairs(readyPlayers) do
        if Object.IsValid(p) then
            readyCount = readyCount + 1
        end
    end

    print("Ready players: "..readyCount.."/"..totalPlayers)

    if readyCount == totalPlayers then
        print("All players ready -> start race")

        -- aquí después lanzaremos la carrera
    end

end

Events.ConnectForPlayer("PlayerReady", OnPlayerReady)