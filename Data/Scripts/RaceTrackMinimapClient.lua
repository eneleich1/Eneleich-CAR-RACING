--[[
Copyright 2021 Manticore Games, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

-- Internal custom properties
local API = require(script:GetCustomProperty("APIRaceTrack"))
local AAP = require(script:GetCustomProperty("APIActivePlayers"))

local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()

local MAP_PANEL = script:GetCustomProperty("MapPanel"):WaitForObject()
local MAP_PIECE_TEMPLATE = script:GetCustomProperty("MapPieceTemplate")
local PLAYER_INDICATOR_TEMPLATE = script:GetCustomProperty("PlayerIndicatorTemplate")


local MAP_PIECES_GROUP = script:GetCustomProperty("MapPiecesGroup"):WaitForObject()
local PLAYERS_GROUP = script:GetCustomProperty("PlayersGroup"):WaitForObject()
local CIRCLE_IMAGE = script:GetCustomProperty("CircleImage")

local LINE_COLOR = COMPONENT_ROOT:GetCustomProperty("LineColor")
local LINE_THICKNESS = COMPONENT_ROOT:GetCustomProperty("LineThickness")
local ROTATE_MAP = COMPONENT_ROOT:GetCustomProperty("RotateMap")



-- Constants
local LOCAL_PLAYER = Game.GetLocalPlayer()
local MAP_PANEL_WIDTH = MAP_PANEL.width
local MAP_PANEL_HEIGHT = MAP_PANEL.width

-- Internal properties --
local mapPieces = {}

local boundsMin = Vector3.ZERO
local boundsMax = Vector3.ONE

local playerMarkers = {}

function InverseLerp(a, b, c)
    return (c-a) / (b-a)
end

function RemapVector3(v)
    local x = InverseLerp(boundsMin.x, boundsMax.x, v.x)
    local y = InverseLerp(boundsMin.y, boundsMax.y, v.y)

    return Vector2.New(x * MAP_PANEL_WIDTH, y * MAP_PANEL_WIDTH)
end

function DestroyMapPieces()
    for _, mapPiece in ipairs(mapPieces) do
        if Object.IsValid(mapPiece) then
            mapPiece:Destroy()
        end
    end
    mapPieces = {}
end


-- Register race track functions to internal variables
function OnRaceTrackChanged(raceTrackId)
    DestroyMapPieces()


    local raceTrackState = API.GetRaceTrackState(raceTrackId)
    local wayPoints = raceTrackState.wayPointPositions
    local isLoop = raceTrackState.loop

    local min = Vector3.New(wayPoints[1])
    local max = Vector3.New(wayPoints[1])

    -- Calculate bounds
    for i=1, #wayPoints do
        local p = wayPoints[i]
        min.x = math.min(min.x, p.x)
        min.y = math.min(min.y, p.y)
        min.z = math.min(min.z, p.z)
        max.x = math.max(max.x, p.x)
        max.y = math.max(max.y, p.y)
        max.z = math.max(max.z, p.z)
    end

    -- Add a little bit of padding
    min = min - Vector3.ONE * 50
    max = max + Vector3.ONE * 50

    -- Expand the bounds to make the x and y sizes equal
    local boundsSize = max-min
    if boundsSize.x > boundsSize.y then
        local expand = (boundsSize.x - boundsSize.y) / 2
        min.y = min.y - expand
        max.y = max.y + expand
    else
        local expand = (boundsSize.x - boundsSize.x) / 2
        min.x = min.x - expand
        max.x = max.x + expand
    end

    boundsMin = min
    boundsMax = max

    -- Loop all the waypoints and add lines
    for i=1, #wayPoints do
        local p1 = wayPoints[i]
        local p2 = wayPoints[i+1]
        if p2 == nil then
            p2 = wayPoints[1]
        end

        if p1 and p2 then
            p1 = RemapVector3(p1)
            p2 = RemapVector3(p2)

            local delta = p2-p1
            local center = (p1+p2)/2

            local mapPiece = World.SpawnAsset(MAP_PIECE_TEMPLATE, {parent=MAP_PIECES_GROUP})
            mapPiece.x = center.x
            mapPiece.y = center.y
            mapPiece.height = LINE_THICKNESS
            mapPiece.width = CoreMath.Round(delta.size)
            mapPiece.rotationAngle = math.deg(math.atan(delta.y, delta.x))
            mapPiece:SetColor(LINE_COLOR)

            table.insert(mapPieces, mapPiece)

            -- If the track isnt a loop, early exit out here so the corner isnt added
            if not isLoop and i == #wayPoints-1 then
                return
            end
            
            local cornerPiece = World.SpawnAsset(MAP_PIECE_TEMPLATE, {parent=MAP_PIECES_GROUP})
            cornerPiece:SetImage(CIRCLE_IMAGE)
            cornerPiece.x = p2.x
            cornerPiece.y = p2.y
            cornerPiece.height = LINE_THICKNESS
            cornerPiece.width = LINE_THICKNESS
            cornerPiece:SetColor(LINE_COLOR)

            table.insert(mapPieces, cornerPiece)
        end
    end
end

function RotateMap()
    local localPlayerMarker = playerMarkers[LOCAL_PLAYER]

    local rotation = -90 - LOCAL_PLAYER:GetWorldRotation().z
    MAP_PANEL.rotationAngle = rotation

    local playerMapPosition = Vector3.New(localPlayerMarker.x, localPlayerMarker.y, 0)
    playerMapPosition = Rotation.New(0,0, rotation) * playerMapPosition


    MAP_PANEL.x = -playerMapPosition.x
    MAP_PANEL.y = -playerMapPosition.y

    -- Counter rotate the player icons so they dont appear rotated
    for _, player in ipairs(AAP.GetActivePlayers()) do
        local playerMarker = playerMarkers[player]
        if Object.IsValid(playerMarker) then
            playerMarker.rotationAngle = -rotation
        end
    end

end

function Tick()
    for player, playerMarker in pairs(playerMarkers) do
        playerMarker.visibility = Visibility.FORCE_OFF
    end

    for _, player in ipairs(AAP.GetActivePlayers()) do
        local playerMarker = playerMarkers[player]
        if Object.IsValid(playerMarker) then
            playerMarker.visibility = Visibility.INHERIT
            local playerPosition = player:GetWorldPosition()
            local playerMapPosition = RemapVector3(playerPosition)
            playerMarker.x = playerMapPosition.x
            playerMarker.y = playerMapPosition.y
        end
    end

    if ROTATE_MAP then
        RotateMap()
    end
end

function OnPlayerJoined(player)
    if playerMarkers[player] == nil then
        local playerMarker = World.SpawnAsset(PLAYER_INDICATOR_TEMPLATE, {parent=PLAYERS_GROUP})
        playerMarkers[player] = playerMarker
        playerMarker:SetPlayerProfile(player)
        local shortName = string.sub(player.name,1, 8)

        -- Dont shorten the players name if its the local player
        if player == LOCAL_PLAYER then
            shortName = player.name
        end

        local label = playerMarker:GetCustomProperty("Label"):GetObject()
        if label then
            label.text = shortName
        end
    end
end

function OnPlayerLeft(player)
    local playerMarker = playerMarkers[player]
    if playerMarker then
        playerMarker:Destroy()
    end
    playerMarkers[player] = nil
end

-- on player joined/left functions need to be defined before calling event:Connect()
Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)




Events.Connect("RaceTrackChanged", OnRaceTrackChanged)