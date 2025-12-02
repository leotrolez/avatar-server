local spellName = "earth cataclysm"
local cf = {atk = spellsInfo[spellName].atk}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)
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
	local atk = cf.atk/2
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

 return doPushCreature(target, getCreatureLookDirection(cid), nil, nil, nil, isPlayer(cid))
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end 

local function isWalkavel(cid, pos)
	return getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true, createTile = false})
end

function getNextPosTo(fromPos, toPos, cid)
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
if getDistanceBetween(redor[i], toPos) < range and isWalkavel(cid, redor[i]) then
return redor[i]
end
end
return 0
end

local function createTerra(pos, time)
	local item = doCreateItem(17112, pos)
      addEvent(removeTileItemById, time, getThingPos(item), 17112)  
end

local function createArena(cid, pos)
	local mypos = getCreaturePosition(cid)
	for i = -1, 1 do 
		for j = -1, 1 do
			local thePos = {x=pos.x+i, y=pos.y+j, z=pos.z}
			if isWalkavel(cid, thePos) and (mypos.x ~= thePos.x or mypos.y ~= thePos.y) then
				createTerra(thePos, 1500)
			end
		end
	end
end

local function doBomb(cid, combat, var, times)
local target = variantToNumber(var)
if not isCreature(cid) or not isCreature(target) or times < 1 then return false end
  local targpos = getCreaturePosition(target)
  local bombPos = getCreaturePosition(cid)
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
      doCombat(cid, combat2, var)
	  createTerra(bombPos, 250)
	  createArena(cid, targpos)
      doSendMagicEffect(targpos, 114)
	  doSendMagicEffect(bombPos, 34)
	  doTeleportThing(cid, bombPos)
    end
    return false 
  end 
      doSendMagicEffect(bombPos, 34)
	  createTerra(bombPos, 250)
	  doTeleportThing(cid, bombPos)
return not isInPz(cid) and not isInPz(target) and addEvent(doBomb, 135, cid, combat, var, times-1)
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
    if getSpellCancels(cid, "earth") == true and not exhaustion.check(cid, "earthArmorActive") then
        return false
    end
  if getPlayerExaust(cid, "earth", "cataclysm") == false then
    return false
  end
	if getDobrasLevel(cid) >= 19 then
		doPlayerAddExaust(cid, "earth", "cataclysm", earthExausted.cataclysm-9)
	else
		doPlayerAddExaust(cid, "earth", "cataclysm", earthExausted.cataclysm)
	end
  if getPlayerHasStun(cid) then
        return true
    end
			if exhaustion.check(cid, "earthArmorActive") then
				setPlayerStorageValue(cid, "earthArmorActive", os.time()-1)
				setPlayerStorageValue(cid, "playerHasTotalAbsorve", os.time()-1)
			end
	doBomb(cid, combat, var, 100) 
  return true 
end
