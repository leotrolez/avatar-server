local alavancas = {{x=758, y=557, z=8}, {x=769, y=550, z=9}}
local stones = {{x=767, y=555, z=9},{x=768, y=555, z=9}}

local function colocarPedras()
	for i = 1, 2 do 
		local pos = alavancas[i]
		local v = getTileItemById(pos, 1946).uid
		if v > 0 then
			doTransformItem(v, 1945)
		end
		doCreateItem(1304, 1, stones[i])
	end 
end 

local function removerPedras()
	for i = 1, 2 do 
		local pos = alavancas[i]
		local v = getTileItemById(pos, 1945).uid
		if v > 0 then
			doTransformItem(v, 1946)
		end
		local pedra = getTileItemById(stones[i], 1304).uid
		if pedra > 0 then
			doRemoveItem(pedra)
			doSendMagicEffect(stones[i], 34)
		end	
	end 
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
