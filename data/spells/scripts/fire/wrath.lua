local spellName = "fire wrath"
local cf = {segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.fireId = 1397
MyLocal.totalTime = cf.segundos
MyLocal.focusTotalTime = cf.segundos*2
MyLocal.players = {}


local function sendFiresAround(cid, focus)
    local playerPos = getCreaturePosition(cid)
    local poses = {{x=playerPos.x+1,y=playerPos.y,z=playerPos.z}, {x=playerPos.x-1,y=playerPos.y,z=playerPos.z},
                   {x=playerPos.x,y=playerPos.y+1,z=playerPos.z}, {x=playerPos.x,y=playerPos.y-1,z=playerPos.z},
                   {x=playerPos.x+1,y=playerPos.y-1,z=playerPos.z}, {x=playerPos.x+1,y=playerPos.y+1,z=playerPos.z},
                   {x=playerPos.x-1,y=playerPos.y+1,z=playerPos.z}, {x=playerPos.x-1,y=playerPos.y-1,z=playerPos.z}}
    for x = 1, #poses do
        if getPlayerCanWalk({player = cid, position = poses[x], checkPZ = true, checkHouse = true}) then
            local item = doCreateItem(MyLocal.fireId, poses[x])
            if focus then
                addEvent(removeTileItemById, MyLocal.focusTotalTime*1000, getThingPos(item), MyLocal.fireId)
            else
                addEvent(removeTileItemById, MyLocal.totalTime*1000, getThingPos(item), MyLocal.fireId)
            end
        end
    end
end

local function sendDistanceEffect(cid, finish, target)
    if isCreature(cid) then
        local playerPos = getCreaturePosition(cid)
        local inPos = {x=playerPos.x+math.random(-1, 1),y=playerPos.y+math.random(-1, 1),z=playerPos.z}
        doSendDistanceShoot(inPos, playerPos, 52)
        
        if finish then
            MyLocal.players[cid] = nil
			if getDobrasLevel(cid) >= 10 then
				doPlayerAddExaust(cid, "fire", "wrath", fireExausted.wrath-4)
			else
				doPlayerAddExaust(cid, "fire", "wrath", fireExausted.wrath)
			end
            if isCreature(target) then
                local posTarget = getCreaturePosition(target)
                if getDistanceBetween(playerPos, posTarget) > 7 then
                    doPlayerSendCancelEf(cid, "The target is too far, the fold was failed.")
                    return true
                end
                if getPlayerOverPower(cid, "fire", true, true) == true then
                    setCreatureNoMoveTime(target, MyLocal.focusTotalTime*1000, MyLocal.focusTotalTime*500)
                    sendFiresAround(target, true)
					doPlayerCancelFollow(target)
                else
                    setCreatureNoMoveTime(target, MyLocal.totalTime*1000, MyLocal.totalTime*500)	
					if isPlayer(target) then 
						exhaustion.set(target, "stopDashs", 2) 
					end 
                    sendFiresAround(target)
					doPlayerCancelFollow(target)
                end
                doSendDistanceShoot(playerPos, posTarget, 52)
            else
                doPlayerSendCancelEf(cid, "The target is gone, the fold was failed.")
                return true
            end
        end
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end 
    if MyLocal.players[cid] == nil then
        if getPlayerExaust(cid, "fire", "wrath") == false then
            return false
        end
        if cantReceiveDisable(cid, getCreatureTarget(cid)) then
            return false
        end
        if getPlayerHasStun(cid) then
			if getDobrasLevel(cid) >= 10 then
				doPlayerAddExaust(cid, "fire", "wrath", fireExausted.wrath-4)
			else
				doPlayerAddExaust(cid, "fire", "wrath", fireExausted.wrath)
			end
            workAllCdAndAndPrevCd(cid, "fire", "wrath", nil, 1)
            return true
        end
        local target = getCreatureTarget(cid)
        MyLocal.players[cid] = true
        for x = 1, 6 do
            addEvent(sendDistanceEffect, 100*x, cid, x == 6, target)
        end
        workAllCdAndAndPrevCd(cid, "fire", "wrath", 1, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
