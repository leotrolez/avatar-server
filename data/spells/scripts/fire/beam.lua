local cf = {}
cf.cooldown = 4 -- tempo de cooldown para poder usar a spell novamente

local combat1 = createCombatObject()
 setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
 setCombatParam(combat1, COMBAT_PARAM_EFFECT, 5)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 36)

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
	
	local dano = remakeValue(1, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

arr1 = {
{2},
{1},
{0},
{0},
{0},
{0},
{0},
{0},
}

arr2 = {
{1},
{1},
{1},
{1},
{1},
{1},
{1},
{3},
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)

setCombatArea(combat1, area1)
setCombatArea(combat2, area2)

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "fire") == true then
		return false
	end
	if getPlayerExaust(cid, "fire", "beam") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "beam", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	  
    addEvent(doCombat, 0, cid, combat1, var)
    addEvent(doCombat, 500, cid, combat2, var)
	
return true
end