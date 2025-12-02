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
	if getPlayerLevel(cid) < 300 or getPlayerResets(cid) < 140 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você precisa de Level 300+ e Paragon 140+ para entrar na The Bosses Quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else 
		doTeleportThing(cid, {x = 1125, y = 1045, z = 7} , false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x = 1125, y = 1045, z = 7} , CONST_ME_TELEPORT)
	end 
	return true
end