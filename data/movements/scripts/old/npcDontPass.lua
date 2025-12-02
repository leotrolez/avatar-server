function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
  if isNpc(cid) then
    doTeleportThing(cid, fromPosition, false)
  end
  return true
end