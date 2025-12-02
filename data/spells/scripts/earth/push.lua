local MyLocal = {}
MyLocal.earthId = 5747
MyLocal.time = 3

local combat = createCombatObject()
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.0)+math.random(2, 3)
    local max = (level+(magLevel/3)*3.3)+math.random(3, 4)

	min = remakeAirEarth(cid, min)
	max = remakeAirEarth(cid, max)
    return -min, -max
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local playerPos = getCreaturePos(cid)
  local targetPos = getCreaturePos(target)
  doPushCreature(target, getDirectionTo(playerPos, targetPos))
  doCombat(cid, combat2, numberToVariant(target))
  doCreateItem(MyLocal.earthId, targetPos)
  addEvent(removeTileItemById, MyLocal.time*1000, targetPos, MyLocal.earthId)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end 
  if getPlayerExaust(cid, "earth", "push", earthExausted.push) == false then
    return false
  end
  doPlayerAddExaust(cid, "earth", "push", earthExausted.push)
  if getPlayerHasStun(cid) then
        return true
    end
  doCombat(cid, combat, var)
  return true                                                                                                                                                                                           
end     





