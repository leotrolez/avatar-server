local spellName = "earth growth"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.earthId = 17112
MyLocal.earthTime = 2
MyLocal.players = {}
MyLocal.direction = {}

local combat = createCombatObject()
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_HITEFFECT, 34)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/4)*2.6)+math.random(1, 2))*2.00
    local max = ((level+(magLevel/4)*3.1)+math.random(2, 3))*2.00
	min = remakeAirEarth(cid, min)
	max = remakeAirEarth(cid, max)
	if getPlayerInWaterWithUnderwater(cid) then 
		return -min*0.6, -max*0.6
	end
    return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


function onTargetCreature(creature, target)
  local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
  if isNpc(target) then
    return false
  end    
  if not MyLocal.direction[cid] then 
		MyLocal.direction[cid] = 0
	end
	doSlow(cid, target, 25, 200)
	doPushCreature(target, MyLocal.direction[cid])   
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

--        doPushCreature(target, dir)

local function isAndavel(pos, cid)
return getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true, createTile = false and isPlayer(cid)})
end 

local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end 

local function getAnotherDirs(dir)
if dir == 0 or dir == 2 then 
	return {1, 3}
else 
	return {0, 2}
end 
end 

local function getGrowPositions(mypos, dir)
     local pos1 = getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, dir, 1)
	 local anotherDirs = getAnotherDirs(dir)
	 local pos2 = getPositionByDirection({x=pos1.x, y=pos1.y, z=pos1.z}, anotherDirs[1], 1)
	 local pos3 = getPositionByDirection({x=pos1.x, y=pos1.y, z=pos1.z}, anotherDirs[2], 1)
	 return {pos1, pos2, pos3}
end

function workGrow(cid, fromPos, nextPos, dir, times)
	if times == 0 or not isCreature(cid) or getTileInfo(getCreaturePosition(cid)).protection or getTileInfo(nextPos).protection or not isProjectable(nextPos) then return false end
	doSendDistanceShoot(fromPos, nextPos, 38)
	doSendMagicEffect(nextPos, 34)
	doCombat(cid, combat, {type=2, pos=nextPos})
	if isAndavel(nextPos, cid) then 
		local item = doCreateItem(MyLocal.earthId, nextPos)
       addEvent(removeTileItemById, 1500, getThingPos(item), MyLocal.earthId)  
	end 
	local newPos = getPositionByDirection({x=nextPos.x, y=nextPos.y, z=nextPos.z}, dir, 1)
	addEvent(workGrow, 150, cid, nextPos, newPos, dir, times-1)
end 

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end

    if getPlayerExaust(cid, "earth", "growth") == false then
        return false
    end

  if getPlayerHasStun(cid) then
		if getDobrasLevel(cid) >= 6 then
			doPlayerAddExaust(cid, "earth", "growth", earthExausted.growth-2)
		else
			doPlayerAddExaust(cid, "earth", "growth", earthExausted.growth)
		end
        return true
    end

	local mypos = getCreaturePosition(cid)
	local dir = getCreatureLookDirection(cid)
	MyLocal.direction[cid] = dir
	local positions = getGrowPositions(mypos, dir)
	local haveSpell = false
    for i = 1, #positions do 
		if isProjectable(positions[i]) then 
			workGrow(cid, mypos, positions[i], dir, 3)
			haveSpell = true
		end 
	end 

  if haveSpell then
		if getDobrasLevel(cid) >= 6 then
			doPlayerAddExaust(cid, "earth", "growth", earthExausted.growth-2)
		else
			doPlayerAddExaust(cid, "earth", "growth", earthExausted.growth)
		end
      return true
  else
         doPlayerSendCancelEf(cid, "There is not enough room.")
    return false
  end
end