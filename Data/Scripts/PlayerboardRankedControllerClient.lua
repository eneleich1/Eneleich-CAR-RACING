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
local AAP = require(script:GetCustomProperty("APIActivePlayers"))
local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()
local PANEL = script:GetCustomProperty("Panel"):WaitForObject()
local LINE_TEMPLATE = script:GetCustomProperty("LineTemplate")

local RESOURCE_NAME = "Race_Rank"

-- Constants
local LOCAL_PLAYER = Game.GetLocalPlayer()

-- Variables
local playerLines = {}

-- nil OnPlayerJoined(Player)
-- Add a line to the scoreboard when a player joins
function OnPlayerJoined(player)
    local newLine = World.SpawnAsset(LINE_TEMPLATE, {parent = PANEL})
    newLine.y = newLine.height * #playerLines
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

    -- If a player doesnt have a rank (ie. its 0) we want them to be below
    -- players who have a rank so set the variables to a big number
    if rankPlayer1 == 0 then
        rankPlayer1 = 99999
    end
    if rankPlayer2 == 0 then
        rankPlayer2 = 99999
    end
  
    -- Sort first by rank
    if rankPlayer1 ~= rankPlayer2 then
        return rankPlayer1 < rankPlayer2
    end

    -- Use name to ensure consistent order for players that are tied (or have a rank of 0)
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

-- nil Tick(float)
-- Update visibility and displayed information
function Tick(deltaTime)
    local players = Game.GetPlayers()
    table.sort(players, ComparePlayers)

    for i, player in ipairs(players) do
        local line = playerLines[i]
        line:GetCustomProperty("Icon"):WaitForObject():SetPlayerProfile(player)
        line:GetCustomProperty("Name"):WaitForObject().text = player.name

        if AAP.IsPlayerActive(player) then
            line:GetCustomProperty("RankText"):WaitForObject().text = FormatRankText(i)
            line.opacity = 1
        else
            line:GetCustomProperty("RankText"):WaitForObject().text = ""
            line.opacity = 0.5
        end
    end
end

Game.playerLeftEvent:Connect(OnPlayerLeft)
Game.playerJoinedEvent:Connect(OnPlayerJoined)