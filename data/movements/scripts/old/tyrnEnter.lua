function onStepIn(cid, item, position, fromPosition)
	if isPlayerPzLocked(cid) then
		doTeleportThing(cid, fromPosition, false)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
		return false
	 end
	if getPlayerLevel(cid) < 200 or getPlayerResets(cid) < 90 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você precisa de Level 200+ e Paragon 90+ para entrar na Tyrn Quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else
		doTeleportThing(cid, {x = 544, y = 620, z = 12}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x = 544, y = 620, z = 12}, CONST_ME_TELEPORT)
	end 
	return true
end