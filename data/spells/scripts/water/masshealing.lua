local cf = {}
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.effectz = 12

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)

setCombatArea(combat, createCombatArea(AREA_CIRCLE2X2))

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else

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
		local heal = remakeValue(2, math.random(min, max), cid)	
		
		doCreatureAddHealth(target, heal)		
		
		end
	end
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
	if getPlayerExaust(cid, "water", "masshealing") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "masshealing", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
		
        return doCombat(cid, combat, var)
end