
function onStepIn(cid, item, position, fromPosition)
	if getPlayerLevel(cid) < 50 then
		doTeleportThing(cid, {x = 502, y = 357, z=7})
		doCreatureSay(cid, "Você precisa de pelo menos nível 50 para participar do evento.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif getCreatureSkullType(cid) == 4 then
		doTeleportThing(cid, {x = 502, y = 357, z=7})
		doCreatureSay(cid, "Você não pode participar do evento com skull ativa.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif getPlayerStorageValue(cid, "ativoBot") == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa responder ao Anti-Bot primeiro.")
		return false
	else
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		if isInParty(cid) then 
			doPlayerLeaveParty(cid, true)
		end
		warRegister(cid)
	end 
	return true
end