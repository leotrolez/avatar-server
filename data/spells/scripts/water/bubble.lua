local chanceFrozzen = 10
local timeFrozzen = 2000

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 28)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 75)


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5

    return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
    if math.random(1, 100) <= chanceFrozzen then
        doFrozzenCreature(target, timeFrozzen)            
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end

  if getPlayerExaust(cid, "water", "bubble") == false then
    return false
  end

    doPlayerAddExaust(cid, "water", "bubble", waterExausted.bubble)
  if getPlayerHasStun(cid) then
        return true
    end
  return doCombat(cid, combat, var) 
end

