function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local getPlayerTemple = getPlayerTown(cid)
  if getPlayerTemple == 3 then
    doPlayerSendCancel(cid, "You're already a citizen of South Air Temple.")
  else
    sendBlueMessage(cid, "Now you're a South Air Temple citizen.")
	doPlayerSetTown(cid, 3)
  end
  return true
end