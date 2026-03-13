local ITEM_INVENTORY_MODULE = require(script:GetCustomProperty("ItemInventoryModule"))

local ROOT = script.parent
local SLOT1_ICON = ROOT:FindDescendantByName("Slot1Icon")
local SLOT2_ICON = ROOT:FindDescendantByName("Slot2Icon")
local SLOT1_ITEM_IMAGE = ROOT:FindDescendantByName("Slot1ItemImage")
local SLOT2_ITEM_IMAGE = ROOT:FindDescendantByName("Slot2ItemImage")

local MUSHROOM_IMAGE = script:GetCustomProperty("MushroomImage")
local BANANA_IMAGE = script:GetCustomProperty("BananaImage")
local GREEN_SHELL_IMAGE = script:GetCustomProperty("GreenShellImage")

if not SLOT1_ICON then
    warn("Slot1Icon not found")
    return
end

if not SLOT2_ICON then
    warn("Slot2Icon not found")
    return
end

if not SLOT1_ITEM_IMAGE then
    warn("Slot1ItemImage not found")
    return
end

if not SLOT2_ITEM_IMAGE then
    warn("Slot2ItemImage not found")
    return
end

local function GetImageForItem(itemId)
    if itemId == "Mushroom" then
        return MUSHROOM_IMAGE
    elseif itemId == "Banana" then
        return BANANA_IMAGE
    elseif itemId == "GreenShell" then
        return GREEN_SHELL_IMAGE
    end

    return nil
end

local function RefreshSlot(itemImage, itemId)
    local imageAsset = GetImageForItem(itemId)

    if imageAsset then
        itemImage:SetImage(imageAsset)
        itemImage.visibility = Visibility.INHERIT
    else
        itemImage.visibility = Visibility.FORCE_OFF
    end
end

local function RefreshUI()
    local slot1Item = ITEM_INVENTORY_MODULE.GetItem(1)
    local slot2Item = ITEM_INVENTORY_MODULE.GetItem(2)

    SLOT1_ICON.visibility = Visibility.INHERIT
    SLOT2_ICON.visibility = Visibility.INHERIT

    RefreshSlot(SLOT1_ITEM_IMAGE, slot1Item)
    RefreshSlot(SLOT2_ITEM_IMAGE, slot2Item)
end

RefreshUI()

while true do
    RefreshUI()
    Task.Wait(0.1)
end
