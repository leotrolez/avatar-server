local function checkPlayer()
local specs = getSpectators({x=730, y=374, z=12}, 30, 30)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isPlayer(specs[i]) then 
				doTeleportThing(specs[i], {x=730, y=378, z=13})
				doSendMagicEffect({x=730, y=378, z=13}, CONST_ME_TELEPORT)
			end 
		end 
	end 
	return false
end 

function onDeath(cid, corpse, mostDamageKiller)
	checkPlayer()
	return true
end