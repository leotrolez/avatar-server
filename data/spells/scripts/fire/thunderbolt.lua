local spellName = "fire thunderbolt"

local cf = {
efeito = 136,
chanceElectrify = 100,
multiplicadorImpacto = 3,
multiplicadorAoe = 2,
multiplicadorElectrify = 0.4,
hitsElectrify = 6,
extraDano = 50,
atk = spellsInfo[spellName].atk
}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 48)
setCombatArea(combat3, createCombatArea(
      {
          {0, 0, 0, 1, 0, 0, 0},
          {0, 0, 1, 2, 1, 0, 0},
          {0, 0, 0, 1, 0, 0, 0}
      }))

      
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
      if exhaustion.check(cid, "isFocusThunderbolt") then 
        min = min*1.5
        max = max*1.5
      end 
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
 
	dano = remakeValue(1, dano, cid)
    return -dano*cf.multiplicadorImpacto, -dano*cf.multiplicadorImpacto
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
      if exhaustion.check(cid, "isFocusThunderbolt") then 
        min = min*2
        max = max*2
      end 

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano*cf.multiplicadorElectrify, -dano*cf.multiplicadorElectrify
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
      if exhaustion.check(cid, "isFocusThunderbolt") then 
        min = min*1.5
        max = max*1.5
      end 
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano*cf.multiplicadorAoe, -dano*cf.multiplicadorAoe
end
setCombatCallback(combat3, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function doElectrify(cid, combat, var, times)
  if times <= 0 then
    return false 
  end 
local target = variantToNumber(var)
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and doCombat(cid, combat, var) and addEvent(doElectrify, 1000, cid, combat, var, times-1)
end


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
          local playerPos = getCreaturePosition(cid)
--        if hasSqm({x=playerPos.x,y=playerPos.y,z=playerPos.z-1}) then
--            doPlayerSendCancelEf(cid, "You can't use this fold in closed places.")
--            return false
--        end
  if getPlayerExaust(cid, "fire", "thunderbolt") == false then
    return false
  end
  if getDobrasLevel(cid) >= 15 then
		doPlayerAddExaust(cid, "fire", "thunderbolt", fireExausted.thunderbolt-2)
  else
		doPlayerAddExaust(cid, "fire", "thunderbolt", fireExausted.thunderbolt)
	end
  if getPlayerHasStun(cid) then
        return true
    end
    if getPlayerOverPower(cid, "fire", true, true) then 
      exhaustion.set(cid, "isFocusThunderbolt", 6)
    end
  local targpos = getThingPos(variantToNumber(var))
    doSendMagicEffect({x=targpos.x+1, y=targpos.y, z=targpos.z}, cf.efeito)
  
  doCombat(cid, combat, var)
  doCombat(cid, combat3, var)
  if math.random(1, 100) > (101-cf.chanceElectrify) then 
		doSendAnimatedText(getCreaturePosition(variantToNumber(var)), "Electrified!", 210) 
		doElectrify(cid, combat2, var, cf.hitsElectrify)
   end
  return true 
end