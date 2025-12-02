local cf = {}
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.stunDuration = 2 -- duracao paralyze
cf.effect = 43

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effect)

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
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

arr1 = {
	{1, 1, 1},
	{1, 1, 1},
	{1, 1, 1},
	{1, 1, 1},
	{0, 1, 0},
	{0, 3, 0}
}

local area1 = createCombatArea(arr1)

setCombatArea(combat, area1)

function onTargetCreature(creature, target)
  local cid = creature:getId()
    if isNpc(target) then
        return false
    end
	doSlow(cid, target, 35, cf.stunDuration*1000)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
      
	if not canUseWaterSpell(cid, 1, 3, false) then
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "pump") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "pump", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	  
    doCombat(cid, combat, var)	
return true
end