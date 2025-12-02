local cf = {}
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.effectx = 42
cf.paralyzeDuration = 5

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, cf.effectx)

function onCastSpell(creature, var)
	local cid = creature:getId()
	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "jet") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "jet", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	local target = creature:getTarget()
	if target then
		doSlow(cid, target:getId(), 40, cf.paralyzeDuration*1000)
	end
	return(doCombat(cid, combat, var))
end
