local spellName = "earth crush"
local cf = {atk = spellsInfo[spellName].atk}


local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 34)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 31)

local condition = createConditionObject(CONDITION_DRUNK)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5000)
addCombatCondition(combat2, condition)

local t = {combat2, combat1, combat1}

local arr = {
{1, 3, 1}
}

local area = createCombatArea(arr)
setCombatArea(combat1, area)
setCombatArea(combat2, area)

for x = 1, 2 do
  function onGetPlayerMinMaxValues(cid, level, magLevel)
      local min = (level+(magLevel/4)*1.7)*1.4
      local max = (level+(magLevel/4)*2)*1.6
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.6
		max = max*0.6
	end
	local dano = math.random(min, max) + math.random(4, 8)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*0.7
	if getDobrasLevel(cid) >= 1 then
		dano = dano*1.2
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
  end
  setCombatCallback(t[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

local function earthCrush(cid, times)
if times == 0 or not isCreature(cid) or isInPz(cid) or getTileInfo(getCreatureLookPosition(cid)).protection then 
	return false 
end
doCombat(cid, t[times], {type=2, pos=getCreatureLookPosition(cid)})
addEvent(earthCrush, 500, cid, times-1)
end 


function onCastSpell(creature, var)
	local cid = creature:getId()
  if getSpellCancels(cid, "earth") == true then
        return false
    end
    if doPlayerAddExaust(cid, "earth", "crush", earthExausted.crush) == false then
      return false
    end
  if getPlayerHasStun(cid) then
        return true
    end
	earthCrush(cid, 3)
  return true 
end