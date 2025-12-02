function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if(item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_HEAD).uid) then
    return false
  end

  doSendMagicEffect(getCreaturePosition(cid), CONST_ME_GIFT_WRAPS)
  return true
end
