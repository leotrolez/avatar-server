local function colocarPedras()
	local v = getTileItemById({x=1195, y=666, z=10}, 1946).uid
	if v > 0 then
		doTransformItem(v, 1945)
	end

	doCreateItem(1547, 1, {x=1192, y=656, z=8})
	doSendMagicEffect({x=1192, y=656, z=8}, 34)
end 

local function removerPedras()
	local v = getTileItemById({x=1195, y=666, z=10}, 1945).uid
	if v > 0 then
		doTransformItem(v, 1946)
	end
	local pedra = getTileItemById({x=1192, y=656, z=8}, 1547).uid
	if pedra > 0 then
		doRemoveItem(pedra)
	end	
	doSendMagicEffect({x=1192, y=656, z=8}, CONST_ME_POFF)
end 


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 1945 then 
		doTransformItem(item.uid, 1946)	
		doCreateItem(1546, 1, {x=1114, y=640, z=9})
		local pedra = getTileItemById({x=1132, y=628, z=8}, 1547).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end	
		return true
	else
		doTransformItem(item.uid, 1945)	
		doCreateItem(1547, 1, {x=1132, y=628, z=8})
		local pedra = getTileItemById({x=1114, y=640, z=9}, 1546).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end	
		return true
	end 
  return false 
end
