local spellName = "air bomb"
local cf = {atk = spellsInfo[spellName].atk, segundosParaExplosao = spellsInfo[spellName].segundosParaExplosao}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 42)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat2, COMBAT_PARAM_EFFECT, 2)
setCombatArea(combat2, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 2, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
      }))


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.16)+10
    local max = (level+(magLevel/3)*2.4)+10
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
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.16)+10
    local max = (level+(magLevel/3)*2.4)+10
	local dano = math.random(min, max)
	local atk = (spellsInfo["air bomb"].atk)/2
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local random = math.random(0, 3)
    addEvent(function() if isCreature(cid) and isCreature(target) then doPushCreature(target, random, nil, nil, nil, isPlayer(cid)) end 
      end, 50)
 return doPushCreature(target, random, nil, nil, nil, isPlayer(cid))
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end 

function getNextPosTo(fromPos, toPos)
local range = getDistanceBetween(fromPos, toPos)
if fromPos.x == toPos.x then
redor = {
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z}

}
elseif fromPos.y == toPos.y then
redor = {
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z}
}
elseif fromPos.x < toPos.x and fromPos.y < toPos.y then
redor = {
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z}
}
elseif fromPos.x > toPos.x and fromPos.y > toPos.y then
redor = {
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z}
}
elseif fromPos.x > toPos.x and fromPos.y < toPos.y then
redor = {
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z}
}
elseif fromPos.x < toPos.x and fromPos.y > toPos.y then
redor = {
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z}
}
else
redor = {
{x=fromPos.x-1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y-1, z=fromPos.z},
{x=fromPos.x+1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x-1, y=fromPos.y, z=fromPos.z},
{x=fromPos.x, y=fromPos.y+1, z=fromPos.z},
{x=fromPos.x, y=fromPos.y-1, z=fromPos.z}
}
end

for i = 1, #redor do
if getDistanceBetween(redor[i], toPos) < range and isProjectable(redor[i]) then
return redor[i]
end
end
return 0
end

local function doBomb(cid, combat, var, times, bombPos)
local target = variantToNumber(var)
if not isCreature(cid) or not isCreature(target) or times < 1 then return false end
  local targpos = getCreaturePosition(target)
  if targpos.z ~= bombPos.z then
		doPlayerSendCancel(cid, "Target lost.")
	return false
  end
    if getDistanceBetween(bombPos, targpos) > 1 then
		bombPos = getNextPosTo(bombPos, targpos, cid)
		if type(bombPos) ~= "table" then
			doPlayerSendCancel(cid, "Target lost.")
			return false
		end
	end
  if getDistanceBetween(bombPos, targpos) <= 1 then
    if not isInPz(cid) and not isInPz(target) then 
      doCombat(cid, combat, var)
		doSlow(cid, target, 60, 1000)
      doCombat(cid, combat2, var)
      doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 122)
      doSendMagicEffect({x=targpos.x, y=targpos.y, z=targpos.z}, 126)
    end
    return false 
  end 
  
      doSendMagicEffect(bombPos, 129)
return not isInPz(cid) and not isInPz(target) and addEvent(doBomb, 100, cid, combat, var, times-1, bombPos)
end

local function doCharge(cid, combat, var, times)
	if not isCreature(cid) or getTileInfo(getCreaturePosition(cid)).protection then return false end
	local pos = getCreaturePosition(cid)
	local target = variantToNumber(var)
	if times <= 0 then
		if not isCreature(target) or isInPz(target) or getCreaturePosition(target).z ~= getCreaturePosition(cid).z then
			doPlayerSendCancel(cid, "Target lost.")
		else
			doSendMagicEffect(pos, 76)
			doBomb(cid, combat, var, 100, pos) 
		end
			return false
	end
	doSendDistanceShoot({x=pos.x-2, y=pos.y, z=pos.z}, pos, 48)
	doSendDistanceShoot({x=pos.x+2, y=pos.y, z=pos.z}, pos, 48)
	doSendDistanceShoot({x=pos.x, y=pos.y-2, z=pos.z}, pos, 48)
	doSendDistanceShoot({x=pos.x, y=pos.y+2, z=pos.z}, pos, 48)
      doSendMagicEffect(pos, 120)
	addEvent(doCharge, 500, cid, combat, var, times-1)
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
  if getPlayerExaust(cid, "air", "bomb") == false then
    return false
  end
	if getDobrasLevel(cid) >= 19 then
		doPlayerAddExaust(cid, "air", "bomb", airExausted.bomb-6)
	else
		doPlayerAddExaust(cid, "air", "bomb", airExausted.bomb)
	end
  if getPlayerHasStun(cid) then
        return true
    end
	doCharge(cid, combat, var, 4)
  return true 
end
