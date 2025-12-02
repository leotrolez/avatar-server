local spellName = "air tornado"
local cf = {atk = spellsInfo[spellName].atk, segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.time = cf.segundos
MyLocal.secondTime = 2
MyLocal.players = {}

local combat = createCombatObject()

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*4.5)+5
    local max = (level+(magLevel/3)*5.0)+10

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

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)

local arr ={{1, 1, 1},
          {1, 3, 1},
          {1, 1, 1}}
    setCombatArea(combat3, createCombatArea(arr))
	
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*4.5)+5
    local max = (level+(magLevel/3)*5.0)+10

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano/2
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat3, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function removeMark(cid)
  MyLocal.players[cid] = nil  
end

local function tornadoWork(cid, target, times)
	if not isCreature(cid) or not isCreature(target) or isInPz(target) or isInPz(cid) then return false end
	local targpos = getCreaturePosition(target)
	doCombat(cid, combat3, {type=2, pos=targpos})
	if times == 2 then 
		doSendMagicEffect(targpos, 61)
	end 
	if times > 0 then 
		addEvent(tornadoWork, 500, cid, target, times-1)
	end 
end

local function rodarCreature(cid, dir, times)
	if not isCreature(cid) then
		return false
	end
	if dir > 3 then
		dir = 0
	end
	doCreatureSetLookDirection(cid, dir)
	if times > 0 then
		addEvent(rodarCreature, 250, cid, dir+1, times-1)
	end
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local tid = target:getId()
  doCombat(cid, combat2, numberToVariant(target))
  local targpos =  getCreaturePosition(target)
  local range = getDistanceBetween(getCreaturePosition(cid), targpos)
  addEvent(doSendMagicEffect, range*75, targpos, 61)
  local time = MyLocal.time
  setCreatureNoMoveTime(target, 1500, 750)
  addEvent(removeMark, 1500, cid)
  tornadoWork(cid, tid, 3)
  addEvent(rodarCreature, range*75, tid, getCreatureLookDirection(target)+1, 6)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
	local target = getCreatureTarget(cid)
	if MyLocal.players[cid] == nil then
		if getDistanceBetween(getThingPos(cid), getThingPos(target)) < 5 then
			if getPlayerExaust(cid, "air", "tornado") == false then
				return false
			end
			if cantReceiveDisable(cid, target) then
				return false
			end
		if getDobrasLevel(cid) >= 15 then
			doPlayerAddExaust(cid, "air", "tornado", airExausted.tornado-4)
		else
			doPlayerAddExaust(cid, "air", "tornado", airExausted.tornado)
		end
		if getPlayerHasStun(cid) then
            return true
        end
		doCombat(cid, combat, var)
		doSendDistanceShoot(getCreaturePosition(cid), getCreaturePosition(target), 45)
		MyLocal.players[cid] = false
		return true
    else
		doPlayerSendCancelEf(cid, "Creature is not reachable.")
		return false
    end
  else
	doPlayerSendCancelEf(cid, "You're already using this fold.")
    return false
  end
end