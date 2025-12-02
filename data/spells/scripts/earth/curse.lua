local spellName = "earth curse"
local cf = {atk = spellsInfo[spellName].atk}

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)
setCombatArea(combat2, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
      }))

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

local function doBomb(cid, combat, var, times)
local target = variantToNumber(var)
if not isCreature(cid) or not isCreature(target) or times < 1 then return false end
  local targpos = getCreaturePosition(target)
  local bombPos = getCreaturePosition(cid)
  if targpos.z ~= bombPos.z or isInPz(target) then
		doPlayerSendCancel(cid, "Target lost.")
	return false
  end
  bombPos = getNextPosTo(targpos, getPosByDir({x=targpos.x, y=targpos.y, z=targpos.z}, getCreatureLookDirection(target), 2), cid)
  if type(bombPos) ~= "table" then
	bombPos = targpos
  end
    if not isInPz(cid) then 
	  createTerra(bombPos, 500)
      doCombat(cid, combat2, {type=2, pos=bombPos})
	end 
return not isInPz(cid) and addEvent(doBomb, 1000, cid, combat, var, times-1)
end


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
  if getPlayerExaust(cid, "earth", "curse") == false then
    return false
  end
	if exhaustion.check(variantToNumber(var), "earthCursed") then
		doPlayerSendCancel(cid, "Your target cant be cursed right now.")
		return false
	end
	if getDobrasLevel(cid) >= 17 then
		doPlayerAddExaust(cid, "earth", "curse", earthExausted.curse-6)
	else
		doPlayerAddExaust(cid, "earth", "curse", earthExausted.curse)
	end
  if getPlayerHasStun(cid) then
        return true
    end
	doSendDistanceShoot(getCreaturePosition(cid), getCreaturePosition(variantToNumber(var)), 38)
	doBomb(cid, combat, var, 3)
	exhaustion.set(variantToNumber(var), "earthCursed", 5)
  return true 
end
