local cf = {}
cooldown = 4 -- tempo de cooldown para poder usar a spell novamente

local function purify(var)
    local conditions = {CONDITION_SILENCED, CONDITION_MISSED}
	local hasPurify = 0
    for x = 1, #conditions do
		if (hasCondition(var, conditions[x])) then 
			doRemoveCondition(var, conditions[x])
			hasPurify = 1
		end
	end
	setPlayerStuned(var, 1)
	doSendAnimatedText(getCreaturePosition(var), "Can Cast!", 215)
end

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 76)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

function onCastSpell(creature, var)
	local cid = creature:getId()
	
	if getPlayerExaust(cid, "air", "voice") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "voice", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
  				
	if isPlayer(cid) == TRUE then
		purify(cid)
	end
	
    return doCombat(cid, combat, var)
end