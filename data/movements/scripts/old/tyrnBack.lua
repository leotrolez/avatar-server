function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, {x = 544, y = 620, z = 12}, true)
		return false 
	end
		doTeleportThing(cid, {x = 535, y = 644, z = 11}, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect({x = 535, y = 644, z = 11}, CONST_ME_TELEPORT)
	return true
end