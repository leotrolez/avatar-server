local spellName = "earth pull"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.earthId = 13846
MyLocal.time = 3

local combat = createCombatObject()
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*4.0)+math.random(2, 3)
    local max = (level+(magLevel/5)*4.3)+math.random(3, 4)
	if getPlayerInWaterWithUnderwater(cid) then 
		min = min * 0.6
		max = max * 0.6
	end
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
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local playerPos = getCreaturePos(cid)
  local targetPos = getCreaturePos(target)
  if getDistanceBetween(playerPos, targetPos) > 1 and getPlayerStorageValue(target, "playerOnAir") == 1 then							
	doPushCreature(target, getDirectionTo(targetPos, playerPos), 1, 500, false, true)
  elseif getDistanceBetween(playerPos, targetPos) > 1 then
    doPushCreature(target, getDirectionTo(targetPos, playerPos))
  end
  doCombat(cid, combat2, numberToVariant(target))
  doCreateItem(MyLocal.earthId, targetPos)
  addEvent(removeTileItemById, MyLocal.time*1000, targetPos, MyLocal.earthId)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
     if getPlayerExaust(cid, "earth", "pull") == false then
    return false
  end
  doPlayerAddExaust(cid, "earth", "pull", earthExausted.pull)
  if getPlayerHasStun(cid) then
        return true
    end
  doCombat(cid, combat, var)
  return true                                                                                                                                                                                           
end     





