local cf = {}
cf.cooldown = 4

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "fire") == true then
		return false
	end
	  if getPlayerExaust(cid, "fire", "flash") == false then
		return false
	  end
	doPlayerAddExaust(cid, "fire", "flash", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
    local target = getCreatureTarget(cid)
	doSlow(cid, target, 40, 1500)
	local mypos = getThingPos(cid)
	doSendMagicEffect(mypos, 90)
	local targpos = getThingPos(target)
	doSendDistanceShoot({x=mypos.x, y=mypos.y, z=mypos.z}, targpos, 3)
	doSendMagicEffect({x=targpos.x, y=targpos.y, z=targpos.z}, 22)
	
	return doCombat(cid, combat, {pos=targpos, type=2})

end