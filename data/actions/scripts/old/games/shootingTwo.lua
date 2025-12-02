local config = {
   enter = {x=509,y=337,z=8},
   exit = {x=507,y=337,z=8},
   clock = {x=511,y=333,z=8,time=60},
   totalPoses = registrePosesBetween({x=513,y=334,z=8}, {x=515,y=339,z=8}),
   nameQuest = "cidShootingTwo",
   isActive = false,
   maxLevel = 8,
   expBonus = 6, --esse valor multiplicado pelo nr de acertos
   expBase = 50, --valor que o player ganhará se ficar até o final
   magicEffectBird = 10, --magicEffect qdo passaro nasce
   msgStart = "You need shot in the bird as many times possible.",
   msgIfExit = "Sorry, you have lost this game.",
   msgIfWin = "Congratulations! You have killed %s birds in 60 seconds",
   magicEffectIfWin = 29,
   magicEffectIfLost = 2,
   canStart = true
}

local function doBird()
   local sortedPos = config.totalPoses[math.random(1, #config.totalPoses)]
   doSendMagicEffect(sortedPos, config.magicEffectBird)
   config.currentBird = doCreateMonster("Challenge Bird", sortedPos)
end

local function doGiantBow(position)
   if config.bowUids ~= nil then
      for x = 1, #config.bowUids do
         if isCreature(config.bowUids[x]) then
            doRemoveCreature(config.bowUids[x])
         end
      end
   end

   if position.x == 509 then
      if position.y == 334 then
         config.bowUids = {doCreateMonster("bow11", {x=position.x+2,y=position.y,z=position.z}), doCreateMonster("bow22", {x=position.x+3,y=position.y,z=position.z})}
      else
         config.bowUids = {doCreateMonster("bow11", {x=position.x+2,y=position.y,z=position.z}), doCreateMonster("bow22", {x=position.x+3,y=position.y,z=position.z}), doCreateMonster("bow33", {x=position.x+3,y=position.y-1,z=position.z})}
      end
   end      
end

local function doRemoveBird(monsterPos)
   if isCreature(config.currentBird) then
      config.birds = config.birds+1
      doSendAnimatedText(monsterPos, config.birds, COLOR_GREY)  
      doSendMagicEffect(monsterPos, 2) 
      doRemoveCreature(config.currentBird)
   end
end

local function reset()
   config.isActive = false
   config.canStart = true
   config.currentPlayer = nil
   config.timeLeft = 0
   config.birds = 0

   if config.currentBird then
      if isMonster(config.currentBird) then
         doRemoveCreature(config.currentBird)
      end
   end

   if config.bowUids ~= nil then
      for x = 1, #config.bowUids do
         if isCreature(config.bowUids[x]) then
            doRemoveCreature(config.bowUids[x])
         end
      end
   end

   config.currentBird = 0
   config.bowUids = {}
   doSetStorage(config.nameQuest, 0)
end

reset()

local function stop(isWin, exit)
   local cid = config.currentPlayer

   if isPlayer(cid) then
      if isWin and config.birds > 0 then
         local stringComplement = "."

         if getPlayerLevel(cid) < config.maxLevel then
            local expFormula = config.expBase+(config.birds*config.expBonus)
            doPlayerAddExperience(cid, expFormula)
            doSendAnimatedText(getPlayerPosition(cid), expFormula, TEXTCOLOR_WHITE)
            stringComplement = ", and you have gained "..expFormula.." points of experience."
         end

         sendBlueMessage(cid, string.format(config.msgIfWin, config.birds)..stringComplement)
         setMiniGameRank(cid, "Shooting The Bird", config.birds)
         addEvent(doSendMagicEffect, 100, config.exit, config.magicEffectIfWin)
      else
         sendBlueMessage(cid, config.msgIfExit)
         if not exit then
             addEvent(doSendMagicEffect, 100, config.exit, config.magicEffectIfLost)
         end
      end

      setPlayerStorageValue(cid, "hasActiveInQuest", -1)
      doTeleportThing(cid, config.exit, true)
   end

   zerarClock(config.clock)
   reset()
end

local function loopFast()
   if config.isActive then
      local cid = config.currentPlayer

      if isPlayer(cid) then
         if not isCreature(config.currentBird) then
            doBird()
         end
         doGiantBow(getThingPos(cid))
         addEvent(loopFast, 200)
      else
         stop()
      end
   end
end

local function loopSlow()
   local currentTime = os.time()

   if config.isActive then
      if getStorage(config.nameQuest) ~= config.currentPlayer then
         return stop()
      end

      if currentTime < config.timeLeft then
         local cid = config.currentPlayer

         if isCreature(cid) then
            local monsterPos, playerPos = getThingPos(config.currentBird), getThingPos(cid)

            if isCreature(config.currentBird) then
               if playerPos.y == monsterPos.y then
                  addEvent(doRemoveBird, 300, monsterPos)
               end
            end
            doSendDistanceShoot({x=playerPos.x+2,y=playerPos.y,z=playerPos.z}, {x=playerPos.x+6,y=playerPos.y,z=playerPos.z}, CONST_ANI_BOLT)
         else
            stop()
         end
         clockWork(config.clock, config.timeLeft)
         addEvent(loopSlow, 1000)
      else
         stop(true)
      end
   end
end

local function start(cid)
   if isPlayer(cid) then
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, config.msgStart)
      config.isActive = true
      config.currentPlayer = cid
      config.timeLeft = os.time()+config.clock.time
      doTeleportThing(cid, config.enter, true)
      doSetStorage(config.nameQuest, cid)
      registerPlayerInQuest({player = cid, posExit = config.exit, globalStorage = config.nameQuest, cannotMoveItems = true})
      doBird()
      loopFast()
      loopSlow()
   end
end


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
   if not config.isActive then
      if isPlayerPzLocked(cid) then
         doPlayerSendCancel(cid, "You cannot start the chellenge with battle active.")
         return true
      end
      if not config.canStart then
         doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
         return true
      end
      setCreatureNoMoveTime(cid, 500)
      doTransformItem(item.uid, 1224)
      doTeleportThing(cid, fromPosition, true)
      config.canStart = false
      addEvent(start, 300, cid)
   else
      if cid == config.currentPlayer then
         setCreatureNoMoveTime(cid, 500)
         doTransformItem(item.uid, 1224)
         doTeleportThing(cid, fromPosition, true)
         addEvent(stop, 300, false, true)   
      else
         doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
      end
   end

   return true
end