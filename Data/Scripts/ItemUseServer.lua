local MUSHROOM_SPEED_MULTIPLIER = script:GetCustomProperty("MushroomSpeedMultiplier")
local MUSHROOM_DURATION = script:GetCustomProperty("MushroomDuration")
local MUSHROOM_IMPULSE = script:GetCustomProperty("MushroomImpulse")
local MUSHROOM_MINIMUM_BOOST_SPEED = script:GetCustomProperty("MushroomMinimumBoostSpeed")
local BANANA_TEMPLATE = script:GetCustomProperty("BananaTemplate")
local GREEN_SHELL_PROJECTILE_TEMPLATE = script:GetCustomProperty("GreenShellProjectileTemplate")

local GREEN_SHELL_SPEED = script:GetCustomProperty("GreenShellSpeed")
local GREEN_SHELL_GRAVITY_SCALE = script:GetCustomProperty("GreenShellGravityScale")
local GREEN_SHELL_LIFE_TIME = script:GetCustomProperty("GreenShellLifeTime")
local GREEN_SHELL_BOUNCES = script:GetCustomProperty("GreenShellBounces")
local GREEN_SHELL_BOUNCINESS = script:GetCustomProperty("GreenShellBounciness")

local GREEN_SHELL_SLOW_MULTIPLIER = 0.45
local GREEN_SHELL_SPIN_DURATION = 0.75

local activeBoosts = {}

local function GetFlatDirection(vector)
    local flat = Vector3.New(vector.x, vector.y, 0)

    if flat.sizeSquared <= 0.001 then
        return Vector3.FORWARD
    end

    return flat:GetNormalized()
end


local function ApplyGreenShellHit(vehicle)
    if not Object.IsValid(vehicle) then
        return
    end

    if not vehicle:IsA("Vehicle") then
        return
    end

    if vehicle.serverUserData.greenShellHitActive then
        return
    end

    vehicle.serverUserData.greenShellHitActive = true

    local originalMaxSpeed = vehicle.maxSpeed
    local originalAccelerationRate = vehicle.accelerationRate
    local originalTireFriction = vehicle.tireFriction

    local currentVelocity = vehicle:GetVelocity()
    local flatVelocity = Vector3.New(currentVelocity.x, currentVelocity.y, 0)

    -- Hard stop first
    vehicle:SetVelocity(Vector3.ZERO)

    -- Prevent immediate recovery
    vehicle.maxSpeed = math.max(80, originalMaxSpeed * 0.08)
    vehicle.accelerationRate = math.max(40, originalAccelerationRate * 0.10)

    -- Make it slide / spin more like a shell hit
    vehicle.tireFriction = math.max(0.2, originalTireFriction * 0.18)

    Task.Spawn(function()
        local spinDirection = 1
        if math.random() < 0.5 then
            spinDirection = -1
        end

        -- Initial violent spin
        vehicle:SetLocalAngularVelocity(Vector3.New(0, 0, 1400 * spinDirection))

        Task.Wait(0.22)

        if not Object.IsValid(vehicle) then
            return
        end

        -- Keep it mostly stopped during the stun
        vehicle:SetVelocity(Vector3.ZERO)
        vehicle:SetLocalAngularVelocity(Vector3.New(0, 0, 950 * spinDirection))

        Task.Wait(0.28)

        if not Object.IsValid(vehicle) then
            return
        end

        vehicle:SetVelocity(Vector3.ZERO)
        vehicle:SetLocalAngularVelocity(Vector3.New(0, 0, 500 * spinDirection))

        Task.Wait(0.20)

        if not Object.IsValid(vehicle) then
            return
        end

        -- Restore normal driving
        vehicle:SetLocalAngularVelocity(Vector3.ZERO)
        vehicle.maxSpeed = originalMaxSpeed
        vehicle.accelerationRate = originalAccelerationRate
        vehicle.tireFriction = originalTireFriction
        vehicle.serverUserData.greenShellHitActive = nil
    end)
end

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

    local forward = vehicle:GetWorldTransform():GetForwardVector()
    local flatForward = GetFlatDirection(forward)

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
    local flatForward = GetFlatDirection(forward)

    local basePosition = vehicle:GetWorldPosition() - flatForward * 300 + Vector3.UP * 200
    local rayStart = basePosition
    local rayEnd = basePosition - Vector3.UP * 1000

    local hitResult = World.Raycast(rayStart, rayEnd, { ignorePlayers = true })

    local spawnPosition = basePosition
    if hitResult then
        spawnPosition = hitResult:GetImpactPosition() + Vector3.UP * 10
    end

    World.SpawnAsset(BANANA_TEMPLATE, {
        position = spawnPosition,
        rotation = Rotation.New(0, 0, 0),
        networkContext = NetworkContextType.NETWORKED
    })
