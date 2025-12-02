function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local hp = -(getCreatureMaxHealth(cid)*(0.5))
	if item.itemid == 8046 then
		doTeleportThing(cid, {x=131, y=848, z=7})
		doCreatureAddHealth(cid, hp)
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	end
  	return false 
end