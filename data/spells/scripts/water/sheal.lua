local spellName = "water sheal"
local cf = {heal = spellsInfo[spellName].heal}

local function purify(cid)
    local conditions = {CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_LIFEDRAIN, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_DRUNK}
	local hasPurify = 0
    for x = 1, #conditions do
		if (hasCondition(cid, conditions[x])) then 
			doRemoveCondition(cid, conditions[x])
			hasPurify = 1
		end
	end
	if hasPurify == 1 then 
		doSendAnimatedText(getCreaturePosition(cid), "Purified!", 52)
	end
end

local function doSendHealth(cid)
    if isPlayer(cid) then
		local vitality = getPlayerStorageValue(cid, "healthvalue")
		if not vitality then vitality = 0 end
		local heal = vitality + getPlayerMagLevel(cid) + (getPlayerLevel(cid)/2)
		heal = heal + math.random(15, 30)
--		local heal = (maxHealth*0.13+(maglevel*2))*0.72
		local atk = cf.heal
		if atk and type(atk) == "number" then 
			heal = heal * (atk/100)
			heal = heal+1
		end
		heal = heal*0.8
		  if not exhaustion.check(cid, "isInCombat") then
				heal = heal*1.5
		  end
		if getDobrasLevel(cid) >= 3 then
			heal = heal*1.2
		end
        doCreatureAddHealth(cid, heal)
        doSendMagicEffect(getThingPos(cid), 12)
		purify(cid)
        return true
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "heal") == false then
        return false
    end

    if canUseWaterSpell(cid, 1, 3, false) then
        workAllCdAndAndPrevCd(cid, "water", "heal", nil, 1)
        doPlayerAddExaust(cid, "water", "heal", waterExausted.heal) 
        if getPlayerHasStun(cid) then
            return true
        end
		exhaustion.set(cid, "canturecover", 3)
        return doSendHealth(cid)
    else
        return false
    end
end