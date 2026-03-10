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

local APIRT = require(script:GetCustomProperty("RaceTrackAPI"))

local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()

local WAYPOINT_ROOT = COMPONENT_ROOT:GetCustomProperty("Waypoints"):WaitForObject()
local VEHICLES_ROOT = COMPONENT_ROOT:GetCustomProperty("Vehicles"):WaitForObject()
local DEFAULT_VEHICLE = COMPONENT_ROOT:GetCustomProperty("DefaultVehicle")

local LAPS = COMPONENT_ROOT:GetCustomProperty("Laps")
local NAME = COMPONENT_ROOT:GetCustomProperty("Name")
local ROUND_TIME = COMPONENT_ROOT:GetCustomProperty("RoundTime")
local RANDOM_VEHICLES = COMPONENT_ROOT:GetCustomProperty("AssignRandomVehicles")
local LOOP = COMPONENT_ROOT:GetCustomProperty("Loop")

local WAYPOINTS = WAYPOINT_ROOT:GetChildren()
local WAYPOINT_POSITIONS = {}
local WAYPOINT_TO_INDEX = {}

local VEHICLES = {}
local VEHICLES_REFERENCES = {}

local STARTING_PLACES = COMPONENT_ROOT:GetCustomProperty("StartingPositions"):WaitForObject():GetChildren()

-- Store the world position of each waypoint
for index, waypoint in ipairs(WAYPOINTS) do
    WAYPOINT_POSITIONS[index] = waypoint:GetWorldPosition()
    WAYPOINT_TO_INDEX[waypoint] = index
end

-- Store vehicle asset references
for index, reference in ipairs(VEHICLES_ROOT:GetChildren()) do
    local asset = reference:GetCustomProperty("Vehicle")
    asset = CoreString.Split(asset, ":")
    table.insert(VEHICLES, asset)
    VEHICLES_REFERENCES[asset] = index
end

function GetWayPoints()
    return WAYPOINTS
end

function GetTrackVehicles()
    return VEHICLES
end

function GetVehiclesReferences()
    return VEHICLES_REFERENCES
end

function GetWayPointPosition(index)
    return WAYPOINT_POSITIONS[index]
end

function GetWayPointIndex(wayPoint)
    return WAYPOINT_TO_INDEX[wayPoint]
end

function GetStartingPositions()
    return STARTING_PLACES
end

function GetState()
    local result = {}

    result.id = COMPONENT_ROOT.id
    result.name = NAME
    result.laps = LAPS
    result.roundTime = ROUND_TIME
    result.defaultVehicle = DEFAULT_VEHICLE
    result.vehicles = VEHICLES
    result.vehiclesReferences = VEHICLES_REFERENCES
    result.isRandomVehicles = RANDOM_VEHICLES
    result.loop = LOOP
    result.wayPoints = WAYPOINTS
    result.wayPointPositions = WAYPOINT_POSITIONS

    return result
end

local functionTable = {
    GetWayPoints = GetWayPoints,
    GetTrackVehicles = GetTrackVehicles,
    GetWayPointPosition = GetWayPointPosition,
    GetWayPointIndex = GetWayPointIndex,
    GetStartingPositions = GetStartingPositions,
    GetState = GetState
}

APIRT.RegisterRaceTrack(COMPONENT_ROOT.id, functionTable)