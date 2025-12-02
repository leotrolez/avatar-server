function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	for i, v in pairs(bloodconfig.premios) do
		doPlayerAddItem(cid, i, v)
	end
	doTeleportThing(cid, bloodconfig.templo)
	sendBlueMessage(cid, "Parabéns por ter resistido! Você ganhou 4 event tokens, 60000 gps e 2 life crystal.")
	doSendMagicEffect(getCreaturePosition(cid), 29)
	return true
end