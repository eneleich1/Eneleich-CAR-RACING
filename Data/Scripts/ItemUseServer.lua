local MUSHROOM_SPEED_MULTIPLIER = script:GetCustomProperty("MushroomSpeedMultiplier")
local MUSHROOM_DURATION = script:GetCustomProperty("MushroomDuration")
local MUSHROOM_IMPULSE = script:GetCustomProperty("MushroomImpulse")
local MUSHROOM_MINIMUM_BOOST_SPEED = script:GetCustomProperty("MushroomMinimumBoostSpeed")
local BANANA_TEMPLATE = script:GetCustomProperty("BananaTemplate")

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

local function UseBanana(player)
    local vehicle = player.occupiedVehicle
    if not Object.IsValid(vehicle) then
        return
    end

    local forward = vehicle:GetWorldTransform():GetForwardVector()
    local flatForward = Vector3.New(forward.x, forward.y, 0)

    if flatForward.sizeSquared <= 0.001 then
        flatForward = Vector3.FORWARD
    else
        flatForward = flatForward:GetNormalized()
    end

    local basePosition = vehicle:GetWorldPosition() - flatForward * 300 + Vector3.UP * 200
    local rayStart = basePosition
    local rayEnd = basePosition - Vector3.UP * 1000

    local hitResult = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})

    local spawnPosition = basePosition
    if hitResult then
        spawnPosition = hitResult:GetImpactPosition() + Vector3.UP * 10
    end

    local spawnRotation = Rotation.New(0, 0, 0)

    World.SpawnAsset(BANANA_TEMPLATE, {
        position = spawnPosition,
        rotation = spawnRotation,
        networkContext = NetworkContextType.NETWORKED
    })
end

Events.ConnectForPlayer("UseMushroom", ApplyMushroom)
Events.ConnectForPlayer("UseBanana", UseBanana)
