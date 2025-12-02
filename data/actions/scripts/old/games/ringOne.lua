local function doPurifyPlayer(cid)
    local conditions = {CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_LIFEDRAIN, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_DRUNK}
    for x = 1, #conditions do
		if (hasCondition(cid, conditions[x])) then 
			doRemoveCondition(cid, conditions[x])
		end
	end
end 

local MyLocal = {}
doSetStorage("cidOneInRingOne", 0)
doSetStorage("cidTwoInRingOne", 0)
MyLocal.isActive = false
MyLocal.minLevel = 30
MyLocal.timeLeft = 0
MyLocal.timeInSeconds = 300
MyLocal.currentPlayers = {}
MyLocal.playerOneName = nil
MyLocal.playerTwoName = nil

MyLocal.enterOne = {x=505,y=326,z=8, stackpos=253}
MyLocal.enterTwo = {x=507,y=326,z=8, stackpos=253}
MyLocal.enterOnePos = {x=503,y=325,z=8}
MyLocal.enterTwoPos = {x=509,y=325,z=8}
MyLocal.exitPosOne = {x=508,y=330,z=8}
MyLocal.exitPosTwo = {x=508,y=331,z=8}
MyLocal.clockPosition = {x=504,y=320,z=8}
addEvent(zerarClock, 3000, MyLocal.clockPosition)



local function stopFightArenaOne() 
      MyLocal.currentPlayers = {}

      local cid1, cid2 = getStorage("cidOneInRingOne"), getStorage("cidTwoInRingOne")
      doSetStorage("cidOneInRingOne", 0)
      doSetStorage("cidTwoInRingOne", 0)

      if isPlayer(cid1) then
         setPlayerStorageValue(cid1, "hasActiveInQuest", -1)
         doCreatureAddHealth(cid1, getCreatureMaxHealth(cid1)-getCreatureHealth(cid1))
      end

      if isPlayer(cid2) then
         setPlayerStorageValue(cid2, "hasActiveInQuest", -1)
         doCreatureAddHealth(cid2, getCreatureMaxHealth(cid2)-getCreatureHealth(cid2))
      end

      MyLocal.isActive = false
      MyLocal.timeLeft = 0
      MyLocal.playerOneName = nil
      MyLocal.playerTwoName = nil
      zerarClock(MyLocal.clockPosition)
end

local function stopFightArenaTied()
      doSendAnimatedText(getCreaturePosition(getStorage("cidOneInRingOne")), "Tied!", COLOR_GREY)
      doSendAnimatedText(getCreaturePosition(getStorage("cidTwoInRingOne")), "Tied!", COLOR_GREY)
      doTeleportThing(getStorage("cidOneInRingOne"), MyLocal.exitPosOne, false)
      doTeleportThing(getStorage("cidTwoInRingOne"), MyLocal.exitPosTwo, false)
      stopFightArenaOne()
end

local function addZeroToString(string)
      if string <= 60 then
         if string < 10 then
            return "0"..string.." second(s)"
         else
            return string.." second(s)"
         end
      elseif string <= 120 then
         string = string-60
         if string < 10 then
            return "01 minute(s) and 0"..string.." second(s)"
         else
            return "01 minute(s) and "..string.." second(s)"
         end
      elseif string <= 180 then
         string = string-120
         if string < 10 then
            return "02 minute(s) and 0"..string.." second(s)"
         else
            return "02 minute(s) and "..string.." second(s)"
         end
      elseif string <= 240 then
         string = string-180
         if string < 10 then
            return "03 minute(s) and 0"..string.." second(s)"
         else
            return "03 minute(s) and "..string.." second(s)"
         end
      elseif string <= 300 then
         string = string-240
         if string < 10 then
            return "04 minute(s) and 0"..string.." second(s)"
         else
            return "04 minute(s) and "..string.." second(s)"
         end
      end
end

local function stopFightArenaOnePlayerOneWin()
      local timeSpent = MyLocal.timeInSeconds-(MyLocal.timeLeft-os.time())
      doTeleportThing(getStorage("cidOneInRingOne"), MyLocal.exitPosOne, false)
      doSendAnimatedText(getCreaturePosition(getStorage("cidOneInRingOne")), "Winner!", COLOR_GREY)
	  doPurifyPlayer(getStorage("cidOneInRingOne"))
      doPlayerSetPzLocked(getStorage("cidOneInRingOne"), false)
      sendBlueMessage(getStorage("cidOneInRingOne"), "You won the battle! You have beat "..MyLocal.playerTwoName.." in "..addZeroToString(timeSpent).." on the ring.")
      doSendMagicEffect(getCreaturePosition(getStorage("cidOneInRingOne")), 29)
      stopFightArenaOne()
