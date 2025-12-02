local spellName = "air suffocation"
local cf = {atk = spellsInfo[spellName].atk, segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.fireId = 13025
MyLocal.totalTime = cf.segundos
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*3.3)+math.random(5, 10)
    local max = (level+(magLevel/3)*3.7)+math.random(10, 15)

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

local function sendFiresAround(cid)
    local playerPos = getCreaturePosition(cid)
    local poses = {{x=playerPos.x+1,y=playerPos.y,z=playerPos.z}, {x=playerPos.x-1,y=playerPos.y,z=playerPos.z},
                   {x=playerPos.x,y=playerPos.y+1,z=playerPos.z}, {x=playerPos.x,y=playerPos.y-1,z=playerPos.z},
                   {x=playerPos.x+1,y=playerPos.y-1,z=playerPos.z}, {x=playerPos.x+1,y=playerPos.y+1,z=playerPos.z},
                   {x=playerPos.x-1,y=playerPos.y+1,z=playerPos.z}, {x=playerPos.x-1,y=playerPos.y-1,z=playerPos.z}}
    for x = 1, #poses do
        local item = doCreateItem(MyLocal.fireId, poses[x])
        addEvent(removeTileItemById, MyLocal.totalTime*1000, getThingPos(item), MyLocal.fireId)
    end
end

local function sendDistanceEffect(cid, finish, target)
    if isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) then
        local playerPos = getCreaturePosition(target)
        local inPos = {x=playerPos.x+math.random(-1, 1),y=playerPos.y+math.random(-1, 1),z=playerPos.z}
        doSendDistanceShoot(playerPos, inPos, 41)
		local mypos = getCreaturePosition(cid)
		doSlow(cid, target, 10, 750)
		doCombat(cid, combat, numberToVariant(target))
        
        if finish then
            MyLocal.players[cid] = nil
            if isCreature(target) then
                local posTarget = getCreaturePosition(target)
               -- if getDistanceBetween(playerPos, posTarget) > 7 then
                --    doPlayerSendCancelEf(cid, "The target is too far, the fold was failed.")
                 --   return true
                --end
                setCreatureNoMoveTime(target, MyLocal.totalTime*1000, MyLocal.totalTime*500)
				if isPlayer(target) then 
					exhaustion.set(target, "stopDashs", 2) 
				end 
                --sendFiresAround(target)
                doSendMagicEffect(posTarget, 120)
				doSendAnimatedText(posTarget, "Suffocated!", 215)
            else
                doPlayerSendCancelEf(cid, "The target is gone, the fold was failed.")
                return true
            end
        end
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end 
    if getPlayerExaust(cid, "air", "suffocation") == false then
        return false
    end

        MyLocal.players[cid] = nil

    if cantReceiveDisable(cid, getCreatureTarget(cid)) then
        return false
    end

    if getPlayerHasStun(cid) then
        if getDobrasLevel(cid) >= 11 then
            doPlayerAddExaust(cid, "air", "suffocation", airExausted.suffocation-7)
        else
            doPlayerAddExaust(cid, "air", "suffocation", airExausted.suffocation)
        end
        return true
    end

    local target = getCreatureTarget(cid)
    doCreatureSetMoveImmuneTime(target, 2701)
    MyLocal.players[cid] = true
    for x = 1, 18 do
        addEvent(sendDistanceEffect, 150*x, cid, x == 18, target)
    end
    workAllCdAndAndPrevCd(cid, "air", "suffocation", nil, 1)
    
        if getDobrasLevel(cid) >= 11 then
            doPlayerAddExaust(cid, "air", "suffocation", airExausted.suffocation-7)
        else
            doPlayerAddExaust(cid, "air", "suffocation", airExausted.suffocation)
        end
    return true
end
