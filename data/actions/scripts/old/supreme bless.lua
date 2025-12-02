function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerLevel(cid) >= 50 then
		if getPlayerStorageValue(cid, "playerWithSupremeBless") == 1 then 
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "You already are supreme blessed.", "Você já está com a supreme bless ativada."))
			return false
		elseif getPlayerStorageValue(cid, "delayBlessPotion") > os.time() then 
			local delay = getPlayerStorageValue(cid, "delayBlessPotion")
			doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(delay-os.time()).." to use this again.", "Você precisa esperar "..getSecsString(delay-os.time()).." para usar isso novamente."))
		else
			doRemoveItem(item.uid, 1)
			setPlayerStorageValue(cid, "playerWithBless", 1)
			setPlayerStorageValue(cid, "blessExpName", "Sony")
			setPlayerStorageValue(cid, "playerWithSupremeBless", 1)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "You are now protected until your next death.", "Você recebeu a supreme bless e está protegido até sua próxima morte."))
			doSendMagicEffect(getThingPos(cid), 49)
			if getPlayerLevel(cid) < 150 then
				setPlayerStorageValue(cid, "delayBlessPotion", os.time()+1*60*60)
			else
				setPlayerStorageValue(cid, "delayBlessPotion", os.time()+12*60*60)
			end
		end
	else
		doPlayerSendCancel(cid, getLangString(cid, "You can only use this item at level 50 or higher.", "Você só pode usar este item no level 50 ou mais."))
	end
return true 
end