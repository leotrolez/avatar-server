function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local fromPosition = (getCreaturePosition(cid))
	local toPosition = getThingPos(item.uid)
        if fromPosition.x < toPosition.x then
		doTeleportThing(cid, {x=toPosition.x+1, y=toPosition.y, z=toPosition.z}) 
	else
		doTeleportThing(cid, {x=toPosition.x-1, y=toPosition.y, z=toPosition.z})
	end 
	doSendMagicEffect(getCreaturePosition(cid), 10)
	return true
end