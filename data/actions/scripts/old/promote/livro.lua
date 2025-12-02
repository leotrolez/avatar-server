function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	doTeleportThing(cid,  {x = 1162, y = 724, z = 10})
	doSendMagicEffect({x = 1162, y = 724, z = 10}, CONST_ME_TELEPORT)
return true
end