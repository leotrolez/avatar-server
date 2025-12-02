local spellName = "water icebolt"
local cf = {atk = spellsInfo[spellName].atk, frozzenTime = spellsInfo[spellName].frozzenTime}

local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 44)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 100, 100, 20, 10)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*7.5)+math.random(40, 50)
    local max = (level+(magLevel/2)*8.0)+math.random(50, 55)

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


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "icebolt", waterExausted.icebolt) == false then
        return false
    end
    local target = getCreatureTarget(cid)
	if cantReceiveDisable(cid, target) then
		return false
	end
	if not canUseWaterSpell(cid, 1, 3, false)  then 
        return false
    end
	if getDobrasLevel(cid) >= 17 then
		doPlayerAddExaust(cid, "water", "icebolt", waterExausted.icebolt-4)
	else
		doPlayerAddExaust(cid, "water", "icebolt", waterExausted.icebolt)
	end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "water", "icebolt", nil, 1)
        return true
    end



	doFrozzenCreature(target, cf.frozzenTime)
	local mypos = getThingPos(cid)
	local targpos = getThingPos(target)
	doSendMagicEffect({x=mypos.x+1, y=mypos.y+1, z=mypos.z}, 116)
	doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 117)
     workAllCdAndAndPrevCd(cid, "water", "icebolt", nil, 1)
     return doCombat(cid, combat, var)
end