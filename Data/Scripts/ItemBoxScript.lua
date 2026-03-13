local VISUAL = script:GetCustomProperty("Visual"):WaitForObject()
local TRIGGER = script:GetCustomProperty("PickupTrigger"):WaitForObject()

local ROTATION_SPEED = script:GetCustomProperty("RotationSpeed")
local RESPAWN_TIME = script:GetCustomProperty("RespawnTime")
local TEST_ITEM_ID = script:GetCustomProperty("TestItemId")

local ITEM_INVENTORY_MODULE = require(script:GetCustomProperty("ItemInventoryModule"))

local collected = false

local POSSIBLE_ITEMS = {
    "Mushroom",
    "Banana",
    "GreenShell"
}

VISUAL:RotateContinuous(Vector3.New(0, 0, ROTATION_SPEED), true)

local function OnBeginOverlap(trigger, other)
    if collected then
        return
    end

    if not Object.IsValid(other) then
        return
    end

    if not other:IsA("Vehicle") then
        return
    end

    if ITEM_INVENTORY_MODULE.IsFull() then
        return
    end

    local randomItem = POSSIBLE_ITEMS[math.random(#POSSIBLE_ITEMS)]
	local wasAdded = ITEM_INVENTORY_MODULE.TryAddItem(randomItem)


    if not wasAdded then
        return
    end

    collected = true

    VISUAL.visibility = Visibility.FORCE_OFF
    TRIGGER.isEnabled = false

    Task.Wait(RESPAWN_TIME)

    if Object.IsValid(VISUAL) then
        VISUAL.visibility = Visibility.INHERIT
    end

    if Object.IsValid(TRIGGER) then
        TRIGGER.isEnabled = true
    end

    collected = false
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)