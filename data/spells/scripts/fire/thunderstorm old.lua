local spellName = "fire thunderstorm"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}


local function doElectrify(cid, combat, var, times)
  if times <= 0 then
    return false 
  end 
local target = variantToNumber(var)
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and doCombat(cid, combat, var) and addEvent(doElectrify, 500, cid, combat, var, times-1)
end

local function getMin(cid)
  local level = getPlayerLevel(cid)
  local magLevel = getPlayerMagLevel(cid)
  local min = ((level+(magLevel/3)*2.5)+math.random(20, 30)) * 1,2
      if exhaustion.check(cid, "isFocusThunderstorm") then 
        min = min*2
      end 
	local dano = min
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
  return dano
end

local function getMax(cid)
  local level = getPlayerLevel(cid)
  local magLevel = getPlayerMagLevel(cid)
 local max = ((level+(magLevel/3)*3.2)+math.random(30, 40))* 1,2
      if exhaustion.check(cid, "isFocusThunderstorm") then 
        max = max*2
      end 
	local dano = max
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
  return dano
end

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)

    return -getMin(cid)/2, -getMax(cid)/2
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat4, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 2, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 0, 0, 0, 0, 0}
      }))


local combats = {combat1, combat4}


local direction = {WEST, SOUTH, NORTH, EAST}

function onTargetCreature1(cid, target)
  doSendAnimatedText(getCreaturePosition(target), "Electrified!", 210) 
  doElectrify(cid, combat2, numberToVariant(target), 4)
  doTargetCombatHealth(cid, target, COMBAT_ENERGYDAMAGE, -getMin(cid), -getMax(cid), -1)
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature1")

function onTargetCreature4(cid, target)
  doTargetCombatHealth(cid, target, COMBAT_ENERGYDAMAGE, -getMin(cid)*0.5, -getMax(cid)*0.5, -1)
end

setCombatCallback(combat4, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature4")

local function sendthunderstormPos(cid, pos)
  if getTileInfo(getCreaturePosition(cid)).protection then return false end
   local tile = getTileInfo(pos)
    if tile and not tile.protection then
    doCombat(cid, combat1, {pos=pos, type=2})  
    doCombat(cid, combat4, {pos=pos, type=2})
    doSendMagicEffect({x=pos.x+1, y=pos.y, z=pos.z}, 136)
  end
end

local function thunderstormWork(cid, id, isEnd)
  
  if not isCreature(cid) then
    return false
  end
  if getTileInfo(getCreaturePosition(cid)).protection then return false end
  local poses = shuffleList(MyLocal.players[cid])
  for counter = 1, math.ceil(#poses/15) do
    for h = 1, #poses do
      if poses[h].used == false then
        sendthunderstormPos(cid, poses[h])
        poses[h].used = true
        break
      end
    end
  end
  if id and isEnd then
    MyLocal.players[cid] = nil
    doPlayerAddExaust(cid, "fire", "thunderstorm", fireExausted.thunderstorm)
  else
    MyLocal.players[cid] = poses
  end
end

local function posthunderstormWork(cid, isEnd)
  if not isCreature(cid) then
    return false
  end
  local playerPos = getCreaturePosition(cid)
  local poses = {}
  for x = -math.random(3, 5), math.random(3, 5) do
    for y = -math.random(3, 5), math.random(3, 5) do
    if isSightClear(getThingPos(cid), {x=playerPos.x+x,y=playerPos.y+y,z=playerPos.z}, true) then 
      table.insert(poses, {x=playerPos.x+x,y=playerPos.y+y,z=playerPos.z, used=false})
    end
    end
  end
  MyLocal.players[cid] = poses

  for x = 1, 4 do
    addEvent(thunderstormWork, 200*x, cid, x == 4, isEnd)
  end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
        local playerPos = getCreaturePosition(cid)
        if hasSqm({x=playerPos.x,y=playerPos.y,z=playerPos.z-1}) and not getTileInfo(getCreaturePosition(cid)).hardcore and not getTileInfo(getCreaturePosition(cid)).optional then
            doPlayerSendCancelEf(cid, "You can't use this fold in closed places.")
            return false
        end
  if MyLocal.players[cid] == nil then
    if getPlayerExaust(cid, "fire", "thunderstorm") == false then
      return false
    end
    if getPlayerHasStun(cid) then
          doPlayerAddExaust(cid, "fire", "thunderstorm", fireExausted.thunderstorm)
          return true
     end
    if getPlayerOverPower(cid, "fire", true, true) then 
      exhaustion.set(cid, "isFocusThunderstorm", 2)
    end
      for a = 0, 3 do
        addEvent(posthunderstormWork, 1000*a, cid, a == 3)
      end
      workAllCdAndAndPrevCd(cid, "fire", "thunderstorm", 9*1000, 1)
    return true
  else
    doPlayerSendCancelEf(cid, "You're already using this fold.")
    return false
  end
end