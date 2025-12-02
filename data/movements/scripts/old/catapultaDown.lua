local MyLocal = {}

function onStepIn(cid, item, position, fromPosition)
  local currentPos = getCreaturePosition(cid)
  if item.actionid == 58880 then
    doTeleportCreature(cid, {x=currentPos.x+1,y=currentPos.y,z=7}, 2)
  else
    doTeleportCreature(cid, {x=currentPos.x,y=currentPos.y+1,z=7}, 2)
  end
  return true
end
