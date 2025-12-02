dofile("data/actions/scripts/old/quests/resetquest/const.lua")

local raioActive = false


local function doRaio()
    for x = 120, 134 do
        local current = {x=x,y=148,z=14,stackpos=253}
        local creature = getThingfromPos(current).uid

        if creature > 0 then
            doTeleportCreature(creature, limboPosition, 77)
            doSendMagicEffect(getCreaturePosition(cid), 10)
        end

        doSendMagicEffect(current, 76)
    end
end

local function raioLoop()
    for x = elementalRoom.topLeftPos.x, elementalRoom.underRightPos.x do
        for y = elementalRoom.topLeftPos.y, elementalRoom.underRightPos.y do
            local current = {x=x,y=y,z=elementalRoom.topLeftPos.z, stackpos=253}

            if getThingfromPos(current).uid > 0 then
                doRaio()
                return addEvent(raioLoop, elementalRoom.delayToGo, nil)
            end
        end
    end

    raioActive = false
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    local current = elementalRoom[item.actionid]

    if current.element == getPlayerElement(cid) then
        doTeleportCreature(cid, current.position, 10)
        doSendMagicEffect(getCreaturePosition(cid), 10)
    else
        doTeleportCreature(cid, limboPosition, 10)
        doSendMagicEffect(getCreaturePosition(cid), 10)
    end

    if not raioActive then
        raioActive = true
        raioLoop()
    end

    return true
end