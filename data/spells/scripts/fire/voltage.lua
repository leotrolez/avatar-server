local spellName = "fire voltage"
local cf = {segundos = spellsInfo[spellName].segundos}

local MyLocal = {}

local function removeAllSummons(cid)
    if not isCreature(cid) then
        return true
    end
    local summons = getCreatureSummons(cid)
    if not(summons == false or #summons == 0) then
        for _, pid in ipairs(summons) do
			if getCreatureName(pid) == "Energy Elemental" or getCreatureName(pid) == "Energy Overlord" then
				local creaturePos = getThingPos(pid)
				doSendMagicEffect(creaturePos, 11)
				doRemoveCreature(pid)
			end
        end
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
    if getSpellCancels(cid, "fire") == true then
        return false
    end
	if getTileInfo(getCreaturePosition(cid)).optional or isInWarGround(cid) then 
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 
    if getPlayerExaust(cid, "fire", "voltage", fireExausted.voltage) == false then
        return false
    end
    if getCreatureSummons(cid) == false or #getCreatureSummons(cid) == 0 then
        if getPlayerHasStun(cid) then
            doPlayerAddExaust(cid, "fire", "voltage", fireExausted.voltage)
            workAllCdAndAndPrevCd(cid, "fire", "voltage", nil, 1)
            return true
        end
        local summonPos = getPositionByDirection(getCreaturePosition(cid), getCreatureLookDirection(cid))

        if not getPlayerCanWalk({player = cid, position = summonPos, checkPZ = true, checkHouse = true, checkWater = true}) then
            doPlayerSendCancelEf(cid, "There is not enough room.")
            return false
        end

        if getPlayerOverPower(cid, "fire", true, true) then
            local creature = doCreateMonster("Energy Summon Focus", summonPos, nil, nil, false)
            if isCreature(creature) then
				local newHp = math.ceil(getCreatureMaxHealth(cid)/1.5)+180
				newHp = newHp*1.5
				if getDobrasLevel(cid) >= 20 then
					newHp = newHp*1.5
				end 
                setCreatureMaxHealth(creature, newHp)
                doCreatureAddHealth(creature, getCreatureMaxHealth(creature))
                doConvinceCreature(cid, creature)
                doSendMagicEffect(getThingPos(creature), 40)
				healTime(creature, math.ceil((getPlayerLevel(cid)/4)+6))
			else
				doPlayerSendCancelEf(cid, "Sorry, it's not possible.")
				return false    
			end
        else
            local creature = doCreateMonster("Energy Summon", summonPos, nil, nil, false)
            if isCreature(creature) then
				local newHp = math.ceil(getCreatureMaxHealth(cid)/2)+180
				newHp = newHp*1.5
				if getDobrasLevel(cid) >= 20 then
					newHp = newHp*1.5
				end 
                setCreatureMaxHealth(creature, newHp)
                doCreatureAddHealth(creature, getCreatureMaxHealth(creature))
                doConvinceCreature(cid, creature)
                doSendMagicEffect(getThingPos(creature), 11)
				healTime(creature, math.ceil((getPlayerLevel(cid)/6)+6))
            else
                doPlayerSendCancelEf(cid, "Sorry, it's not possible.")
                return false    
            end
        end
        doPlayerAddExaust(cid, "fire", "voltage", fireExausted.voltage)
        addEvent(removeAllSummons, cf.segundos*1000, cid)
        workAllCdAndAndPrevCd(cid, "fire", "voltage", nil, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You already have active summons.")
        return false
    end
end
