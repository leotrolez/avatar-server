local frases = {""}

local function checkZuko()
local specs = getSpectators({x=730, y=374, z=12}, 30, 30)
local haveLost = 0
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and not isSummon(specs[i]) then 
				--doRemoveCreature(specs[i])
				haveLost = 1
			end 
		end 
	end 
	if haveLost == 0 then 
		doCreateMonster("Lost Avatar", {x=730, y=369, z=12})
	end 
end 



function onStepIn(cid, item, position, fromPosition)
		checkZuko()
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doTeleportThing(cid, {x=730, y=374, z=12})
		doSendMagicEffect({x=730, y=374, z=12}, CONST_ME_TELEPORT)
	return true
end