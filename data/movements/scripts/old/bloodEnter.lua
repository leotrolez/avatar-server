
function onStepIn(cid, item, position, fromPosition)
	if getPlayerLevel(cid) < 50 then
		doTeleportThing(cid, {x = 502, y = 357, z = 7})
		doCreatureSay(cid, "Você precisa de pelo menos nível 50 para participar no evento.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif getPlayerStorageValue(cid, "ativoBot") == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa responder ao Anti-Bot primeiro.")
		return false
	else
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doTeleportThing(cid, bloodconfig.positionEvento)	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
		registerCreatureEvent(cid, "bloodKill")
		setPlayerStorageValue(cid, "bloodKills", 0)
	end 
	return true
end