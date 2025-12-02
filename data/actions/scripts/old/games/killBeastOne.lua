local MyLocal = {}

doSetStorage("cidBeastOne", 0)
doSetStorage("cidPlayerOne", 0)
MyLocal.currentPlayer = 0
MyLocal.currentMonster = 0
MyLocal.posPlayerEnter = {x=505,y=323,z=9}
MyLocal.posPlayerExit = {x=505,y=327,z=9}
MyLocal.posMonster = {x=510,y=323,z=9}
MyLocal.clockPosition = {x=505,y=320,z=9}
MyLocal.price = 1000
MyLocal.isActive = false
MyLocal.timeLeft = 0
MyLocal.timeInSeconds = 120



local function startGameBeast(cid)
      doSendMagicEffect(getCreaturePosition(cid), 2)
      doTeleportThing(cid, MyLocal.posPlayerEnter, false)
      doSendMagicEffect(getCreaturePosition(cid), 10)
      MyLocal.currentPlayer = cid
      MyLocal.currentMonster = doCreateMonster("challenge destroyer e", MyLocal.posMonster)
      doSendMagicEffect(MyLocal.posMonster, 10)
      MyLocal.isActive = true
      registerPlayerInQuest({player = cid, posExit = MyLocal.posPlayerExit, globalStorage = "cidPlayerOne", cannotMoveItems = true})
      doSetStorage("cidBeastOne", MyLocal.currentMonster)
      doSetStorage("cidPlayerOne", cid)
      MyLocal.timeLeft = os.time()+MyLocal.timeInSeconds
end

local function addZeroToString(string)
      if string <= 60 then
         if string < 10 then
            return "0"..string.." second(s)"
         else
            return string.." second(s)"
         end
      else
         string = string-60
         if string < 10 then
            return "01 minute(s) and 0"..string.." second(s)"
         else
            return "01 minute(s) and "..string.." second(s)"
         end
      end
end

local function stopGameBeast(remPlayer, remMonster, win)
      if remPlayer == true then
         doSendMagicEffect(getCreaturePosition(MyLocal.currentPlayer), 2)
         doTeleportThing(MyLocal.currentPlayer, MyLocal.posPlayerExit)
      end
      if remMonster == true then
         if MyLocal.currentMonster > 0 then
             doSendMagicEffect(getCreaturePosition(MyLocal.currentMonster), 2)
             doRemoveCreature(MyLocal.currentMonster)
         end
      end
      if win == true then
         local timeSpent = MyLocal.timeInSeconds-(MyLocal.timeLeft-os.time())
         doPlayerAddItem(MyLocal.currentPlayer, 2148, 50)
         doPlayerAddItem(MyLocal.currentPlayer, 2152, 2)
         doPlayerAddExp(MyLocal.currentPlayer, 5000)
         doSendMagicEffect(getCreaturePosition(MyLocal.currentPlayer), 29)
         doSendAnimatedText(getCreaturePosition(MyLocal.currentPlayer), 5000, TEXTCOLOR_WHITE)
         setMiniGameRank(MyLocal.currentPlayer, "Kill The Beast Easy", timeSpent)
         sendBlueMessage(MyLocal.currentPlayer, "Congratulations, you won! You have completed the challenge in "..addZeroToString(timeSpent)..", and received 5000 points of experience plus 250 gold coins.")
      end
      if isPlayer(MyLocal.currentPlayer) then
        setPlayerStorageValue(MyLocal.currentPlayer, "hasActiveInQuest", -1)
      end
      MyLocal.currentPlayer = 0
      MyLocal.currentMonster = 0
      MyLocal.isActive = false
      MyLocal.timeLeft = 0
      doSetStorage("cidBeastOne", 0)
      doSetStorage("cidPlayerOne", 0)
      zerarClock(MyLocal.clockPosition)
end

local function loopGameBeast()
      if MyLocal.isActive == true then
         clockWork(MyLocal.clockPosition, MyLocal.timeLeft)
         if getStorage("cidPlayerOne") ~= MyLocal.currentPlayer then
            stopGameBeast(false, true, false)
            return true
         end
         if getStorage("cidBeastOne") ~= MyLocal.currentMonster then
            stopGameBeast(true, false, true)
            return true
         end
         if MyLocal.timeLeft <= os.time() then
            sendBlueMessage(MyLocal.currentPlayer, "Your time is up, try again!")
            stopGameBeast(true, true, false)
            return true   
         end
         addEvent(loopGameBeast, 1000, nil)
      end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
         if not(isPlayer(getThingfromPos({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z, stackpos=253}).uid)) then
            doPlayerSendCancel(cid, "You need to be in correct position to start the challenge.")
            return true
         end
         if getPlayerGUID(getThingfromPos({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z, stackpos=253}).uid) == getPlayerGUID(cid) then
            if MyLocal.isActive == true then
                doPlayerSendCancel(cid, "Sorry the room is in use, wait please.")
                return true
            end
            if isPlayerPzLocked(cid) then
                doPlayerSendCancel(cid, "You cannot start the chellenge with battle active.")
                return true
            end
            if doPlayerRemoveMoney(cid, MyLocal.price) == true then
                if item.itemid == 1945 then
                   doTransformItem(item.uid, 1946)
                else
                   doTransformItem(item.uid, 1945)
                end
                addEvent(loopGameBeast, 1000, nil)
                startGameBeast(cid)
            else
               sendBlueMessage(cid, "You don't have enough money.")
            end
         else   
            doPlayerSendCancel(cid, "You need to be in correct position to start the challenge.")
         end
   return true
end