local spellName = "earth rock"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.removeEvent = {}

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 11)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 34)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 11)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_DISTANCEEFFECT, 11)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*3.9)+5
    local max = (level+(magLevel/5)*4.3)+5
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.6
		max = max*0.6
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*3.9)+8
    local max = (level+(magLevel/5)*4.5)+8
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.6
		max = max*0.6
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*4.0)+12
    local max = (level+(magLevel/5)*4.6)+12
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.6
		max = max*0.6
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat3, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combats = {combat1, combat1, combat1, combat2, combat2, combat3}

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
  if getPlayerExaust(cid, "earth", "rock") == false then
    return false
  end	
	local dif = 0
	if MyLocal.removeEvent[cid] ~= nil then 
		stopEvent(MyLocal.removeEvent[cid])
		dif = 2
	end
	if getDobrasLevel(cid) >= 3 and dif ~= 2 then
		dif = 2
	end 
	MyLocal.removeEvent[cid] = addEvent(function() MyLocal.removeEvent[cid] = nil end, 6500)
    doPlayerAddExaust(cid, "earth", "rock", earthExausted.rock+dif)
  if getPlayerHasStun(cid) then
        return true
    end
	local target = variantToNumber(var)
	if isCreature(target) then 
		local targpos = getCreaturePosition(target)
		doSendAnimatedText(targpos, "Slowed!", 120, cid)
		doSendAnimatedText(targpos, "Slowed!", 120, target)
		if dif == 0 then dif = 1 end
		doSlow(cid, target, 35, 1250*dif)
		if dif == 2 then 
			addEvent(function() if isCreature(cid) and isCreature(variantToNumber(var)) and not isInPz(cid) and not isInPz(variantToNumber(var)) then doCombat(cid, combats[math.random(1,6)], var) end end, 250)
		end
	end 
  return doCombat(cid, combats[math.random(1,6)], var) 
end
