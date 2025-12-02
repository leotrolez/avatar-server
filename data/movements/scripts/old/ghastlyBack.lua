function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, fromPosition, true)
		return false
	end
		doTeleportThing(cid, {x=262, y=830, z=5}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x=262, y=830, z=5}, CONST_ME_TELEPORT)
	return true
end