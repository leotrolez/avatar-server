local spellName = "earth kick"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.earthId = 13847
MyLocal.timeEarth = 2

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 31)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.1)+math.random(5, 7)
    local max = (level+(magLevel/3)*3.8)+math.random(7, 9)
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
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if getPlayerExaust(cid, "earth", "kick") == false then
      return false
    end
    if getPlayerHasStun(cid) then
        return true
    end
    doPlayerAddExaust(cid, "earth", "kick", earthExausted.kick)
    local target = getCreatureTarget(cid)

    local targetPosition = getCreaturePosition(target)
    local newTargetPosition = getCreaturePosition(target)
    local dir = getCreatureLookDirection(cid)
    if dir == 0 then
      newTargetPosition.y = targetPosition.y-1
    elseif dir == 1 then
      newTargetPosition.x = targetPosition.x+1
    elseif dir == 2 then
      newTargetPosition.y = targetPosition.y+1
    else
      newTargetPosition.x = targetPosition.x-1
    end

    doCombat(cid, combat, var)
    if target > 0 then 
       doPushCreature(target, getPlayerLookDir(cid))    
        addEvent(removeTileItemById, MyLocal.timeEarth*1000, targetPosition, MyLocal.earthId)
        doCreateItem(MyLocal.earthId, targetPosition) 
        return true
    end
end