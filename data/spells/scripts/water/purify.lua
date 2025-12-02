local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 12)

setCombatArea(combat, createCombatArea({{3}}))

function onTargetCreature(creature, target)
  local cid = creature:getId()
    local conditions = {CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_LIFEDRAIN, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_DRUNK}

    for x = 1, #conditions do
        doRemoveCondition(target, conditions[x])
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "purify") == false then
        return false
    end
    if canUseWaterSpell(cid, 1, 3, false) then
        doPlayerAddExaust(cid, "water", "purify", waterExausted.purify) 
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "water", "purify", nil, 1)
            return true
        end
        
        doCombat(cid, combat, var)
        workAllCdAndAndPrevCd(cid, "water", "purify", nil, 1)
        return true
    else
        return false
    end
end