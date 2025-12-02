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
		local quantia = getPlayerMagLevel(cid) + (getPlayerLevel(cid))
		quantia = quantia + math.random(15, 30)
		local vitality = getPlayerStorageValue(cid, "healthvalue")
		if not vitality then vitality = 0 end
		quantia = quantia + (vitality*2)
        doCreatureAddHealth(cid, quantia*3)
        doSendMagicEffect(getThingPos(cid), 12)
		if math.random(1, 100) > 76 then 
			purify(cid)
		end 
        return true
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end 
		if getPlayerExaust(cid, "water", "recover") == false then
        return false
    end
	if exhaustion.check(cid, "canturecover") then
		doPlayerSendCancel(cid, "You are exhausted.")
		return false
	end
	
        if not canUseWaterSpell(cid, 1, 3, false)  then 
            return false
        end   
   if doPlayerAddExaust(cid, "water", "recover", waterExausted.recover*3) == false then
       return false
   end
        if getPlayerHasStun(cid) then
            return true
        end 
    --if canUseWaterSpell(cid, 1, 2, false) then


  --workAllCdAndAndPrevCd(cid, "water", "recover", nil, 1)

        return doSendHealth(cid)
    --else
        --return false
    --end
end