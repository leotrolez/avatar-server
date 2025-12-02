local pilares = {[43897] = {{x=974, y=875, z=5}, {x=974, y=879, z=5}},
[43898] = {{x=979, y=883, z=5}, {x=983, y=883, z=5}},
[43899] = {{x=987, y=875, z=5}, {x=987, y=879, z=5}}
}

local function canEnter()
	for i = 1, 3 do 
		local pos = pilares[43896+i][1]
		local v = getTileItemById(pos, 1425).uid
		if v > 0 then
			return false
		end
	end 
	return true
end 

function onStepIn(cid, item, position, fromPosition)
	if not canEnter() then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Não foi possível fazer a conexão. Verifique se todas as fogueiras estão acesas!", TALKTYPE_ORANGE_1, false, cid)
		return false
	else
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doTeleportThing(cid, {x=981, y=850, z=6})	
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	end 
	return true
end