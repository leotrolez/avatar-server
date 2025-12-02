local spellName = "water clock"
local cf = {atk = spellsInfo[spellName].atk}

local function doDrown(cid, target, times)
    cid = cid:getId()
    target = target:getId()
	if times <= 0 then
		return false 
	end 
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	local min = (level+(magLevel/4)*2.2)+5
	min = math.random(min*0.3, min*0.6)
	min = remakeValue(2, min, cid)
    return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and doTargetCombatHealth(cid, target, COMBAT_DROWNDAMAGE, -min, -min, 0) and addEvent(doDrown, 300, cid, target, times-1)
end 

local MyLocal = {}
MyLocal.players = {}

local combatNorthEast = createCombatObject()
setCombatParam(combatNorthEast, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatNorthEast, COMBAT_PARAM_EFFECT, 138)

local combatNorthWest = createCombatObject()
setCombatParam(combatNorthWest, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatNorthWest, COMBAT_PARAM_EFFECT, 138)

local combatSouthEast = createCombatObject()
setCombatParam(combatSouthEast, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatSouthEast, COMBAT_PARAM_EFFECT, 138)

local combatSouthWest = createCombatObject()
setCombatParam(combatSouthWest, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatSouthWest, COMBAT_PARAM_EFFECT, 138)

local combatWest = createCombatObject()
setCombatParam(combatWest, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatWest, COMBAT_PARAM_EFFECT, 138)

local combatEast = createCombatObject()
setCombatParam(combatEast, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatEast, COMBAT_PARAM_EFFECT, 138)

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
setCombatCallback(combatNorthEast, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
setCombatCallback(combatNorthWest, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
setCombatCallback(combatSouthEast, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
setCombatCallback(combatSouthWest, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
setCombatCallback(combatWest, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
setCombatCallback(combatEast, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combat3 = createCombatObject()
local combat4 = createCombatObject()
local combat5 = createCombatObject()
local combat6 = createCombatObject()
local combat7 = createCombatObject()
local combat8 = createCombatObject()
local combat9 = createCombatObject()
local combat10 = createCombatObject()
local combat11 = createCombatObject()
local combat12 = createCombatObject()

local combats = {combat1, combat2, combat3, combat4, combat5, combat6, combat7, combat8, combat9, combat10, combat11, combat12}
local arr = {}

arr[1] = { -- VAO < \/ 
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 2, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[2] = {-- VAO < \/ 
    {0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 2, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[3] = { -- VAO < \/
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 2, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[4] = { -- VAO > \/
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 2, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[5] = { -- VAO > \/ 
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 2, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0}
}

arr[6] = { -- VAO >
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 2, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0, 0}
}

arr[7] = { -- VAO > /\
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 2, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0}
}

arr[8] = { -- VAO > /\
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 2, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[9] = { -- VAO > /\
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 2, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[10] = { -- VAO < /\
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 2, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[11] = { -- VAO < /\
    {0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 2, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr[12] = { -- VAO <
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 2, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

local combatsTo = {
[1] = combatNorthEast,
[2] = combatNorthEast,
[3] = combatNorthEast,
[4] = combatNorthWest,
[5] = combatNorthWest,
[6] = combatEast,
[7] = combatSouthWest,
[8] = combatSouthWest,
[9] = combatSouthWest,
[10] = combatSouthEast,
[11] = combatSouthEast,
[12] = combatWest
}
local function getDirectionToMod(pos1, pos2)
    local dir = SOUTH

    if(pos1.x > pos2.x) then
        dir = WEST
    elseif(pos1.x < pos2.x) then
        dir = EAST
    elseif(pos1.y > pos2.y) then
        dir = NORTH
    elseif(pos1.y < pos2.y) then
        dir = SOUTH
    end

    return dir
end

for x = 1, #combats do
    setCombatArea(combats[x], createCombatArea(arr[x]))
    function onTargetTile(creature, pos)
	local cid = creature:getId()
        if getTileInfo(getCreaturePosition(cid)).protection then return false end
        doCombat(cid, combatsTo[x], {type=2, pos=pos})
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

function onTargetCreatureNorthEast(cid, target)
    doSlow(cid, target, 35, 2500)
    doDrown(cid, target, 5)
    doSendAnimatedText(getCreaturePosition(target), "Drowned!", 52)
end

setCombatCallback(combatNorthEast, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureNorthEast")

function onTargetCreatureNorthWest(cid, target)
doSlow(cid, target, 35, 2500)
                 doDrown(cid, target, 5)
 doSendAnimatedText(getCreaturePosition(target), "Drowned!", 52)              
end

setCombatCallback(combatNorthWest, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureNorthWest")

function onTargetCreatureSouthEast(cid, target)
doSlow(cid, target, 35, 2500)
                 doDrown(cid, target, 5)
 doSendAnimatedText(getCreaturePosition(target), "Drowned!", 52)
end

setCombatCallback(combatSouthEast, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureSouthEast")

function onTargetCreatureSouthWest(cid, target)
doSlow(cid, target, 35, 2500)
                 doDrown(cid, target, 5)
 doSendAnimatedText(getCreaturePosition(target), "Drowned!", 52)
end

setCombatCallback(combatSouthWest, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureSouthWest")

function onTargetCreatureEast(cid, target)
doSlow(cid, target, 35, 2500)
                 doDrown(cid, target, 5)
 doSendAnimatedText(getCreaturePosition(target), "Drowned!", 52)
end

setCombatCallback(combatEast, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureEast")

function onTargetCreatureWest(cid, target)
doSlow(cid, target, 35, 2500)
                 doDrown(cid, target, 5)
 doSendAnimatedText(getCreaturePosition(target), "Drowned!", 52)
end

setCombatCallback(combatWest, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureWest")

local function removeTable(cid)
    if isCreature(cid) then
		if getDobrasLevel(cid) >= 21 then
			doPlayerAddExaust(cid, "water", "clock", waterExausted.clock-10)
		else
			doPlayerAddExaust(cid, "water", "clock", waterExausted.clock)
		end
        MyLocal.players[cid] = nil
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "clock") == false then
        return false
    end


    if MyLocal.players[cid] == nil then
        if getPlayerHasStun(cid) then
            removeTable(cid)
            return true
        end

        if not canUseWaterSpell(cid, 1, 3, false)  then 
            return false
        end
        
        MyLocal.players[cid] = getCreatureLookDirection(cid)
        for x = 0, #combats-1 do
            addEvent(doCombat, 125*x, cid, combats[x+1], var)
            addEvent(doCombat, (125*x)+1500, cid, combats[x+1], var)
        end

        setCreatureNoMoveTime(cid, 3000)
		exhaustion.set(cid, "AirBarrierReduction", 3)
        doPlayerCancelFollow(cid)
        workAllCdAndAndPrevCd(cid, "water", "clock", 1125, 1)
        addEvent(removeTable, 3000, cid)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end