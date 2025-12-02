local cf = {}
cf.cooldown = 3

local MyLocal = {}

local combat = createCombatObject()
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 41)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 28)

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local playerPos = getCreaturePos(cid)
  local targetPos = getCreaturePos(target)
  if getDistanceBetween(playerPos, targetPos) > 1 and getPlayerStorageValue(target, "playerOnAir") == 1 then							
	doPushCreature(target, getDirectionTo(targetPos, playerPos), 1, 500, false, true)
  elseif getDistanceBetween(playerPos, targetPos) > 1 then
    doPushCreature(target, getDirectionTo(targetPos, playerPos))
  end
  doCombat(cid, combat2, numberToVariant(target))
  doSendMagicEffect(targetPos, 35)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "claw") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "claw", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
  doSlow(cid, variantToNumber(var), 30, 1500)
  doCombat(cid, combat, var)
  return true                                                                                                                                                                                           
end     





