local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

setCombatArea(combat, createCombatArea(AREA_CIRCLE2X2))

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5*1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, 50)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 1)
addCombatCondition(combat, condition)

function onCastSpell(creature, var)
	local cid = creature:getId()

    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "regen") == false then 
        return false
    end

    if canUseWaterSpell(cid, 30, 3, false) then 
        workAllCdAndAndPrevCd(cid, "water", "regen", nil, 1)
        doPlayerAddExaust(cid, "water", "regen", waterExausted.regen)
        if getPlayerHasStun(cid) then
            return true
        end
        return doCombat(cid, combat, var)
    else
        return false
    end
end