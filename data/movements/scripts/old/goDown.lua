function onStepIn(cid, item, position, fromPosition)
  local newPos = {x=position.x,y=position.y,z=position.z+1}
  
 -- if getPlayerCanWalk({player = cid, position = newPos}) then
    doTeleportThing(cid, newPos)
 -- end
  return true
end