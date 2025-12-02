local MyLocal = {}

function onStepIn(cid, item, position, fromPosition)
         if isPlayer(cid) then
            doTeleportThing(cid, toPosition, false)
         end
  return true
end
