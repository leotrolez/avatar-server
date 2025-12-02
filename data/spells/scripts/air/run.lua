local spellName = "air run"
local cf = {duracao = spellsInfo[spellName].duracao}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 77)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, cf.duracao)
setConditionFormula(condition, 0.3, -36, 0.3, -36)
addCombatCondition(combat, condition)

local combatUp = createCombatObject()
setCombatParam(combatUp, COMBAT_PARAM_EFFECT, 77)
setCombatParam(combatUp, COMBAT_PARAM_AGGRESSIVE, 0)

local conditionUp = createConditionObject(CONDITION_HASTE)
setConditionParam(conditionUp, CONDITION_PARAM_TICKS, cf.duracao+8000)
setConditionFormula(conditionUp, 0.3, -36, 0.3, -36)
addCombatCondition(combatUp, conditionUp)


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "run") == false then
        return false
    end
    if getCreatureCondition(cid, CONDITION_HASTE) or isAvaliableTileWaterByPos(getThingPos(cid)) then
        doPlayerSendCancelEf(cid, "You can not use this ability now.")
        return false
    end
    doPlayerAddExaust(cid, "air", "run", airExausted.run)
    if getPlayerHasStun(cid) then
        return true
    end
	if getDobrasLevel(cid) >= 3 then 
		return doCombat(cid, combatUp, var)
	end 
    return doCombat(cid, combat, var)
end
