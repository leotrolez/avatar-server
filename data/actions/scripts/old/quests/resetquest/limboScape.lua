dofile("data/actions/scripts/old/quests/resetquest/const.lua")

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doTeleportCreature(cid, elementalRoom.positionBorn, 10)
    return true
end