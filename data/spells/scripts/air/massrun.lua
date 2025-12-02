local cf = {}
cf.cooldown = 2
cf.duration = 10
cf.effectz = 77

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_NONE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local area = createCombatArea(AREA_CIRCLE2X2)
setCombatArea(combat, area)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, cf.duration * 1000)
setConditionFormula(condition, 0.3, -36, 0.3, -36)
addCombatCondition(combat, condition)

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "massrun") == false then
		return false
	end
    if getCreatureCondition(cid, CONDITION_HASTE) or isAvaliableTileWaterByPos(getThingPos(cid)) then
        doPlayerSendCancelEf(cid, "You can not use this ability now.")
        return false
    end
	doPlayerAddExaust(cid, "air", "massrun", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	local creatures = combat:getTargets(creature, var)

	for _, target in ipairs(creatures) do
		if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
			if isNonPvp(cid) and not isNonPvp(target) then 
			else
				if not cid == target then
					doAddCondition(target, condition)
				end
			end
		end
	end

    return true
end
