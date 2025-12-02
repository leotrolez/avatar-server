function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if not isInPz(cid) then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa estar em uma zona de proteção (pz) para remover o skull.")
		return true 
	end 
	if getCreatureSkullType(cid) ~= 4 then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você não possui red skull para ser removida.")
		return true 
	end 
	if getPlayerStorageValue(cid, "ativoBot") == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa responder ao Anti-Bot primeiro.")
		return true 
	end
    doRemoveItem(item.uid, 1)
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
	doCreatureSetSkullType(cid, 0)
	doPlayerSetSkullEnd(cid, 0, SKULL_RED)
	local pid = getPlayerGUID(cid)
	doRemoveCreature(cid)
	 db.executeQuery("UPDATE players SET skulltime = 0 WHERE id = ".. pid ..";")
	db.executeQuery("UPDATE `killers` SET `unjustified` = 0 WHERE `id` IN (SELECT `kill_id` FROM `player_killers` WHERE `player_id` = " .. pid .. ")")
  return true
end
