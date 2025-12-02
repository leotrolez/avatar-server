local cf = {}
cf.cooldown = 4

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 84)

local area = createCombatArea(AREA_CIRCLE2X2)
setCombatArea(combat, area)

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if not (isImune(cid, target) or (cid == target)) then
		doSlow(cid, target, 35, 1500)
    end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "fire") == true then
		return false
	end
	if getPlayerExaust(cid, "fire", "smoke") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "smoke", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	return doCombat(cid, combat, var)
end
