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
		removerPedras()
		addEvent(colocarPedras, 5*60*1000)
        sendBlueMessage(cid, getLangString(cid, "You now have only 5 minutes. Run!", "Você agora tem somente 5 minutos. Corra!"))
		return true
	end 
  return false 
end
