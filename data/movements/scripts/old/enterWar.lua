
function onStepIn(cid, item, position, fromPosition)
	if not castleWar.isInDominantGuild(cid) and not castleWar.isRunning() then
		doTeleportThing(cid, fromPosition)
		doCreatureSay(cid, "O evento ainda não começou e você não faz parte da guild dominante do castelo.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif castleWar.isInDominantGuild(cid) then 
		doTeleportThing(cid, {x=1150, y=978, z=7})	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
		return false
	else
		doTeleportThing(cid, {x=1150, y=978, z=7})	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	end 
	
	return true
end