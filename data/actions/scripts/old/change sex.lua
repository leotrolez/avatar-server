function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if not getTileInfo(getCreaturePosition(cid)).protection then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "É necessário estar em uma zona protegida (PZ) para trocar de sexo.")
		return false 
	end 
	local sexId = getPlayerSex(cid)
	local newSex = 0
	if sexId == 0 then 
		newSex = 1
	end
	doRemoveItem(item.uid, 1)
	doPlayerSetSex(cid, newSex)
	doSendMagicEffect(getCreaturePosition(cid), 28)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você trocou o sexo de seu personagem!")
	addEvent(doRemoveCreature, 1*1000, cid, true)
  return true
end
