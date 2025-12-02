local spellName = "fire discharge"
local cf = {atk = spellsInfo[spellName].atk}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat, createCombatArea(
		  {
		  {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
}))
setCombatArea(combatFocus, createCombatArea(
		  {
		  {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
}))


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
	if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
	local dano = math.random(min, max)
	local atk = spellsInfo["fire discharge"].atk
	if atk and type(atk) == "number" then 
		atk = atk*0.72
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
	if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
	local dano = math.random(min, max)
	local atk = spellsInfo["fire discharge"].atk
	if atk and type(atk) == "number" then
		atk = atk*0.42
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*2
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end

setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
  if getPlayerExaust(cid, "fire", "discharge") == false then
    return false
  end
	if getDobrasLevel(cid) >= 22 then
		doPlayerAddExaust(cid, "fire", "discharge", fireExausted.discharge-12)
	else
		doPlayerAddExaust(cid, "fire", "discharge", fireExausted.discharge)
	end
  if getPlayerHasStun(cid) then
        return true
    end
	local duracao = 4000
	exhaustion.set(cid, "AirBarrierReduction", duracao/1000)
	exhaustion.set(cid, "BendReflection", duracao/1000)
	local haveFocus = getPlayerOverPower(cid, "fire", true, true)
		for i = 0, 11 do 
			addEvent(function()
				if isCreature(cid) and not isInPz(cid) then 
					local pos = getThingPos(cid)
					doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 143)
					if not haveFocus then
						doCombat(cid, combat, var)
					else
						doCombat(cid, combatFocus, var)
					end
				end 
			end, 350*i)
		end 
  return true 
end
