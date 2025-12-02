local cf = {}
cf.cooldown = 4

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 19)

local area = createCombatArea(AREA_CIRCLE2X2)
setCombatArea(combat, area)

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if isImune(cid, target) or (cid == target) then
		return false
	else	
		doSlow(cid, target, 35, 2000)
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "haze") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "haze", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	return doCombat(cid, combat, var)
end
