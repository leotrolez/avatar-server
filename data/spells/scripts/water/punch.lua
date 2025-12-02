local spellName = "water punch"
local cf = {atk = spellsInfo[spellName].atk, slowPercent = spellsInfo[spellName].slowPercent, slowTempo = spellsInfo[spellName].slowTempo}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 87)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*1.5)+2
    local max = (level+(magLevel/2)*2.2)+5		

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	if getDobrasLevel(cid) >= 12 then
		dano = dano*1.2
	end
	dano = dano/2
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function secondPunch(cid, combat, target)
return isCreature(cid) and isCreature(target) and getDistanceBetween(getThingPos(cid), getThingPos(target)) < 2 and doCombat(cid, combat, numberToVariant(target)) and doSlow(cid, target, cf.slowPercent/2, cf.slowTempo/2, 135)
end 

function onCastSpell(creature, var)
	local cid = creature:getId()
    local target = getCreatureTarget(cid)
    
    if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 1 then
      doPlayerSendCancelEf(cid, "Creature is not reachable.")
    return false
  end
    if getSpellCancels(cid, "water") == true then
        return false
    end
  if getPlayerExaust(cid, "water", "punch", waterExausted.punch) == false then
    return false
  end
  if getPlayerHasStun(cid) then
        return true
    end
  if not canUseWaterSpell(cid, 1, 3, false)  then 
    return false
  end
  doPlayerAddExaust(cid, "water", "punch", waterExausted.punch)

  if target > 0 and getDistanceBetween(getThingPos(cid), getThingPos(target)) <= 1 then
	for i = 1, 5 do
		addEvent(secondPunch, 600*i, cid, combat, target)
	 end
     return doCombat(cid, combat, numberToVariant(target))
  end
  return doCombat(cid, combat, var)
end