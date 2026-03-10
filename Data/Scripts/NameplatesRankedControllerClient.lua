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
local API_ACTIVE_PLAYERS = require(script:GetCustomProperty("APIActivePlayers"))
local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()
local NAMEPLATE_TEMPLATE = script:GetCustomProperty("NameplateTemplate")

-- User exposed properties
local SHOW_ON_SELF = COMPONENT_ROOT:GetCustomProperty("ShowOnSelf")

local RANK_COLOR = COMPONENT_ROOT:GetCustomProperty("RankColor")
local NAME_COLOR = COMPONENT_ROOT:GetCustomProperty("NameColor")

local MAX_DISTANCE_TO_SHOW_RANK = COMPONENT_ROOT:GetCustomProperty("MaxDistanceToShowRank")
local MAX_DISTANCE_TO_SHOW_NAME = COMPONENT_ROOT:GetCustomProperty("MaxDistanceToShowName")

local SCALE = COMPONENT_ROOT:GetCustomProperty("Scale")

-- Check user properties
if MAX_DISTANCE_TO_SHOW_RANK < 0.0 then
    warn("MaxDistanceToShowRank cannot be negative")
    MAX_DISTANCE_TO_SHOW_RANK = 0.0
end

if MAX_DISTANCE_TO_SHOW_NAME < 0.0 then
    warn("MaxDistanceToShowName cannot be negative")
    MAX_DISTANCE_TO_SHOW_NAME = 0.0
end

if SCALE <= 0.0 then
    warn("Scale must be positive")
    SCALE = 1.0
end

-- Constants
local LOCAL_PLAYER = Game.GetLocalPlayer()
local RESOURCE_NAME = "Race_Rank"

-- Variables
local nameplates = {}

function SetText(textObject, text)
	textObject.text = text
	for _, value in ipairs(textObject:GetChildren()) do
		value.text = text
	end
end

-- nil OnPlayerJoined(Player)
-- Creates a nameplate for the local player to see the target player's status
function OnPlayerJoined(player)
	local nameplateRoot = World.SpawnAsset(NAMEPLATE_TEMPLATE)

	nameplates[player] = {}
	nameplates[player].templateRoot = nameplateRoot
	nameplates[player].nameText = nameplateRoot:GetCustomProperty("NameText"):WaitForObject()
	nameplates[player].rankText = nameplateRoot:GetCustomProperty("RankText"):WaitForObject()

	-- Setup static properties
	nameplateRoot:AttachToPlayer(player, "nameplate")
	nameplateRoot:SetScale(Vector3.New(SCALE, SCALE, SCALE))

	-- Static properties on pieces
	SetText(nameplates[player].nameText, player.name)
	SetText(nameplates[player].rankText, "")

	nameplates[player].rankText:SetColor(RANK_COLOR)
	nameplates[player].nameText:SetColor(NAME_COLOR)
end

-- nil OnPlayerLeft(Player)
-- Destroy their nameplate
function OnPlayerLeft(player)
	nameplates[player].templateRoot:Destroy()
	nameplates[player] = nil
end

-- bool IsNameplateVisible(Player)
-- Can we see this player's nameplate given team and distance properties?
function IsNameplateVisible(player)
	if player.isDead then
		return false
	end

	if player == LOCAL_PLAYER then
		return SHOW_ON_SELF
	end

	local distance = (player:GetWorldPosition() - LOCAL_PLAYER:GetWorldPosition()).size

	if distance > MAX_DISTANCE_TO_SHOW_NAME and distance > MAX_DISTANCE_TO_SHOW_RANK then
		return false
	end

	return true
end

-- nil RotateNameplate(CoreObject)
-- Called every frame to make nameplates align with the local view
function RotateNameplate(nameplate)
	local quat = Quaternion.New(LOCAL_PLAYER:GetViewWorldRotation())
	quat = quat * Quaternion.New(Vector3.UP, 180.0)
	nameplate.templateRoot:SetWorldRotation(Rotation.New(quat))
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

-- nil Tick(float)
function Tick(deltaTime)
	for _, player in pairs(Game.GetPlayers()) do
		local nameplate = nameplates[player]

		if nameplate then
			local visible = IsNameplateVisible(player)

			if not visible then
				nameplate.templateRoot.visibility = Visibility.FORCE_OFF
			else
				nameplate.templateRoot.visibility = Visibility.INHERIT
				RotateNameplate(nameplate)

				-- Check player's rank
				if API_ACTIVE_PLAYERS.IsPlayerActive(player) then
					SetText(nameplate.rankText, FormatRankText(player:GetResource(RESOURCE_NAME)))
				else
					SetText(nameplate.rankText, "")
				end

				-- Check distances to show relevant information
				local distance = (player:GetWorldPosition() - LOCAL_PLAYER:GetWorldPosition()).size

				if distance <= MAX_DISTANCE_TO_SHOW_NAME then
					nameplate.nameText.visibility = Visibility.INHERIT
				else
					nameplate.nameText.visibility = Visibility.FORCE_OFF
				end

				if distance <= MAX_DISTANCE_TO_SHOW_RANK then
					nameplate.rankText.visibility = Visibility.INHERIT
				else
					nameplate.rankText.visibility = Visibility.FORCE_OFF
				end
			end
		end
	end
end

-- Initialize
Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)