end

local function stopFightArenaOnePlayerTwoWin()
      local timeSpent = MyLocal.timeInSeconds-(MyLocal.timeLeft-os.time())
      doTeleportThing(getStorage("cidTwoInRingOne"), MyLocal.exitPosTwo, false)
      doSendAnimatedText(getCreaturePosition(getStorage("cidTwoInRingOne")), "Winner!", COLOR_GREY)
	  doPurifyPlayer(getStorage("cidTwoInRingOne"))
      doPlayerSetPzLocked(getStorage("cidTwoInRingOne"), false)
      sendBlueMessage(getStorage("cidTwoInRingOne"), "You won the battle! You have beat "..MyLocal.playerOneName.." in "..addZeroToString(timeSpent).." on the ring.")
      doSendMagicEffect(getCreaturePosition(getStorage("cidTwoInRingOne")), 29)
      stopFightArenaOne()
end

local function startFightArenaOne(cid1, cid2)
      MyLocal.currentPlayers = {cid1, cid2}
      doSetStorage("cidOneInRingOne", cid1)
      doSetStorage("cidTwoInRingOne", cid2)
      registerPlayerInQuest({player = cid1, posExit = MyLocal.exitPosOne, globalStorage = "cidOneInRingOne", cannotMoveItems = true})
      registerPlayerInQuest({player = cid2, posExit = MyLocal.exitPosTwo, globalStorage = "cidTwoInRingOne", cannotMoveItems = true})
      MyLocal.isActive = true
      doSendMagicEffect(getCreaturePosition(cid1), 2)
      doSendMagicEffect(getCreaturePosition(cid2), 2)
      doTeleportThing(cid1, MyLocal.enterOnePos, false)
      doTeleportThing(cid2, MyLocal.enterTwoPos, false)
      MyLocal.timeLeft = os.time()+MyLocal.timeInSeconds
      MyLocal.playerOneName = getCreatureName(cid1)
      MyLocal.playerTwoName = getCreatureName(cid2)
      doSendMagicEffect(getCreaturePosition(cid1), 10)
      doSendMagicEffect(getCreaturePosition(cid2), 10)
      
end

local function loopRingOne()
      if MyLocal.isActive == true then
         clockWork(MyLocal.clockPosition, MyLocal.timeLeft)
         if MyLocal.currentPlayers[1] ~= getStorage("cidOneInRingOne") then
            stopFightArenaOnePlayerTwoWin()
            return true
         elseif MyLocal.currentPlayers[2] ~= getStorage("cidTwoInRingOne") then
            stopFightArenaOnePlayerOneWin()
            return true     
         end
         if MyLocal.timeLeft <= os.time() then
            sendBlueMessage(MyLocal.currentPlayers[1], "Sorry, the time is up!")
            sendBlueMessage(MyLocal.currentPlayers[2], "Sorry, the time is up!")
            stopFightArenaTied()
            return true   
         end
         addEvent(loopRingOne, 1000, nil)   
      end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if getThingfromPos(MyLocal.enterOne).uid > 0 and getThingfromPos(MyLocal.enterTwo).uid > 0 then
            
        local cidOne = getThingfromPos(MyLocal.enterOne).uid
        local cidTwo = getThingfromPos(MyLocal.enterTwo).uid
        
        if isPlayer(cidOne) and isPlayer(cidTwo) then
            if MyLocal.isActive == true then
                doPlayerSendCancel(cid, "The ring is in use, try again later.")
                return true
            end

            if getPlayerParty(cidOne) or getPlayerParty(cidTwo) then
                doPlayerSendCancel(cid, "Party not allowed here.")
            end
               
            if getPlayerLevel(cidOne) >= MyLocal.minLevel and getPlayerLevel(cidTwo) >= MyLocal.minLevel then
                if item.itemid == 1945 then
                    doTransformItem(item.uid, 1946)
                else
                    doTransformItem(item.uid, 1945)
                end
                  
                startFightArenaOne(cidOne, cidTwo)
                addEvent(loopRingOne, 1000, nil)   
            else
                doPlayerSendCancel(cid, "The two must have a level greater than "..MyLocal.minLevel..".")
            end
        else
            doPlayerSendCancel(cid, "To start the fight two players are needed.")
        end
    else
        doPlayerSendCancel(cid, "To start the fight two players are needed.")
    end
    
    return true
end