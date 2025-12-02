function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, fromPosition, true)
		return false
	end
		doTeleportThing(cid, {x = 491, y = 747, z = 12}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x = 491, y = 747, z = 12}, CONST_ME_TELEPORT)
	return true
end