local stones = {
	{id = 1304, pos = {x=493,y=602,z=9}},
	{id = 1304, pos = {x=493,y=603,z=9}},
}


local function createStones()
	for i,v in pairs (stones) do
		local st = getTileItemById(v.pos, v.id)
		if st.itemid >= 0 then
			doCreateItem(v.id, v.pos)
		end
	end
	return true
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	for i,v in pairs (stones) do
		local st = getTileItemById(v.pos, v.id)
		if st.itemid > 0 then
			doRemoveThing(st.uid)
		end
	end
	
	addEvent(createStones, 1* 60 * 1000)
	return true
end