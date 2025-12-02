local spellName = "water res"
local cf = {segundos = spellsInfo[spellName].segundos}

local MyLocal = {}

local function removeAllSummons(cid)
    if isCreature(cid) then
        doSendMagicEffect(getThingPos(cid), 2)
        doRemoveCreature(cid)
    end
end

local function healTime(monster, reg)
    if isCreature(monster) then
        doCreatureAddHealth(monster, reg)
        addEvent(healTime, 1000, monster, reg)
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
	if getTileInfo(getCreaturePosition(cid)).optional or isInWarGround(cid) then  
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 
    if getPlayerExaust(cid, "water", "res", waterExausted.res) == false then
        return false
    end

    if getCreatureSummons(cid) == false or #getCreatureSummons(cid) == 0 then

        if getPlayerHasStun(cid) then
            doPlayerAddExaust(cid, "water", "res", waterExausted.res)
            workAllCdAndAndPrevCd(cid, "water", "res", nil, 1)
            return true
        end

        local summonPos = getPositionByDirection(getCreaturePosition(cid), getCreatureLookDirection(cid))

        if not getPlayerCanWalk({player = cid, position = summonPos, checkPZ = true, checkHouse = true, checkWater = true, acceptTileMonsteable = true}) then
            doPlayerSendCancelEf(cid, "There is not enough room.")
            return false
        end

        if canUseWaterSpell(cid, 1, 3, false) then
            local creature = doCreateMonster("Water Man", summonPos, nil, nil, false)
            if isCreature(creature) then
				local newHp = (math.ceil(getCreatureMaxHealth(cid)/2)+120)*2
				if getDobrasLevel(cid) >= 6 then
					newHp = newHp*1.5
				end
                setCreatureMaxHealth(creature, newHp)
                doCreatureAddHealth(creature, getCreatureMaxHealth(creature))
                doConvinceCreature(cid, creature)
                doSendMagicEffect(getThingPos(creature), 1)
                healTime(creature, math.ceil((getPlayerLevel(cid)/2)+2))
            else
                doPlayerSendCancelEf(cid, "Sorry, it's not possible.")
                return false    
            end

            doPlayerAddExaust(cid, "water", "res", waterExausted.res)
            addEvent(removeAllSummons, cf.segundos*1000, creature)
            workAllCdAndAndPrevCd(cid, "water", "res", nil, 1)
            return true
        else
            return false
        end
    else
        doPlayerSendCancelEf(cid, "You already have active summons.")
        return false
    end
end
