local spellName = "fire blast"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 6)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 3)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 4, 7)
setCombatArea(combat, createCombatArea(AREA_CROSS1X1))

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combatFocus, COMBAT_PARAM_EFFECT, 6)
setCombatParam(combatFocus, COMBAT_PARAM_DISTANCEEFFECT, 3)
setAttackFormula(combatFocus, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 4, 7)
setCombatArea(combatFocus, createCombatArea(AREA_CROSS1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.0)+math.random(20, 25)
    local max = (level+(magLevel/2)*4.0)+math.random(25, 35)
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*3.0)+math.random(20, 25))*1.5
    local max = ((level+(magLevel/2)*4.0)+math.random(25, 35))*2.0
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()

end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetCreatureFocus(cid, target)

end
setCombatCallback(combatFocus, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureFocus")


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if doPlayerAddExaust(cid, "fire", "blast", fireExausted.blast) == false then
      return false
    end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "fire", "blast", nil, 1)
        return true
    end

  if getPlayerOverPower(cid, "fire", true, true) == true then
        workAllCdAndAndPrevCd(cid, "fire", "blast", nil, 1)
    return doCombat(cid, combatFocus, var)
  else
        workAllCdAndAndPrevCd(cid, "fire", "blast", nil, 1)
    return doCombat(cid, combat, var)
  end
end