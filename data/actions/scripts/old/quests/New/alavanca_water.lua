local cf = {storage = 487547, effect = 10}
local stones = {
	{id = 1304, pos = {x=493,y=602,z=9}},
	{id = 1304, pos = {x=493,y=603,z=9}},
}


local function createStones()
	for i,v in pairs (stones) do
		local st = getTileItemById(v.pos, v.id)
		if st.itemid == 0 then
			doCreateItem(v.id, v.pos)
		end
	end
	return true
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local restante = getStorage(cf.storage) - os.time()
		if restante > 0 then 
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você precisa esperar "..restante.." segundo(s) para que as pedras possam ser removidas novamente.")
		return true 
		end
	for i,v in pairs (stones) do
		local st = getTileItemById(v.pos, v.id)
		if st.uid > 0 then
			doRemoveThing(st.uid)
		end
	end
	doSetStorage(cf.storage, os.time()+60)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Corra! As pedras foram removidas por um período de 1 minuto.")
	doSendMagicEffect(getCreaturePosition(cid), cf.effect)
	addEvent(createStones, 60 * 1000)
	return true
end