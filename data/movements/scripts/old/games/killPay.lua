local MyLocal = {}

function onStepIn(cid, item, position, fromPosition)
         if isPlayer(cid) then
            doTeleportThing(cid, fromPosition, false)
         end
  return true
end

function onStepOut(cid, item, position, fromPosition)
         if not(isPlayer(cid)) then
           if getCreatureMaster(cid) ~= cid then
             return false
           end
            doTeleportThing(cid, fromPosition, false)
         end
   return true
end
