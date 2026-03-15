local ITEM_INVENTORY_MODULE = require(script:GetCustomProperty("ItemInventoryModule"))

local function TryUseActiveItem()
    local activeSlot = ITEM_INVENTORY_MODULE.GetActiveSlot()
    local activeItem = ITEM_INVENTORY_MODULE.GetActiveItem()

    if activeItem == nil then
        return
    end

    if activeItem == "Mushroom" then
        ITEM_INVENTORY_MODULE.ClearSlot(activeSlot)
    end
end

function OnBindingPressed(player, binding)
    if binding == "ability_extra_27" then
        TryUseActiveItem()
    end
end

Game.GetLocalPlayer().bindingPressedEvent:Connect(OnBindingPressed)
