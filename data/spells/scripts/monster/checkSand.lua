function onCastSpell(creature, var)
	local cid = creature:getId()
	if not isMonster(cid) then return true end
	if getDistanceBetween({x=922, y=279, z=9}, getCreaturePosition(cid)) > 35 then
		doSendMagicEffect(getCreaturePosition(cid), 34)
		doTeleportThing(cid, {x=922, y=279, z=9})
	end
	return true
end