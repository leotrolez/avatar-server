local MyLocal = {}
MyLocal.players = {}

local function sendAllCheckFunctions(cid)
    sendInitialItens(cid)
    --sendBackupToPlayer(cid)
    --sendAllConfigsToClient(cid)
    setPlayerStorageValue(cid, "getAwnserAntiBot", -1) -- antiBot System
    setPlayerStorageValue(cid, "currentCid", cid)
    MyLocal.players[cid] = true
end

function onThink(creature, interval)
    local cid = creature.uid
  
    if MyLocal.players[cid] ~= true then
        if getPlayerStorageValue(cid, "currentCid") ~= cid then
            sendAllCheckFunctions(cid)
        else
            MyLocal.players[cid] = true
        end
    end

    local currentPos = getThingPos(cid)
    local item = getThingfromPos({
        x = currentPos.x,
        y = currentPos.y,
        z = currentPos.z,
        stackpos = 0
    })

    if item.itemid == 1 or item.itemid == 460 or item.itemid == 0 then
        if getPlayerStorageValue(cid, "playerCantDown") == -1 then
            doPlayerDown(cid, true)
        end
    end

    return true
end
