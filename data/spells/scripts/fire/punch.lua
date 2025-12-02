local cf = {}
cf.cooldown = 4

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 30)

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


local function secondPunch(cid, combat, target)
return isCreature(cid) and isCreature(target) and getDistanceBetween(getThingPos(cid), getThingPos(target)) < 2 and doCombat(cid, combat, numberToVariant(target)) and doSlow(cid, target, 15, 1000)
end 

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "fire") == true then
		return false
	end
	if getPlayerExaust(cid, "fire", "punch") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "punch", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

    local target = getCreatureTarget(cid)
    
	if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 1 then
		doPlayerSendCancel(cid, "Creature is not reachable.")
		return false
	end
	
	if target > 0 and getDistanceBetween(getThingPos(cid), getThingPos(target)) <= 1 then
		for i = 1, 5 do
			addEvent(secondPunch, 600*i, cid, combat, target)
		end
		return doCombat(cid, combat, numberToVariant(target))
	end
	return doCombat(cid, combat, var)
end