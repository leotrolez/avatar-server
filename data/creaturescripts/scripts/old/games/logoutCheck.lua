function onLogout(cid)
      local storageActive = getPlayerStorageValue(cid, "hasActiveInQuest")

      if storageActive == 1 then
            doTeleportCreature(cid, getPosInStorage(cid, "genericQuestPos"), 10)     
            setPlayerStorageValue(cid, "hasActiveInQuest", -1)
            doSetStorage(getPlayerStorageValue(cid, "genericQuestString"), 0)
      end
      return true
end

--[[function onLogout(cid)
         ---shooting one game----
         local shootingGameOne = {
               posExit = {x=505,y=337,z=8},
               externalCid = getStorage("cidShootingOne")
         }
         if shootingGameOne.externalCid == cid then
            doTeleportThing(cid, shootingGameOne.posExit)
            doSetStorage("cidShootingOne", 0)
         end
         ---shooting two game----
         local shootingGameTwo = {
               posExit = {x=507,y=337,z=8},
               externalCid = getStorage("cidShootingTwo")
         }
         if shootingGameTwo.externalCid == cid then
            doTeleportThing(cid, shootingGameTwo.posExit)
            doSetStorage("cidShootingTwo", 0)
         end
         ---killAndPay----
         if getPlayerStorageValue(cid, "inKillPayRoomNorth") == 1 then
            local position = getCreaturePosition(cid)
            local newPosition = {x=position.x,y=position.y+2,z=position.z}
            doTeleportThing(cid, newPosition, false)
            setPlayerStorageValue(cid, "inKillPayRoomNorth", 0)
         elseif getPlayerStorageValue(cid, "inKillPayRoomSouth") == 1 then
            local position = getCreaturePosition(cid)
            local newPosition = {x=position.x,y=position.y-2,z=position.z}
            doTeleportThing(cid, newPosition, false)
            setPlayerStorageValue(cid, "inKillPayRoomSouth", 0)
         end
         ---boxRoomGame----
         if getStorage("cidBoxGame") == cid then
            local boxRoom = {
                  posExit = {x=513,y=333,z=9},
                  dollId = 10306
            }
            doTeleportThing(cid, boxRoom.posExit, false)
            doPlayerRemoveItem(cid, boxRoom.dollId, 1)
            doSetStorage("cidBoxGame", 0)
         end
         ---ringone---
         local ringOne = {
               exitPosOne = {x=509,y=327,z=8},
               exitPosTwo = {x=510,y=327,z=8},
         }
         if getStorage("cidOneInRingOne") == cid then
            doTeleportThing(cid, ringOne.exitPosOne, false)
            doSetStorage("cidOneInRingOne", 0)
         elseif getStorage("cidTwoInRingOne") == cid then
            doTeleportThing(cid, ringOne.exitPosTwo, false)
            doSetStorage("cidTwoInRingOne", 0)    
         end 
         ---ringtwo---
         local ringTwo = {
               exitPosOne = {x=511,y=327,z=8},
               exitPosTwo = {x=512,y=327,z=8},
         }
         if getStorage("cidOneInRingTwo") == cid then
            doTeleportThing(cid, ringTwo.exitPosOne, false)
            doSetStorage("cidOneInRingTwo", 0)
         elseif getStorage("cidTwoInRingTwo") == cid then
            doTeleportThing(cid, ringTwo.exitPosTwo, false)
            doSetStorage("cidTwoInRingTwo", 0)    
         end
         ---kill the beast one--
         if getStorage("cidPlayerOne") == cid then
            local killTheBeastOne = {posExit = {x=505,y=327,z=9}}
            doTeleportThing(cid, killTheBeastOne.posExit, false)
            doSetStorage("cidPlayerOne", 0)    
         end
         ---kill the beast two--
         if getStorage("cidPlayerTwo") == cid then
            local killTheBeastTwo = {posExit = {x=517,y=327,z=9}}
            doTeleportThing(cid, killTheBeastTwo.posExit, false)
            doSetStorage("cidPlayerTwo", 0)    
         end
         --snake game--
         if getStorage("cidSnakeGame") == cid then
            local snake = {posExit = {x=508,y=337,z=10}}
            doTeleportThing(cid, snake.posExit, false)
            doSetStorage("cidSnakeGame", 0) 
         end

         -- genius game --
         local geniusPos = {x=510,y=331,z=8}
         if getStorage("geniusGame1") == cid then
            doSetStorage("geniusGame1", 1)
            doTeleportThing(cid, geniusPos)

         elseif getStorage("geniusGame2") == cid then
            doSetStorage("geniusGame2", 1)
            doTeleportThing(cid, geniusPos)

         elseif getStorage("geniusGame3") == cid then
            doSetStorage("geniusGame3", 1)
            doTeleportThing(cid, geniusPos)
         end

   return true
end--]]