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

--[[ 
    Smart and smooth camera for players sitting in vehicle.
--]]

-- Internal custom properties
local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()

-- Exposed custom properties
local MIN_FIELD_OF_VIEW = COMPONENT_ROOT:GetCustomProperty("MinFieldOfView")
local MAX_FIELD_OF_VIEW = COMPONENT_ROOT:GetCustomProperty("MaxFieldOfView")
local MAX_VEHICLE_SPEED = COMPONENT_ROOT:GetCustomProperty("MaxVehicleSpeed")
local PITCH = COMPONENT_ROOT:GetCustomProperty("Pitch")
local POSITION_OFFSET = COMPONENT_ROOT:GetCustomProperty("PositionOffset")
local CAMERA_POSITION = COMPONENT_ROOT:GetCustomProperty("CameraPosition")
local STIFFNESS = COMPONENT_ROOT:GetCustomProperty("Stiffness")
local LOOK_BACK_BINDING = COMPONENT_ROOT:GetCustomProperty("LookBackBinding")

-- Constant variables
local LOCAL_PLAYER = Game.GetLocalPlayer()

-- Internal variables
local currentCamera = nil
local isReverse = false

-- Lerps an angle to pick the shortest rotation. Angle must be in degrees.
-- returned angle is between -180 to 180
function LerpAngle(fromAngle, toAngle, r)
    fromAngle = fromAngle % 360
    toAngle = toAngle % 360

    local diff = math.abs(fromAngle-toAngle)
    if diff > 360-diff then
        diff = diff-360
    end

    local retAngle
    if fromAngle < toAngle then
        retAngle = fromAngle + diff * r
    else
        retAngle = fromAngle - diff * r
    end

    if retAngle > 180 then
        return retAngle - 360
    else
        return retAngle
    end
end

function SetupCamera(camera)
    camera:SetPosition(CAMERA_POSITION)
    camera.rotationMode = RotationMode.NONE
    camera.hasFreeControl = true
    camera.isYawLimited = false
    camera.followPlayer = nil
    camera:SetPositionOffset(POSITION_OFFSET)

    local vehicle = LOCAL_PLAYER.occupiedVehicle
    camera.currentYaw = vehicle:GetWorldRotation().z
    camera.currentPitch = PITCH
end

function Tick(deltaTime)
    local vehicle = LOCAL_PLAYER.occupiedVehicle

    -- Ignore if the local player is not in the vehicle 
    if not Object.IsValid(vehicle) then
        currentCamera = nil
        return
    end

    -- Ignore if the vehicle doesn't have the camera
    local camera = vehicle.camera
    if not Object.IsValid(camera) then
        currentCamera = nil
        return
    end

    -- Setup camera if this camera hasn't been set up
    if camera ~= currentCamera then
        currentCamera = camera
        SetupCamera(camera)
    end

    if isReverse then
        camera.currentYaw = camera.currentYaw - 180
    end

    -- Smoothening yaw and pitch of the camera 
    local easeStrength = CoreMath.Clamp(vehicle:GetVelocity().size / 1000) * STIFFNESS

    camera.currentYaw = LerpAngle( camera.currentYaw, vehicle:GetWorldRotation().z, 1 - 0.5 ^ (deltaTime * easeStrength))
    camera.currentPitch = LerpAngle(camera.currentPitch, PITCH, 1 - 0.5 ^ (deltaTime * easeStrength))

    -- Smoothening FOV based on vehicle speed
    local forwardLookDirection = LOCAL_PLAYER:GetViewWorldRotation() * Vector3.FORWARD

    local speed = vehicle:GetVelocity() .. forwardLookDirection
    local targetFOV = CoreMath.Lerp(MIN_FIELD_OF_VIEW, MAX_FIELD_OF_VIEW, CoreMath.Clamp(speed / MAX_VEHICLE_SPEED))
    camera.fieldOfView = CoreMath.Lerp(camera.fieldOfView, targetFOV,  1 - 0.5 ^ (deltaTime * STIFFNESS))

    -- Reverse look if binding is pressed
    isReverse = LOCAL_PLAYER:IsBindingPressed(LOOK_BACK_BINDING)

    if isReverse then
        camera.currentYaw = camera.currentYaw + 180
    end
end