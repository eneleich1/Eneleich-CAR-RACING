local ITEM_INVENTORY_MODULE = require(script:GetCustomProperty("ItemInventoryModule"))

local localPlayer = Game.GetLocalPlayer()

local ITEM_USE_ACTIONS = {
    Mushroom = function()
        Events.BroadcastToServer("UseMushroom")
    end,

    Banana = function()
        Events.BroadcastToServer("UseBanana")
    end
}

local function TryUseSlot1Item()
    local slot1Item = ITEM_INVENTORY_MODULE.GetItem(1)

    if slot1Item == nil then
        return
    end

    local useAction = ITEM_USE_ACTIONS[slot1Item]
    if useAction then
        useAction()
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