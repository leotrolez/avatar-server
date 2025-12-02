local spellName = "water regen"
local cf = {segundos = spellsInfo[spellName].segundos, quantia = spellsInfo[spellName].quantia}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 12)

setCombatArea(combat, createCombatArea(AREA_CIRCLE2X2))

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_TICKS, cf.segundos*1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, cf.quantia)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 1)
--addCombatCondition(combat, condition)

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

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		doSendAnimatedText(getThingPos(target), "Regen!", COLOR_LIGHTBLUE)      
		doAddCondition(target, condition)
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
			doPlayerAddExaust(cid, "water", "regen", waterExausted.regen-9)
		else
			doPlayerAddExaust(cid, "water", "regen", waterExausted.regen)
		end
        if getPlayerHasStun(cid) then
            return true
        end
        return doCombat(cid, combat, var)
    else
        return false
    end
end