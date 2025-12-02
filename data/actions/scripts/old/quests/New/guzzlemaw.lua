function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local rewards = {13136, 12862, 13132}
	
	if getPlayerStorageValue(cid, item.uniqueid) == -1 then
		doPlayerAddItem(cid, rewards[math.random(#rewards)])
		setPlayerStorageValue(cid, item.uniqueid, 1)
		return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You have found an item.", "Você encontrou um item."))
	else
		return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The chest is empty.", "Esse chest está vazio."))
	end
	return true
end