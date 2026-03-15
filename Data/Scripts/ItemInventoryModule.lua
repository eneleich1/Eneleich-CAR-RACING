local ItemInventory = {}

ItemInventory.slot1 = nil
ItemInventory.slot2 = nil
ItemInventory.activeSlot = 1

function ItemInventory.GetItem(slotIndex)
    if slotIndex == 1 then
        return ItemInventory.slot1
    elseif slotIndex == 2 then
        return ItemInventory.slot2
    end

    return nil
end

function ItemInventory.SetItem(slotIndex, itemId)
    if slotIndex == 1 then
        ItemInventory.slot1 = itemId
    elseif slotIndex == 2 then
        ItemInventory.slot2 = itemId
    end
end

function ItemInventory.GetActiveSlot()
    return ItemInventory.activeSlot
end

function ItemInventory.SetActiveSlot(slotIndex)
    if slotIndex == 1 or slotIndex == 2 then
        ItemInventory.activeSlot = slotIndex
    end
end

function ItemInventory.GetActiveItem()
    return ItemInventory.GetItem(ItemInventory.activeSlot)
end

function ItemInventory.ClearSlot(slotIndex)
    ItemInventory.SetItem(slotIndex, nil)
end

function ItemInventory.ClearAll()
    ItemInventory.slot1 = nil
    ItemInventory.slot2 = nil
    ItemInventory.activeSlot = 1
end

function ItemInventory.IsFull()
    return ItemInventory.slot1 ~= nil and ItemInventory.slot2 ~= nil
end

function ItemInventory.TryAddItem(itemId)
    if itemId == nil then
        return false
    end

    if ItemInventory.slot1 == nil then
        ItemInventory.slot1 = itemId
        return true
    end

    if ItemInventory.slot2 == nil then
        ItemInventory.slot2 = itemId
        return true
    end

    return false
end

function ItemInventory.SwapSlots()
    local temp = ItemInventory.slot1
    ItemInventory.slot1 = ItemInventory.slot2
    ItemInventory.slot2 = temp
end

return ItemInventory