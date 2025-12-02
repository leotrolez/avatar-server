function onDeath(cid, corpse, mostDamageKiller)
	local remover = false
	local energyPos = getCreaturePosition(cid)
    if isMonster(cid) then
		if string.lower(getCreatureName(cid)) == string.lower("Flaming Rarod") then
			remover = true
			energyPos = {x=925, y=871, z=7}
		elseif string.lower(getCreatureName(cid)) == string.lower("Swamp Rarod") then
			remover = true
			energyPos = {x=979, y=943, z=7}
		elseif string.lower(getCreatureName(cid)) == string.lower("Frozen Rarod") then
			remover = true
			energyPos = {x=1052, y=858, z=7}
		end
    end
	if remover then 
		local v = getTileItemById(energyPos, 1491).uid
		if v > 0 then
			doRemoveItem(v)
			addEvent(doCreateItem, 1*60*1000, 1491, 1, energyPos)
		end
	end 
	return true
end