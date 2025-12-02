function onDeath(cid, corpse, mostDamageKiller)
	local energyPos = {x=1118, y=1204, z=7}
	local v = getTileItemById(energyPos, 5070).uid
		if v > 0 then
			doRemoveItem(v)
		end
		--doCreateTeleport(1387, {x=970, y=911, z=8}, {x=1028, y=929, z=9})
	return true
end