local spellName = "water dragon"
local cf = {atk = spellsInfo[spellName].atk, chanceFrozzen = spellsInfo[spellName].chanceFrozzen}

local MyLocal = {}
MyLocal.players = {}
MyLocal.chanceFrozzen = cf.chanceFrozzen

local combat = createCombatObject()
setCombatArea(combat, createCombatArea(AREA_CIRCLE3X3))

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*5.1)+5
    local max = (level+(magLevel/3)*5.9)+15

	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


function onTargetTile(creature, pos)
	local cid = creature:getId()
    if isAvaliableTileWaterByPos(pos) then
        table.insert(MyLocal.players[cid], pos)
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  local cid = creature:getId()
    local mainRandom = math.random(1, 100)
	if isPlayer(target) then
		mainRandom = math.random(1, 200)
	end
    if mainRandom <= MyLocal.chanceFrozzen then  
        doFrozzenCreature(target, 3*1000)
        if mainRandom <= 20 then
         --   setPlayerStuned(target, math.random(6, 10))
        end
    end
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function getAllPosIsWater(pos)

	local underWater = {5405, 5406, 5407, 5408, 5409, 5410, 15217, 15218, 15219, 15220, 15221, 15222, 15235, 15236, 15237, 15238, 15239, 15240}

    local poses = {pos, {x=pos.x-1,y=pos.y,z=pos.z}, {x=pos.x,y=pos.y-1,z=pos.z}, {x=pos.x-1,y=pos.y-1,z=pos.z}}
    local checks = 0
    
    for x = 1, 4 do
	local itemId = getThingFromPos({x=poses[x].x,y=poses[x].y,z=poses[x].z,stackpos=0}).itemid
	if isInArray(underWater, itemId) then return true end
        local check = isAvaliableTileWaterByPos(poses[x], true)
        if check ~= false then
            if check <= 18 then
                checks = checks+1    
            else
                checks = checks+100
            end
        end
    end
    if checks == 4 then
        return true
    elseif checks >= 100 then
        return 10
    else
        return false
    end
end

local function removeTable(cid, exaust)
    if isCreature(cid) then
        MyLocal.players[cid] = nil
        if exaust then
			if getDobrasLevel(cid) >= 13 then
				doPlayerAddExaust(cid, "water", "dragon", waterExausted.dragon-6)
			else
				doPlayerAddExaust(cid, "water", "dragon", waterExausted.dragon)
			end
        end
    end
end

local function isInPvpZone(cid)
local pos = getCreaturePosition(cid)
	if getTileInfo(pos).hardcore then
		return true 
	end
return false
end

local function isInSameGuild(cid, target)
if isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
	local cidGuild = getPlayerGuildId(cid)
	local targGuild = getPlayerGuildId(target)
	if cidGuild > 0 and cidGuild == targGuild then
		return true
	end
end
	return false
end

local function isSameParty(cid, target)
	if isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target) then 
		return true
	end
	if isInSameGuild(cid, target) then
		return true
	end
	return false
end

local function dragonWork(cid, posStart, isStart, id)
    if not isCreature(cid) then
        return false
    end

    local creatures = getSpectators(posStart, 7, 5)
    local id = id or 0

    if not isStart then
        if creatures ~= nil then
            for x = 1, #creatures do
                if creatures[x] ~= cid then
                    local creaturePos = getThingPos(creatures[x])
                    if isPlayer(creatures[x]) then
                        if getPlayerAccess(creatures[x]) < 5 then
                            if not getTileInfo(creaturePos).protection and not isSameParty(cid, creatures[x]) and isSightClear(posStart, creaturePos, true) then
                                doSendDistanceShoot(posStart, creaturePos, 56)
                                doCombat(cid, combat1, {type=2, pos=creaturePos})
                            end
                        end
                    else
                        if not isNpc(creatures[x]) and isSightClear(posStart, creaturePos, true) then
                            doSendDistanceShoot(posStart, creaturePos, 56)
                            doCombat(cid, combat1, {type=2, pos=creaturePos})   
                        end
                    end  
                end
            end
        end
    else
        doSendMagicEffect(posStart, 33)
		addEvent(doSendMagicEffect, 1600, posStart, 33)
    end
    if id <= 3 then
        addEvent(dragonWork, 800, cid, posStart, false, id+1)
    else
        removeTable(cid, true)
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "dragon") == false then
        return false
    end

    if MyLocal.players[cid] == nil then
        MyLocal.players[cid] = {}
        local numberToString = 0
        doCombat(cid, combat, var)

        if #MyLocal.players[cid] > 0 then 
            for x = 1, #MyLocal.players[cid] do
                local check = getAllPosIsWater(MyLocal.players[cid][x])

                if check == true then
                    if canUseWaterSpell(cid, nil, 2, true) then 
                        workAllCdAndAndPrevCd(cid, "water", "dragon", 10, 1)

                        if getPlayerHasStun(cid) then
                            removeTable(cid, true)
                            return true
                        end

                        dragonWork(cid, MyLocal.players[cid][x], true)
                        return true
                    else
                        removeTable(cid)
                        return false
                    end

                elseif check == 10 then
                    numberToString = 100
                else
                    numberToString = 1
                end
            end
        end

        if numberToString == 100 then
            doPlayerSendCancelEf(cid, "This water's type is not apropriate for this fold.")
        else
            doPlayerSendCancelEf(cid, "This fold requires a lot of ambient water.")
        end
        removeTable(cid)
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
    end
   return false
end