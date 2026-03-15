local MUSHROOM_SPEED_MULTIPLIER = script:GetCustomProperty("MushroomSpeedMultiplier")
local MUSHROOM_DURATION = script:GetCustomProperty("MushroomDuration")
local MUSHROOM_IMPULSE = script:GetCustomProperty("MushroomImpulse")
local MUSHROOM_MINIMUM_BOOST_SPEED = script:GetCustomProperty("MushroomMinimumBoostSpeed")

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


	--Add Impulse to the kart when use Mushroom
	
	local forward = vehicle:GetWorldTransform():GetForwardVector()
	local flatForward = Vector3.New(forward.x, forward.y, 0):GetNormalized()
	
	local currentVelocity = vehicle:GetVelocity()
	local currentFlatVelocity = Vector3.New(currentVelocity.x, currentVelocity.y, 0)
	local currentFlatSpeed = currentFlatVelocity.size
	
	local minimumBoostSpeed = MUSHROOM_MINIMUM_BOOST_SPEED
	local movingBoostMultiplier = 1.35
	
	if currentFlatSpeed < minimumBoostSpeed then
	    vehicle:SetVelocity(flatForward * minimumBoostSpeed)
	else
	    vehicle:SetVelocity(flatForward * (currentFlatSpeed * movingBoostMultiplier))
	end
	
	--End region Add Impulse to the kart when use Mushroom

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
