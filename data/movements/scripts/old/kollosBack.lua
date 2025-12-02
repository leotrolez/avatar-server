function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, fromPosition, true)
		return false
	end
		doTeleportThing(cid, {x=886, y=312, z=7}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x=886, y=312, z=7}, CONST_ME_TELEPORT)
	return true
end