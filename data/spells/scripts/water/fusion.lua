local MyLocal = {}
MyLocal.waterPounchFull = 4864
MyLocal.waterPounchEmpty = 4863
MyLocal.blockId = 6299
MyLocal.timeToPuff = 60

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "fusion") == false then
        return false
    end
    local playerPos = getThingPos(cid)
    if tileIsIce(playerPos) then
        if getTileItemById(playerPos, MyLocal.blockId).uid == 0 then    
            if getPlayerHasStun(cid) then
                doPlayerAddExaust(cid, "water", "fusion", waterExausted.fusion)
                workAllCdAndAndPrevCd(cid, "water", "fusion", nil, 1)
                return true
            end
            if setWaterOnPounchPlayer(cid, 100) then
                doPlayerAddExaust(cid, "water", "fusion", waterExausted.fusion)
                doCreateItem(MyLocal.blockId, playerPos)
                addEvent(removeTileItemById, MyLocal.timeToPuff*1000, playerPos, MyLocal.blockId)
                doSendMagicEffect(playerPos, 25)
                workAllCdAndAndPrevCd(cid, "water", "fusion", nil, 1)
                return true
            else
                doPlayerSendCancelEf(cid, "You need have a water pounch to use this fold.")  
            end
        else
            doPlayerSendCancelEf(cid, "This tile has already been drained.")
        end
    else
        doPlayerSendCancelEf(cid, "You can use this fold only on ice.")
    end 
    return false
end