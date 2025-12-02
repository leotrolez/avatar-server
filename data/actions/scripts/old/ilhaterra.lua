function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 1945 then 
		doTransformItem(item.uid, 1946)
		local pedra = getTileItemById({x=773, y=974, z=8}, 15793).uid
		local pedra1 = getTileItemById({x=773, y=975, z=8}, 15793).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end	
		if pedra1 > 0 then
			doRemoveItem(pedra1)
		end	
		return true
	else
		doTransformItem(item.uid, 1945)	
		doCreateItem(15793, 1, {x=773, y=974, z=8})
		doCreateItem(15793, 1, {x=773, y=975, z=8})
		return true
	end 
  return false 
end
