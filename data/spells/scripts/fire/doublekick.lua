local cf = {}
cf.cooldown = 4

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatArea(combat, createCombatArea(AREA_SQUARE1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local dodge = getPlayerStorageValue(cid, "dodgevalue")
	if not dodge then dodge = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
	
	local dano = remakeValue(1, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "fire") == true then
		return false
	end
	if getPlayerExaust(cid, "fire", "doublekick") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "doublekick", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
    local target = getCreatureTarget(cid)
	local mypos = getThingPos(cid)
	doSendMagicEffect(mypos, 90)
	local targpos = getThingPos(target)
	doSendDistanceShoot({x=mypos.x+1, y=mypos.y, z=mypos.z}, targpos, 3)
	doSendDistanceShoot({x=mypos.x-1, y=mypos.y, z=mypos.z}, targpos, 3)
	doSendDistanceShoot({x=mypos.x, y=mypos.y+1, z=mypos.z}, targpos, 3)
	doSendDistanceShoot({x=mypos.x, y=mypos.y-1, z=mypos.z}, targpos, 3)
	doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 137)
	return doCombat(cid, combat, {pos=targpos, type=2})
end