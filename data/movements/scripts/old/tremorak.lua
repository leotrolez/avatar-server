function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) and getCreatureName(cid) == "Tremorak" then 
		doSendMagicEffect(getCreaturePosition(cid), 45)
		doSendMagicEffect({x = 585, y = 24, z = 8}, 45)
		doTeleportThing(cid, {x = 585, y = 24, z = 8}, true)
		return false 
	end
	return true
end