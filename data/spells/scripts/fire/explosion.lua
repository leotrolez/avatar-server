local spellName = "fire explosion"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}

local cf = {
effect = 132,
effectExplo = 137,
extraDano = 80
}
local combatNorth = createCombatObject()
setCombatParam(combatNorth, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatSouth = createCombatObject()
setCombatParam(combatSouth, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatEast = createCombatObject()
setCombatParam(combatEast, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatWest = createCombatObject()
setCombatParam(combatWest, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatNorthWest = createCombatObject()
setCombatParam(combatNorthWest, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatSouthWest = createCombatObject()
setCombatParam(combatSouthWest, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatNorthEast = createCombatObject()
setCombatParam(combatNorthEast, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatSouthEast = createCombatObject()
setCombatParam(combatSouthEast, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatSelf = createCombatObject()
setCombatParam(combatSelf, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

local combats = {combatNorth, combatSouth, combatEast, combatWest, combatNorthWest, combatNorthEast, combatSouthWest, combatSouthEast}


local function getMinAndMax(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.1)+math.random(3, 7)
    local max = (level+(magLevel/2)*5.3)+math.random(7, 15)
    if exhaustion.check(cid, "isFocusExplosion") then 
        min = min*1.5
        max = max*2.0
    end
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.5
        max = max*0.5
    end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return {dano*1.8, dano*1.8}
end 

for x = 1, #combats do
    function onTargetTile(creature, pos)
	local cid = creature:getId()
        return doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, cf.effectExplo)
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local minAndMax = getMinAndMax(cid, level, magLevel)
        return -minAndMax[1], -minAndMax[2]
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end




function onGetPlayerMinMaxValues(cid, level, magLevel)
    local minAndMax = getMinAndMax(cid, level, magLevel)
    return -minAndMax[1], -minAndMax[2]
end
setCombatCallback(combatSelf, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreatureNorth(cid, target)
    if isNpc(target) then
        return false
    end
    if getTileInfo(getCreaturePosition(cid)).protection then return false end
    doPushCreature(target, 0)
end

function onTargetCreatureSouth(cid, target)
    if isNpc(target) then
        return false
    end
    doPushCreature(target, 2)
end

function onTargetCreatureEast(cid, target)
    if isNpc(target) then
        return false
    end
    doPushCreature(target, 1)
end

function onTargetCreatureWest(cid, target)
    if isNpc(target) then
        return false
    end
    doPushCreature(target, 3)
end
function onTargetCreatureNorthWest(cid, target)
    if isNpc(target) then
        return false
    end
    local targpos = getCreaturePosition(target)
    doPushCreature(target, 0, nil, nil, nil, isPlayer(cid), {x=targpos.x-1, y=targpos.y-1, z=targpos.z})
end
function onTargetCreatureSouthWest(cid, target)
    if isNpc(target) then
        return false
    end
    local targpos = getCreaturePosition(target)
    doPushCreature(target, 2, nil, nil, nil, isPlayer(cid), {x=targpos.x-1, y=targpos.y+1, z=targpos.z})
end
function onTargetCreatureNorthEast(cid, target)
    if isNpc(target) then
        return false
    end
    local targpos = getCreaturePosition(target)
    doPushCreature(target, 0, nil, nil, nil, isPlayer(cid), {x=targpos.x+1, y=targpos.y-1, z=targpos.z})
end
function onTargetCreatureSouthEast(cid, target)
    if isNpc(target) then
        return false
    end
    local targpos = getCreaturePosition(target)
    doPushCreature(target, 2, nil, nil, nil, isPlayer(cid), {x=targpos.x+1, y=targpos.y+1, z=targpos.z})
end
    
    
function onTargetCreatureSelf(cid, target)
    if isNpc(target) then
        return false
    end
    doPushCreature(target, math.random(0, 3))
end

setCombatCallback(combatNorth, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureNorth")
setCombatCallback(combatSouth, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureSouth")
setCombatCallback(combatEast, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureEast")
setCombatCallback(combatWest, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureWest")
setCombatCallback(combatSouthEast, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureSouthEast")
setCombatCallback(combatNorthEast, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureNorthEast")
setCombatCallback(combatSouthWest, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureSouthWest")
setCombatCallback(combatNorthWest, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureNorthWest")
setCombatCallback(combatSelf, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureSelf")

local function explodePos(cid, pos, combat, frompos)
return isCreature(cid) and not getTileInfo(getCreaturePosition(cid)).protection and isSightClear(frompos, pos, true) and doCombat(cid, combat, {type=2, pos=pos})
end 

local function startExplosion(cid)
    if not isCreature(cid) then
        return false
    end
    if getTileInfo(getCreaturePosition(cid)).protection then return false end
        local mypos = getCreaturePosition(cid)
        doCombat(cid, combatSelf, {type=2, pos=mypos})
        for i = 1, 4 do 
            addEvent(explodePos, 50*i, cid, getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 0, i), combatNorth, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 1, i), combatEast, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 2, i), combatSouth, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 3, i), combatWest, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection(getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 0, i), 1, i), combatNorthEast, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection(getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 0, i), 3, i), combatNorthWest, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection(getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 2, i), 1, i), combatSouthEast, mypos)
            addEvent(explodePos, 50*i, cid, getPositionByDirection(getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, 2, i), 3, i), combatSouthWest, mypos)
        end 
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end 
    if getPlayerExaust(cid, "fire", "explosion") == false then
        return false
    end
	if getDobrasLevel(cid) >= 19 then
		doPlayerAddExaust(cid, "fire", "explosion", fireExausted.explosion-5)
	else
		doPlayerAddExaust(cid, "fire", "explosion", fireExausted.explosion)
	end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "fire", "explosion", nil, 1)
        return true
    end
    setCreatureNoMoveTime(cid, 800)
    if getPlayerOverPower(cid, "fire", true, true) then 
        exhaustion.set(cid, "isFocusExplosion", 2)
    end
    local mypos = getThingPos(cid)
    doSendMagicEffect({x=mypos.x+1, y=mypos.y+1, z=mypos.z}, cf.effect)
    addEvent(startExplosion, 500, cid)
	exhaustion.set(cid, "AirBarrierReduction", 2)

    return true
end