local cf = {}
cf.cooldown = 4
cf.interval = 1500 -- intervalo entre um tick e outro em milisegundos

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 13)

local area = createCombatArea(AREA_CROSS2X2)
setCombatArea(combat, area)

function onTargetCreature(creature, target)
  local cid = creature:getId() 
	return doChallengeCreature(cid, target) 
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

if getSpellCancels(cid, "earth") == true then
	return false
end
  if getPlayerExaust(cid, "earth", "challenge") == false then
	return false
  end
doPlayerAddExaust(cid, "earth", "challenge", cf.cooldown)
if getPlayerHasStun(cid) then
	return true
end

    doCombat(cid, combat, var)
	addEvent(doCombat, cf.interval, cid, combat, var)
	return true
end
