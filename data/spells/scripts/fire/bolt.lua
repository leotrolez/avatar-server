local spellName = "fire bolt"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat, createCombatArea(AREA_CROSS1X1))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local combatFocus2 = createCombatObject()
setCombatParam(combatFocus2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, 6)
--setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 3)
--setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 4, 7)

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combatFocus, createCombatArea(AREA_CROSS1X1))
--setAttackFormula(combatFocus, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 4, 7)

local combats = {combat, combat2}
for i = 1, #combats do 
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.0)+math.random(20, 25)
    local max = (level+(magLevel/2)*4.0)+math.random(25, 35)
	
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combats[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

local combatsFocus = {combatFocus, combatFocus2}
for i = 1, #combatsFocus do 
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*3.0)+math.random(20, 25))*1.5
    local max = ((level+(magLevel/2)*4.0)+math.random(25, 35))*1.5
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combatsFocus[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
local targpos = getCreaturePosition(target)
  doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 131)
  doSendAnimatedText(targpos, "Slowed!", 155, cid)
	doSendAnimatedText(targpos, "Slowed!", 155, target)
		doSlow(cid, target, 25, 2500)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetCreatureFocus(cid, target)
local targpos = getCreaturePosition(target)
  doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 131)  
  doSendAnimatedText(targpos, "Slowed!", 155, cid)
	doSendAnimatedText(targpos, "Slowed!", 155, target)
		doSlow(cid, target, 40, 3500)
end
setCombatCallback(combatFocus, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureFocus")


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
	local theCooldown = fireExausted.bolt
	if getDobrasLevel(cid) >= 6 then
		theCooldown = theCooldown-2
	end
    if doPlayerAddExaust(cid, "fire", "bolt", theCooldown) == false then
      return false
    end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "fire", "bolt", nil, 1)
        return true
    end
	local target = getCreatureTarget(cid)
  if getPlayerOverPower(cid, "fire", true, true) == true then
        workAllCdAndAndPrevCd(cid, "fire", "bolt", nil, 1)
		for i =1, 2 do 
			addEvent(function() if isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) then doCombat(cid, combatFocus2, numberToVariant(target)) end end, 250*i)
		end
    return doCombat(cid, combatFocus, var)
  else
        workAllCdAndAndPrevCd(cid, "fire", "bolt", nil, 1)
		for i =1, 2 do 
			addEvent(function() if isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) then doCombat(cid, combat2, numberToVariant(target)) end end, 250*i)
		end
    return doCombat(cid, combat, var)
  end
end