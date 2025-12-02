local spellName = "earth control"
local cf = {atk = spellsInfo[spellName].atk}


local MyLocal = {}
MyLocal.jumps = 10
MyLocal.walkTime = 500
MyLocal.playersCanUse = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*3.6)
    local max = (level+(magLevel/4)*3.9)
  if getPlayerInWaterWithUnderwater(cid) then 
    min = min*0.6
	max = max*0.6
  end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local arr = {
{0, 3, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local function removeTable(cid)
  if isCreature(cid) then
    MyLocal.playersCanUse[cid] = nil
	if getDobrasLevel(cid) >= 11 then
		doPlayerAddExaust(cid, "earth", "control", earthExausted.control-6)
	else
		doPlayerAddExaust(cid, "earth", "control", earthExausted.control)
	end
  end
end

local function moveTarget(cid, pos, jumps, countInPlayer) 
  local jumps = jumps or 0
  local target = 0
  local countInPlayer = countInPlayer or 0

  if not isCreature(cid) then
    return false
  end

  local playerDir = getCreatureLookDirection(cid)
  local playerPos = getCreaturePosition(cid)
  local target = getCreatureTarget(cid)

  local effectPos, newPos = pos or playerPos, nil


  if getDistanceBetween(playerPos, effectPos) > 7 or not isWalkable(effectPos) then
    removeTable(cid)
    return false
  end

  if countInPlayer >= 5 then
    removeTable(cid)
    return false
  end
  
  if getTileInfo(effectPos).protection or getTileInfo(effectPos).house then
      removeTable(cid)
    return false
  end

  if jumps > MyLocal.jumps or getCreatureNoMove(cid) then
    removeTable(cid)
    return false
  end
  
  if target > 0 then
    local targetPos = getCreaturePosition(target)
    newPos = getPoses(effectPos, targetPos)

    if newPos == true then
      if isPlayer(target) then
        countInPlayer = countInPlayer+1
      end
    
      newPos = getPosByDir(playerDir, targetPos)
    if  not getCreatureNoMove(target) then
      doPushCreature(target, newPos, nil, nil, true)
      setCreatureNoMoveTime(target, MyLocal.walkTime-1)
      doPlayerCancelFollow(target)
    end 

      doCombat(cid, combat, numberToVariant(target))
      newPos = getCreaturePosition(target)
    else
      newPos = newPos[1]
    end
  else
    newPos = getPosByDir(effectPos, playerDir)
    effectPos.stackpos = 253
    local possiblePlayer = getThingFromPos(effectPos).uid
    
    if possiblePlayer ~= cid and not isNpc(possiblePlayer) then
      if possiblePlayer > 0 then
        if isPlayer(possiblePlayer) then
          countInPlayer = countInPlayer+1
        end

        setCreatureNoMoveTime(possiblePlayer, MyLocal.walkTime-1, 2000)
    doPlayerCancelFollow(possiblePlayer)
        doPushCreature(possiblePlayer, playerDir)  
        doCombat(cid, combat, numberToVariant(possiblePlayer))
        target = possiblePlayer
      end  
    end
  end

  doSendMagicEffect(newPos, 34)
  addEvent(moveTarget, MyLocal.walkTime, cid, newPos, jumps+1, countInPlayer)
end

function onCastSpell(creature, var)
	local cid = creature:getId()
  if getSpellCancels(cid, "earth") == true then
    return false
  end
  
  if getPlayerExaust(cid, "earth", "control") == false then
    return false
  end

  if MyLocal.playersCanUse[cid] == nil then
    if getPlayerHasStun(cid) then
      removeTable(cid)
          return true
      end
      workAllCdAndAndPrevCd(cid, "earth", "control", MyLocal.jumps*MyLocal.walkTime, 1)
    MyLocal.playersCanUse[cid] = false
    moveTarget(cid)  
        return true
  else
    doPlayerSendCancelEf(cid, "You're already using this fold.")
    return false
  end
end