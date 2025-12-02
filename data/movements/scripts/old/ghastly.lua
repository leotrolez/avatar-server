

function onStepIn(cid, item, position, fromPosition)
	if isPlayerPzLocked(cid) then
		doTeleportThing(cid, fromPosition, false)
      	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
		return false
	end
	if getPlayerLevel(cid) < 130 or getPlayerResets(cid) < 60 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você precisa de Level 130+ e Paragon 60+ para entrar na Medreth Quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else 
		doTeleportThing(cid, {x=292, y=840, z=11}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x=292, y=840, z=11}, CONST_ME_TELEPORT)
	end 
	return true
end