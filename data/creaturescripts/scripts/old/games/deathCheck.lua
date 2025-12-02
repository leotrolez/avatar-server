local function doPurifyPlayer(cid)
    local conditions = {CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_LIFEDRAIN, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_DRUNK}
    for x = 1, #conditions do
		if (hasCondition(cid, conditions[x])) then 
			doRemoveCondition(cid, conditions[x])
		end
	end

end 

function onPrepareDeath(cid)
    if isPlayer(cid) and not castleWar.isOnCastle(cid) then
		if getTileInfo(getCreaturePosition(cid)).hardcore then 
			doPurifyPlayer(cid)
			doPlayerSetPzLocked(cid, false)
			doCreatureSetNoMove(cid, false)
			if not isInWarGround(cid) then 
				doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
				addEvent(function() if isCreature(cid) then doTeleportThing(cid, {x=511, y=348, z=8}, false) end end, 50)
			end
            return true
		end 
		--[[
        if getPlayerStorageValue(cid, "hasActiveInQuest") == -1 then
            return true
        end
            
        --ring one--
        local ringOne = {
            exitPosOne = {x=509,y=327,z=8},
            exitPosTwo = {x=510,y=327,z=8},
        }

        if getStorage("cidOneInRingOne") == cid then
            addEvent(doTeleportThing, 1, cid, ringOne.exitPosOne, false)
            setPlayerStorageValue(cid, "hasActiveInQuest", -1)
            doSetStorage("cidOneInRingOne", 0)
			doPurifyPlayer(cid)
			doPlayerSetPzLocked(cid, false)
            return false
            
        elseif getStorage("cidTwoInRingOne") == cid then 
            addEvent(doTeleportThing, 1, cid, ringOne.exitPosTwo, false)
            setPlayerStorageValue(cid, "hasActiveInQuest", -1)
            doSetStorage("cidTwoInRingOne", 0)
			doPurifyPlayer(cid)
			doPlayerSetPzLocked(cid, false)
            return false
        end
            
        --ring two--
        local ringTwo = {
            exitPosOne = {x=511,y=327,z=8},
            exitPosTwo = {x=512,y=327,z=8},
        }
            
        if getStorage("cidOneInRingTwo") == cid then
            addEvent(doTeleportThing, 1, cid, ringTwo.exitPosOne, false)
            setPlayerStorageValue(cid, "hasActiveInQuest", -1)
            doSetStorage("cidOneInRingTwo", 0)
			doPurifyPlayer(cid)
			doPlayerSetPzLocked(cid, false)
            return false
        
        elseif getStorage("cidTwoInRingTwo") == cid then
            addEvent(doTeleportThing, 1, cid, ringTwo.exitPosOne, false)
            setPlayerStorageValue(cid, "hasActiveInQuest", -1)
            doSetStorage("cidTwoInRingTwo", 0)  
			doPurifyPlayer(cid) 
			doPlayerSetPzLocked(cid, false)
            return false
        end
		]]
    end 

    return true
end