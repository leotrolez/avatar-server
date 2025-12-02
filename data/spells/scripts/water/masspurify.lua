local cf = {}
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.effectz = 12

local function purify(var)
    local conditions = {CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_LIFEDRAIN, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_DRUNK, CONDITION_OUTFIT}
	local hasPurify = 0
    for x = 1, #conditions do
		if (hasCondition(var, conditions[x])) then 
			doRemoveCondition(var, conditions[x])
			hasPurify = 1
		end
	end
	doSendAnimatedText(getCreaturePosition(var), "Purified!", 35)
end

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setCombatArea(combat, createCombatArea({
	{0, 1, 1, 1, 0},
	{1, 1, 1, 1, 1},
	{1, 1, 3, 1, 1},
	{1, 1, 1, 1, 1},
	{0, 1, 1, 1, 0}
}))

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else		
			if isPlayer(target) then
				purify(target)	
			end
		end
	end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "masspurify") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "masspurify", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
    return doCombat(cid, combat, var)
end