local alavancas = {{x=894, y=167, z=10}, {x=869, y=138, z=9}}

local function colocarPedras()
	for i = 1, 2 do 
		local pos = alavancas[i]
		local v = getTileItemById(pos, 1946).uid
		if v > 0 then
			doTransformItem(v, 1945)
		end
	end 

	doCreateItem(1304, 1, {x=897, y=162, z=10})
	doSendMagicEffect({x=897, y=162, z=10}, 34)
end 

local function removerPedras()
	for i = 1, 2 do 
		local pos = alavancas[i]
		local v = getTileItemById(pos, 1945).uid
		if v > 0 then
			doTransformItem(v, 1946)
		end
	end 
	local pedra = getTileItemById({x=897, y=162, z=10}, 1304).uid
	if pedra > 0 then
		doRemoveItem(pedra)
	end	
	doSendMagicEffect({x=897, y=162, z=10}, CONST_ME_POFF)
end 


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 1945 then 
		removerPedras()
		addEvent(colocarPedras, 3*60*1000)
		return true
	end 
  return false 
end
