local spellName = "earth lavaball"
local cf = {atk = spellsInfo[spellName].atk, bolhas = spellsInfo[spellName].bolhas}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 49)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level*1.3)+(magLevel/4)*2.7)+5
    local max = ((level*1.5)+(magLevel/4)*3.5)+5
	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function doMelt(cid, combat, var, times)
	if times <= 0 then
		return false 
	end 
local target = variantToNumber(var)
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and doCombat(cid, combat, var) and addEvent(doMelt, 1000, cid, combat, var, times-1)
end

local function removeDefBreak(cid)
	if isCreature(cid) then
		if not exhaustion.check(cid, "defBreak") then
			setPlayerStorageValue(cid, "defBreakMonster", 0)
		end
	end
end

local function doLavaball(cid, combat, var)
	local target = variantToNumber(var)
	if not isCreature(target) then return false end
	addEvent(doMelt, 500, cid, combat2, var, 4)
	local targpos = getCreaturePosition(target)
	doSendAnimatedText(targpos, "Melted!", 198)
	addEvent(doSendAnimatedText, 200, targpos, "- DEF", 198)
	if isPlayer(target) then
		exhaustion.set(target, "defBreak", 4)
	else
		exhaustion.set(target, "defBreak", 3)
		setPlayerStorageValue(target, "defBreakMonster", 1)
		addEvent(removeDefBreak, 4300, target)
	end
	doSlow(cid, target, 25, 4000)
	local delayEffect = getDistanceBetween(getCreaturePosition(cid), targpos) * 75
	addEvent(doSendMagicEffect, delayEffect, targpos, 140)
return not isInPz(cid) and not isInPz(target) and isSightClear(getThingPos(cid), getThingPos(target), true) and doCombat(cid, combat, var)
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
  if getPlayerExaust(cid, "earth", "lavaball") == false then
    return false
  end
	if getDobrasLevel(cid) >= 22 then
		doPlayerAddExaust(cid, "earth", "lavaball", earthExausted.lavaball-12)
	else
		doPlayerAddExaust(cid, "earth", "lavaball", earthExausted.lavaball)
	end
    if getPlayerHasStun(cid) then
        return true
    end

  return doLavaball(cid, combat, var) 
end
