local cf = {}
cf.cooldown = 4

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)

	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local dodge = getPlayerStorageValue(cid, "dodgevalue")
	if not dodge then dodge = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0) + 5)
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0) + 25)
	
	local total = math.random(min, max)
	
return -total, -total
end
setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

local area = createCombatArea(AREA_CIRCLE2X2)
setCombatArea(combat, area)

function onTargetCreature(creature, target)
  local cid = creature:getId()
	cpos = getCreaturePosition(cid)
	tpos = getCreaturePosition(target)
	if not isPzPos(tpos) then
		doSendDistanceShoot(cpos, tpos, 40)
		doSendMagicEffect(tpos, 2)
	end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "windcall") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "windcall", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	return doCombat(cid, combat, var)
end
