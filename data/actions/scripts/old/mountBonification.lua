function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if ((canPlayerWearOutfitId(cid, 25, 3)) or (canPlayerWearOutfitId(cid, 26, 3)) or (canPlayerWearOutfitId(cid, 27, 3)) or (canPlayerWearOutfitId(cid, 28, 3))) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já possui este outfit.")
		return true
	end

	doRemoveItem(item.uid, 1)
	doSendMagicEffect(getCreaturePosition(cid), 28)

	if getPlayerVocation(cid) == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Fire Ultimate.")
		doPlayerAddOutfitId(cid, 25, 3)
		return true
	end

	if getPlayerVocation(cid) == 2 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Water Ultimate.")
		doPlayerAddOutfitId(cid, 26, 3)
		return true
	end

	if getPlayerVocation(cid) == 3 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Air Ultimate.")
		doPlayerAddOutfitId(cid, 27, 3)
		return true
	end

	if getPlayerVocation(cid) == 4 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui o outfit Earth Ultimate.")
		doPlayerAddOutfitId(cid, 28, 3)
		return true
	end

  return true
end

