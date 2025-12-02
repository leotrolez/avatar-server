function onStepIn(cid, item, position, fromPosition)
	if not castleWar.isInDominantGuild(cid) then
		doTeleportThing(cid, fromPosition)
		doCreatureSay(cid, "Você não faz parte da guild dominante do castelo.", TALKTYPE_ORANGE_1, false, cid)
		return false 
	end 
	return true
end