local spellName = "water rain"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}
MyLocal.players = {}
MyLocal.splashIds = {2016, 2017, 2018, 2019, 2020, 2021}

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


local skulls = {1,3,4,5,6}
local function isImune(cid, creature)
    if isMonster(creature) or isMonster(cid) then 
        return false 
    end
	if isPlayer(cid) and isPlayer(creature) and (getPlayerStorageValue(cid, "canAttackable") == 1 or getPlayerStorageValue(creature, "canAttackable") == 1) then 
		return true 
	end 
    if isInParty(cid) and isInParty(creature) and getPlayerParty(cid) == getPlayerParty(creature) then
        return true
    end 
	if isInSameGuild(cid, target) then
		return true
	end
    local modes = getPlayerModes(cid)
    if isInArray(skulls, getCreatureSkullType(creature)) then
        return false
    end     
    if (modes.secure == SECUREMODE_OFF) then
        return false
    end
    return true
end

local combat = createCombatObject()
setCombatArea(combat, createCombatArea(AREA_CROSS6X6))

function onTargetTile(creature, pos)
	local cid = creature:getId()
    table.insert(MyLocal.players[cid].poses, pos)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile") 

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 41)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 70) 

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 70)

local combats = {combat1, combat2, combat3}

for x = 1, 3 do
    function onTargetTile(creature, pos)
	local cid = creature:getId()
        if math.random(1, 10) == 10 then
            if isWalkable(pos) and not isAvaliableTileWaterByPos(pos) then
                doDecayItem(doCreateItem(MyLocal.splashIds[math.random(1, #MyLocal.splashIds)], 1, pos))
            end
        end    
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")   
    
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/3)*5.1)+40
        local max = (level+(magLevel/3)*5.9)+50

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
    if math.random(1, 3) == 1 then
        doFrozzenCreature(target, 3*1000)
    end  
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function doRain(cid, poses, sendToSky)
    if not isCreature(cid) then
        return true
    end

    local poses = poses or nil

    if sendToSky == true then
        local currentPos = getCreaturePosition(cid)
        local toPosition = {x=currentPos.x-2,y=currentPos.y-6,z=currentPos.z}

        for h = 1, 4 do
            local time
            if math.random(1,2) == 1 then
                time = 300*h
            else
                time = 400*h
            end
            addEvent(doRain, time, cid, poses, false)
        --    addEvent(doSendDistanceShoot, time-200, currentPos, toPosition, 49)
        end
        return true
    else
        poses = shuffleList(poses)
        for h = 1, math.floor(#poses/4) do
            for x = 1, #poses do
                if poses[x].used == nil then
                    local effectPos = poses[x]
                    local skyPos = {x=poses[x].x-2,y=poses[x].y-6,z=poses[x].z}
                    local randCombat = math.random(1, 3)

                    if randCombat == 1 then
                        doCombat(cid, combat1, {type=2, pos=poses[x]})
                    elseif randCombat == 2 then
                        doCombat(cid, combat2, {type=2, pos=poses[x]})
                    else
                        doCombat(cid, combat3, {type=2, pos=poses[x]})
                    end

                    if math.random(1, 10) > 6 then
                        if randCombat == 1 then
                            doSendDistanceShoot(skyPos, effectPos, 28)    
                            local toPos = {x=effectPos.x, y=effectPos.y, z=effectPos.z-1}
                            local player = getThingFromPosition(toPos)
                            if player.uid > 0 then
                                if isPlayer(player.uid) then
                                    if not isImune(cid, player.uid) then
                                        local tile = getClosestFreeTile(player.uid, effectPos)
                                        if tile and not getTileInfo(tile).protection then 
                                            doTeleportThing(player.uid, tile)
                                        end
                                    end
                                end
                            end
							player = getThingFromPosition(effectPos)
							if player.uid > 0 then 
								if isPlayer(player.uid) then 
									if not isImune(cid, player.uid) and getPlayerStorageValue(player.uid, "playerOnAir") == 1 then
										doPushCreature(player.uid, math.random(0, 3), 1, 500, false, true)
									end
								end 
							end 
                        else
                            doSendDistanceShoot(skyPos, effectPos, 36)
                            local toPos = {x=effectPos.x, y=effectPos.y, z=effectPos.z-1}
                            local player = getThingFromPosition(toPos)
                            if player.uid > 0 then
                                if isPlayer(player.uid) then
                                    if not isImune(cid, player.uid) then
                                        local tile = getClosestFreeTile(player.uid, effectPos)
                                        if tile and not getTileInfo(tile).protection then 
                                            doTeleportThing(player.uid, tile)
                                        end
                                    end
                                end
                            end
							player = getThingFromPosition(effectPos)
							if player.uid > 0 then 
								if isPlayer(player.uid) then 
									if not isImune(cid, player.uid) and getPlayerStorageValue(player.uid, "playerOnAir") == 1 then
										doPushCreature(player.uid, math.random(0, 3), 1, 500, false, true)
									end
								end 
							end 
                        end
                        
                    end

                    poses[x].used = true
                    break
                end 
            end    
        end
    end
end

local function removeTable(cid)
    MyLocal.players[cid] = nil
	if isCreature(cid) then 
		if getDobrasLevel(cid) >= 14 then
			doPlayerAddExaust(cid, "water", "rain", waterExausted.rain-10)
		else
			doPlayerAddExaust(cid, "water", "rain", waterExausted.rain)
		end
	end
end

local function startWaves(cid, isEnd)
    if not isCreature(cid) then
        return false
    end

    local playerPos = getThingPos(cid)
    if hasSqm({x=playerPos.x,y=playerPos.y,z=playerPos.z-1}) and not getTileInfo(getCreaturePosition(cid)).hardcore then
        addEvent(removeTable, 300, cid)
        return false
    end
    MyLocal.players[cid] = {poses = {}}
    doCombat(cid, combat, {type=2, pos=getThingPos(cid)})
    doRain(cid, MyLocal.players[cid].poses, true)

    if isEnd then
        addEvent(removeTable, 300, cid)
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

    if getPlayerExaust(cid, "water", "rain") == false then
        return false
    end

    if MyLocal.players[cid] == nil then
        local playerPos = getCreaturePosition(cid)
        if hasSqm({x=playerPos.x,y=playerPos.y,z=playerPos.z-1}) and not getTileInfo(getCreaturePosition(cid)).hardcore then
            doPlayerSendCancelEf(cid, "You can't use this fold in closed places.")
            return false
        end

        if canUseWaterSpell(cid, 1, 3, false) then 
            if getPlayerHasStun(cid) then
				if getDobrasLevel(cid) >= 14 then
					doPlayerAddExaust(cid, "water", "rain", waterExausted.rain-10)
				else
					doPlayerAddExaust(cid, "water", "rain", waterExausted.rain)
				end
                workAllCdAndAndPrevCd(cid, "water", "rain", nil, 1)
                return true
            end

            for x = 0, 4 do
                addEvent(startWaves, 1000*x, cid, x == 4)
            end      
            workAllCdAndAndPrevCd(cid, "water", "rain", 5, 1)
            return true
        else
            return false
        end

    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end