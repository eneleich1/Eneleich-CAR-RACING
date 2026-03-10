local propUITextBox = script:GetCustomProperty("UITextBox"):WaitForObject()
local LOCAL_PLAYER = Game.GetLocalPlayer()

local RESOURCE_WAYPOINT_INDEX = "Race_WaypointIndex"
local RESOURCE_LAP = "Race_Lap"
local RESOURCE_RACE_STATE = "Race_State"
local RESOURCE_RANK = "Race_Rank"
local RESOURCE_TOTAL_RACE_TIME = "Race_TotalMilliseconds"




function Tick()
    local wayPointIndex = LOCAL_PLAYER:GetResource(RESOURCE_WAYPOINT_INDEX)
    local lap = LOCAL_PLAYER:GetResource(RESOURCE_LAP)
    local raceState = LOCAL_PLAYER:GetResource(RESOURCE_RACE_STATE)
    local rank = LOCAL_PLAYER:GetResource(RESOURCE_RANK)  
    local raceTime = LOCAL_PLAYER:GetResource(RESOURCE_TOTAL_RACE_TIME)

    local text = "waypoint index: " .. tostring(wayPointIndex) .. "\nlaps: " .. tostring(lap) .. "\nraceState: " ..tostring(raceState) .. "\nrank: " .. tostring(rank)
    propUITextBox.text = text

end