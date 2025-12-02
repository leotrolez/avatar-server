local function checkPlayer()
local specs = getSpectators({x=187, y=1027, z=8}, 20, 20)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isPlayer(specs[i]) then 
				setPlayerStorageValue(specs[i], "demonAccess", 2)
				doTeleportThing(specs[i], {x=181, y=1060, z=6})
				doSendMagicEffect({x=181, y=1060, z=6}, CONST_ME_TELEPORT)
			end 
		end 
	end 
	return false
end 


function onDeath(cid, corpse, mostDamageKiller)
	checkPlayer()
	return true
end