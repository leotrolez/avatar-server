local spellName = "air jail"
local cf = {segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.fireId = 13025
MyLocal.totalTime = cf.segundos
MyLocal.players = {}

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
    if isCreature(cid) then
        local playerPos = getCreaturePosition(cid)
        local inPos = {x=playerPos.x+math.random(-1, 1),y=playerPos.y+math.random(-1, 1),z=playerPos.z}
        doSendDistanceShoot(inPos, playerPos, 41)
        
        if finish then
            MyLocal.players[cid] = nil
            doPlayerAddExaust(cid, "air", "jail", airExausted.jail)
            if isCreature(target) then
                local posTarget = getCreaturePosition(target)
                if getDistanceBetween(playerPos, posTarget) > 7 then
                    doPlayerSendCancelEf(cid, "The target is too far, the fold was failed.")
                    return true
                end
                setCreatureNoMoveTime(target, MyLocal.totalTime*1000, MyLocal.totalTime*500)
				if isPlayer(target) then 
					exhaustion.set(target, "stopDashs", 2) 
				end 
                sendFiresAround(target)
                doSendDistanceShoot(playerPos, posTarget, 41)
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
    if MyLocal.players[cid] == nil then
        if getPlayerExaust(cid, "air", "jail") == false then
            return false
        end


        if getCreatureNoMove(getCreatureTarget(cid)) then
            doPlayerSendCancelEf(cid, "You can not use this ability in this creature now.")
            return false
        end

        if getPlayerHasStun(cid) then
            doPlayerAddExaust(cid, "air", "jail", airExausted.jail)
            return true
        end

        local target = getCreatureTarget(cid)
        doPlayerCancelFollow(target)
        MyLocal.players[cid] = true
        for x = 1, 6 do
            addEvent(sendDistanceEffect, 100*x, cid, x == 6, target)
        end
        workAllCdAndAndPrevCd(cid, "air", "jail", 1, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
