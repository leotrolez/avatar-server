local spellName = "water tsunami"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.areas = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 53)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*6.1)+math.random(5, 10)
    local max = (level+(magLevel/3)*7.2)+math.random(10, 15)

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

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combat3 = createCombatObject()
local combat4 = createCombatObject()
local combat5 = createCombatObject()
local combat6 = createCombatObject()
local combat7 = createCombatObject()


MyLocal.areas[1] = {{0, 1, 3, 1, 0}}

MyLocal.areas[2] = {{0, 1, 1, 1, 1, 1, 0},
                    {0, 0, 0, 2, 0, 0, 0}}

MyLocal.areas[3] = {{0, 1, 1, 1, 1, 1, 1, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 2, 0, 0, 0, 0}}

MyLocal.areas[4] = {{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0}}

MyLocal.areas[5] = {{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0}}

MyLocal.areas[6] = {{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0}}

MyLocal.areas[7] = {{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0}}



local combats = {combat1, combat2, combat3, combat4, combat5, combat6, combat7}

for x = 1, #MyLocal.areas do
  setCombatArea(combats[x], createCombatArea(MyLocal.areas[x]))
end

for x = 1, #combats do
    function onTargetTile(creature, pos)
	local cid = creature:getId()
        doCombat(cid, combat, {type=2, pos=pos})
        doSendMagicEffect(pos, 53)
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
	doSlow(cid, target, 5, 3000)
    doPushCreature(target, MyLocal.players[cid].dir)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid)
    if not isCreature(cid) then
        return false
    end

    MyLocal.players[cid] = nil
	if getDobrasLevel(cid) >= 20 then
		doPlayerAddExaust(cid, "water", "tsunami", waterExausted.tsunami-9)
	else
		doPlayerAddExaust(cid, "water", "tsunami", waterExausted.tsunami)
	end
end

local function sendWave(cid, isEnd)
        if not isCreature(cid) then
            return false
        end

        local dir = getCreatureLookDirection(cid)
        MyLocal.players[cid].dir = dir
        for x = 1, #combats do
            addEvent(doCombat, 100*x, cid, combats[x], {type=2, pos=getPositionByDirection(getThingPos(cid), dir)})
        end

        if isEnd then
            addEvent(removeTable, 100*#combats, cid)
        end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "tsunami") == false then 
        return false
    end

    if MyLocal.players[cid] ~= nil then
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end

    if canUseWaterSpell(cid, nil, 1, true) then
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "water", "tsunami", nil, 1)
			if getDobrasLevel(cid) >= 20 then
				doPlayerAddExaust(cid, "water", "tsunami", waterExausted.tsunami-9)
			else
				doPlayerAddExaust(cid, "water", "tsunami", waterExausted.tsunami)
			end
            return true
        end
        MyLocal.players[cid] = {dir = nil}
        setCreatureNoMoveTime(cid, 750) 
        sendWave(cid, true)
        workAllCdAndAndPrevCd(cid, "water", "tsunami", 3, 1)
        return true
    else
        return false
    end
end