function onCastSpell(creature, var)
	local cid = creature:getId()
if not isMonster(cid) then return true end
if getCreatureName(cid) == "Devovorga" then
	if getDistanceBetween({x=83, y=726, z=10}, getCreaturePosition(cid)) > 11 then
		doSendMagicEffect(getCreaturePosition(cid), 38)
		doTeleportThing(cid, {x=83, y=726, z=10})
	end
	return true
end
if getDistanceBetween({x=943, y=427, z=8}, getCreaturePosition(cid)) > 8 then
	doSendMagicEffect(getCreaturePosition(cid), 1)
	doTeleportThing(cid, {x=940, y=431, z=8})
end
return true
end