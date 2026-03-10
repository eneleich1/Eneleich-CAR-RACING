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
local GROUP = script:GetCustomProperty("ToggleGroup"):WaitForObject()
local TRIGGER = script:GetCustomProperty("ToggleTrigger"):WaitForObject()
local SPAWN_PARENT = script:GetCustomProperty("SpawnParent"):WaitForObject()
local SPEED_TEXT = script:GetCustomProperty("Speed"):WaitForObject()
local ACCELERATION_TEXT = script:GetCustomProperty("Acceleration"):WaitForObject()
local BRAKING_TEXT = script:GetCustomProperty("Braking"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()

function OnChildAddedEvent(parent, child)
    if child:IsA("Vehicle") then
        SPEED_TEXT.text = string.format("Top Speed<br>%.0f", child.maxSpeed)
        ACCELERATION_TEXT.text = string.format("Acceleration<br>%.0f", child.accelerationRate)
        BRAKING_TEXT.text = string.format("Braking<br>%.0f", child.brakeStrength)
    end
end

function Reset()
    SPEED_TEXT.text = ""
    ACCELERATION_TEXT.text = ""
    BRAKING_TEXT.text = ""
    GROUP.visibility = Visibility.FORCE_OFF
end

SPAWN_PARENT.childAddedEvent:Connect(OnChildAddedEvent)

TRIGGER.beginOverlapEvent:Connect(function (trigger, player)
    if player == LOCAL_PLAYER then
        GROUP.visibility = Visibility.INHERIT
    end
end
)

TRIGGER.endOverlapEvent:Connect(function (trigger, player)
    if player == LOCAL_PLAYER then
        GROUP.visibility = Visibility.FORCE_OFF
    end
end)

Reset()

for _, child in ipairs(SPAWN_PARENT:GetChildren()) do
    if child:IsA("Vehicle") then
        OnChildAddedEvent(parent, child)
    end
end
