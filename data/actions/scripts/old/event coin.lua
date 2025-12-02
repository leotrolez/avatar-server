function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.type <= 2 then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa de 3 event coins para transformar em 1 elemental coin.")
		return true
	end 
    doRemoveItem(item.uid, 3)
	doPlayerAddItem(cid, 11259, 1)
	doSendMagicEffect(getCreaturePosition(cid), 30)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você transformou 3 event coins em 1 elemental coin! Use o elemental coin para receber pontos no SHOP ONLINE.")
  return true
end
