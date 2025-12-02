local spellName = "air windblast"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.airId = 17112
MyLocal.airTime = 2
MyLocal.players = {}
MyLocal.direction = {}
MyLocal.imunes = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_HITEFFECT, 34)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/3)*2.6)+math.random(1, 2))*1.68
    local max = ((level+(magLevel/3)*3.1)+math.random(2, 3))*1.68
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



function onTargetCreature(creature, target)
  local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
  if isNpc(target) then
    return false
  end    
  if not MyLocal.direction[cid] then 
		MyLocal.direction[cid] = 0
	end
	--if MyLocal.imunes[cid] == nil or #MyLocal.imunes[cid] == 0 or not isInArray(MyLocal.imunes[cid], target) then 
		--doSlow(cid, target, 15, 100)
	--	doPushCreature(target, getToPushDir(MyLocal.direction[cid]))
	--	table.insert(MyLocal.imunes[cid], target)
	--end
		doSlow(cid, target, 50, 450)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

--        doPushCreature(target, dir)

local function isAndavel(pos, cid)
return getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true, createTile = false and isPlayer(cid)})
end 

local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end 



local function loopDamage(cid, nextPos, times)
	if times == 0 or not isCreature(cid) or getTileInfo(getCreaturePosition(cid)).protection or getTileInfo(nextPos).protection or not isProjectable(nextPos) then return false end
	doSendMagicEffect(nextPos, 77)
	doSendMagicEffect(nextPos, 61)
	doCombat(cid, combat, {type=2, pos=nextPos})
	addEvent(loopDamage, 300, cid, nextPos, times-1)
end

local function workWind(cid, fromPos, nextPos, dir, times)
	if times == 0 or not isCreature(cid) or getTileInfo(getCreaturePosition(cid)).protection or getTileInfo(nextPos).protection or not isProjectable(nextPos) then return false end
	--doSendDistanceShoot(fromPos, nextPos, 45)

	--doCombat(cid, combat, {type=2, pos=nextPos})
	local newPos = getPositionByDirection({x=nextPos.x, y=nextPos.y, z=nextPos.z}, dir, 1)
	loopDamage(cid, nextPos, 10)
	addEvent(workWind, 100, cid, nextPos, newPos, dir, times-1)
end 


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end

    if getPlayerExaust(cid, "air", "windblast") == false then
        return false
    end

  if getPlayerHasStun(cid) then
		if getDobrasLevel(cid) >= 14 then
			doPlayerAddExaust(cid, "air", "windblast", airExausted.windblast-4)
		else
			doPlayerAddExaust(cid, "air", "windblast", airExausted.windblast)
		end
        return true
    end
	MyLocal.imunes[cid] = {}
	local mypos = getCreaturePosition(cid)
	local dir = getCreatureLookDirection(cid)
	MyLocal.direction[cid] = dir
	local positions = getCreatureLookPosition(cid)
	local haveSpell = false
	if isProjectable(positions) then 
		workWind(cid, mypos, positions, dir, 6)
		haveSpell = true
	end 

  if haveSpell then
		if getDobrasLevel(cid) >= 14 then
			doPlayerAddExaust(cid, "air", "windblast", airExausted.windblast-4)
		else
			doPlayerAddExaust(cid, "air", "windblast", airExausted.windblast)
		end
      return true
  else
         doPlayerSendCancelEf(cid, "There is not enough room.")
    return false
  end
end