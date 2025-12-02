local spellName = "earth leech"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}
MyLocal.positions = {}


local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatArea(combat, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 2, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
      }))


local function getDamage(cid)
  local level = getPlayerLevel(cid)
  local magLevel = getPlayerMagLevel(cid)
  local min = (level/5 + (magLevel/4))
	local max = (level/4 + (magLevel/4))
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
	dano = dano*1.4
	if getDobrasLevel(cid) >= 12 then
		dano = dano*1.2
	end
	dano = remakeAirEarth(cid, dano)
    return dano
end

--function onGetPlayerMinMaxValues(cid, level, magLevel)
--        return 0, 0
--end
--setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local random = getDamage(cid)
  doTargetCombatHealth(cid, target, COMBAT_EARTHDAMAGE, -random, -random, 8)
  if isPlayer(target) then 
    random = random/2
  end
  doTargetCombatHealth(0, cid, COMBAT_HEALING, random, random, -1)
  --doSendMagicEffect({x=mypos.x+1, y=mypos.y+1, z=mypos.z}, 130)
  if isMonster(target) then 
    doChallengeCreature(cid, target)
  end 
 return
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetTile(creature, pos)
	local cid = creature:getId()
    return doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 130)
end
    setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")


local function removeTable(cid)
    MyLocal.players[cid] = nil
end



function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if getPlayerExaust(cid, "earth", "leech") == false then
        return false
    end
    if MyLocal.players[cid] == nil then
     positionsimune = {}
         doPlayerAddExaust(cid, "earth", "leech", earthExausted.leech)
            if getPlayerHasStun(cid) then
               -- workAllCdAndAndPrevCd(cid, "earth", "leech", nil, 1)
                return true
            end
			doPlayerAddExaust(cid, "earth", "leech", earthExausted.leech)
			exhaustion.set(cid, "cantEarthArmor", 4)
            MyLocal.players[cid] = 0
            addEvent(removeTable, 250, cid)
            --workAllCdAndAndPrevCd(cid, "earth", "leech", nil, 1)
      local mypos = getCreaturePosition(cid)
		exhaustion.set(cid, "canturecover", 3)
      return doCombat(cid, combat, var)
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
