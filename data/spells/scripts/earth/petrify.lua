local spellName = "earth petrify"
local cf = {atk = spellsInfo[spellName].atk, segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.time = cf.segundos
MyLocal.secondTime = 2
MyLocal.earthId = 13847
MyLocal.players = {}

local combat = createCombatObject()

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*5)+5
    local max = (level+(magLevel/4)*5.5)+10

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

local function removeMark(cid) -- getCreatureNoMove(cid)
  MyLocal.players[cid] = nil  
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local tid = target:getId()
  doCombat(cid, combat2, numberToVariant(tid))
  local time = MyLocal.time
 -- if math.random(1, 100) <= 20 then
 --   time = MyLocal.secondTime
 -- end
	if isPlayer(tid) then 
		exhaustion.set(tid, "stopDashs", 2) 
		time = time/2
	end 
  setCreatureNoMoveTime(tid, time*1000, time*500)
  doSetItemOutfit(tid, MyLocal.earthId, (time*1000)-500)
  addEvent(removeMark, time*1000, cid)

end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
  local target = getCreatureTarget(cid)
  if MyLocal.players[cid] == nil then
    if getDistanceBetween(getThingPos(cid), getThingPos(target)) < 5 then
      if getPlayerExaust(cid, "earth", "petrify") == false then
        return false
      end
        if cantReceiveDisable(cid, target) then
            return false
        end
	  if getDobrasLevel(cid) >= 9 then
		doPlayerAddExaust(cid, "earth", "petrify", earthExausted.petrify-6)
	  else
		doPlayerAddExaust(cid, "earth", "petrify", earthExausted.petrify)
	  end
      if getPlayerHasStun(cid) then
            return true
        end
      doCombat(cid, combat, var)
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