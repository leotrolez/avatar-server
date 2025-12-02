
function onStepIn(cid, item, position, fromPosition)
	local counter = getPlayerResets(cid)
	if type(counter) ~= "number" then
		counter = 0
	end
	if isPlayerPzLocked(cid) then
		doTeleportThing(cid, fromPosition, false)
      	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
		return false
	end
	if getPlayerLevel(cid) < 110 or counter < 50 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você precisa de Level 110+ e Paragon 50+ para entrar na Survival Quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else
		if getPlayerStorageValue(cid, "canPassPoiReward") == 1 then
			doTeleportThing(cid, {x=866, y=1142, z=8})	
			doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
			doSendMagicEffect(position, CONST_ME_TELEPORT)
		else
			doTeleportThing(cid, {x=802, y=1102, z=9})	
			doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
			doSendMagicEffect(position, CONST_ME_TELEPORT)
		end
	end 
	return true
end