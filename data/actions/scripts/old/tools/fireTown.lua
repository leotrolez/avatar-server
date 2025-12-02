function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local getPlayerTemple = getPlayerTown(cid)
  if getPlayerTemple == 5 then
    doPlayerSendCancel(cid, "You're already a citizen of Fire Nation Capital.")
  else
    sendBlueMessage(cid, "Now you're a Fire Nation Capital citizen.")
	doPlayerSetTown(cid, 5)
  end
  return true
end