local spellName = "air vortex"
local cf = {atk = spellsInfo[spellName].atk}
local centerPoses = {}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level+(magLevel/4)*0.3
    local max = level+(magLevel/4)*0.7
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		atk = atk * 1
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combat3 = createCombatObject()
local combats = {combat1, combat2, combat3}

setCombatParam(combat2, COMBAT_PARAM_EFFECT, 76)

local arr = {}

arr[1] = {{1, 1, 1},
          {1, 3, 1},
          {1, 1, 1}
}

arr[2] = {{0, 1, 1, 1, 0},
          {1, 0, 0, 0, 1},
          {1, 0, 2, 0, 1},
          {1, 0, 0, 0, 1},
          {0, 1, 1, 1, 0}
}

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

local skulls = {1,3,4,5,6}
local function isImune(cid, creature)
	if cid == creature then
		return true
	end
    if isMonster(creature) or isMonster(cid) then 
        return false 
    end
	if isPlayer(cid) and isPlayer(creature) and (getPlayerStorageValue(cid, "canAttackable") == 1 or getPlayerStorageValue(creature, "canAttackable") == 1) then 
		return true 
	end 
    if isInParty(cid) and isInParty(creature) and getPlayerParty(cid) == getPlayerParty(creature) then
        return true
    end 
	if isInSameGuild(cid, target) then
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

local function isInSameCoord(posU, posD)
	return posU.x == posD.x and posU.y == posD.y
end

local function addProtections(cid, pos)
	local specs = getSpectators(pos, 1, 0)
	local protegeuAlguem = false
	if specs and #specs > 0 then
		for i = 1, #specs do 
			local creature = specs[i]
			if isPlayer(creature) and isInSameCoord(pos, getCreaturePosition(creature)) and isImune(cid, creature) then 
				exhaustion.set(creature, "vortexProtection", 1)
				if not exhaustion.check(creature, "defMsg") then
					doSendAnimatedText(getCreaturePosition(creature), "+ DEF", 215, creature)
					exhaustion.set(creature, "defMsg", 2)
				end
				protegeuAlguem = true
			end 
		end 
	end 
	if protegeuAlguem then
		doSendMagicEffect(pos, 94)
	end
end

for x = 1, 2 do
    setCombatArea(combats[x], createCombatArea(arr[x]))
    function onTargetTile(creature, pos)
	local cid = creature:getId()
		addProtections(cid, pos)
        doCombat(cid, combat, {type=2, pos=pos})
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
    doPushCreature(target, getDirectionTo(centerPoses[cid], getThingPos(target)), nil, nil, nil, isPlayer(cid))
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function sendCombat(cid, combatId, pos, times, sendEffect)
    if not isCreature(cid) then
        return true
    end
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
	if sendEffect and times % 2 == 0 and times ~= 15 then
		doSendMagicEffect(pos, 61)
	end
	if sendEffect then
		doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 122)
	end
    doCombat(cid, combatId, {type=2, pos=pos}) 
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "vortex") == false then
        return false
    end
	if getDobrasLevel(cid) >= 22 then
		doPlayerAddExaust(cid, "air", "vortex", airExausted.vortex-12)
	else	
		doPlayerAddExaust(cid, "air", "vortex", airExausted.vortex)
	end
    if getPlayerHasStun(cid) then
        return true
    end
	local pos = getThingPos(cid)
	centerPoses[cid] = pos
	for y = 0, 15 do
		addEvent(sendCombat, 400*y, cid, combats[1], pos, y, true)
		addEvent(sendCombat, (400*y)+100, cid, combats[2], pos, y)
	end
	addEvent(function() 
		centerPoses[cid] = nil 
	end, 10000)

    return true
end
