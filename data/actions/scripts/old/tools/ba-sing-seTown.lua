local MyLocal = {}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local getPlayerTemple = getPlayerTown(cid)
  if getPlayerTemple == 1 then
    doPlayerSendCancel(cid, "You're already a citizen of Ba Sing Se.")
  else
    sendBlueMessage(cid, "Now you're a Ba Sing Se citizen.")
	doPlayerSetTown(cid, 1)
    --doTeleportThing(cid, getTownTemplePosition(1), 10)
  end
  return true
end
