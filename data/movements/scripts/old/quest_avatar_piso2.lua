local posStone = {x=691,y=320,z=10}


local function createStone()
		local st = getTileItemById(posStone, 1304)
		if st.itemid == 0 then
			doCreateItem(1304, posStone)
		end
	return true
end

local function removeStone()
	local st = getTileItemById(posStone, 1304)
		if st.uid > 0 then
			doRemoveThing(st.uid)
		end
	return true
end

function onStepIn(cid, item)
	if item.itemid == 426 then 
	 doTransformItem(item.uid, 425)
	end
	if isPlayer(cid) then
	 removeStone()
	end
	return true
end

function onStepOut(cid, item)
	if item.itemid == 425 then 
	 doTransformItem(item.uid, 426)
	end
	if isPlayer(cid) then 
	 createStone()
	end
	return true
end

