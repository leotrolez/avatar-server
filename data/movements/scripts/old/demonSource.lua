local function checkZuko()
local specs = getSpectators({x=187, y=1027, z=8}, 20, 20)
local haveLost = 0
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and not isSummon(specs[i]) then 
				haveLost = 1
			end 
		end 
	end 
	if haveLost == 0 then 
		local boss = doCreateMonster("Retching Horror", {x=187, y=1027, z=8})
	end 
end 



function onStepIn(cid, item, position, fromPosition)
	if getPlayerStorageValue(cid, "demonAccess") == 1 then
		checkZuko()
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doTeleportThing(cid, {x=185, y=1017, z=8})
		doSendMagicEffect({x=185, y=1017, z=8}, CONST_ME_TELEPORT)
	else
		doTeleportThing(cid, {x=180, y=1065, z=6}, true)
		doCreatureSay(cid, "Você não possui permissão para entrar.", TALKTYPE_ORANGE_1, false, cid)
		return false
	end
	return true
end