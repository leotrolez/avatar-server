local cf = {}
cf.cooldown = 3
cf.effectz = 1

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, cf.effectz)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, cf.effectz)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, cf.effectz)

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
	
	if getPlayerInWaterWithUnderwater(cid) then -- aprimora a spell dentro d'agua
		total = (total * 1.25)
	end
	
return -total, -total
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
	
	local dano = remakeValue(2, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

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
	
	local dano = remakeValue(2, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat3, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

arr1 = {
	{0, 1, 0},
	{1, 3, 1},
	{0, 1, 0}
}

arr2 = {
	{0, 0, 1, 0, 0},
	{0, 1, 0, 1, 0},
	{1, 0, 2, 0, 1},
	{0, 1, 0, 1, 0},
	{0, 0, 1, 0, 0}
}

arr3 = {
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 1, 0, 1, 0, 0},
	{0, 1, 0, 0, 0, 1, 0},
	{1, 0, 0, 2, 0, 0, 1},
	{0, 1, 0, 0, 0, 1, 0},
	{0, 0, 1, 0, 1, 0, 0},
	{0, 0, 0, 1, 0, 0, 0}
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)

setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)

function onCastSpell(creature, var)
	local cid = creature:getId()

	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "dale") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "dale", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

    doCombat(cid, combat1, var)
    addEvent(doCombat, 500, cid, combat2, var)
    addEvent(doCombat, 1000, cid, combat3, var)
return true
end