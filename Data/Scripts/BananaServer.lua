local TRIGGER = script.parent:FindDescendantByName("Trigger")
local VELOCITY_MULTIPLIER_ON_HIT = script:GetCustomProperty("VelocityMultiplierOnHit")
local SPIN_DURATION = script:GetCustomProperty("SpinDuration")
local SPIN_ANGULAR_VELOCITY_Z = script:GetCustomProperty("SpinAngularVelocityZ")
local SPIN_MAX_SPEED_MULTIPLIER = script:GetCustomProperty("SpinMaxSpeedMultiplier")

local hasBeenTriggered = false

local function OnBeginOverlap(trigger, other)
    if hasBeenTriggered then
        return
    end

    if not Object.IsValid(other) then
        return
    end

    if not other:IsA("Vehicle") then
        return
    end

    hasBeenTriggered = true

    local currentVelocity = other:GetVelocity()
    other:SetVelocity(currentVelocity * VELOCITY_MULTIPLIER_ON_HIT)

    local originalMaxSpeed = other.maxSpeed

	other.maxSpeed = originalMaxSpeed * SPIN_MAX_SPEED_MULTIPLIER


	Task.Spawn(function()
	    local pulseDuration = SPIN_DURATION / 6
	
	    local directions = { 1, -1, 1, -1 }
	
	    for _, direction in ipairs(directions) do
	        if not Object.IsValid(other) then
	            return
	        end
	
	        other:SetLocalAngularVelocity(Vector3.New(0, 0, SPIN_ANGULAR_VELOCITY_Z * direction))
	        Task.Wait(pulseDuration)
	
	        if not Object.IsValid(other) then
	            return
	        end
	
	        other:SetLocalAngularVelocity(Vector3.ZERO)
	        Task.Wait(pulseDuration * 0.5)
	    end
	
	    if Object.IsValid(other) then
	        other.maxSpeed = originalMaxSpeed
	        other:SetLocalAngularVelocity(Vector3.ZERO)
	    end
	end)


    script.parent:Destroy()
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)