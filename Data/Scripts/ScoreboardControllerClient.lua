--[[
Copyright 2019 Manticore Games, Inc. 

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
local PANEL = script:GetCustomProperty("Panel"):WaitForObject()
local LINE_TEMPLATE = script:GetCustomProperty("LineTemplate")

local RESOURCE_NAME = "Race_Rank"

-- User exposed properties
local BINDING = COMPONENT_ROOT:GetCustomProperty("Binding")

-- Constants
local LOCAL_PLAYER = Game.GetLocalPlayer()

-- Variables
local headerLine = nil
local playerLines = {}
local bindingDown = false

local hasFinishedRace = false

-- nil OnBindingPressed(Player, string)
-- Keep track of the binding state to show the scoreboard 
function OnBindingPressed(player, binding)
    if binding == BINDING then
        bindingDown = true
    end
end

-- nil OnBindingReleased(Player, string)
-- Keep track of the binding state to show the scoreboard 
function OnBindingReleased(player, binding)
    if binding == BINDING then
        bindingDown = false
    end
end

-- nil OnPlayerJoined(Player)
-- Add a line to the scoreboard when a player joins
function OnPlayerJoined(player)
    local newLine = World.SpawnAsset(LINE_TEMPLATE, {parent = PANEL})
    newLine.y = newLine.height * (#playerLines + 1)
    table.insert(playerLines, newLine)
end

-- nil OnPlayerLeft(Player)
-- Remove a line when a player leaves
function OnPlayerLeft(player)
    playerLines[#playerLines]:Destroy()
    playerLines[#playerLines] = nil
end

-- bool ComparePlayers(Player, Player)
-- Comparing function that sets the sorting order
function ComparePlayers(player1, player2)
    local rankPlayer1 = player1:GetResource(RESOURCE_NAME)
    local rankPlayer2 = player2:GetResource(RESOURCE_NAME)
  
    -- Third we use deaths
    if rankPlayer1 ~= rankPlayer2 then
        return rankPlayer1 < rankPlayer2
    end

    -- Use name to ensure consistent order for players that are tied
    return player1.name < player2.name
end

function FormatRankText(number)
    if number == 0 then
        return ""
    elseif number == 1 then
        return "1st"
    elseif number == 2 then
        return "2nd"
    elseif number == 3 then
        return "3rd"
    else
        return tostring(number) .. "th"
    end
end

function SecondsToCounterString(totalSeconds)
    local currentTime = totalSeconds

    currentTime = currentTime * 1000

    currentTime = math.floor(currentTime)

    local milliseconds = currentTime % 1000
    currentTime = currentTime-milliseconds
    currentTime = math.floor(currentTime / 1000)

    local seconds = currentTime % 60
    currentTime = currentTime - seconds
    currentTime = math.floor(currentTime/60)

    local minutes = math.min(currentTime, 99)

    return string.format("%02d.%02d.%03d", minutes, seconds, milliseconds)
end

-- nil Tick(float)
-- Update visibility and displayed information
function Tick(deltaTime)
    local passiveShowScoreboard = false
    
    if AAP.IsPlayerActive(LOCAL_PLAYER) and hasFinishedRace then
        passiveShowScoreboard = true
    end

    if not bindingDown and not passiveShowScoreboard then
        PANEL.visibility = Visibility.FORCE_OFF
        return
    end

    PANEL.visibility = Visibility.INHERIT

    local players = Game.GetPlayers()
    table.sort(players, ComparePlayers)

    for i, player in ipairs(players) do
        local line = playerLines[i]
        local vehicle = player.occupiedVehicle

        line:GetCustomProperty("Icon"):WaitForObject():SetPlayerProfile(player)
        line:GetCustomProperty("Name"):WaitForObject().text = player.name

        if AAP.IsPlayerActive(player) then
            line:GetCustomProperty("RankText"):WaitForObject().text = FormatRankText(i)
            line.opacity = 1
            
        else
            line:GetCustomProperty("RankText"):WaitForObject().text = ""
            line.opacity = 0.5
        end
        
        if vehicle then
            line:GetCustomProperty("CarText"):WaitForObject().text = vehicle.name
        else
            line:GetCustomProperty("CarText"):WaitForObject().text = "-"
        end

        local totalRaceTimeSeconds = API.GetPlayerTotalRaceTimeSeconds(player)

        local raceTimeText = "--:--:---"
        if totalRaceTimeSeconds > 0 then
            raceTimeText = SecondsToCounterString(totalRaceTimeSeconds)
        end

        line:GetCustomProperty("TimeText"):WaitForObject().text = raceTimeText
    end
end

function OnRaceFinalLapFinished()
    hasFinishedRace = true
end

function OnEndRace()
    hasFinishedRace = true
end

function OnResetRace()
    hasFinishedRace = false
end

-- Initialize
PANEL.visibility = Visibility.FORCE_OFF

headerLine = World.SpawnAsset(LINE_TEMPLATE, {parent = PANEL})
headerLine:GetCustomProperty("Icon"):WaitForObject().visibility = Visibility.FORCE_OFF
headerLine:GetCustomProperty("Name"):WaitForObject().text = "Players"
headerLine:GetCustomProperty("RankText"):WaitForObject().text = "Rank"
headerLine:GetCustomProperty("CarText"):WaitForObject().text = "Car"
headerLine:GetCustomProperty("TimeText"):WaitForObject().text = "Total Time"

Game.playerLeftEvent:Connect(OnPlayerLeft)
Game.playerJoinedEvent:Connect(OnPlayerJoined)
LOCAL_PLAYER.bindingPressedEvent:Connect(OnBindingPressed)
LOCAL_PLAYER.bindingReleasedEvent:Connect(OnBindingReleased)

Events.Connect("RaceFinalLapFinished", OnRaceFinalLapFinished)
Events.Connect("EndRace", OnEndRace)
Events.Connect("ResetRace", OnResetRace)
