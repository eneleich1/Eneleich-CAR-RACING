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
local SERVER_SCRIPT = script:GetCustomProperty("ServerScript"):WaitForObject()
local SPAWN_PARENT = script:GetCustomProperty("SpawnParent"):WaitForObject()
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local NAME_LABEL = script:GetCustomProperty("NameLabel"):WaitForObject()
local INFO_LABEL = script:GetCustomProperty("InfoLabel"):WaitForObject()

-- User exposed variables
local SUCCESS_SOUND = COMPONENT_ROOT:GetCustomProperty("SelectionSuccessSound")
local FAIL_SOUND = COMPONENT_ROOT:GetCustomProperty("SelectionFailSound")

-- Constants
local LOCAL_PLAYER = Game.GetLocalPlayer()
local vehicleName = ""
local vehicleAsset = nil

-- nil OnInteracted(Trigger, Player)
-- Check whether or not player is allowed to buy / slelect the Vehicle on interaction
function OnInteracted(trigger, player)
    if vehicleAsset == nil then
        ShowMessage("No vehicles to select", Color.RED)
        return
    end

    if IsVehicleSelected(player) then
        ShowMessage(string.format("Already selected %s", vehicleName), Color.ORANGE)
        SpawnFeedbackAsset(FAIL_SOUND)
        return
    end

    -- Selection logic
    local success = Events.BroadcastToServer("VS", COMPONENT_ROOT.id)
    if success then        
        player.clientUserData.selectedVehicleId = vehicleAsset
        UpdateTexts()
        
        ShowMessage(string.format("Selected %s!", vehicleName), Color.GREEN)
        SpawnFeedbackAsset(SUCCESS_SOUND)

        Events.Broadcast("VehicleSelected", vehicleAsset)
    else
        ShowMessage("Selection Error. Try Again!", Color.RED)
        SpawnFeedbackAsset(FAIL_SOUND)
    end

    -- Giving some delay to avoid spamming interaction trigger
    trigger.isInteractable = false
    Task.Wait(1)
    trigger.isInteractable = true
end

-- bool IsVehicleSelected(player)
-- Whether or not the player selected the vehicleAsset
function IsVehicleSelected(player)
    if player.clientUserData.selectedVehicleId == vehicleAsset then
        return true
    end

    return false
end

-- nil ShowMessage(string, Color)
-- Wrapper function to show message to Message Banner component
-- This can broadcast any of your custom messaging system
function ShowMessage(message, color)
    if color == nil then
        color = Color.WHITE
    end

    -- Duration by default is 2 for this script
    Events.Broadcast("SubBannerMessage", message, 2.5, color)
end

-- nil SpawnFeedbackAsset(string)
-- Spawns template at the component root position
function SpawnFeedbackAsset(asset)
    if asset then
        World.SpawnAsset(asset, {parent = COMPONENT_ROOT})
    end
end

-- nil UpdateTexts()
-- Update world texts. You can add more information about the Vehicle by adjusting this function
function UpdateTexts()
    NAME_LABEL.text = string.format("%s", vehicleName)
    TRIGGER.interactionLabel = string.format("Select %s", vehicleName)

    if vehicleAsset ~= "" then
        if IsVehicleSelected(LOCAL_PLAYER) then
            INFO_LABEL.text = "Selected"
            INFO_LABEL:SetColor(Color.GREEN)
        else
            INFO_LABEL.text = "Select Car"
            INFO_LABEL:SetColor(Color.WHITE)
        end
    else
        INFO_LABEL.text = ""
    end
end

-- SetVehicleAsset(string)
function SetVehicleAsset(assetId)
    TRIGGER.isInteractable = true
    vehicleAsset = assetId

    UpdateTexts()
end

function OnNetworkedPropertyChangedEvent(obj, property)
    if obj ~= SERVER_SCRIPT then return end

    if property == "VehicleAsset" then
        local assetId = obj:GetCustomProperty(property)
        SetVehicleAsset(assetId)
    end
    if property == "VehicleName" then
        vehicleName = obj:GetCustomProperty("VehicleName")
        UpdateTexts()
    end
end

-- Initialize
NAME_LABEL.text = ""
INFO_LABEL.text = ""
TRIGGER.isInteractable = false

TRIGGER.interactedEvent:Connect(OnInteracted)

SERVER_SCRIPT.customPropertyChangedEvent:Connect(OnNetworkedPropertyChangedEvent)

OnNetworkedPropertyChangedEvent(SERVER_SCRIPT, "VehicleAsset")
OnNetworkedPropertyChangedEvent(SERVER_SCRIPT, "VehicleName")

UpdateTexts()

Events.Connect("VehicleSelected", UpdateTexts)