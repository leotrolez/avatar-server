local spellName = "earth storm"
local cf = {atk = spellsInfo[spellName].atk}

--FAZER PUXAR AO REDOR PRA SPELL
local MyLocal = {}
MyLocal.players = {}
local timeleft = 250
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*4.3)+math.random(15, 20))*0.6
    local max = ((level+(magLevel/2)*5.1)+math.random(20, 21))*0.6

    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.6
		max = max*0.6
    end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*4.3)+math.random(15, 20))*0.6
    local max = ((level+(magLevel/2)*5.1)+math.random(20, 21))*0.6
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.6
		max = max*0.6
    end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function getPositionsAroundPlayer(cid)
    local pos, poses = getThingPos(cid), {}
    table.insert(poses, {x=pos.x,y=pos.y-1,z=pos.z, dir = WEST})
    table.insert(poses, {x=pos.x-1,y=pos.y-1,z=pos.z, dir = SOUTH})
    table.insert(poses, {x=pos.x-1,y=pos.y,z=pos.z, dir = SOUTH})
    table.insert(poses, {x=pos.x-1,y=pos.y+1,z=pos.z, dir = EAST})
    table.insert(poses, {x=pos.x,y=pos.y+1,z=pos.z, dir = EAST})
    table.insert(poses, {x=pos.x+1,y=pos.y+1,z=pos.z, dir = NORTH})
    table.insert(poses, {x=pos.x+1,y=pos.y,z=pos.z, dir = NORTH})
    table.insert(poses, {x=pos.x+1,y=pos.y-1,z=pos.z, dir = WEST})
    return poses
end

local function doPushCreature2(cid, dir)
local pos = getThingPos(cid)
--doTeleportThing(cid, getPositionByDirection(pos, dir, 1))
return doPushCreature(cid, dir, nil, nil, nil, isPlayer(cid), false, true)
end
function onTargetCreature(creature, target)
  local cid = creature:getId()
    if isNpc(target) then
        return false
    end
    local poses = MyLocal.players[cid]
    if poses == nil then 
        poses = getPositionsAroundPlayer(cid)
     end 
    local targetPos = getThingPos(target)
    doPlayerCancelFollow(target)
    for x = 1, #poses do
        if poses[x].x == targetPos.x and poses[x].y == targetPos.y and poses[x].z == targetPos.z then
            if getCreatureName(target) ~= "target" then
				addEvent(function() if isCreature(target) then doPushCreature2(target, poses[x].dir) setCreatureNoMoveTime(target, 190) end end, 50)
				exhaustion.set(target, "airtrapped", 1)
            end
        end
    end
end

function onTargetCreature2(cid, target)
    if isNpc(target) then
        return false
    end
    local poses = MyLocal.players[cid]
    if poses == nil then 
        poses = getPositionsAroundPlayer(cid)
     end 
    local targetPos = getThingPos(target)
    doPlayerCancelFollow(target)
    for x = 1, #poses do
        if poses[x].x == targetPos.x and poses[x].y == targetPos.y and poses[x].z == targetPos.z then
            if getCreatureName(target) ~= "target" then
                if not getCreatureNoMove(target) then 
                    for i = 1, 4 do 
                        addEvent(function() if isCreature(target) then doPushCreature2(target, poses[x].dir) end end, 50*i)
                    end
                    doSlow(cid, target, 60, 5000)
                    doSendAnimatedText(getCreaturePosition(target), "Slow!", 30)
                   exhaustion.set(target, "airtrapped", 1)
                else 
                    
                    for i = 1, 4 do 
                        addEvent(function() if isCreature(target) then doPushCreature2(target, poses[x].dir) if i == 4 then doSendAnimatedText(getCreaturePosition(target), "Slow!", 30) end end end, 50*i)
                    end
                    doSlow(cid, target, 60, 5000)
                   exhaustion.set(target, "airtrapped", 1)
                end
            end
        end
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature2")

local function sendSpell(cid, pos, isEnd, restante)
    if not isCreature(cid) then
        return false
    end
    timeleft = restante
    if getTileInfo(pos).protection then return false end
	local topcr = getTopCreature(pos).uid
	if isCreature(topcr) and isPlayer(topcr) and isPlayer(cid) and isInParty(cid) and isInParty(topcr) and getPlayerParty(topcr) == getPlayerParty(cid) then 
		exhaustion.set(topcr, "AirBarrierReduction", 2)
	elseif isCreature(topcr) and isPlayer(topcr) and isPlayer(cid) and isSameWarTeam(cid, topcr) then 
		exhaustion.set(topcr, "AirBarrierReduction", 2)
	end 

    if isEnd then
      --  MyLocal.players[cid] = nil
		if getDobrasLevel(cid) >= 19 then
			doPlayerAddExaust(cid, "earth", "storm", earthExausted.storm-10)
		else
			doPlayerAddExaust(cid, "earth", "storm", earthExausted.storm)
		end
        doCombat(cid, combat2, {type=2, pos=pos})
    else 
        doCombat(cid, combat, {type=2, pos=pos})
    end  
end

local function returnTable(cid)
MyLocal.players[cid] = nil
 end
 
function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if getPlayerExaust(cid, "earth", "storm") == false then
        return false
    end
    if MyLocal.players[cid] == nil then
        if getPlayerHasStun(cid) then
			if getDobrasLevel(cid) >= 19 then
				doPlayerAddExaust(cid, "earth", "storm", earthExausted.storm-10)
			else
				doPlayerAddExaust(cid, "earth", "storm", earthExausted.storm)
			end
            workAllCdAndAndPrevCd(cid, "earth", "storm", nil, 1)
            return true
        end
        MyLocal.players[cid] = getPositionsAroundPlayer(cid)
        setCreatureNoMoveTime(cid, 4000)
        addEvent(returnTable, 4000, cid)
        exhaustion.set(cid, "earthstormTime", 5)
		exhaustion.set(cid, "AirBarrierReduction", 4)
        doPlayerCancelFollow(cid)
        local mypos = getThingPos(cid)
        doSendMagicEffect({x=mypos.x+1, y=mypos.y, z=mypos.z}, 125)
        addEvent(doSendMagicEffect, 1500, {x=mypos.x+1, y=mypos.y, z=mypos.z}, 125)
        addEvent(doSendMagicEffect, 3000, {x=mypos.x+1, y=mypos.y, z=mypos.z}, 125)
        for h = 0, 16 do
            for x = 1, #MyLocal.players[cid] do
                addEvent(sendSpell, (250*h), cid, MyLocal.players[cid][x], h == 14, 4000-(250*h))
                if h % 4 == 0 then  
                    local pos = MyLocal.players[cid][x]
                    addEvent(doSendMagicEffect, (250*h), {x=pos.x+1, y=pos.y+1, z=pos.z}, 130)
                end
            end
        end
        workAllCdAndAndPrevCd(cid, "earth", "storm", 6, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end