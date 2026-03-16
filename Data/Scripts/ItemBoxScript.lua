local VISUAL = script:GetCustomProperty("Visual"):WaitForObject()
local TRIGGER = script:GetCustomProperty("PickupTrigger"):WaitForObject()

local ROTATION_SPEED = script:GetCustomProperty("RotationSpeed")
local RESPAWN_TIME = script:GetCustomProperty("RespawnTime")

local ITEM_INVENTORY_MODULE = require(script:GetCustomProperty("ItemInventoryModule"))
local LOCAL_PLAYER = Game.GetLocalPlayer()

local collected = false

VISUAL:RotateContinuous(Vector3.New(0, 0, ROTATION_SPEED), true)

local ITEM_WEIGHTS = {
    { id = "Mushroom", weight = 33 },
    { id = "Banana", weight = 33 },
    { id = "GreenShell", weight = 33 }
}

local function GetRandomWeightedItem()
    local totalWeight = 0

    for _, entry in ipairs(ITEM_WEIGHTS) do
        totalWeight = totalWeight + entry.weight
    end

    local roll = math.random() * totalWeight
    local currentWeight = 0

    for _, entry in ipairs(ITEM_WEIGHTS) do
        currentWeight = currentWeight + entry.weight

        if roll <= currentWeight then
            return entry.id
        end
    end

    return ITEM_WEIGHTS[#ITEM_WEIGHTS].id
end

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

    if other.driver ~= LOCAL_PLAYER then
        return
    end

    if ITEM_INVENTORY_MODULE.IsFull() then
        return
    end

    local randomItem = GetRandomWeightedItem()
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
