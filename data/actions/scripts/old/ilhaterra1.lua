function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 1945 then 
		doTransformItem(item.uid, 1946)
		local pedra = getTileItemById({x=849, y=994, z=10}, 17109).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end
		return true
	else
		doTransformItem(item.uid, 1945)	
		doCreateItem(17109, 1, {x=849, y=994, z=10})
		return true
	end 
  return false 
end
