dofile("data/actions/scripts/old/quests/resetquest/const.lua")

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if itemEx.actionid == 3509 then
        doRemoveItem(itemEx.uid)
        doSendMagicEffect(toPosition, 2)
        doCreateItem(2253, 1, toPosition)
        return true
    end

    return false
end