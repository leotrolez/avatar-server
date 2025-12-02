local spellName = "earth punch"
local cf = {atk = spellsInfo[spellName].atk}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 89)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*2.7)+2
    local max = (level+(magLevel/5)*3.6)+5
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
	if getDobrasLevel(cid) >= 2 then
		dano = dano*1.2
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function earthPunchs(cid, times)
if times == 0 or not isCreature(cid) or isInPz(cid) then return false end 
local target = getCreatureTarget(cid)
	if target > 0 then 
		local targpos = getThingPos(target)
		if getDistanceBetween(getThingPos(cid), targpos) <= 1 then
			doSendMagicEffect(targpos, 111)
			doCombat(cid, combat, numberToVariant(target))
		end
	end
	addEvent(earthPunchs, 300, cid, times-1)
end 

function onCastSpell(creature, var)
	local cid = creature:getId()
    local target = getCreatureTarget(cid)
    
    if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 1 then
      doPlayerSendCancelEf(cid, "Creature is not reachable.")
    return false
  end
    if getSpellCancels(cid, "earth") == true then
        return false
    end
  if getPlayerExaust(cid, "earth", "punch", earthExausted.punch) == false then
    return false
  end
  doPlayerAddExaust(cid, "earth", "punch", earthExausted.punch)
  if getPlayerHasStun(cid) then
        return true
    end

  if target > 0 then
		earthPunchs(cid, 3)
	end
  return true
end


