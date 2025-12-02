local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 6)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_LIGHT)
setConditionParam(condition, CONDITION_PARAM_LIGHT_LEVEL, 10)
setConditionParam(condition, CONDITION_PARAM_LIGHT_COLOR, 215)
setConditionParam(condition, CONDITION_PARAM_TICKS, (6 * 60 + 10) * 1000)
addCombatCondition(combat, condition)

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_EFFECT, 6)
setCombatParam(combatFocus, COMBAT_PARAM_AGGRESSIVE, 0)

local conditionFocus = createConditionObject(CONDITION_LIGHT)
setConditionParam(conditionFocus, CONDITION_PARAM_LIGHT_LEVEL, 20)
setConditionParam(conditionFocus, CONDITION_PARAM_LIGHT_COLOR, 215)
setConditionParam(conditionFocus, CONDITION_PARAM_TICKS, (15 * 60 + 10) * 1000)
addCombatCondition(combatFocus, conditionFocus)

function onCastSpell(creature, var)
	local cid = creature:getId()
  if getSpellCancels(cid, "fire") == true then
        return false
    end
    if doPlayerAddExaust(cid, "fire", "light", fireExausted.light) == false then
      return false
     end
     if getPlayerHasStun(cid) then
       workAllCdAndAndPrevCd(cid, "fire", "light", nil, 1)
       return true
    end
  if getPlayerOverPower(cid, "fire", true, true) then
    workAllCdAndAndPrevCd(cid, "fire", "light", nil, 1)
    return doCombat(cid, combatFocus, var)
  else
    workAllCdAndAndPrevCd(cid, "fire", "light", nil, 1)
    return doCombat(cid, combat, var)
  end
end