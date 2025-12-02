local spellName = "air force"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 2)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 41)
setCombatArea(combat, createCombatArea(AREA_CROSS1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*2.56)+(math.random(30, 35)/2)
    local max = (level+(magLevel/4)*2.8)+(math.random(35, 45)/2)
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	if getDobrasLevel(cid) >= 5 then 
		dano = dano*1.2
	end 
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
function onTargetCreature(creature, target)
  local cid = creature:getId()
		if isPlayer(cid) then 
			addEvent(function() if isCreature(cid) and isCreature(target) then doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, true) end end, 50)
		end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end

    if doPlayerAddExaust(cid, "air", "force", airExausted.force) == false then
      return false
     end
    workAllCdAndAndPrevCd(cid, "air", "force", nil, 1)

    if getPlayerHasStun(cid) then
        return true
    end
    
  return doCombat(cid, combat, var)
end