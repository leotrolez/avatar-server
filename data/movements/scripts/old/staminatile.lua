STAMINA_TIME = 5 * 60 * 1000
STAMINA_ADD = 1

local staminaPlayers = {}

function event(cid)
    if isPlayer(cid) then
        doPlayerAddStamina(cid, STAMINA_ADD)
        staminaPlayers[cid] = addEvent(event, STAMINA_TIME, cid)
    end
end

function onStepIn(creature, item, position, fromPosition, pos)
    if isPlayer(creature) then
        staminaPlayers[creature:getId()] = addEvent(event, STAMINA_TIME, creature:getId())
    end
    return true
end

function onStepOut(creature, item, position, fromPosition)
    if isPlayer(creature) then
        if staminaPlayers[creature:getId()] then
            stopEvent(staminaPlayers[creature:getId()])
            staminaPlayers[creature:getId()] = nil
        end
    end
    return true
end