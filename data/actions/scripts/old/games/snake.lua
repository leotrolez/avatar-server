local MyLocal = {}
MyLocal.enterPos = {x=505,y=343,z=10}
MyLocal.exitPos = {x=508,y=337,z=10}
MyLocal.totalPoses = registrePosesBetween({x=496,y=339,z=10}, {x=515,y=347,z=10})
MyLocal.clockPosition = {x=500,y=338,z=10}
MyLocal.outfit = {lookType = 311, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0}
MyLocal.objetiveIds = {6022, 6083}
MyLocal.levelMin = 50
MyLocal.time = 30
doSetStorage("cidSnakeGame", 0)

local function loopEffectCorpse()
   if MyLocal.isOpen == true then
      doSendMagicEffect(MyLocal.objetivePos, 32)
   end
   addEvent(loopEffectCorpse, 1000, nil)
end
addEvent(loopEffectCorpse, 1000, nil)

local function randomizeObjetive()
   MyLocal.timeLeft = os.time()+MyLocal.time
   local posToCreate = MyLocal.totalPoses[math.random(1, #MyLocal.totalPoses)]
   MyLocal.objetivePos = posToCreate
   doCreateItem(MyLocal.objetiveIds[math.random(1, #MyLocal.objetiveIds)], posToCreate)
end

local function resetSnake()
   MyLocal.playerSpeed = 1000
   MyLocal.isOpen = false
   MyLocal.currentPlayer = 0
   MyLocal.timeLeft = 0
   MyLocal.totalTime = 0
   MyLocal.snakesNumber = 0
   MyLocal.objetivePos = {}
   MyLocal.totalNpcs = {}
end
resetSnake()

local function getTimeInStringInternalSnake(time)
    interval = time
    timeTable = {}
    timeTable.hour = math.floor(interval/(60*60))
    timeTable.minute = math.floor((math.fmod(interval, 60*60))/60) 
    timeTable.second = math.fmod(math.fmod(interval, 60*60),60) 
    for i, v in pairs(timeTable) do
      if tostring(v):len() < 2 then
         timeTable[i] = "0"..timeTable[i]
       end
    end
    return timeTable
end

local function stopSnake(logout)
   if #MyLocal.totalNpcs > 1 then
      for x = 2, #MyLocal.totalNpcs do
         doRemoveCreature(MyLocal.totalNpcs[x].cid)
      end
   end
   clearItemsArea(MyLocal.totalPoses, {MyLocal.objetiveIds[1], MyLocal.objetiveIds[2]})
   if logout == nil and isPlayer(MyLocal.currentPlayer) then
      setPlayerStorageValue(MyLocal.currentPlayer, "hasActiveInQuest", -1)
      doSetStorage("cidSnakeGame", 0)
      doSendMagicEffect(getCreaturePosition(MyLocal.currentPlayer), 2)
      doTeleportThing(MyLocal.currentPlayer, MyLocal.exitPos)
      doSendMagicEffect(getCreaturePosition(MyLocal.currentPlayer), 29)
      doCreatureSetNoMove(MyLocal.currentPlayer, false)
      setPlayerStorageValue(MyLocal.currentPlayer, "playerCanMoveDirection", 0)
      local minute, second = getTimeInStringInternalSnake(os.time()-MyLocal.totalTime).minute, getTimeInStringInternalSnake(os.time()-MyLocal.totalTime).second
      if tonumber(minute) > 0 then
         sendBlueMessage(MyLocal.currentPlayer, "Congratulations, you have survived for "..minute.." minute(s) and "..second.." second(s), and you have consumed "..((#MyLocal.totalNpcs)-1).." bodies.")
      else
         sendBlueMessage(MyLocal.currentPlayer, "Congratulations, you have survived for "..second.." second(s), and you have consumed "..((#MyLocal.totalNpcs)-1).." bodies.") 
      end
      setMiniGameRank(MyLocal.currentPlayer, "Zumbi Snake", ((#MyLocal.totalNpcs)-1))
   end
   clockDraw(MyLocal.clockPosition, "00:00")
   resetSnake()
end

local function getCreatureDir(oldPos, newPos)
    if oldPos.y-newPos.y == -1 then
      return SOUTH
    elseif oldPos.y-newPos.y == 1 then
      return NORTH
    elseif oldPos.x-newPos.x == 1 then
      return WEST
    elseif oldPos.x-newPos.x == -1 then
      return EAST
    else
      return 25
    end
end

local function internalSnakeMove(cid, direction)
   local newPosition = getPositionByDirection(getCreaturePosition(cid), direction, 1)

   if isWalkable(newPosition, nil, nil, nil, nil, true) and getThingfromPos({x=newPosition.x,y=newPosition.y,z=newPosition.z,stackpos=253}).uid == 0 and doMoveCreature(cid, direction, FLAG_NOLIMIT) == 0 then
      return true
   else
      return false
   end
end

local function snakeLoop()
   if MyLocal.isOpen == true and getStorage("cidSnakeGame") == MyLocal.currentPlayer then
      MyLocal.totalNpcs[1].oldPos = getCreaturePosition(MyLocal.currentPlayer)
      doSetCreatureOutfit(MyLocal.currentPlayer, MyLocal.outfit, 1000)
      local playerSpeed = getCreatureSpeed(MyLocal.currentPlayer)

      if not internalSnakeMove(MyLocal.currentPlayer, getCreatureLookDir(MyLocal.currentPlayer)) then
         stopSnake()
      else
         local currentPos = getCreaturePosition(MyLocal.currentPlayer)
         if removeTileItemById(currentPos, MyLocal.objetiveIds[1]) or removeTileItemById(currentPos, MyLocal.objetiveIds[2]) then
            local posToNpcBorn = MyLocal.totalNpcs[#MyLocal.totalNpcs].oldPos
            local newNpcUid = doCreateNpc("Zumbie", posToNpcBorn)
            doCreatureSetNoMove(newNpcUid, true)
            doChangeSpeed(newNpcUid, playerSpeed)
            --doSendAnimatedText(getCreaturePosition(newNpcUid), #MyLocal.totalNpcs, COLOR_RED) 
            doSetCreatureOutfit(newNpcUid, MyLocal.outfit)
            doSendMagicEffect(posToNpcBorn, 10)
            table.insert(MyLocal.totalNpcs, {cid=newNpcUid, oldPos=getCreaturePosition(newNpcUid)})
            randomizeObjetive()   
         end
      end
      if #MyLocal.totalNpcs > 1 then
         for x = 2, #MyLocal.totalNpcs do
            local snakePlayer = MyLocal.totalNpcs[x].cid
            MyLocal.totalNpcs[x].oldPos = getCreaturePosition(snakePlayer)
            internalSnakeMove(snakePlayer, getCreatureDir(MyLocal.totalNpcs[x].oldPos, MyLocal.totalNpcs[x-1].oldPos))
         end
      end
   else
      if getStorage("cidSnakeGame") ~= MyLocal.currentPlayer then
         stopSnake(true)
      end
   end
   addEvent(snakeLoop, MyLocal.playerSpeed-(#MyLocal.totalNpcs*20), nil)
end
addEvent(snakeLoop, 3000, nil)

local function workClockSnake()
   if MyLocal.isOpen == true then
      local currentTime = os.time()
      if MyLocal.timeLeft < currentTime then
         stopSnake()
      else
         clockWork(MyLocal.clockPosition, MyLocal.timeLeft)
      end
   end
   addEvent(workClockSnake, 1000, nil)
end
addEvent(workClockSnake, 3000, nil)

local function startSnake(cid)
   MyLocal.isOpen = true
   MyLocal.currentPlayer = cid
   doSetStorage("cidSnakeGame", cid)
   registerPlayerInQuest({player = cid, posExit = MyLocal.exitPos, globalStorage = "cidSnakeGame", cannotMoveItems = true})
   table.insert(MyLocal.totalNpcs, {cid = cid, pos = getCreaturePosition(cid)})
   MyLocal.totalTime = os.time()
   doSendMagicEffect(getCreaturePosition(cid), 2)
   doTeleportThing(cid, MyLocal.enterPos)
   doSendMagicEffect(getCreaturePosition(cid), 10)
   doCreatureSetNoMove(cid, true)
   doSetCreatureOutfit(cid, MyLocal.outfit, 1000)
   randomizeObjetive(true)
   doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You need consume the bodies to create your Zumbie Army, you have "..MyLocal.time.." seconds to consume each body.")
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
   local possiblePlayer = getThingfromPos({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z,stackpos=253}).uid
   
   if isPlayer(possiblePlayer) then
      if getPlayerGUID(possiblePlayer) ~= getPlayerGUID(cid) then
         doPlayerSendCancel(cid, "You need to be in correct position to start the challenge.")
         return true
      end
      if getPlayerLevel(cid) < MyLocal.levelMin then
         doPlayerSendCancel(cid, "Sorry, you need have level "..MyLocal.levelMin.." or more to start this challenge.")
         return true   
      end
      if MyLocal.isOpen == true then
         doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
         return true
      end
      if isPlayerPzLocked(cid) or isPlayerBattle(cid) then
         doPlayerSendCancel(cid, "You cannot start the chellenge with battle active.")
         return true
      end
      setPlayerStorageValue(cid, "playerCanMoveDirection", os.time()+60*60*3)
      startSnake(cid)
      doTransformLever(item)
   else
      doPlayerSendCancel(cid, "You need to be in correct position to start the challenge.") 
      return true
   end
end

--[[
local snake = createQuest("snakeGame")
local tableInfos = {
   enterPos = {x=505,y=343,z=10},
   exitPos = {x=508,y=337,z=10},
   totalPoses = registrePosesBetween({x=496,y=339,z=10}, {x=515,y=347,z=10}),
   clock = {x=500,y=338,z=10, time=30},
   outfit = {lookType = 311, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0},
   objetiveIds = {6022, 6083},
   playerSpeed = 1000,
   levelMin = 50
}

local function randomizeObjetive()
   tableInfos.timeLeft = os.time()+tableInfos.clock.time
   local posToCreate = MyLocal.tableInfos[math.random(1, #MyLocal.tableInfos)]
   tableInfos.objetivePos = posToCreate
   doCreateItem(tableInfos.objetiveIds[math.random(1, #tableInfos.objetiveIds)], posToCreate)
end

local function internalSnakeMove(cid, direction)
   local newPosition = getPositionByDirection(getCreaturePosition(cid), direction)

   if isWalkable(newPosition) and getThingfromPos({x=newPosition.x,y=newPosition.y,z=newPosition.z,stackpos=253}).uid == 0 and doMoveCreature(cid, direction) then
      return true
   else
      return false
   end
end

local function loopSnakeWalk()
   if snake:hasOpened() then
      local cid = tableInfos.currentPlayer
      if isCreature(cid) then
         if not internalSnakeMove(cid, getCreatureLookDir(cid)) then
            snake:stop()
         else
            local currentPos = getCreaturePosition(MyLocal.currentPlayer)
            if removeTileItemById(currentPos, MyLocal.objetiveIds[1]) or removeTileItemById(currentPos, MyLocal.objetiveIds[2]) then
               local posToNpcBorn = MyLocal.totalNpcs[#MyLocal.totalNpcs].oldPos
               local newNpcUid = doCreateNpc("Zumbie", posToNpcBorn)
               doCreatureSetNoMove(newNpcUid, true)
               doChangeSpeed(newNpcUid, playerSpeed)
               doSetCreatureOutfit(newNpcUid, MyLocal.outfit)
               doSendMagicEffect(posToNpcBorn, 10)
               table.insert(MyLocal.totalNpcs, {cid=newNpcUid, oldPos=getCreaturePosition(newNpcUid)})
               randomizeObjetive()   
            end
            if #tableInfos.totalNpcs > 1 then
               for x = 2, #tableInfos.totalNpcs do
                  local snakePlayer = tableInfos.totalNpcs[x].cid
                  tableInfos.totalNpcs[x].oldPos = getCreaturePosition(snakePlayer)
                  internalSnakeMove(snakePlayer, getCreatureDir(tableInfos.totalNpcs[x].oldPos, tableInfos.totalNpcs[x-1].oldPos))
               end
            end
         end
      end
      snake:addEvent(loopSnakeWalk, tableInfos.playerSpeed-(#tableInfos.totalNpcs*20), nil)
   end
end

local function executeAllPlayerCommands(cid)
   if isCreature(cid) then
      doTeleportCreature(cid, tableInfos.exitPos, 10)
      doCreatureSetNoMove(cid, false)
   end
end

snake:setResetFunction(
function()
   doSetStorage("cidSnakeGame", 0)
   tableInfos.currentPlayer = nil
   tableInfos.timeLeft = 0
   tableInfos.timeStarted = 0
   tableInfos.totalNpcs = {}
   tableInfos.objetivePos = nil
end)

snake:setStopFunction(
function()
   local cid = tableInfos.currentPlayer
   executeAllPlayerCommands(cid)
end)

snake:setStartFunction(
function(cid)
   tableInfos.currentPlayer = cid
   tableInfos.timeLeft = os.time()+tableInfos.clock.time
   tableInfos.timeStarted = os.time()
   doSetStorage("cidSnakeGame", cid)
   doTeleportCreature(cid, tableInfos.enterPos, 10)
   doCreatureSetNoMove(cid, true)
   loopSnakeWalk()
end)

snake:setLoopFunction(
function()
   if tableInfos.timeLeft <= os.time() then
      snake:stop()
   else
      if tableInfos.currentPlayer ~= getStorage("cidSnakeGame", 0) then
         snake:stop()
      else
         clockWork(tableInfos.clock, tableInfos.timeLeft)
      end
   end
end, 1000)

snake:loop()

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
      snake:start(cid)
      return true
end--]]