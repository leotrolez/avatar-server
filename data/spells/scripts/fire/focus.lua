local MyLocal = {}
MyLocal.time = 15

local function sendDistanceEffect(cid)
	local playerPos = getCreaturePosition(cid)
	local xizes = {-3, 3, -3, 3}
	local yizes = {-3, 3, 3, -3}
	for i = 1, #xizes do 
		doSendDistanceShoot({x=playerPos.x+xizes[i], y=playerPos.y+yizes[i], z=playerPos.z}, playerPos, 3)
	end 
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if getPlayerExaust(cid, "fire", "focus") == false then
        return false
    end

    if getPlayerHasStun(cid) then
		if getDobrasLevel(cid) >= 11 then
			doPlayerAddExaust(cid, "fire", "focus", fireExausted.focus-12)
		else
			doPlayerAddExaust(cid, "fire", "focus", fireExausted.focus)
		end
        workAllCdAndAndPrevCd(cid, "fire", "focus", nil, 5)
        return true
    end
    local playerPos = getThingPos(cid)
	doSendMagicEffect(playerPos, 15)
    sendDistanceEffect(cid)
    workAllCdAndAndPrevCd(cid, "fire", "focus", 4, 0)
	if getDobrasLevel(cid) >= 11 then	
		doPlayerAddExaust(cid, "fire", "focus", fireExausted.focus-12)
	else
		doPlayerAddExaust(cid, "fire", "focus", fireExausted.focus)
	end
    setPlayerOverPower(cid, "fire", MyLocal.time)    
	doSendMagicEffect(playerPos, 15)
    return true
end