
function onStepIn(cid, item, position, fromPosition)
	if getPlayerLevel(cid) < 50 then
		doTeleportThing(cid, {x = 502, y = 357, z = 7})
		doCreatureSay(cid, "Você precisa de pelo menos nível 50 para participar do evento.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif getPlayerGuildId(cid) == 0 then 
		doTeleportThing(cid, {x = 502, y = 357, z = 7})
		doCreatureSay(cid, "Você não participa de nenhuma guild.", TALKTYPE_ORANGE_1, false, cid)
		return false 
	elseif getPlayerStorageValue(cid, "ativoBot") == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa responder ao Anti-Bot primeiro.")
		return false
	end
	if castleWar.isInDominantGuild(cid) then 
		doTeleportThing(cid, {x=1149, y=978, z=7})	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
		return false
	else
		doTeleportThing(cid, {x=1149, y=978, z=7})	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	end 
	return true
end