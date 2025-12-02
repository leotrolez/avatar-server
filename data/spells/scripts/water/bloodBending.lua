local spellName = "water bloodbending"
local cf = {atk = spellsInfo[spellName].atk}
local centerPoses = {}

local arr = {{0, 1, 1, 1, 0},
			{1, 1, 1, 1, 1},
			{1, 1, 2, 1, 1},
			{1, 1, 1, 1, 1},
			{0, 1, 1, 1, 0}
}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 69)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_AGGRESSIVE, 0)

local function isInPvpZone(cid)
local pos = getCreaturePosition(cid)
	if getTileInfo(pos).hardcore then
		return true 
	end
return false
end

local function isInSameGuild(cid, target)
if isPlayer(cid) and isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
	local cidGuild = getPlayerGuildId(cid)
	local targGuild = getPlayerGuildId(target)
	if cidGuild > 0 and cidGuild == targGuild then
		return true
	end
end
	return false
end

local function isNonPvp(cid)
return isMonster(cid) or getPlayerStorageValue(cid, "canAttackable") == 1
end 

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else
			local heal = getPlayerMagLevel(cid) + (getPlayerLevel(cid)/2)
			heal = heal + math.random(15, 30)
			local atk = 40
			if atk and type(atk) == "number" then 
				heal = heal * (atk/100)
				heal = heal+1
			end
			doCreatureAddHealth(target, heal)
		end
	end
end
setCombatCallback(combat3, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*2.2)+5
    local max = (level+(magLevel/4)*3.8)+15
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*2.2)+5
    local max = (level+(magLevel/4)*3.8)+15
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

setCombatArea(combat, createCombatArea(arr))
function onTargetTile(creature, pos)
	local cid = creature:getId()
	addEvent(doSendMagicEffect, getDistanceBetween(pos, centerPoses[cid]) * 100, pos, 138)
	doCombat(cid, combat3, {type=2, pos=pos})
 end
    setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  local cid = creature:getId()
doSlow(cid, target, 35, 2500)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function rollClock(cid, target, times)
	if not isCreature(cid) or not isCreature(target) or isInPz(cid) or isInPz(target) then
		return false
	end
	local targpos = getCreaturePosition(target)
	centerPoses[cid] = targpos
	doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 135)
	doCombat(cid, combat, {type=2, pos=targpos})
	doCombat(cid, combat2, numberToVariant(target))
	if times > 1 then
		addEvent(rollClock, 375, cid, target, times-1)
	end
end


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "bloodBending") == false then
        return false
    end
	local target = variantToNumber(var)
    if cantReceiveDisable(cid, target) then
		return false
	end
	
        if not canUseWaterSpell(cid, 1, 3, false)  then 
            return false
        end
		
		if getDobrasLevel(cid) >= 23 then
			doPlayerAddExaust(cid, "water", "bloodBending", waterExausted.bloodBending-18)
		else
			doPlayerAddExaust(cid, "water", "bloodBending", waterExausted.bloodBending)
		end
        if getPlayerHasStun(cid) then
            return true
        end
		doSendDistanceShoot(getThingPos(cid), getThingPos(target), 54)
        setCreatureNoMoveTime(target, 3000, 1500)
		rollClock(cid, target, 8)
	addEvent(function() 
		centerPoses[cid] = nil 
	end, 10000)
        return true
end