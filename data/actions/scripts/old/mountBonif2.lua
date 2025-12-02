function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if ((canPlayerWearOutfitId(cid, 31, 3)) or (canPlayerWearOutfitId(cid, 34, 3)) or (canPlayerWearOutfitId(cid, 36, 3)) or (canPlayerWearOutfitId(cid, 39, 3))) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já possui este outfit.")
		return true
	end

	doRemoveItem(item.uid, 1)
	doSendMagicEffect(getCreaturePosition(cid), 28)

	if getPlayerVocation(cid) == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Fire Diamond.")
		doPlayerAddOutfitId(cid, 31, 3)
		return true
	end

	if getPlayerVocation(cid) == 2 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Water Diamond.")
		doPlayerAddOutfitId(cid, 34, 3)
		return true
	end

	if getPlayerVocation(cid) == 3 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Air Diamond.")
		doPlayerAddOutfitId(cid, 36, 3)
		return true
	end

	if getPlayerVocation(cid) == 4 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Earth Diamond.")
		doPlayerAddOutfitId(cid, 39, 3)
		return true
	end

  return true
end

