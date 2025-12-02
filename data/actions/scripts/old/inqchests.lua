function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
local storage = 100166
   	if item.uid == 2012 then
		queststatus = getPlayerStorageValue(cid,storage)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, "You have found Olympus Helmet.")
   			doPlayerAddItem(cid,13666,1)
   			setPlayerStorageValue(cid,storage,1)
			doSendMagicEffect(getCreaturePosition(cid), 29)
   		else
   			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The chest is empty.", "Esse chest está vazio."))
   		end
   	elseif item.uid == 2013 then
		queststatus = getPlayerStorageValue(cid,storage)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, "You have found Olympus Chest.")
   			doPlayerAddItem(cid,13667,1)
   			setPlayerStorageValue(cid,storage,1)
			doSendMagicEffect(getCreaturePosition(cid), 29)
   		else
   			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The chest is empty.", "Esse chest está vazio."))
   		end
	end
   	return true
end
