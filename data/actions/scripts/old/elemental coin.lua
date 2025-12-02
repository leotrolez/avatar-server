function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doRemoveItem(item.uid, 1)
	db.executeQuery("UPDATE accounts SET premium_points = premium_points + 1 where name = '" .. getPlayerAccount(cid) .. "'")
	doSendMagicEffect(getCreaturePosition(cid), 30)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você usou uma elemental coin, seu saldo agora é: "..getPlayerCoins(cid)..".")
  return true
end
