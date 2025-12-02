function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  doRemoveItem(item.uid, 1)
  doCreatureSay(cid, "You don't really know what this did to you, but suddenly you feel very happy.", TALKTYPE_MONSTER)
  doSendMagicEffect(getThingPos(cid), CONST_ME_HEARTS)
  return true
end
