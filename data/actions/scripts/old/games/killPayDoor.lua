local MyLocal = {}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
         if item.actionid == 10253 then
            if getThingfromPos({x=fromPosition.x,y=fromPosition.y-1,z=fromPosition.z, stackpos=253}).uid > 0 and getPlayerStorageValue(cid, "inKillPayRoomNorth") <= 0 then
               doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
            else
               if getPlayerStorageValue(cid, "inKillPayRoomNorth") == 1 then
                   doTransformItem(item.uid, 5106)
                   doTeleportThing(cid, fromPosition, true)
                   addEvent(doTeleportThing, 200, cid, {x=fromPosition.x,y=fromPosition.y+1,z=fromPosition.z}, true)
                   setPlayerStorageValue(cid, "inKillPayRoomNorth", 0)
               else
                  if isPlayerPzLocked(cid)  then
                     doPlayerSendCancel(cid, "You cannot enter here with battle active.")
                     return true
                  end
                  doTransformItem(item.uid, 5106)
                  doTeleportThing(cid, fromPosition, true)
                  addEvent(doTeleportThing, 200, cid, {x=fromPosition.x,y=fromPosition.y-1,z=fromPosition.z}, true)
                  setPlayerStorageValue(cid, "inKillPayRoomNorth", 1) 
               end    
            end
         end
         if item.actionid == 10254 then
            if getThingfromPos({x=fromPosition.x,y=fromPosition.y+1,z=fromPosition.z, stackpos=253}).uid > 0 and getPlayerStorageValue(cid, "inKillPayRoomSouth") <= 0 then
               doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
            else
               if getPlayerStorageValue(cid, "inKillPayRoomSouth") == 1 then
                   doTransformItem(item.uid, 5106)
                   doTeleportThing(cid, fromPosition, true)
                   addEvent(doTeleportThing, 200, cid, {x=fromPosition.x,y=fromPosition.y-1,z=fromPosition.z}, true)
                   setPlayerStorageValue(cid, "inKillPayRoomSouth", 0)
               else
                  if isPlayerPzLocked(cid) then
                     doPlayerSendCancel(cid, "You cannot enter here with pz locked.")
                     return true
                  end
                  doTransformItem(item.uid, 5106)
                  doTeleportThing(cid, fromPosition, true)
                  addEvent(doTeleportThing, 200, cid, {x=fromPosition.x,y=fromPosition.y+1,z=fromPosition.z}, true)
                  setPlayerStorageValue(cid, "inKillPayRoomSouth", 1) 
               end    
            end        
         end
         return true
end