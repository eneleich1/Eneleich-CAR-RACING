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
local API_RACE_TRACK = require(script:GetCustomProperty("APIRaceTrack"))
local VEHICLE_DISPLAYS = script:GetCustomProperty("VehicleDisplays"):WaitForObject():GetChildren()

-- Similar to a % operation, but base1
function RepeatIndex(index, count)
    return ((index-1)%count) + 1
end

-- Updates all the pads with the vehicle set, repeating the same vehicles when theres more pads than vehicles
function OnRaceTrackChanged(raceTrackId)
    local trackState = API_RACE_TRACK.GetRaceTrackState(raceTrackId)
    local vehicles = trackState.vehicles

    -- Loop over all the pads and put a vehicle from the vehicle set into the pad
    for index, pad in ipairs(VEHICLE_DISPLAYS) do
        local vehicleIndex = RepeatIndex(index, #vehicles)
        Events.Broadcast("ChangeVehicleDisplay", pad.id, vehicles[vehicleIndex])
    end
end

-- Initialize
Events.Connect("RaceTrackChanged", OnRaceTrackChanged)