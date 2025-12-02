local spellName = "water heal"
local cf = {heal = spellsInfo[spellName].heal}

local function isNonPvp(cid)
return isMonster(cid) or getPlayerStorageValue(cid, "canAttackable") == 1
end 

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

local function doSendHealth(cid, pos)
    local player = getThingFromPos({x=pos.x,y=pos.y,z=pos.z,stackpos=253})

    if player.uid > 0 then
		if isNonPvp(cid) and not isNonPvp(player.uid) then 
		else 
			local heal = getPlayerMagLevel(cid) + (getPlayerLevel(cid)/2)
			heal = heal + math.random(15, 30)
			--		local heal = (maxHealth*0.13+(maglevel*2))*0.72
			local atk = cf.heal
			if atk and type(atk) == "number" then 
				heal = heal * (atk/100)
				heal = heal+1
			end
			if player.uid ~= cid then 
				heal = heal*1.2
			end 
			if not exhaustion.check(player.uid, "isInCombat") then
				heal = heal*1.5
			end
			if getDobrasLevel(cid) >= 3 then
				heal = heal*1.2
			end
			doCreatureAddHealth(player.uid, heal)
			purify(player.uid)
		end
    end 
    doSendMagicEffect(pos, 12)
end

function onCastSpell(creature, variant)
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
        
		local target = Creature(variant:getNumber())
		doSendHealth(creature:getId(), target and target:getPosition() or getCreatureLookPosition(cid))
		if isPlayer(cid) and getPlayerStorageValue(cid, "nuncaUsouWaterHeal") ~= 1 then
			setPlayerStorageValue(cid, "nuncaUsouWaterHeal", 1)
			sendBlueMessage(cid, 'Dica: Você pode utilizar esta dobra de duas outras formas: Water Heal "NomeDoJogador" - para curar este jogador em específico (sio) ou Water Sheal - para utilizar em si mesmo.')
		end
        return true
    else
        return false
    end
end