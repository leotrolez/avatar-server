function onStepIn(cid, item, position, fromPosition)
      local creatureDir = getDirectionTo(fromPosition, position)
      local more = 1
      
      if creatureDir == SOUTH or creatureDir == EAST then
            more = 2
      end

      local newPosition = getPositionByDirection(position, creatureDir, more)
      doTeleportCreature(cid, {x=newPosition.x,y=newPosition.y,z=newPosition.z-1}, 10)
end