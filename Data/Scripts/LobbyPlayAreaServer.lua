
local STARTING_POSITIONS = script:GetCustomProperty("StartingPositions"):WaitForObject()
local DEFAULT_VEHICLE = script:GetCustomProperty("Vehicle")


local playerVehicles = {}

local startingPlaceIndex = 1

local startingPositions = STARTING_POSITIONS:GetChildren()

function GetStartingPositionRotation()
    if startingPlaceIndex > #startingPositions then
        startingPlaceIndex = 1
    end

    local startPosition = startingPositions[startingPlaceIndex]:GetWorldPosition()
    local startRotation = startingPositions[startingPlaceIndex]:GetWorldRotation()

    startingPlaceIndex = startingPlaceIndex+1
    if startingPlaceIndex > #startingPositions then
        startingPlaceIndex = 1
    end

    return startPosition, startRotation
end

function GetPlayerVehicleTemplate(player)
    if player.serverUserData.selectedVehicleId == nil then
        player.serverUserData.selectedVehicleId = DEFAULT_VEHICLE
    end
    
    local template = player.serverUserData.selectedVehicleId

    assert(template)
    return template
end 

function OnEnterLobbyPlayArea(player)
    if not Object.IsValid(playerVehicles[player]) then
        local vehicleTemplate = GetPlayerVehicleTemplate(player)
        local startPosition, startRotation = GetStartingPositionRotation()
        local vehicle = World.SpawnAsset(vehicleTemplate, {position = startPosition, rotation = startRotation})
        playerVehicles[player] = vehicle
    end

    local vehicle = playerVehicles[player]

    Task.Wait()
    Task.Wait()

    vehicle:SetDriver(player)
end

function OnPlayerLeft(player)
    DestroyPlayerVehicle(player)
end

function OnEnterLobbyArea(player)
    DestroyPlayerVehicle(player)
end

function DestroyPlayerVehicle(player)
    local vehicle = playerVehicles[player]
    playerVehicles[player] = nil
    if Object.IsValid(vehicle) then
        vehicle:Destroy()
    end
end

function OnRaceStarted()
    for player, vehicle in pairs(playerVehicles) do
        DestroyPlayerVehicle(player)
        Task.Wait()
    end
end

Game.playerLeftEvent:Connect(OnPlayerLeft)

Events.Connect("EnterLobbyPlayArea", OnEnterLobbyPlayArea)
Events.Connect("EnterLobbyArea", OnEnterLobbyArea)
Events.Connect("StartRace", OnRaceStarted)