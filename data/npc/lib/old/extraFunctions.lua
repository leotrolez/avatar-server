
local initialItens = {
    normalItens = {
        {itemid=13734, amount=1, slot = CONST_SLOT_FEET},
        {itemid=13733, amount=1, slot = CONST_SLOT_LEGS},
        {itemid=13732, amount=1, slot = CONST_SLOT_ARMOR},
        {itemid=13412, amount=1, slot = CONST_SLOT_RIGHT},
        {itemid=2389, amount=7, slot = CONST_SLOT_LEFT},
        {itemid=1998, amount=1, slot = CONST_SLOT_BACKPACK},
        {itemid=7379, amount=1, slot = CONST_SLOT_BACKPACK},
        {itemid=3963, amount=1, slot = CONST_SLOT_BACKPACK},
        {itemid=2428, amount=1, slot = CONST_SLOT_BACKPACK},
        {itemid=2002, amount=1, slot = CONST_SLOT_BACKPACK},
    },
    vocItens = {
        {{itemid = 13731, amount=1, slot=CONST_SLOT_HEAD} },
        {{itemid = 13731, amount=1, slot=CONST_SLOT_HEAD}, {itemid = 4864, amount=1, slot=CONST_SLOT_AMMO, waterFull = true}, {itemid = 4864, amount=1, slot=CONST_SLOT_BACKPACK, waterFull = true}, {itemid = 4864, amount=1, slot=CONST_SLOT_BACKPACK, waterFull = true}}, 
        {{itemid = 13731, amount=1, slot=CONST_SLOT_HEAD} }, 
        {{itemid = 13731, amount=1, slot=CONST_SLOT_HEAD} },
    },

    slots = {CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, 
             CONST_SLOT_LEFT, CONST_SLOT_LEGS, CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO},

    vocOutfits = {
        {383, 388},
        {387, 368},
        {456, 457},
        {384, 371}
    }
}

function sendInitialItens(cid)
    local playerVoc = getPlayerVocation(cid)

    if playerVoc == 0 then
        return true
    end

    if getPlayerStorageValue(cid, "playerHasGetInitialItens") == 1 then
        return true
    end

    --doPlayerAddOutfit(cid, initialItens.vocOutfits[playerVoc][getPlayerSex(cid)+1], 0)


    for x = 1, #initialItens.slots do
        local possibleItemInSlot = getPlayerSlotItem(cid, initialItens.slots[x]).uid
        if possibleItemInSlot > 0 then
            doRemoveItem(possibleItemInSlot)
        end
    end

    for x = 1, #initialItens.normalItens do
        doPlayerAddItem(cid, initialItens.normalItens[x].itemid, initialItens.normalItens[x].amount, false, initialItens.normalItens[x].slot)
    end

    for x = 1, #initialItens.vocItens[playerVoc] do
        local itemUid = doPlayerAddItem(cid, initialItens.vocItens[playerVoc][x].itemid, initialItens.vocItens[playerVoc][x].amount, false, initialItens.vocItens[playerVoc][x].slot)
        setItemWaterFullByBorean(itemUid, initialItens.vocItens[playerVoc][x].waterFull)
    end
    setPlayerStorageValue(cid, "playerHasGetInitialItens", 1)
	doPlayerSendOutfitWindow(cid)
end