local cf = {}
cf.segundos = 90
cf.cooldown = 120

local MyLocal = {}

local function removeAllSummons(cid)
    if isCreature(cid) then
        doSendMagicEffect(getThingPos(cid), 43)
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
    if getSpellCancels(cid, "fire") == true then
        return false
    end
	if getTileInfo(getCreaturePosition(cid)).optional or isInWarGround(cid) then  
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 
    if getPlayerExaust(cid, "fire", "dragon", cf.cooldown) == false then
        return false
    end

    if getCreatureSummons(cid) == false or #getCreatureSummons(cid) == 0 then

        if getPlayerHasStun(cid) then
            doPlayerAddExaust(cid, "fire", "dragon", cf.cooldown)
            workAllCdAndAndPrevCd(cid, "fire", "dragon", nil, 1)
            return true
        end

        local summonPos = getPositionByDirection(getCreaturePosition(cid), getCreatureLookDirection(cid))

        if not getPlayerCanWalk({player = cid, position = summonPos, checkPZ = true, checkHouse = true, checkWater = true, acceptTileMonsteable = true}) then
            doPlayerSendCancelEf(cid, "There is not enough room.")
            return false
        end

            local creature = doCreateMonster("fire dragon", summonPos, nil, nil, false)
            if isCreature(creature) then
				local newHp = math.ceil((getCreatureMaxHealth(creature) + getCreatureMaxHealth(cid))*1.2)
                setCreatureMaxHealth(creature, newHp)
                doCreatureAddHealth(creature, getCreatureMaxHealth(creature))
                doConvinceCreature(cid, creature)
                doSendMagicEffect(getThingPos(creature), 178)
                healTime(creature, math.ceil((getPlayerLevel(cid)/2)))
            else
                doPlayerSendCancelEf(cid, "Sorry, it's not possible.")
                return false    
            end

            doPlayerAddExaust(cid, "fire", "dragon", cf.cooldown)
            addEvent(removeAllSummons, cf.segundos*1000, creature)
            return true
    else
        doPlayerSendCancelEf(cid, "You already have active summons.")
        return false
    end
end