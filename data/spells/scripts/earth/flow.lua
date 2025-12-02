local cf = {}
cf.cooldown = 4
cf.effectz = 84
cf.duration = 2 -- segundos de duracao da paralyze

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)

local area = createCombatArea(AREA_CIRCLE2X2)
setCombatArea(combat, area)

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if isImune(cid, target) or (cid == target) then
	else	
		doSlow(cid, target, 30, cf.duration * 1000)
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "flow") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "flow", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	return doCombat(cid, combat, var)
end