end

local function UseGreenShell(player)
    if not Object.IsValid(player) then
        return
    end

    local vehicle = player.occupiedVehicle
    if not Object.IsValid(vehicle) then
        return
    end

    local flatForward = GetFlatDirection(vehicle:GetWorldTransform():GetForwardVector())

    local vehicleVelocity = vehicle:GetVelocity()
    local forwardVehicleSpeed = vehicleVelocity .. flatForward
    if forwardVehicleSpeed < 0 then
        forwardVehicleSpeed = 0
    end

    local shellSpeed = GREEN_SHELL_SPEED + forwardVehicleSpeed
    local spawnDistance = 420 + math.min(forwardVehicleSpeed * 0.12, 220)

    local basePosition = vehicle:GetWorldPosition() + flatForward * spawnDistance + Vector3.UP * 120
    local groundHit = World.Raycast(
        basePosition + Vector3.UP * 120,
        basePosition - Vector3.UP * 1200,
        {
            ignorePlayers = true,
            ignoreObjects = { vehicle }
        }
    )

    local spawnPosition = basePosition
    if groundHit then
        spawnPosition = groundHit:GetImpactPosition() + Vector3.UP * 35
    end

    local projectile = Projectile.Spawn(GREEN_SHELL_PROJECTILE_TEMPLATE, spawnPosition, flatForward)
    projectile.owner = player
    projectile.speed = shellSpeed
    projectile.maxSpeed = shellSpeed
    projectile.gravityScale = GREEN_SHELL_GRAVITY_SCALE
    projectile.drag = 0
    projectile.lifeSpan = GREEN_SHELL_LIFE_TIME
    projectile.bouncesRemaining = GREEN_SHELL_BOUNCES
    projectile.bounciness = GREEN_SHELL_BOUNCINESS
    projectile.capsuleRadius = 45
    projectile.capsuleLength = 70

    projectile:SetVelocity(flatForward * shellSpeed)

    local resolved = false


	--Projectil impact

	projectile.impactEvent:Connect(function(p, other, hitResult)
	    if resolved then
	        return
	    end
	
	    if not Object.IsValid(p) then
	        return
	    end
	
	    if Object.IsValid(other) and other:IsA("Vehicle") then
	        resolved = true
	        ApplyGreenShellHit(other)
	        p:Destroy()
	        return
	    end
	
	    local impactNormal = nil
	    if hitResult then
	        impactNormal = hitResult:GetImpactNormal()
	    end
	
	    local currentVelocity = p:GetVelocity()
	    local flatVelocity = Vector3.New(currentVelocity.x, currentVelocity.y, 0)
	
	    if flatVelocity.sizeSquared <= 0.001 then
	        flatVelocity = flatForward * shellSpeed
	    end
	
	    local newFlatDirection = flatVelocity:GetNormalized()
	
	    if impactNormal then
	        local flatNormal = Vector3.New(impactNormal.x, impactNormal.y, 0)
	
	        if flatNormal.sizeSquared > 0.001 then
	            flatNormal = flatNormal:GetNormalized()
	            newFlatDirection = newFlatDirection - 2 * (newFlatDirection .. flatNormal) * flatNormal
	
	            if newFlatDirection.sizeSquared > 0.001 then
	                newFlatDirection = newFlatDirection:GetNormalized()
	            else
	                newFlatDirection = flatForward
	            end
	        end
	    end
	
	    p:SetVelocity(newFlatDirection * shellSpeed)
	
	    Task.Spawn(function()
	        Task.Wait()
	
	        if not Object.IsValid(p) then
	            return
	        end
	
	        local delayedVelocity = p:GetVelocity()
	        local delayedFlatVelocity = Vector3.New(delayedVelocity.x, delayedVelocity.y, 0)
	
	        if delayedFlatVelocity.sizeSquared <= 0.001 then
	            p:SetVelocity(newFlatDirection * shellSpeed)
	        else
	            p:SetVelocity(delayedFlatVelocity:GetNormalized() * shellSpeed)
	        end
	    end)
	end)

	--End Projectil Impact

end

Events.ConnectForPlayer("UseMushroom", ApplyMushroom)
Events.ConnectForPlayer("UseBanana", UseBanana)
Events.ConnectForPlayer("UseGreenShell", UseGreenShell)