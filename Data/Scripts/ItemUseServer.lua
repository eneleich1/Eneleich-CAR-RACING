local MUSHROOM_SPEED_MULTIPLIER = script:GetCustomProperty("MushroomSpeedMultiplier")
local MUSHROOM_DURATION = script:GetCustomProperty("MushroomDuration")
local MUSHROOM_IMPULSE = script:GetCustomProperty("MushroomImpulse")

local activeBoosts = {}

local function ApplyMushroom(player)
    if not Object.IsValid(player) then
        return
    end

    local vehicle = player.occupiedVehicle

    if not Object.IsValid(vehicle) then
        return
    end

    if activeBoosts[player] then
        return
    end

    activeBoosts[player] = true

    local originalMaxSpeed = vehicle.maxSpeed
    local originalAccelerationRate = vehicle.accelerationRate

    vehicle.maxSpeed = originalMaxSpeed * MUSHROOM_SPEED_MULTIPLIER
    vehicle.accelerationRate = originalAccelerationRate * MUSHROOM_SPEED_MULTIPLIER

    vehicle:AddImpulse(vehicle:GetWorldTransform():GetForwardVector() * MUSHROOM_IMPULSE)

    Task.Spawn(function()
        Task.Wait(MUSHROOM_DURATION)

        if Object.IsValid(vehicle) then
            vehicle.maxSpeed = originalMaxSpeed
            vehicle.accelerationRate = originalAccelerationRate
        end

        activeBoosts[player] = nil
    end)
end

Events.ConnectForPlayer("UseMushroom", ApplyMushroom)
