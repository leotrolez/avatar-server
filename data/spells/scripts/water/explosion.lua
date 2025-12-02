local spellName = "water explosion"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.removeEvent = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 53)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 46)
setCombatArea(combat, createCombatArea(AREA_CROSS1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*3.2)+(math.random(20, 25)/2)
    local max = (level+(magLevel/4)*3.5)+(math.random(25, 35)/2)
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	if getDobrasLevel(cid) >= 2 then
		dano = dano*1.2
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end  
	if getPlayerExaust(cid, "water", "explosion") == false then
        return false
    end
	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end
	local dif = 1
	if MyLocal.removeEvent[cid] ~= nil then 
		stopEvent(MyLocal.removeEvent[cid])
		dif = 2
	end
	MyLocal.removeEvent[cid] = addEvent(function() MyLocal.removeEvent[cid] = nil end, 3000)
    if doPlayerAddExaust(cid, "water", "explosion", waterExausted.explosion*dif) == false then
      return false
     end
    workAllCdAndAndPrevCd(cid, "water", "explosion", nil, 1)

    if getPlayerHasStun(cid) then
        return true
    end
    if dif == 2 then 
		addEvent(function() if isCreature(cid) and isCreature(variantToNumber(var)) and not isInPz(cid) and not isInPz(variantToNumber(var)) then doCombat(cid, combat, var) end end, 250)
		addEvent(function() if isCreature(cid) and isCreature(variantToNumber(var)) and not isInPz(cid) and not isInPz(variantToNumber(var)) then doCombat(cid, combat, var) end end, 500)
	end
  return doCombat(cid, combat, var)
end