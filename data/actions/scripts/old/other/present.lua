function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  doSendMagicEffect(fromPosition, CONST_ME_EXPLOSIONAREA)
  doCreatureSay(cid, "KABOOOOOOOOOOM!", TALKTYPE_MONSTER)

  doRemoveItem(item.uid, 1)
  return true
end
