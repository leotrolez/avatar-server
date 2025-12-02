local pilares = {[39246] = {{x=310, y=836, z=12}, {x=311, y=836, z=12}, {x=312, y=836, z=12}, {x=313, y=836, z=12}, {x=314, y=836, z=12}},
[39245] = {{x=308, y=838, z=12}, {x=308, y=839, z=12}, {x=308, y=840, z=12}, {x=308, y=841, z=12}}
}
local gateId = {[39246] = {9486}, [39245] = {9532}}


local function acenderFogos(actionid)
	for i = 1, #pilares[actionid] do 
		local pos = pilares[actionid][i]
		local v = getTileItemById(pos, gateId[actionid][1]).uid
		if v == 0 then
			doCreateItem(gateId[actionid][1], 1, pos)
			doSendMagicEffect(pos, CONST_ME_POFF)
		end
	end 
end 

local function apagarFogos(actionid)
	local apagou = 0
	for i = 1, #pilares[actionid] do 
		local pos = pilares[actionid][i]
		local v = getTileItemById(pos, gateId[actionid][1]).uid
		if v > 0 then
			doRemoveItem(v)
			doSendMagicEffect(pos, CONST_ME_POFF)
			apagou = 1
		end
	end 
	if apagou == 1 then 
		addEvent(acenderFogos, 5*60*1000, actionid)
	end
end 



function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	apagarFogos(item.actionid)
	doPlayerSendCancel(cid, "The gates are now open.")
	return true
end
