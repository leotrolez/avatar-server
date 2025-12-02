local const = {
     exitPos = {x=510,y=331,z=8},
     enterPos = {x=491,y=322,z=8},
     storageName = "geniusGame1",
     possiblesDir = {{dir = EAST, eff = 34}, {dir = WEST, eff = 15}, {dir = NORTH, eff = 86}, {dir = SOUTH, eff = 77}},
     isOpen = false,
     baseMoney = 20
}

local function reset()
      const.clockPos = {x=const.enterPos.x-1,y=const.enterPos.y-2,z=8}
      const.totalArea = registrePosesBetween({x=const.enterPos.x-1,y=const.enterPos.y-1,z=const.enterPos.z}, {x=const.enterPos.x+1,y=const.enterPos.y+1,z=const.enterPos.z})
      const.currentPlayer = nil
      const.timeLeft = 0
      const.pos = {}
      const.totalTime = 0
      const.sequences = {}
      const.isOpen = false
      const.currentPlayerSequence = 0
      doSetStorage(const.storageName, 0)
end

reset()

local function stop()
      local player = getStorage(const.storageName)
      local number = 0

      if #const.sequences-1 > 0 then
            number = #const.sequences-1
            setMiniGameRank(player, "Genius", number)
      end

      if isCreature(player) then
            setPlayerStorageValue(player, "hasActiveInQuest", -1)
            doPlayerAddMoney(player, number*const.baseMoney) 
            sendBlueMessage(player, "You lose! You have survived per "..getSecsString(os.time()-const.totalTime).." and you did "..number.." correct sequences.")
            doCreatureSetNoMove(const.currentPlayer, false)
            doTeleportCreature(player, const.exitPos, 10)
      end

      for x = 1, #const.totalArea do
            doCleanTile(const.totalArea[x])
            doSendMagicEffect(const.totalArea[x], 2)
      end
      reset()
end

local function sendEffect(pos, eff, isFinal, initialTime)
      if const.isOpen == false or initialTime ~= const.totalTime then
            return
      end

      if pos and eff then
            doSendMagicEffect(pos, eff)
      end

      if isFinal then
            if isPlayer(const.currentPlayer) then
                  doCreatureSetNoMove(const.currentPlayer, false)
            end
            const.timeLeft = os.time()+(3*(#const.sequences+1))
      end
end

local function getPosDir(pos, dir)
      if dir == NORTH then
            return {x=pos.x,y=pos.y-1,z=pos.z}
      elseif dir == SOUTH then
            return {x=pos.x,y=pos.y+1,z=pos.z}
      elseif dir == EAST then
            return {x=pos.x+1,y=pos.y,z=pos.z}  
      elseif dir == WEST then
            return {x=pos.x-1,y=pos.y,z=pos.z}
      end 
end

local function randomizeNewSequence()
      const.timeLeft = false
      const.currentPlayerSequence = 1
      local forWorked = 0

      if isPlayer(const.currentPlayer) then
            doCreatureSetNoMove(const.currentPlayer, true)
      end

      for counter = 1, #const.sequences+1 do
            if const.sequences[counter] == nil then
                  local tableDir = const.possiblesDir[math.random(1, 4)]
                  local position, effect = getPosDir(const.enterPos, tableDir.dir), tableDir.eff
                  table.insert(const.sequences, {position = position, effect = effect})
                  addEvent(sendEffect, 1000*counter, position, effect, nil, const.totalTime)
            else
                  addEvent(sendEffect, 1000*counter, const.sequences[counter].position, const.sequences[counter].effect, nil, const.totalTime)
            end
         forWorked = forWorked+1
      end
      addEvent(sendEffect, 1000*forWorked, false, false, true, const.totalTime)
end

local function loop()
      if const.isOpen then
            if const.currentPlayer ~= getStorage(const.storageName) then
                  stop()
                  return true
            end

            if const.timeLeft == false then
                  sendTimesOnAnimatedText(const.clockPos, "Wait!", true)
            else
                  local currentTime = os.time()
                  if currentTime > const.timeLeft then
                        stop()
                        return true
                  else
                        sendTimesOnAnimatedText(const.clockPos, const.timeLeft)   
                  end
            end
            addEvent(loop, 1000, nil)
      end
end

local function start(cid)
      const.isOpen = true
      const.totalTime = os.time()
      const.currentPlayer = cid
      registerPlayerInQuest({player = cid, posExit = const.exitPos, globalStorage = const.storageName, cannotMoveItems = true})
      doSetStorage(const.storageName, cid)
      randomizeNewSequence()
      loop()
end

function onStepIn(cid, item, position, fromPosition)
      if item.actionid == 4972 then
            if not const.isOpen then
                  start(cid)
            end
      else
            if const.isOpen == false or const.currentPlayer ~= cid then
                  return true
            end
            local currentSequence = const.currentPlayerSequence
            
            if const.sequences[currentSequence] ~= nil then
                  if comparePoses(const.sequences[currentSequence].position, position) then
                        doSendMagicEffect(const.sequences[currentSequence].position, const.sequences[currentSequence].effect)
                        const.currentPlayerSequence = currentSequence+1
                        if const.sequences[const.currentPlayerSequence] == nil then
                              randomizeNewSequence()      
                        end
                        doTeleportThing(cid, fromPosition)
                  else
                        stop()  
                  end
            end
      end
      return true
end


