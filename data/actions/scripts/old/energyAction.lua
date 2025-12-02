local pilares = {[40293] = {{x=711, y=627, z=7}},
[40292] = {{x=710, y=627, z=7}},
[40291] = {{x=709, y=627, z=7}}
}

local function fecharPortao()
	local pos = {x=709, y=627, z=7}
	for y = -1, 0 do
		for x = 0, 2 do
			local posRemove = {x=pos.x+x, y=pos.y+y, z=pos.z}
			local v = getTileItemById(posRemove, 5071).uid
			if v <= 0 then
				doCreateItem(5071, 1, posRemove)
			end 
			v = getTileItemById(posRemove, 5070).uid
			if v <= 0 then
				doCreateItem(5070, 1, posRemove)
			end 
			doSendMagicEffect(posRemove, 11)
		end
	end
end

local function abrirPortao()
	local pos = {x=709, y=627, z=7}
	for y = -1, 0 do
		for x = 0, 2 do
			local posRemove = {x=pos.x+x, y=pos.y+y, z=pos.z}
			local v = getTileItemById(posRemove, 5070).uid
			if v > 0 then
				doRemoveItem(v)
			end 
			local vD = getTileItemById(posRemove, 5071).uid
			if vD > 0 then
				doRemoveItem(vD)
				doSendMagicEffect(posRemove, 11)
			end 
		end
	end
	addEvent(fecharPortao, 3*60*1000)
end



local function acenderFogos(actionid, toPos)
		local pos = pilares[actionid][1]
		local vT = getTileItemById(pos, 5071).uid
		if vT <= 0 then
			return true
		end 

		local v = getTileItemById(pos, 5070).uid
		if v > 0 then
			doRemoveItem(v)
			doSendMagicEffect(pos, 11)
			doSendMagicEffect(toPos, 11)
		end 
		for i = 1, 3 do 
			pos = pilares[40290+i][1]
			v = getTileItemById(pos, 5070).uid
			if v > 0 then
				return true
			end
		end 
		abrirPortao()
end 


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	 acenderFogos(item.actionid, toPosition)
	return true
end
