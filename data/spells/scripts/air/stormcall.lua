local spellName = "air stormcall"
local cf = {atk = spellsInfo[spellName].atk}

local extraDano = -20


local MyLocal = {}
MyLocal.players = {}
MyLocal.positions = {}
MyLocal.tornados = {}

local cf = {
missile = 43,
effect = 76
}

local xizes = {
3,
-3,
-3,
3
}
local yizes = {
3,
3,
-3,
-3
}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effect)
setCombatArea(combat, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0}
      }))
      
      
local combat2 = createCombatObject()
local combat3 = createCombatObject()
local combat4 = createCombatObject()
local combat5 = createCombatObject()
local combat6 = createCombatObject()
local combat7 = createCombatObject()
local combat8 = createCombatObject()
local combat9 = createCombatObject()
local combats = {combat2, combat3, combat4, combat5}
local combats2 = {combat6, combat7, combat8, combat9}

for i = 1, #combats do 
setCombatParam(combats[i], COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combats[i], COMBAT_PARAM_EFFECT, cf.effect)
if i == 2 then 
setCombatArea(combats[i], createCombatArea(
      {
      {0, 1, 1, 1, 1, 1, 0},
          {0, 1, 0, 0, 0, 1, 0},
          {0, 1, 0, 2, 0, 1, 0},
          {0, 1, 0, 0, 0, 1, 0},
          {0, 1, 1, 1, 1, 1, 0},
          {0, 0, 0, 0, 0, 0, 0}
      }))
elseif i == 3 then 
setCombatArea(combats[i], createCombatArea(
      {
      {1, 1, 1, 1, 1, 1, 0},
          {1, 1, 0, 0, 0, 1, 0},
          {1, 1, 0, 2, 0, 1, 0},
          {1, 1, 0, 0, 0, 1, 0},
          {1, 1, 1, 1, 1, 1, 0},
      {0, 1, 1, 1, 1, 1, 0}
      }))
elseif i == 4 then 
setCombatArea(combats[i], createCombatArea(
      {
          {0, 0, 0, 0, 0, 0, 0},
      {0, 1, 1, 1, 1, 1, 1},
          {0, 1, 0, 0, 0, 1, 1},
          {0, 1, 0, 2, 0, 1, 1},
          {0, 1, 0, 0, 0, 1, 1},
          {0, 1, 1, 1, 1, 1, 1}
      }))
elseif i == 1 then 
setCombatArea(combats[i], createCombatArea(
      {
          {0, 0, 0, 0, 0, 0, 0, 0},
      {0, 0, 1, 1, 1, 1, 1, 0},
          {0, 0, 1, 0, 0, 0, 1, 0},
          {0, 0, 1, 0, 2, 0, 1, 0},
          {0, 0, 1, 0, 0, 0, 1, 0},
          {0, 0, 1, 1, 1, 1, 1, 0},
          {0, 0, 1, 1, 1, 1, 1, 0}
      }))
end 
function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/3)*4.16)+math.random(35, 45)
        local max = (level+(magLevel/3)*4.8)+math.random(45, 60)
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
 end
setCombatCallback(combats[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  --  doPushCreature(target, i-1, nil, nil, nil, isPlayer(cid))
	local initialFloor = getThingPos(target).z
      local range = getDistanceBetween(getThingPos(target), MyLocal.tornados[cid][i])
    for x = 1, range do 
      addEvent(function ()
        if isCreature(target) and getThingPos(target).z == initialFloor and not isInPz(target) then 
          doSendMagicEffect(getThingPos(target), 129)
          doPushCreature(target, getDirectionTo(getThingPos(target), MyLocal.tornados[cid][i]), nil, nil, nil, isPlayer(cid))
        end 
      end, 50*x)
    end 
    doSlow(cid, target, 10, 3000)
    exhaustion.set(target, "stopDashs", 1)
 return true
end

setCombatCallback(combats[i], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

end

for i = 1, #combats2 do 

setCombatParam(combats2[i], COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combats2[i], COMBAT_PARAM_EFFECT, 2)
setCombatArea(combats2[i], createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0}
      }))
      
function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/3)*5.2)+math.random(35, 45)
        local max = (level+(magLevel/3)*6.0)+math.random(45, 60)
      if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.6 
        max = max*0.6
      end 
      min = min*(extraDano/100+1)
	max = max*(extraDano/100+1)
	min = remakeAirEarth(cid, min)
	max = remakeAirEarth(cid, max)
        return -min, -max
 end
