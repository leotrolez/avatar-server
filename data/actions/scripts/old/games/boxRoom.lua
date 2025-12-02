local MyLocal = {}

MyLocal.price = 100
MyLocal.posEnter = {x=510,y=335,z=9}
MyLocal.posExit = {x=513,y=333,z=9}
MyLocal.isActive = false
MyLocal.roomReady = true
MyLocal.currentPlayer = 0
MyLocal.avaliableTiles = {}
MyLocal.boxUids = {}
MyLocal.trueDoll = 10306
MyLocal.maxBoxs = 132
MyLocal.boxId = 1739
MyLocal.timeLeft = 0
MyLocal.topLeftPosition = {x=505,y=335,z=9}
MyLocal.underRightPosition = {x=515,y=337,z=9}
MyLocal.clockPosition = {x=505,y=334,z=9}
MyLocal.timeInSeconds = 120 --max 120 se nao buga
doSetStorage("cidBoxGame", 0)
doSetStorage("timeLeftBoxGame", 0)
addEvent(zerarClock, 3000, MyLocal.clockPosition)

local function clean(pos)
  pos.stackpos = 1
  local itemid = getThingfromPos(pos).itemid
  doCleanTile(pos)  

  if itemid == clockParts["0"] then
      doCreateItem(clockParts["0"], pos)
  elseif itemid == clockParts[":"] then
      doCreateItem(clockParts[":"], pos)
  end
  
  doSendMagicEffect(pos, 2)
end

local function clearBoxArea()
      local topLeftPosition = {x=505,y=334,z=9}
      local underRightPosition = {x=515,y=337,z=9}
      local number = 1
      for x = topLeftPosition.x, underRightPosition.x do
          for y = topLeftPosition.y, underRightPosition.y do
              addEvent(clean, 100*number, {x=x,y=y,z=9})   
              number = number+1
          end
      end
end

local function isRoomReady(seila)
  MyLocal.roomReady = true
end

local function stopBoxGame(remPlayer)
      local cid = getStorage("cidBoxGame")
      MyLocal.timeLeft = 0
      MyLocal.currentPlayer = 0
      doSetStorage("cidBoxGame", 0)
      doSetStorage("timeLeftBoxGame", 0)
      if remPlayer == nil then
         doTeleportThing(cid, MyLocal.posExit)
      end
      if isPlayer(cid) then
        setPlayerStorageValue(cid, "hasActiveInQuest", -1)
      end
      MyLocal.isActive = false
      addEvent(isRoomReady, 5000, true)
      zerarClock(MyLocal.clockPosition)
      clearBoxArea()
      MyLocal.roomReady = false
end

local function putBoxinArea()
  local randomTrueDoll = math.random(1, MyLocal.maxBoxs)
  for x = MyLocal.topLeftPosition.x, MyLocal.underRightPosition.x do
      for y = MyLocal.topLeftPosition.y,  MyLocal.underRightPosition.y do
         table.insert(MyLocal.avaliableTiles, {x = x, y = y, z = 9, amount = 0})
      end
  end
  for boxes = 1, MyLocal.maxBoxs do
    local container = nil
    for currentTile = 1, #MyLocal.avaliableTiles do
      if MyLocal.avaliableTiles[currentTile].amount < 4 then
        container = doCreateItem(MyLocal.boxId, 1, MyLocal.avaliableTiles[currentTile])
        MyLocal.avaliableTiles[currentTile].amount = MyLocal.avaliableTiles[currentTile].amount+1
        break
      end    
    end
    if randomTrueDoll == boxes then
      doAddContainerItem(container, MyLocal.trueDoll, 1)
    end
  end
  return true
end

local function startBoxGame(cid)
      MyLocal.isActive = true
      MyLocal.currentPlayer = cid
      putBoxinArea()
      doTeleportThing(cid, MyLocal.posEnter)
      MyLocal.timeLeft = os.time()+MyLocal.timeInSeconds
      registerPlayerInQuest({player = cid, posExit = MyLocal.posExit, globalStorage = "cidBoxGame"}) --{player, posExit, globalStorage}
      doSetStorage("cidBoxGame", cid)
      doSetStorage("timeLeftBoxGame", os.time()+MyLocal.timeInSeconds)
      doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You need to find the real doll inside the boxs in 2 minutes.")
end

local function loopBoxGame()
      if MyLocal.isActive == true then
         clockWork(MyLocal.clockPosition, MyLocal.timeLeft)
         if getStorage("cidBoxGame") ~= MyLocal.currentPlayer and MyLocal.isActive == true then
            stopBoxGame(false)
            return true   
         end
         local currentTime = os.time()
         if MyLocal.timeLeft <= currentTime then
            sendBlueMessage(MyLocal.currentPlayer, "Your time is up, try again!")
            stopBoxGame()
            return true  
         end
         addEvent(loopBoxGame, 1000, nil)
      end
end

local function addZeroToString(string)
      if string <= 60 then
         if string < 10 then
            return "0"..string
         else
            return string
         end
      else
         string = string-60
         if string < 10 then
            return "01 minute(s) and 0"..string
         else
            return "01 minute(s) and "..string
         end
      end
end
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
         if item.itemid == MyLocal.trueDoll then
            if cid == getStorage("cidBoxGame") then
               local timeSpent = MyLocal.timeInSeconds-(getStorage("timeLeftBoxGame")-os.time())
               sendBlueMessage(cid, "Congratulations, you won! You have completed the challenge in "..addZeroToString(timeSpent).." second(s), and received 1000 points of experience plus 50 gold coins.")
               setMiniGameRank(cid, "Find The Doll", timeSpent)
               doPlayerAddItem(cid, 2148, 50)
               doPlayerAddExp(cid, 1000)
               doRemoveItem(item.uid, 1)
               stopBoxGame()
               doSendMagicEffect(getCreaturePosition(cid), 29)
               doSendAnimatedText(getPlayerPosition(cid), 1000, TEXTCOLOR_WHITE)
            else
               sendBlueMessage(cid, "This item belongs to a challenge and was removed.")
               doRemoveItem(item.uid, 1)
            end
            return true
         end
         if not(isPlayer(getThingfromPos({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z, stackpos=253}).uid)) then
            doPlayerSendCancel(cid, "You need to be in correct position to start the challenge.")
            return true
         end
         if getPlayerGUID(getThingfromPos({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z, stackpos=253}).uid) == getPlayerGUID(cid) then
              if MyLocal.roomReady == false then
                  doPlayerSendCancel(cid, "Wait a minute to get the room ready.")
                  return true
              end
              if MyLocal.isActive == true then
                  doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
                  return true   
              end
              if isPlayerPzLocked(cid) or isPlayerBattle(cid) then
                  doPlayerSendCancel(cid, "You cannot start the chellenge with battle active.")
                  return true
              end
              if doPlayerRemoveMoney(cid, MyLocal.price) == true then
                if item.itemid == 1945 then
                   doTransformItem(item.uid, 1946)
                else
                   doTransformItem(item.uid, 1945)
                end
                addEvent(loopBoxGame, 1000, nil)
                startBoxGame(cid)
              else
                sendBlueMessage(cid, "You don't have enough money.")
              end
         else   
            doPlayerSendCancel(cid, "You need to be in correct position to start the challenge.")
         end  
         return true
end