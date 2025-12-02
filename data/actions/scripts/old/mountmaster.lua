function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if isCreature(cid) then return true end
	if getPlayerStorageValue(cid, 93911) ~= 1 then 
		doSendMagicEffect(getCreaturePosition(cid), 29)
		setPlayerStorageValue(cid, 93911, 1)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Agora você possui todas as montarias. Você pode troca-las mudando seu outfit.")
		doRemoveItem(item.uid)
		addMountsToPlayer(cid, getPlayerVocation(cid), getPlayerSex(cid))
	else 
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já possui todas as montarias.")
	end 
  return true
end