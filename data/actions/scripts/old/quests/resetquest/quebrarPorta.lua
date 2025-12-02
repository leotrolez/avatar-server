dofile("data/actions/scripts/old/quests/resetquest/const.lua")

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if itemEx.actionid == 251 and itemEx.uid == warlockRoom.uniqueIdDoor then
        doRemoveItem(itemEx.uid)
        doCreateItem(warlockRoom.newDoorId, 1, toPosition)
        return true
    end

    return false
end