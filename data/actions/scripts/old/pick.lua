function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if itemEx.actionid == 62124 and item.itemid == 4856 and isInArray({354, 355}, itemEx.itemid) then
    doTransformItem(itemEx.uid, 392)
    doDecayItem(itemEx.uid)
    doSendMagicEffect(toPosition, CONST_ME_POFF)
    return true
  end
  return true
end