setCombatCallback(combats2[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetTile(creature, pos)
	local cid = creature:getId()
  for i = 1, #MyLocal.tornados[cid] do  
    if pos.x == MyLocal.tornados[cid][i].x and pos.y == MyLocal.tornados[cid][i].y then 
      return false
    end
  end 
  --doSendMagicEffect(pos, 2)
 return true
end

setCombatCallback(combats2[i], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

for i = 1, #combats2 do 
function onTargetCreature(creature, target)
  local cid = creature:getId()
    local range = getDistanceBetween(getThingPos(target), MyLocal.tornados[cid][i])
	local initialFloor = getThingPos(target).z
    for x = 1, range do 
      addEvent(function ()
        if isCreature(target) and getThingPos(target).z == initialFloor and not isInPz(target) then 
          doSendMagicEffect(getThingPos(target), 129)
          doPushCreature(target, getDirectionTo(getThingPos(target), MyLocal.tornados[cid][i]), nil, nil, nil, isPlayer(cid))
        end
      end, 50*x)
    end 
  doSlow(cid, target, 10, 1000)
    exhaustion.set(target, "stopDashs", 1)
 return true
end

setCombatCallback(combats2[i], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

end

      
local function removeTable(cid)
    MyLocal.players[cid] = nil
  MyLocal.tornados[cid] = nil
end


local function isAndavel(pos, cid)
return getPlayerCanWalk({player = cid, position = pos, checkPZ = false, checkHouse = true, createTile = itsFlySpell and isPlayer(cid)})
end
 
local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end

local function getTornados(pos)
local tornados = {}
for i = 1, 4 do
local newtornado = {x=pos.x+xizes[i], y=pos.y+yizes[i], z=pos.z}
table.insert(tornados, newtornado)
end
return tornados
end 

local function stormcallWork(cid, times, inipos)
if not isCreature(cid) or isInPz(cid) then return false end 
for j = -1, 1 do 
  for i = -1, 1 do 
    local posEf = {x=inipos.x+i, y=inipos.y+j, z=inipos.z}
    if posEf.x ~= inipos.x or posEf.y ~= inipos.y then 
      --doSendMagicEffect(posEf, cf.effect)
    elseif not getTileInfo(posEf).protection then 
      doSendMagicEffect({x=posEf.x+1, y=posEf.y+1, z=posEf.z}, 126)
    end 
  end 
end
local poses = getTornados(inipos)
    for i = 1, #poses do  
    --  doCombat(cid, combat, {type=2, pos=poses[i]})
      doCombat(cid, combats[i], {type=2, pos=poses[i]})
    if not getTileInfo(poses[i]).protection then 
    doSendMagicEffect({x=poses[i].x+1, y=poses[i].y+1, z=poses[i].z}, 126)
    end
  end
    doCombat(cid, combats2[1], {type=2, pos=poses[2]})
    doCombat(cid, combats2[2], {type=2, pos=poses[3]})
    doCombat(cid, combats2[3], {type=2, pos=poses[4]})
    doCombat(cid, combats2[4], {type=2, pos=poses[1]})
  if times > 1 then 
    addEvent(stormcallWork, 500, cid, times-1, inipos)
  end
end 


local function noSpace(cid)
local tornados = getTornados(getThingPos(cid))
for i = 1, #tornados do 
if isProjectable({x=tornados[i].x, y=tornados[i].y, z=tornados[i].z}) then return false end 
end 
doPlayerSendCancel(cid, "Voc� precisa de espa�o para executar esta dobra.")
--doSendMagicEffect(getThingPos(cid), 2)
return true
end 
function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "stormcall") == false then
        return false
    end
  if noSpace(cid) then 
    return false 
  end 
    if MyLocal.players[cid] == nil then
     positionsimune = {}
		if getDobrasLevel(cid) >= 21 then
			doPlayerAddExaust(cid, "air", "stormcall", airExausted.stormcall-9)
		else
			doPlayerAddExaust(cid, "air", "stormcall", airExausted.stormcall)
		end
            if getPlayerHasStun(cid) then
                workAllCdAndAndPrevCd(cid, "air", "stormcall", nil, 1)
                return true
            end
            MyLocal.players[cid] = 0
            addEvent(removeTable, 2010, cid)
    --  setCreatureNoMoveTime(cid, 6000)
            workAllCdAndAndPrevCd(cid, "air", "stormcall", nil, 1)
      local tornados = getTornados(getThingPos(cid))
      MyLocal.tornados[cid] = {}
      for i = 1, #tornados do  
        table.insert(MyLocal.tornados[cid], tornados[i])
      end 
      stormcallWork(cid, 4, getThingPos(cid))
    --  doCombat(cid, combat3, {type=2, pos=getThingPos(cid)})
            return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end