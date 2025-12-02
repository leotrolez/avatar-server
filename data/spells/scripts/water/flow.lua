local spellName = "water flow"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local alvosFlow = {}

local combatHeal = createCombatObject()
setCombatParam(combatHeal, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combatHeal, COMBAT_PARAM_EFFECT, 12)
setCombatArea(combatHeal, createCombatArea(AREA_SQUARE1X1))

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatArea(combat1, createCombatArea(
      {
		  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		  {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
          {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
      }))

	  
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 152)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.1)+5
    local max = (level+(magLevel/3)*3.9)+15

	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function isInPvpZone(cid)
local pos = getCreaturePosition(cid)
	if getTileInfo(pos).hardcore then
		return true 
	end
return false
end

local function isInSameGuild(cid, target)
if isPlayer(cid) and isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
	local cidGuild = getPlayerGuildId(cid)
	local targGuild = getPlayerGuildId(target)
	if cidGuild > 0 and cidGuild == targGuild then
		return true
	end
end
	return false
end

local function isNonPvp(cid)
return isMonster(cid) or getPlayerStorageValue(cid, "canAttackable") == 1
end 

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else
			local heal = getPlayerMagLevel(cid) + (getPlayerLevel(cid)/2)
			heal = heal + math.random(15, 30)
			if cid == target then
				heal = heal*0.70
			end
			local atk = 125
			if atk and type(atk) == "number" then 
				heal = heal * (atk/100)
				heal = heal+1
			end
			doCreatureAddHealth(target, heal)
		end
	end
end

setCombatCallback(combatHeal, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  if alvosFlow[cid] == nil then 
    alvosFlow[cid] = 0 
  end 
  if alvosFlow[cid] < 5 then 
    alvosFlow[cid] = alvosFlow[cid]+1
    return doSendDistanceShoot(getThingPos(cid), getThingPos(target), 46) and doCombat(cid, combat2, numberToVariant(target))
  end 
  return false 
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")


function onCastSpell(creature, var)
	local cid = creature:getId()

    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "flow") == false then 
        return false
    end

    if canUseWaterSpell(cid, 1, 3, false) then 
        workAllCdAndAndPrevCd(cid, "water", "flow", nil, 1)
		if getDobrasLevel(cid) >= 18 then
			doPlayerAddExaust(cid, "water", "flow", waterExausted.flow-6)
		else
			doPlayerAddExaust(cid, "water", "flow", waterExausted.flow)
		end
        if getPlayerHasStun(cid) then
            return true
        end
        alvosFlow[cid] = nil
		for i = 0, 8 do 
			addEvent(function()
				if isCreature(cid) and not isInPz(cid) then 
					local pos = getThingPos(cid)
					doSendMagicEffect(pos, 12)
					alvosFlow[cid] = nil
					doCombat(cid, combat1, {type=3, pos=pos})
					doCombat(cid, combatHeal, {type=3, pos=pos})
				end 
			end, 400*i)
		end 
        addEvent(function () alvosFlow[cid] = nil 
        end, 3500)
    
		exhaustion.set(cid, "canturecover", 3)
		return true 
    else
        return false
    end
end