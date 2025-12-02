function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 1945 then 
		doTransformItem(item.uid, 1946)	
		doCreateItem(1547, 1, {x=367, y=957, z=8})
		doCreateItem(1547, 1, {x=370, y=957, z=8})
		local pedra = getTileItemById({x=364, y=960, z=8}, 1546).uid
		local pedra1 = getTileItemById({x=364, y=963, z=8}, 1546).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end	
		if pedra1 > 0 then
			doRemoveItem(pedra1)
		end	
		return true
	else
		doTransformItem(item.uid, 1945)	
		doCreateItem(1546, 1, {x=364, y=960, z=8})
		doCreateItem(1546, 1, {x=364, y=963, z=8})
		local pedra = getTileItemById({x=367, y=957, z=8}, 1547).uid
		local pedra1 = getTileItemById({x=370, y=957, z=8}, 1547).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end	
		if pedra1 > 0 then
			doRemoveItem(pedra1)
		end	
		return true
	end 
  return false 
end
