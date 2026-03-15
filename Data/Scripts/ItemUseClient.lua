local ITEM_INVENTORY_MODULE = require(script:GetCustomProperty("ItemInventoryModule"))

local localPlayer = Game.GetLocalPlayer()

local function TryUseSlot1Item()
    local slot1Item = ITEM_INVENTORY_MODULE.GetItem(1)

    if slot1Item == nil then
        return
    end

    if slot1Item == "Mushroom" then
        Events.BroadcastToServer("UseMushroom")
        ITEM_INVENTORY_MODULE.ClearSlot(1)
    end
end

function OnBindingPressed(player, binding)
    if binding == "ability_extra_27" then
        TryUseSlot1Item()
    elseif binding == "ability_extra_28" then
        ITEM_INVENTORY_MODULE.SwapSlots()
    end
end

localPlayer.bindingPressedEvent:Connect(OnBindingPressed)