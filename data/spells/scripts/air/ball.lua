local spellName = "air ball"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.removeEvent = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 41)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.3, -30, -0.4, 0)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level+(magLevel/2)*1.04
    local max = level+(magLevel/2)*1.44
	
	local dano = math.random(min, max) + math.random(6, 16)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onCastSpell(creature, var)
	local cid = creature:getId()
	local dif = 0
	if MyLocal.removeEvent[cid] ~= nil then 
		stopEvent(MyLocal.removeEvent[cid])
		dif = 1
	end
	MyLocal.removeEvent[cid] = addEvent(function() MyLocal.removeEvent[cid] = nil end, 3000)
	if dif ~= 1 and getDobrasLevel(cid) >= 1 then 
		dif = 1
	end
    local checks = allSpellChecks(cid, "air ball", airExausted.ball+dif) --Nova func em beta :D
    if checks == "ready" then
		if dif == 1 then 
			addEvent(function() if isCreature(cid) and isCreature(variantToNumber(var)) and not isInPz(cid) and not isInPz(variantToNumber(var)) then doCombat(cid, combat, var) end end, 250)
		end
        return doCombat(cid, combat, var)
    end
    return checks
end