local cf = {}
cf.cooldown = 3

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE) -- MUDAR PARA PHYSICALDAMAGE
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 41) -- MUDAR PARA EFEITO DE FLECHA DE AR

function onTargetCreature(creature, target)
  local cid = creature:getId()
	local initialFloor = getThingPos(target).z
        if isCreature(target) and getThingPos(target).z == initialFloor and not isInPz(target) then 
          doSendMagicEffect(getThingPos(target), 2)
		  doSlow(cid, target, 30, 1500)
          doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, isPlayer(cid))
        end 
 return true
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature") -- new

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "fist") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "fist", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	return doCombat(cid, combat, var)
end
