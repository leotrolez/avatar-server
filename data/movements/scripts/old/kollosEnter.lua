

function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, {x=886, y=312, z=7}, true)
		return false
	end
	if isPlayerPzLocked(cid) then
		doTeleportThing(cid, {x=886, y=312, z=7}, true)
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
		return false
	 end
	if getPlayerLevel(cid) < 160 then
		doTeleportThing(cid, {x=886, y=312, z=7}, true)
		doCreatureSay(cid, "Você precisa de pelo menos nível 160 para entrar.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else 
		doTeleportThing(cid, {x=881, y=296, z=8}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x=881, y=296, z=8}, CONST_ME_TELEPORT)
	end 
	return true
end