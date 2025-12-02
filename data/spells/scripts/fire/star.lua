local spellName = "fire star"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}
MyLocal.players = {}

--local combat2 = createCombatObject()
--setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
--setCombatParam(combat2, COMBAT_PARAM_CREATEITEM, 1492)

-- START SYSTEM TARGET
local combatStarTarget = createCombatObject()
setCombatParam(combatStarTarget, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

local combatStarTargetFocus = createCombatObject()
setCombatParam(combatStarTargetFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.5)+math.random(30, 40)
    local max = (level+(magLevel/2)*5.2)+math.random(40, 55)
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = 50
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end

setCombatCallback(combatStarTarget, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.5)+math.random(30, 40)*3.0
    local max = (level+(magLevel/2)*5.2)+math.random(40, 55)*4.0
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = 50
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end

setCombatCallback(combatStarTargetFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

-- END SYSTEM TARGET

local combat1 = createCombatObject()
local combat1Focus = createCombatObject()

local combat = createCombatObject()
setCombatParam(combat,COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat,COMBAT_PARAM_EFFECT, 15)
setCombatFormula(combat,COMBAT_FORMULA_LEVELMAGIC,-1.3,-30,-1.7,0)

local combatFocus = createCombatObject()
setCombatParam(combatFocus,COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combatFocus,COMBAT_PARAM_EFFECT, 15)
setCombatFormula(combatFocus,COMBAT_FORMULA_LEVELMAGIC,-1.3,-30,-1.7,0)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.5)+math.random(30, 40)
    local max = (level+(magLevel/2)*5.2)+math.random(40, 55)
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
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*4.5)+math.random(30, 40))*1.5
    local max = ((level+(magLevel/2)*5.2)+math.random(40, 55))*2.0
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
    return -dano, -dano
end
setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local area = createCombatArea(AREA_CIRCLE3X3)
setCombatArea(combat1, area)
setCombatArea(combat1Focus, area)

function onTargetTile(creature, pos)
	local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
    local randOne, randTwo, randThree = math.random(1, 5), math.random(1, 3), math.random(1, 50)
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
    if randOne >= 3 then
        doCombat(cid, combat, {type=2, pos=pos})
        if randTwo == 3 then
            doSendDistanceShoot(getThingPos(cid), pos, 18)
        end
        if randThree == 1 then
            if isPlayer(cid) then
                if getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true, checkWater = true}) then

                    if not getPlayerHasInQuest(cid, "resetQuest") then
                       -- doCombat(cid, combat2, {type=2, pos=pos})
                    end
                end
            end
        end
    end
end
setCombatCallback(combat1, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetTileFocus(cid, pos)
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
    local randOne, randTwo, randThree = math.random(1, 5), math.random(1, 3), math.random(1, 50)
    if randOne >= 3 then
        doCombat(cid, combatFocus, {type=2, pos=pos})
        if randTwo == 3 then
            doSendDistanceShoot(getThingPos(cid), pos, 18)
        end
        if randThree == 1 then
            if getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true, checkWater = true}) then
                if not getPlayerHasInQuest(cid, "resetQuest") then
                    --doCombat(cid, combat2, {type=2, pos=pos})
                end
            end
        end
    end
end
setCombatCallback(combat1Focus, CALLBACK_PARAM_TARGETTILE, "onTargetTileFocus")

local function removeTable(cid)
    if isCreature(cid) then
		if getDobrasLevel(cid) >= 8 then
			doPlayerAddExaust(cid, "fire", "star", fireExausted.star-5)
		else
			doPlayerAddExaust(cid, "fire", "star", fireExausted.star)
		end
        MyLocal.players[cid] = nil
    end
end

local function doCombatOne(cid)
    if not isCreature(cid) then
        return
    end

    local var = {type=2, pos=getCreaturePosition(cid)}
    doCombat(cid, combat1, var)
end

local function doCombatTwo(cid)
    if not isCreature(cid) then
        return
    end
    
    local var = {type=2, pos=getCreaturePosition(cid)}
    doCombat(cid, combat1Focus, var)
end

local function starWork(cid, times, isFocus)
	if not isCreature(cid) or isInPz(cid) then return false end
		local pos = getCreaturePosition(cid)
		local target = getCreatureTarget(cid)
		if isCreature(target) then
			local posT = getCreaturePosition(target)
			if getDistanceBetween(pos, posT) <= 4 and isSightClear(pos, posT, true) then
				if not isFocus then
					doCombat(cid, combatStarTarget, numberToVariant(target))
				else
					doCombat(cid, combatStarTargetFocus, numberToVariant(target))
				end
				doSendDistanceShoot(pos, posT, 3)
				doSendDistanceShoot(pos, posT, 18)
			end
		end
	if times > 0 then 
		addEvent(starWork, 500, cid, times-1, isFocus)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if MyLocal.players[cid] == nil then
        if getPlayerExaust(cid, "fire", "star", fireExausted.star) == false then
            return false
        end
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "fire", "star", nil, 1)
            removeTable(cid)
            return true
        end
        addEvent(removeTable, 6*500, cid)
        MyLocal.players[cid] = true
        if getPlayerOverPower(cid, "fire", true, true) then
            for a = 0, 6 do
                addEvent(doCombatTwo, 500*a, cid)    
            end
			starWork(cid, 6, true)
        else
            for a = 0, 6 do
                addEvent(doCombatOne, 500*a, cid)
            end
			starWork(cid, 6, false)
        end
        workAllCdAndAndPrevCd(cid, "fire", "star", 3, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
