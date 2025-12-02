local exitPos = {x=380,y=685,z=7}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  --if isPremium(cid) then
    doTeleportCreature(cid, exitPos, 10)
    --return true
  --else
    --sendBlueMessage(cid, getLangString(cid, WITHOUTPREMIUM, WITHOUTPREMIUMBR))
  --end

  return true
end