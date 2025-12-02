function onStepIn(cid, item, position, fromPosition)
	local newpos = {x=558, y=315, z=9}
	if fromPosition.z > position.z then 
		doTeleportThing(cid, newpos, false) 
	elseif fromPosition.z == position.z then 
		doTeleportThing(cid, {x=position.x, y=position.y, z=position.z+1})
	end	
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_WATERSPLASH)
  return true
end