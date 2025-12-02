local spellName = "water bloodcontrol"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.jumps = 4
MyLocal.walkTime = 500
MyLocal.playersCanUse = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.0)
    local max = (level+(magLevel/3)*3.2)
	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local arr = {
{0, 3, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.0)
    local max = (level+(magLevel/3)*3.2)
	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*0.40
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function removeTable(cid)
    if isCreature(cid) then
        MyLocal.playersCanUse[cid] = nil

    end
end


local function doBleed(cid, combat, var, times)
	if times <= 0 then
		return false 
	end 
local target = variantToNumber(var)
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and doCombat(cid, combat, var) and addEvent(doBleed, 1000, cid, combat, var, times-1)
end

local function moveTarget(cid, pos, jumps) 
    local jumps = jumps or 0
    local target = 0

    if not isCreature(cid) then
        return false
    end

    local playerDir = getCreatureLookDirection(cid)
    local playerPos = getCreaturePosition(cid)
    local target = getCreatureTarget(cid)
    local effectPos = pos or playerPos
    local newPos

    doPlayerCancelFollow(target)

    if getDistanceBetween(playerPos, effectPos) > 7 or not isWalkable(effectPos) then
        removeTable(cid)
        return false
    end
    
    if getTileInfo(effectPos).protection or getTileInfo(effectPos).house then
            removeTable(cid)
        return false
    end

    if jumps > MyLocal.jumps or getCreatureNoMove(cid) then
        removeTable(cid)
        return false
    end

    if target == 0 then
        removeTable(cid)
        return false

    elseif target > 0 then
        local targetPos = getCreaturePosition(target)
        newPos = getPoses(effectPos, targetPos)
        if newPos == true and not exhaustion.check(target, "airtrapped") then
            newPos = getPosByDir(playerDir, targetPos)
            setCreatureNoMoveTime(target, MyLocal.walkTime-1, 2000)
			doPlayerCancelFollow(target)
            doPushCreature(target, newPos, nil, nil, true)
            doCombat(cid, combat, numberToVariant(target))
            newPos = getCreaturePosition(target)
			if jumps+1 > MyLocal.jumps then
				addEvent(doBleed, 500, cid, combat2, numberToVariant(target), 7)
				doSendAnimatedText(getCreaturePosition(target), "Bleeding!", 180)
			end
        else
            newPos = newPos[1]
        end
    end
    addEvent(moveTarget, MyLocal.walkTime, cid, newPos, jumps+1, name)
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    local target = getCreatureTarget(cid)

    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "bloodControl") == false then
        return false
    end

    local targetPos, playerPos = getThingPos(target), getThingPos(cid)
    if getDistanceBetween(targetPos, playerPos) > 3 then
        doPlayerSendCancelEf(cid, "Creature is not reachable.")
        return false        
    end
	
	if cantReceiveDisable(cid, target) then
		return false
	end

   -- if MyLocal.playersCanUse[cid] == nil then
        if canUseWaterSpell(cid, 1, 3, false) then
            if getPlayerHasStun(cid) then
                removeTable(cid)
				if getDobrasLevel(cid) >= 11 then
					doPlayerAddExaust(cid, "water", "bloodControl", waterExausted.bloodControl-9)
				else
					doPlayerAddExaust(cid, "water", "bloodControl", waterExausted.bloodControl)
				end
               -- workAllCdAndAndPrevCd(cid, "water", "bloodControl", nil, 1)
                return true
            end
            MyLocal.playersCanUse[cid] = false
			doSendMagicEffect(targetPos, 69)
            moveTarget(cid, targetPos) 
			if getDobrasLevel(cid) >= 11 then
				doPlayerAddExaust(cid, "water", "bloodControl", waterExausted.bloodControl-4)
			else
				doPlayerAddExaust(cid, "water", "bloodControl", waterExausted.bloodControl+5)
			end
          --  workAllCdAndAndPrevCd(cid, "water", "bloodControl", 15, 1)
          doSendDistanceShoot(getThingPos(cid), getThingPos(target), 54)
            return true
        else
            return false
        end
   -- else
    --    doPlayerSendCancelEf(cid, "You're already using this fold.")
    --    return false
  --  end
end