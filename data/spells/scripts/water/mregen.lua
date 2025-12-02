local spellName = "water heal"
local cf = {heal = spellsInfo[spellName].heal}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 12)

setCombatArea(combat, createCombatArea(AREA_CIRCLE2X2))

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
			local atk = cf.heal
			if atk and type(atk) == "number" then 
				heal = heal * (atk/100)
				heal = heal+1
			end
			doCreatureAddHealth(target, heal*1.7)
		end
	end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "regen") == false then 
        return false
    end

    if canUseWaterSpell(cid, 1, 3, false) then 
        workAllCdAndAndPrevCd(cid, "water", "regen", nil, 1)
		if getDobrasLevel(cid) >= 10 then
			doPlayerAddExaust(cid, "water", "regen", waterExausted.mregen-3)
		else
			doPlayerAddExaust(cid, "water", "regen", waterExausted.mregen)
		end
        if getPlayerHasStun(cid) then
            return true
        end
		exhaustion.set(cid, "canturecover", 3)
        return doCombat(cid, combat, var)
    else
        return false
    end
end