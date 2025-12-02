local function checkPlayer()
local specs = getSpectators({x=520, y=990, z=7}, 7, 7)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isPlayer(specs[i]) then 
				setPlayerStorageValue(specs[i], "outlawAccess", 2)
				doTeleportThing(specs[i], {x=526, y=938, z=7})
				doSendMagicEffect({x=526, y=938, z=7}, CONST_ME_TELEPORT)
			end 
		end 
	end 
	return false
end 

local function createGates()
	local basePos = {x=527, y=988, z=7}
	for i = 1, 4 do 
		local pos = {x=basePos.x, y=basePos.y+i, z=basePos.z}
		local v = getTileItemById(pos, 6735).uid
		if v > 0 then
			doTransformItem(v, 1546)
			doSendMagicEffect(pos, CONST_ME_POFF)
		end
	end 
end


function onDeath(cid, corpse, mostDamageKiller)
	checkPlayer()
	createGates()
	return true
end