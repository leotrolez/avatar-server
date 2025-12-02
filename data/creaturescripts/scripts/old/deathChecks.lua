function copyItem(item)
    if (isContainer(item.uid) == TRUE) then
        return copyContainer(item.uid, item.itemid)
    else
        return doCreateItemEx(item.itemid, getCharges(item.uid))
    end
end

function copyContainer(uid, itemid)
    local container = doCreateItemEx(itemid, 1)
    local iterator = getContainerSize(uid)
    while iterator >= 0 do
        doAddContainerItemEx(container, copyItem(getContainerItem(uid, iterator)))
        iterator = iterator - 1
    end
    return container
end

function doAddContainerItemsFromContainer(containerFrom, containerTo)
    doAddContainerItem(containerTo.uid, 1988)
    containerTo = getContainerItem(containerTo.uid, 0)
    local size = getContainerSize(containerFrom.uid)
    if size >= 0 then
        for i = 0, size - 1 do
            -- doAddContainerItemEx(containerTo.uid, getContainerItem(containerFrom.uid, i).uid)
            local item = getContainerItem(containerFrom.uid, (size - 1) - i)
            doAddContainerItem(containerTo.uid, item.itemid, item.type)
            if type(item.type) == "number" and item.type >= 2 then
                doRemoveItem(item.uid, item.type)
            else
                doRemoveItem(item.uid)
            end
        end
    end

end

function onDeath(cid, corpse, deathList)
    -- local expLoss, hasBless = getLostExp(cid), false
    --	 doAddContainerItemEx(corpse, copyItem(getPlayerSlotItem(cid, CONST_SLOT_RING)))
    -- doAddContainerItemsFromContainer(getPlayerSlotItem(cid, CONST_SLOT_RING), corpse)
    local lastHit = getPlayerStorageValue(cid, "lastHit")
    if getPlayerStorageValue(cid, "isAvatar") == 1 then
        if isCreature(lastHit) and isPlayer(lastHit) and math.random(1, 100) >= 51 then
            makeNewAvatar(lastHit)
        else
            randomizeNewAvatar()
        end
    end
    if getPlayerLevel(cid) < 50 then
        setPlayerStorageValue(cid, "morreuD", 1)
    end
    if getPlayerStorageValue(cid, "hasActiveInQuest") ~= 1 then
        setPlayerStorageValue(cid, "expBeforeDie", getPlayerExperience(cid))
        saida.death(cid)
    end
    return true
end
