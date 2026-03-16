local ROOT = script.parent
local TRIGGER = ROOT:FindDescendantByName("Trigger")

local SPEED = ROOT:GetCustomProperty("Speed")
local LIFE_TIME = ROOT:GetCustomProperty("LifeTime")
local SPIN_DURATION = ROOT:GetCustomProperty("SpinDuration")
local SLOW_MULTIPLIER = ROOT:GetCustomProperty("SlowMultiplier")

local hasBeenTriggered = false

local forwardDirection = ROOT:GetWorldTransform():GetForwardVector()
forwardDirection = Vector3.New(forwardDirection.x, forwardDirection.y, 0)

if forwardDirection.sizeSquared <= 0.001 then
    forwardDirection = Vector3.FORWARD
else
    forwardDirection = forwardDirection:GetNormalized()
end

local function ApplyHitToVehicle(vehicle)
    if hasBeenTriggered then
        return
    end

    if not Object.IsValid(vehicle) then
        return
    end

    if not vehicle:IsA("Vehicle") then
        return
    end

    hasBeenTriggered = true

    local currentVelocity = vehicle:GetVelocity()
    vehicle:SetVelocity(currentVelocity * SLOW_MULTIPLIER)

    local originalMaxSpeed = vehicle.maxSpeed
    vehicle.maxSpeed = originalMaxSpeed * SLOW_MULTIPLIER

    Task.Spawn(function()
        local pulseDuration = SPIN_DURATION / 6
        local directions = { 1, -1, 1, -1 }

        for _, direction in ipairs(directions) do
            if not Object.IsValid(vehicle) then
                return
            end

            vehicle:SetLocalAngularVelocity(Vector3.New(0, 0, 900 * direction))
            Task.Wait(pulseDuration)

            if not Object.IsValid(vehicle) then
                return
            end

            vehicle:SetLocalAngularVelocity(Vector3.ZERO)
            Task.Wait(pulseDuration * 0.5)
        end

        if Object.IsValid(vehicle) then
            vehicle.maxSpeed = originalMaxSpeed
            vehicle:SetLocalAngularVelocity(Vector3.ZERO)
        end
    end)

    ROOT:Destroy()
end

local function OnBeginOverlap(trigger, other)
    ApplyHitToVehicle(other)
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)

function Tick(deltaTime)
    if hasBeenTriggered or not Object.IsValid(ROOT) then
        return
    end

    local currentPosition = ROOT:GetWorldPosition()
    local nextPosition = currentPosition + forwardDirection * SPEED * deltaTime

    local hitResult = World.Raycast(currentPosition + Vector3.UP * 20, nextPosition + Vector3.UP * 20, {
        ignorePlayers = true,
        ignoreObjects = { ROOT }
    })

    if hitResult then
        local hitObject = hitResult.other

        if Object.IsValid(hitObject) and hitObject:IsA("Vehicle") then
            ApplyHitToVehicle(hitObject)
            return
        end

        local normal = hitResult:GetImpactNormal()
        forwardDirection = forwardDirection - 2 * (forwardDirection .. normal) * normal
        forwardDirection = Vector3.New(forwardDirection.x, forwardDirection.y, 0)

        if forwardDirection.sizeSquared <= 0.001 then
            forwardDirection = Vector3.FORWARD
        else
            forwardDirection = forwardDirection:GetNormalized()
        end

        ROOT:SetWorldPosition(hitResult:GetImpactPosition() + forwardDirection * 30)
        ROOT:SetWorldRotation(Rotation.New(forwardDirection, Vector3.UP))
        return
    end

    ROOT:SetWorldPosition(nextPosition)
end

Task.Spawn(function()
    Task.Wait(LIFE_TIME)

    if Object.IsValid(ROOT) then
        ROOT:Destroy()
    end
end)