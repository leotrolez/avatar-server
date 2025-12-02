local cf = {}
cf.cooldown = 4

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

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
	
	local dano = remakeValue(4, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)

	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + 5)
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + 25)
	
	local total = math.random(min, max)
	
	if getPlayerInWaterWithUnderwater(cid) then -- reduz dano dentro da agua
		total = (total * 0.6)
	end
	
return -total, -total
end
setCombatCallback(combat2, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

arr1 = {
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 3, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 0, 0},
	{1, 1, 1, 1, 0, 0, 0}
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)

setCombatArea(combat1, area1)
setCombatArea(combat2, area2)

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "earth") == true then
		return false
	end
	if getPlayerExaust(cid, "earth", "palm") == false then
		return false
	end
	doPlayerAddExaust(cid, "earth", "palm", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	pos = getCreaturePosition(cid)
	newpos = {x = pos.x + 5, y = pos.y + 5, z = pos.z}
	doSendMagicEffect(newpos, 213)
	doCombat(cid, combat1, var)
	doCombat(cid, combat2, var)

return true
end