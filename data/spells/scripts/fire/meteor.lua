local spellName = "fire meteor"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}
MyLocal.players = {}

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
local arr = {
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
}
setCombatArea(combat, createCombatArea(arr))

function onTargetTile(creature, pos)
	local cid = creature:getId()
    table.insert(MyLocal.players[cid].poses, pos)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile") 

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 6)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 36)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 15)

local combats = {combat1, combat2, combat3}

for x = 1, #combats do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/2)*5.9)+math.random(25, 30)
        local max = (level+(magLevel/2)*6.5)+math.random(30, 35)
    if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end


local combat1Focus = createCombatObject()
setCombatParam(combat1Focus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat1Focus, COMBAT_PARAM_EFFECT, 6)
setCombatFormula(combat1Focus, COMBAT_FORMULA_LEVELMAGIC, -0.3, -30, -0.4, 0) 

local combat2Focus = createCombatObject()
setCombatParam(combat2Focus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat2Focus, COMBAT_PARAM_EFFECT, 36)
setCombatFormula(combat2Focus, COMBAT_FORMULA_LEVELMAGIC, -0.3, -30, -0.4, 0) 

local combat3Focus = createCombatObject()
setCombatParam(combat3Focus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat3Focus, COMBAT_PARAM_EFFECT, 15)
setCombatFormula(combat3Focus, COMBAT_FORMULA_LEVELMAGIC, -0.3, -30, -0.4, 0) 

local combatsFocus = {combat1Focus, combat2Focus, combat3Focus}

for x = 1, #combatsFocus do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/2)*5.9)+math.random(25, 30)
        local max = (level+(magLevel/2)*6.5)+math.random(30, 35)
    if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.5
		max = max*0.5
	end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*1.5
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
    end
    setCombatCallback(combatsFocus[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

local function burnMeteor(cid, poses, sendToSky, focus)
    if getTileInfo(getCreaturePosition(cid)).protection then return false end
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
            addEvent(burnMeteor, time, cid, poses, false, focus)
            addEvent(doSendDistanceShoot, time-200, currentPos, toPosition, 3)
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

                    if focus == true then
                        if randCombat == 1 then
                            doCombat(cid, combat1Focus, {type=2, pos=poses[x]})
                        elseif randCombat == 2 then
                            doCombat(cid, combat2Focus, {type=2, pos=poses[x]})
                        else
                            doCombat(cid, combat3Focus, {type=2, pos=poses[x]})
                        end
                    else
                        if randCombat == 1 then
                            doCombat(cid, combat1, {type=2, pos=poses[x]})
                        elseif randCombat == 2 then
                            doCombat(cid, combat2, {type=2, pos=poses[x]})
                        else
                            doCombat(cid, combat3, {type=2, pos=poses[x]})
                        end
                    end 
                    
                    if math.random(1, 10) > 6 then
                        doSendDistanceShoot(skyPos, effectPos, 3)
                        
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
		if getDobrasLevel(cid) >= 16 then
			doPlayerAddExaust(cid, "fire", "meteor", fireExausted.meteor-10)
		else
			doPlayerAddExaust(cid, "fire", "meteor", fireExausted.meteor)
		end
	end
end

local function startWaves(cid, focus, isEnd)
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
    burnMeteor(cid, MyLocal.players[cid].poses, true, focus)
    if isEnd then
        addEvent(removeTable, 300, cid)
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

    if MyLocal.players[cid] == nil then
        if getPlayerExaust(cid, "fire", "meteor") == false then
            return false
        end

        if getPlayerHasStun(cid) then
            removeTable(cid)
            workAllCdAndAndPrevCd(cid, "fire", "meteor", nil, 1)
            return true
        end

        local playerPos = getCreaturePosition(cid)
        if hasSqm({x=playerPos.x,y=playerPos.y,z=playerPos.z-1}) and not getTileInfo(getCreaturePosition(cid)).hardcore then
            doPlayerSendCancelEf(cid, "You can't use this fold in closed places.")
            return false
        end
		local focus = getPlayerOverPower(cid, "fire", true, true)
        for x = 0, 4 do
            if focus then
                addEvent(startWaves, 1000*x, cid, true, x == 4)
            else
                addEvent(startWaves, 1000*x, cid, false, x == 4)
            end
        end
        workAllCdAndAndPrevCd(cid, "fire", "meteor", 6, 1)  
        return true

    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end