local spellName = "air wings"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local combatWing = createCombatObject()
setCombatParam(combatWing, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combatWing, COMBAT_PARAM_EFFECT, 76)

local combatVaco = createCombatObject()
setCombatParam(combatVaco, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combatVaco, COMBAT_PARAM_EFFECT, 76)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*2.2)+5
    local max = (level+(magLevel/4)*3.8)+15
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combatWing, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*2.2)+5
    local max = (level+(magLevel/4)*3.8)+15
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combatVaco, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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

local combats = {combat1, combat2, combat3, combat4, combat5, combat6, combat7, combat8, combat9, combat10}
local arr = {}

arr[1] = {
    {1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 2, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 1}
}

arr[2] = {
    {1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 2, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 1}
}

arr[3] = {
    {1, 0, 0, 0, 1},
    {1, 0, 0, 0, 1},
    {1, 0, 2, 0, 1},
    {1, 0, 0, 0, 1},
    {1, 0, 0, 0, 1}
}

arr[4] = {
    {1, 0, 1},
    {1, 3, 1},
    {1, 0, 1},
    {1, 0, 1}
}

arr[5] = {
    {1, 1, 1},
    {1, 3, 1},
    {1, 1, 1},
    {1, 1, 1}
}

arr[6] = {
    {0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1},
    {0, 1, 0, 0, 0},
    {0, 0, 2, 0, 0}
}

arr[7] = {
    {0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0},
    {0, 0, 2, 0, 0}
}

arr[8] = {
    {1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0},
    {0, 0, 2, 0, 0}
}

arr[9] = {
    {1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0},
    {0, 0, 2, 0, 0}
}

arr[10] = {
    {1, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 2, 0, 0, 0}
}

arr[11] = {
    {1, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 2, 0, 0, 0}
}


local function getDirectionToMod(pos1, pos2)
    local dir = SOUTH
	if pos1.x >= pos2.x and pos1.y < pos2.y then 
		return SOUTH
	end 
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
        if x < 4 then
            doCombat(cid, combatWing, {type=2, pos=pos})
        else
            doCombat(cid, combatVaco, {type=2, pos=pos})
        end
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

function onTargetCreatureWing(cid, target)
    local direction = getDirectionToMod(getThingPos(target), getThingPos(cid))
    doPushCreature(target, direction, nil, nil, nil, isPlayer(cid))
end

setCombatCallback(combatWing, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureWing")

function onTargetCreatureVaco(creature, target)
	local cid = creature:getId()
    local direction = MyLocal.players[cid]
    doPushCreature(target, direction, nil, nil, nil, isPlayer(cid))
end

setCombatCallback(combatVaco, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureVaco")

local function removeTable(cid)
    if isCreature(cid) then
		if getDobrasLevel(cid) >= 10 then
			doPlayerAddExaust(cid, "air", "wings", airExausted.wings-3)
		else
			doPlayerAddExaust(cid, "air", "wings", airExausted.wings)
		end
        MyLocal.players[cid] = nil
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "wings") == false then
        return false
    end


    if MyLocal.players[cid] == nil then
        if getPlayerHasStun(cid) then
            removeTable(cid)
            return true
        end

        MyLocal.players[cid] = getCreatureLookDirection(cid)
        for x = 0, #combats-1 do
            addEvent(doCombat, 75*x, cid, combats[x+1], var)
        end

        setCreatureNoMoveTime(cid, 1000)
        doPlayerCancelFollow(cid)
        workAllCdAndAndPrevCd(cid, "air", "wings", 1000, 1)
        addEvent(removeTable, 1000, cid)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end

