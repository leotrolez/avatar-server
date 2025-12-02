local spellName = "water bubbles"
local cf = {atk = spellsInfo[spellName].atk, bolhas = spellsInfo[spellName].bolhas}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 25)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 53)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 25)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*2.7)+5
    local max = (level+(magLevel/2)*3.0)+5
	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*2.7)+5
    local max = (level+(magLevel/2)*3.0)+5
	min = min * 0.4
	max = max * 0.4
	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function doDrown(cid, combat, var, times)
	if times <= 0 then
		return false 
	end 
local target = variantToNumber(var)
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and doCombat(cid, combat, var) and addEvent(doDrown, 1000, cid, combat, var, times-1)
end

local function doBubbles(cid, combat, var, times)
times = times or 1
local target = variantToNumber(var)
	if times > cf.bolhas then
		if isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and isSightClear(getThingPos(cid), getThingPos(target), true) and getDistanceBetween(getThingPos(cid), getThingPos(target)) < 5 then 
			addEvent(doDrown, 500, cid, combat2, var, 5)
			doSendAnimatedText(getCreaturePosition(variantToNumber(var)), "Drowned!", 52)
		end
		return false 
	end 
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and isSightClear(getThingPos(cid), getThingPos(target), true) and getDistanceBetween(getThingPos(cid), getThingPos(target)) < 5 and doCombat(cid, combat, var) and addEvent(doBubbles, 300, cid, combat, var, times+1)
end
function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
  if getPlayerExaust(cid, "water", "bubbles") == false then
    return false
  end
  if not canUseWaterSpell(cid, 1, 3, false)  then 
    return false
  end
	if getDobrasLevel(cid) >= 15 then
		doPlayerAddExaust(cid, "water", "bubbles", waterExausted.bubbles-2)
	else
		doPlayerAddExaust(cid, "water", "bubbles", waterExausted.bubbles)
	end
    if getPlayerHasStun(cid) then
        return true
    end

  return doBubbles(cid, combat, var) 
end
