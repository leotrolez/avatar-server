local cf = {}
cf.cooldown = 4 -- cooldown
cf.duration = 10 -- duração da movespeed
cf.effectz = 77 -- efeito visual Z

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, cf.duration*1000)
setConditionFormula(condition, 0.3, -36, 0.3, -36)
addCombatCondition(combat, condition)

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "walk") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "walk", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

    if getCreatureCondition(cid, CONDITION_HASTE) then
        doPlayerSendCancel(cid, "You are already running.")
        return false
    end
    return doCombat(cid, combat, var)
end
