local spellName = "air trap"
local cf = {segundos = spellsInfo[spellName].segundos}

local trapId = 13025
local time = cf.segundos

function onCastSpell(creature, var)
	local cid = creature:getId()
    if not isPlayer(cid) then
        return false
    end  

    if getSpellCancels(cid, "air") == true then
        return false
    end

    if getPlayerExaust(cid, "air", "trap") == false then
        return false
    end

    if getPlayerHasStun(cid) then
		if getDobrasLevel(cid) >= 17 then
			doPlayerAddExaust(cid, "air", "trap", airExausted.trap-2)
		else
			doPlayerAddExaust(cid, "air", "trap", airExausted.trap)  
		end
        return true
    end

    local posTrap = getCreatureLookPosition(cid)

    if getPlayerCanWalk({player = cid, position = posTrap, checkPZ = true, checkHouse = true, checkWater = true}) then
		if getDobrasLevel(cid) >= 17 then
			doPlayerAddExaust(cid, "air", "trap", airExausted.trap-2)
		else
			doPlayerAddExaust(cid, "air", "trap", airExausted.trap) 
		end
        local trap = doCreateItem(trapId, posTrap)
		if not trap then
			return false
		end
        addEvent(removeTileItemById, time*1000, getThingPos(trap), trapId)
        doItemSetAttribute(trap, "airTrapOwner", cid)
        return true
    else
        doPlayerSendCancelEf(cid, "It isn't possible use this fold here.")
        return false
    end  
    return true
end
