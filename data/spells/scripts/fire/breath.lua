local cf = {}
cf.cooldown = 4 -- tempo de cooldown para poder usar a spell novamente

local function purify(var)
    local conditions = {CONDITION_FIRE, CONDITION_PARALYZE, CONDITION_DRUNK}
	local hasPurify = 0
    for x = 1, #conditions do
		if (hasCondition(var, conditions[x])) then 
			doRemoveCondition(var, conditions[x])
		end
	end
	if hasCondition(var, CONDITION_OUTFIT) and getCreatureOutfit(var).lookType ~= 267 then
		doRemoveCondition(var, CONDITION_OUTFIT)
	end
	doCreatureSetNoMove(var, false)
	doSendAnimatedText(getCreaturePosition(var), "Can Walk!", 180)
end

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 13)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getPlayerExaust(cid, "fire", "breath") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "breath", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
		
	if isPlayer(cid) == TRUE then
		purify(cid)
	end
	
    return true
end