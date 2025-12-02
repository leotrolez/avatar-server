function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, fromPosition, false)
		return false
	end
	if isPlayerPzLocked(cid) then
		doTeleportThing(cid, fromPosition, false)
      	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
		return false
	end
	if getPlayerLevel(cid) < 250 or getPlayerResets(cid) < 120 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você precisa de Level 250+ e Paragon 120+ para entrar na Evil Avatar Quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else 
		doTeleportThing(cid, {x = 506, y = 156, z = 12}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x = 506, y = 156, z = 12}, CONST_ME_TELEPORT)
	end 
	return true
end