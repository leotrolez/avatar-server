function onStepIn(cid, item, position, fromPosition)
	if getPlayerStorageValue(cid, "90525") ~= 1 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você não é digno para enfrentá-lo.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else
		doTeleportThing(cid, {x = 446, y = 1473, z = 7})	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
	end 
	return true
end