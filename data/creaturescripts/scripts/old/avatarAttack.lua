AREA_SQUARE1X1 = {
  {1, 1, 1},
  {1, 3, 1},
  {1, 1, 1}
}

--- PROMOTE ATKS --
local promoteFireAtk = createCombatObject()
setCombatParam(promoteFireAtk, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.5)+math.random(20, 25)
    local max = (level+(magLevel/2)*5.0)+math.random(25, 35)
    if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = spellsInfo["fire kick"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano/2.4
    return -dano, -dano
end
setCombatCallback(promoteFireAtk, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local promoteFireAtkBurn = createCombatObject()
setCombatParam(promoteFireAtkBurn, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.5)+math.random(20, 25)
    local max = (level+(magLevel/2)*5.0)+math.random(25, 35)
    if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = spellsInfo["fire kick"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano/10
    return -dano, -dano
end
setCombatCallback(promoteFireAtkBurn, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combatEarth = createCombatObject()
setCombatParam(combatEarth, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatArea(combatEarth, createCombatArea(AREA_SQUARE1X1))
setCombatParam(combatEarth, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.1)+math.random(5, 10)
    local max = (level+(magLevel/2)*3.5)+math.random(10, 15)
    if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.6
		max = max*0.6
	end

	local dano = math.random(min, max)
	local atk = spellsInfo["water shards"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*1.2
    return -dano, -dano
end
setCombatCallback(combatEarth, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local combatWat = createCombatObject()
setCombatParam(combatWat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatWat, COMBAT_PARAM_EFFECT, 53)
setCombatParam(combatWat, COMBAT_PARAM_DISTANCEEFFECT, 46)
setCombatArea(combatWat, createCombatArea(AREA_SQUARE1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*3.2)+(math.random(20, 25)/2)
    local max = (level+(magLevel/4)*3.5)+(math.random(25, 35)/2)
	local dano = math.random(min, max)
	local atk = spellsInfo["water explosion"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*4
    return -dano, -dano
end
setCombatCallback(combatWat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combatAir = createCombatObject()
setCombatParam(combatAir, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combatAir, COMBAT_PARAM_DISTANCEEFFECT, 41)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*3.2)+(math.random(20, 25)/2)
    local max = (level+(magLevel/4)*3.5)+(math.random(25, 35)/2)
	local dano = math.random(min, max)
	local atk = spellsInfo["water explosion"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*4.8
    return -dano, -dano
end
setCombatCallback(combatAir, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

---- PROMOTE ATKS --


-- WATER SHARDS START --
local combatIceSpikes = createCombatObject()
setCombatParam(combatIceSpikes, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combatIceSpikes, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.1)+5
    local max = (level+(magLevel/3)*3.5)+5
	local dano = math.random(min, max)
	local atk = spellsInfo["water shards"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combatIceSpikes, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatArea(combat1, createCombatArea(AREA_SQUARE1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.1)+math.random(5, 10)
    local max = (level+(magLevel/2)*3.5)+math.random(10, 15)

	local dano = math.random(min, max)
	local atk = spellsInfo["water shards"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local xizes1 = {0, -1, -1, 0} -- cima pra esquerda, esquerda pra baixo
local yizes1 = {-1, 0, 0, 1} -- cima pra esquerda, esquerda pra baixo
local xizes2 = {0, 1, 1, 0} -- baixo pra direita, direita pra cima
local yizes2 = {1, 0, 0, -1} -- baixo pra direita, direita pra cima
local function shardsWork(cid, state, times)
	if not isCreature(cid) or isInPz(cid) then return false end
		local pos = getCreaturePosition(cid)
        doSendDistanceShoot({x=pos.x+xizes1[state], y=pos.y+yizes1[state], z=pos.z}, {x=pos.x+xizes1[state+1], y=pos.y+yizes1[state+1], z=pos.z}, 28)
        doSendDistanceShoot({x=pos.x+xizes2[state], y=pos.y+yizes2[state], z=pos.z}, {x=pos.x+xizes2[state+1], y=pos.y+yizes2[state+1], z=pos.z}, 28)
	if state == 3 then 
		state = -1
		local target = getCreatureTarget(cid)
		if isCreature(target) and getDistanceBetween(pos, getCreaturePosition(target)) <= 4 and isSightClear(pos, getCreaturePosition(target), true) then
			doCombat(cid, combatIceSpikes, numberToVariant(target))
		end
		doCombat(cid, combat1, {type=2, pos=pos})
	end
		if times < 21 then
			addEvent(shardsWork, 150, cid, state+2, times+1)
		end
end

-- ICE SPIKES END --

-- AIR BALL START --

local combatBall = createCombatObject()
setCombatParam(combatBall, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combatBall, COMBAT_PARAM_DISTANCEEFFECT, 41)
setCombatFormula(combatBall, COMBAT_FORMULA_LEVELMAGIC, -0.3, -30, -0.4, 0)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level+(magLevel/4)*1.04
    local max = level+(magLevel/4)*1.44
	
	local dano = math.random(min, max) + math.random(6, 16)
	local atk = spellsInfo["air ball"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano * 1.3
    return -dano, -dano
end

setCombatCallback(combatBall, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function airBall(cid, target)
	if not isSightClear(getCreaturePosition(cid), getCreaturePosition(target), true) then return false end
	doCombat(cid, combatBall, numberToVariant(target))
	addEvent(function() if isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) then doCombat(cid, combatBall, numberToVariant(target)) end end, 250)
end

-- AIR BALL END -- 

-- EARTH ROCK START --

local combatRock = createCombatObject()
setCombatParam(combatRock, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combatRock, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_LARGEROCK)
setCombatParam(combatRock, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level+(magLevel/4)*1.44
    local max = level+(magLevel/4)*2.44
	
	local dano = math.random(min, max) + math.random(6, 16)
	local atk = spellsInfo["earth rock"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*1.3
    return -dano, -dano
end

setCombatCallback(combatRock, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function earthRock(cid, target)
	if not isSightClear(getCreaturePosition(cid), getCreaturePosition(target), true) then return false end
	local targpos = getCreaturePosition(target)
	doSendAnimatedText(targpos, "Slowed!", 120, cid)
	doSendAnimatedText(targpos, "Slowed!", 120, target)
	doSlow(cid, target, 35, 2500)
	doCombat(cid, combatRock, numberToVariant(target))
end

-- EARTH ROCK END -- 

-- FIRE KICK START -- 
local combatKick = createCombatObject()
setCombatParam(combatKick, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.5)+math.random(20, 25)
    local max = (level+(magLevel/2)*5.0)+math.random(25, 35)
    if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = spellsInfo["fire kick"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combatKick, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function fireKick(cid, target)
	if not isSightClear(getCreaturePosition(cid), getCreaturePosition(target), true) then return false end
	local mypos = getThingPos(cid)
	doSendMagicEffect(mypos, 90)
	local targpos = getThingPos(target)
	doSendDistanceShoot({x=mypos.x+1, y=mypos.y, z=mypos.z}, targpos, 3)
	doSendDistanceShoot({x=mypos.x-1, y=mypos.y, z=mypos.z}, targpos, 3)
	doSendDistanceShoot({x=mypos.x, y=mypos.y+1, z=mypos.z}, targpos, 3)
	doSendDistanceShoot({x=mypos.x, y=mypos.y-1, z=mypos.z}, targpos, 3)
	doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 137)
	return doCombat(cid, combatKick, numberToVariant(target))
end

-- FIRE KICK END --

-- PASSIVE WEAPON --
local combatWeapon = createCombatObject()
setCombatParam(combatWeapon, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combatWeapon, COMBAT_PARAM_EFFECT, 9)

local combatCrossbow = createCombatObject()
setCombatParam(combatCrossbow, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

setCombatArea(combatWeapon, createCombatArea(
		  {
		  {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
		  }))
 function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
	local dano = math.random(min, max)
	local atk = spellsInfo["air barrier"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*2
    return -dano, -dano
end
setCombatCallback(combatWeapon, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

 function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
	local dano = math.random(min, max)
	local atk = spellsInfo["air barrier"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*2
    return -dano, -dano
end
setCombatCallback(combatCrossbow, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function havePassiveWeapon(cid)
	local passiveWeapons = {17860, 17861, 17862, 17863}
	if isInArray(passiveWeapons, getPlayerSlotItem(cid, 6).itemid) or isInArray(passiveWeapons, getPlayerSlotItem(cid, 5).itemid) then
		return true
	end
	return false
end

local function getPassiveWeapon(cid)
	local passiveWeapons = {17860, 17861, 17862, 17863}
	if isInArray(passiveWeapons, getPlayerSlotItem(cid, 6).itemid) then
		return getPlayerSlotItem(cid, 6).itemid
	else 
		return getPlayerSlotItem(cid, 5).itemid
	end
end

local function tryMelee(cid, target)
if math.random(1, 100) <= 95 or exhaustion.check(cid, "passiveWeaponExh") or getDistanceBetween(getThingPos(cid), getThingPos(target)) > 4 then
	return false
end
local passiveWeapons = {[17860] = 24, [17862] = 26, [17863] = 25}

exhaustion.set(cid, "passiveWeaponExh", 5)
doCombat(cid, combatWeapon, numberToVariant(target))
doSendDistanceShoot(getThingPos(cid), getThingPos(target), passiveWeapons[getPassiveWeapon(cid)])
end

local function isInPvpZone(cid)
local pos = getCreaturePosition(cid)
	if getTileInfo(pos).hardcore then
		return true 
	end
return false
end

local function isInSameGuild(cid, target)
if isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
	local cidGuild = getPlayerGuildId(cid)
	local targGuild = getPlayerGuildId(target)
	if cidGuild > 0 and cidGuild == targGuild then
		return true
	end
end
	return false
end

local function isSameParty(cid, target)
	if isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target) then 
		return true
	end
	if isInSameGuild(cid, target) then
		return true
	end
	return false
end

local skulls = {1,3,4,5,6}
local function isImune(cid, creature)
    if isMonster(creature) or isMonster(cid) then 
        return false 
    end
	if isPlayer(cid) and isPlayer(creature) and (getPlayerStorageValue(cid, "canAttackable") == 1 or getPlayerStorageValue(creature, "canAttackable") == 1) then 
		return true 
	end 
    local modes = getPlayerModes(cid)
    if isInArray(skulls, getCreatureSkullType(creature)) then
        return false
    end     
    if (modes.secure == SECUREMODE_OFF) then
        return false
    end
    return true
end

local function searchNewAlvo(cid, targPos, target)
    local creatures = getSpectators(targPos, 6, 6)
    if creatures ~= nil then
		for x = 1, #creatures do
			if creatures[x] ~= cid and creatures[x] ~= target then
				local creaturePos = getThingPos(creatures[x])
				if isMonster(creatures[x]) or (isPlayer(creatures[x]) and getPlayerAccess(creatures[x]) < 5 and not isSameParty(cid, creatures[x]) and not isImune(cid, creatures[x])) then
					if not getTileInfo(creaturePos).protection and isSightClear(targPos, creaturePos, true) then
						return creatures[x]
					end
				end
			end
		end
	end
	return false
end

local function tryCrossbow(cid, target)
if math.random(1, 100) <= 95 or exhaustion.check(cid, "passiveWeaponExh") or getDistanceBetween(getThingPos(cid), getThingPos(target)) > 6 then
	return false
end
	exhaustion.set(cid, "passiveWeaponExh", 5)
	doCombat(cid, combatCrossbow, numberToVariant(target))
	local second = searchNewAlvo(cid, getCreaturePosition(cid), target)
	if second and isCreature(second) then
		doCombat(cid, combatCrossbow, numberToVariant(second))
		doSendDistanceShoot(getThingPos(cid), getThingPos(second), 32)
	end
	doSendDistanceShoot(getThingPos(cid), getThingPos(target), 32)
	return true
end

-- PASSIVE WEAPON END

function onAttack(cid, target)
	if havePassiveWeapon(cid) and isSightClear(getCreaturePosition(cid), getCreaturePosition(target), true) then
		if getPlayerSlotItem(cid, 6).itemid == 17861 or getPlayerSlotItem(cid, 5).itemid == 17861 then
			tryCrossbow(cid, target)
		else
			tryMelee(cid, target)
		end
	end
	if getPlayerStorageValue(cid, "isPromoted") == 1 then
		tryPromoteAtk(cid, target, {promoteFireAtk, promoteFireAtkBurn, combatEarth, combatWat, combatAir})
	end
	if getPlayerStorageValue(cid, "isAvatar") ~= 1 then
		return true
	end
 if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 4 then
	return true
end
	if not exhaustion.check(cid, "avatarAtkExh") then
		exhaustion.set(cid, "avatarAtkExh", 4)
		local rands = math.random(1, 200)
		if rands <= 25 then
			shardsWork(cid, 1, 1)
		elseif rands <= 70 then
			fireKick(cid, target)
		elseif rands <= 120 then
			earthRock(cid, target)
		elseif rands <= 180 then
			airBall(cid, target)
		end
	end
return true
end