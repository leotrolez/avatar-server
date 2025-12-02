local spellName = "fire bomb"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, 118)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 3)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 100, 100, 20, 10)


local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
--setCombatParam(combatFocus, COMBAT_PARAM_EFFECT, 118)
setCombatParam(combatFocus, COMBAT_PARAM_DISTANCEEFFECT, 3)
setAttackFormula(combatFocus, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 4, 7)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*7.5)+math.random(40, 50)
    local max = (level+(magLevel/2)*8.0)+math.random(50, 55)
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
    local min = ((level+(magLevel/2)*7.5)+math.random(40, 50))*1.5
    local max = ((level+(magLevel/2)*8.0)+math.random(50, 55))*2.0
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

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end

    if getPlayerExaust(cid, "fire", "bomb", fireExausted.bomb) == false then
        return false
    end
	if getDobrasLevel(cid) >= 13 then
		doPlayerAddExaust(cid, "fire", "bomb", fireExausted.bomb-4)
	else
		doPlayerAddExaust(cid, "fire", "bomb", fireExausted.bomb)
	end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "fire", "bomb", nil, 1)
        return true
    end

    local target = getCreatureTarget(cid)
	local targpos = getThingPos(target)
	doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 118)
    if getPlayerOverPower(cid, "fire", true, true) == true then
        setPlayerStuned(target, 5)
        workAllCdAndAndPrevCd(cid, "fire", "bomb", nil, 1)
        return doCombat(cid, combatFocus, var)
    else
		setPlayerStuned(target, 3)
        workAllCdAndAndPrevCd(cid, "fire", "bomb", nil, 1)
        return doCombat(cid, combat, var)
    end
end