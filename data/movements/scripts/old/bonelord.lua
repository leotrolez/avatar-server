
function onStepIn(cid, item, position, fromPosition)
	if item.actionid == 62337 then 
		if fromPosition.y >= 600 then 
			doTeleportThing(cid, {x=586, y=479, z=8})
		else 
			doTeleportThing(cid, {x=1010, y=1190, z=6})
		end 
	else 
		if fromPosition.y >= 600 then 
			doTeleportThing(cid, {x=587, y=479, z=8})
		else 
			doTeleportThing(cid, {x=1011, y=1190, z=6})
		end 
	end 
	doSendMagicEffect(position, CONST_ME_TELEPORT)
	doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	return true
end