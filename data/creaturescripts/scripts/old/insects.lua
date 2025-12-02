function onDeath(cid, corpse, mostDamageKiller)
	local poisonPos = {x=115, y=312, z=9}
	local v = getTileItemById(poisonPos, 1490).uid
	if v > 0 then
		doRemoveItem(v)
		addEvent(doCreateItem, 1*60*1000, 1490, 1, poisonPos)
	end
	return true
end