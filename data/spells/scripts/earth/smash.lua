local spellName = "earth smash"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 44)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*5.0)+math.random(10, 15)
    local max = (level+(magLevel/5)*5.5)+math.random(15, 18)
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
	if getDobrasLevel(cid) >= 13 then
		dano = dano*1.2
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  doSlow(cid, target, 15, 2000)    
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function sendTwo(cid, frompos, pos, times, target)
  if not isCreature(cid) then
    return false
  end
  if isCreature(target) and not getTileInfo(getCreaturePosition(target)).protection and getCreaturePosition(target).z == getCreaturePosition(cid).z then 
	pos = getCreaturePosition(target)
  end 
  doSendDistanceShoot(frompos, pos, 11)
  doCombat(cid, combat, {pos=pos, type=2})  
  doSendMagicEffect(pos, 34)
  if times == 3 then
    doPlayerAddExaust(cid, "earth", "smash", earthExausted.smash)
    MyLocal.players[cid] = nil
  end
end

local function SendOne(cid, frompos, pos, targetPos, target)
  if not(isCreature(cid)) then
    return false
  end
  doSendDistanceShoot(frompos, pos, 11)
  if targetPos ~= nil then
    for x = 1, 3 do
      addEvent(sendTwo, x*333, cid, {x=targetPos.x-2,y=targetPos.y-6,z=targetPos.z}, targetPos, x, target)  
    end
  end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    local playerPos = getCreaturePosition(cid)
	local target = getCreatureTarget(cid)
    local targetPos = getCreaturePosition(target)
--    if hasSqm({x=playerPos.x,y=playerPos.y,z=playerPos.z-1}) and isPlayer(cid) then
--      doPlayerSendCancelEf(cid, "You can't use this fold in closed places.")
--      return false
--    end
  if MyLocal.players[cid] == nil then
    if getPlayerExaust(cid, "earth", "smash") == false then
      return false
    end
    if getPlayerHasStun(cid) then
      doPlayerAddExaust(cid, "earth", "smash", earthExausted.smash)
          return true
      end
      --setCreatureNoMoveTime(cid, 1000)
      workAllCdAndAndPrevCd(cid, "earth", "smash", 2, 1)
    for x = 1, 3 do
      if x == 3 then
        addEvent(SendOne, x*333, cid, playerPos, {x=playerPos.x-2,y=playerPos.y-6,z=playerPos.z}, targetPos, target)
      else
        addEvent(SendOne, x*333, cid, playerPos, {x=playerPos.x-2,y=playerPos.y-6,z=playerPos.z}, nil, target)
      end  
    end
    MyLocal.players[cid] = true
    return true
  else
    doPlayerSendCancelEf(cid, "You're already using this fold.")
    return false
  end
end  



