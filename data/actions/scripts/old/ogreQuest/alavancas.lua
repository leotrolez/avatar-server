local pilares = {[43897] = {{x=974, y=875, z=5}, {x=974, y=879, z=5}},
[43898] = {{x=979, y=883, z=5}, {x=983, y=883, z=5}},
[43899] = {{x=987, y=875, z=5}, {x=987, y=879, z=5}}
}

local function apagarFogos(item, actionid, itemPos)
	doTransformItem(getTileItemById(itemPos, 9825).uid, 9826)
	for i = 1, 2 do 
		local pos = pilares[actionid][i]
		local v = getTileItemById(pos, 1424).uid
		if v > 0 then
			doTransformItem(v, 1425)
			doSendMagicEffect(pos, 2)
		end
	end 
end 

local function acenderFogos(item, actionid)
	doTransformItem(item, 9825)
	for i = 1, 2 do 
		local pos = pilares[actionid][i]
		local v = getTileItemById(pos, 1425).uid
		if v > 0 then
			doTransformItem(v, 1424)
			doSendMagicEffect(pos, 15)
		end
	end 
end 


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 9826 then 
	  acenderFogos(item.uid, item.actionid)
	  addEvent(apagarFogos, 20*60*1000, item.uid, item.actionid, toPosition)
		return true
  end 
  return false 
end
