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
local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()
local SPAWN_PARENT = script:GetCustomProperty("SpawnParent"):WaitForObject()
local VEHICLE_DRIVE_POSITION = script:GetCustomProperty("VehicleDrivePosition"):WaitForObject()

-- User exposed variables
local DEFAULT_VEHICLE_ASSET = COMPONENT_ROOT:GetCustomProperty("VehicleAsset")
local DRIVE_VEHICLE_ON_SELECTION = COMPONENT_ROOT:GetCustomProperty("DriveVehicleOnSelection")
local DISPLAY_ANGLE = COMPONENT_ROOT:GetCustomProperty("DisplayAngle")

-- Internal variables
local previewInstance = nil
local vehicleAsset = nil

-- nil SaveSelectedVehicle(Player)
-- Saves vehicleAsset to server user data for other scripts to see player's selection
function SaveSelectedVehicle(player)
    player.serverUserData.selectedVehicleId = vehicleAsset
end

-- nil SetVehicleToPlayer(Player)
-- Set the specified vehicle and destroys player's current vehicle
function SetVehicleToPlayer(player)
    local instance = World.SpawnAsset(vehicleAsset)
    local playerPos = player:GetWorldPosition()

    local occupiedVehicle = player.occupiedVehicle
    if occupiedVehicle then
        occupiedVehicle:RemoveDriver()
        occupiedVehicle:Destroy()
    end
    instance:SetWorldPosition(VEHICLE_DRIVE_POSITION:GetWorldPosition())
    instance:SetWorldRotation(VEHICLE_DRIVE_POSITION:GetWorldRotation())

    Task.Wait(1)

    instance:SetDriver(player)
end

-- nil SetVehicleSelector(string)
-- Set new car to this vehicle pad
function SetVehicleSelector(assetId)
    vehicleAsset = CoreString.Split(assetId,":")

    script:SetCustomProperty("VehicleAsset", vehicleAsset)

    if previewInstance then
        previewInstance:Destroy()
    end
    if assetId then
        previewInstance = World.SpawnAsset(assetId, {parent = SPAWN_PARENT})
        previewInstance:SetRotation(Rotation.New(0, 0, DISPLAY_ANGLE))

        script:SetCustomProperty("VehicleName", previewInstance.name)
    end
end

-- bool OnVehicleSelected(Player, string)
function OnVehicleSelected(player, rootId)
    if rootId ~= COMPONENT_ROOT.id then return end

    SaveSelectedVehicle(player)

    if DRIVE_VEHICLE_ON_SELECTION then
        SetVehicleToPlayer(player)
    end
end

-- nil function OnChangeVehicleDisplay(string)
function OnChangeVehicleDisplay(id, vehicleAsset)
    if id == COMPONENT_ROOT.id then
        SetVehicleSelector(vehicleAsset)
    end
end

-- Initialize
-- "VS" stands for Vehicle Selected. This event is called from VehicleSelectorDisplayClient script.
Events.ConnectForPlayer("VS", OnVehicleSelected)
Events.Connect("ChangeVehicleDisplay", OnChangeVehicleDisplay)

if DEFAULT_VEHICLE_ASSET then
    SetVehicleSelector(DEFAULT_VEHICLE_ASSET)
end