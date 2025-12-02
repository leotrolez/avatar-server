dofile("data/actions/scripts/old/quests/resetquest/const.lua")
local actionsUsed = {}

local function doAllBoses(ready)
    local ready = ready or 3

    if ready < 0 then
        return
    end

    for _, pos in pairs(bosses.altarPositions) do
        if ready > 0 then
            doSendAnimatedText(pos, ready, COLOR_RED)
        else
            local currentAction = 0

            for x = 1, 255 do
                local current = getThingFromPos({x=pos.x,y=pos.y,z=pos.z,stackpos=x})

                if current.uid > 0 then
                    doRemoveItem(current.uid)

                    if current.actionid > 0 then
                        currentAction = current.actionid
                    end
                else
                    break
                end
            end

            if currentAction > 0 then
                doCreateMonster(bosses.posesPotions[currentAction].monsterName, pos, nil, true)
                doSendMagicEffect(pos, 10)
            end
        end
    end

    if ready == 3 then
        removeTileItemByIds(bosses.gatePos, {bosses.gateID}, 2)
    end

    addEvent(doAllBoses, 1000, ready-1)
end


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    for actionid, infos in pairs(bosses.posesPotions) do
        if actionid == item.actionid and item.itemid ~= 8268 then
            if not actionsUsed[actionid] then
                local monster = doCreateMonster(infos.monsterName, {x=fromPosition.x+infos.x,y=fromPosition.y+infos.y,z=fromPosition.z}, nil, true)
                doCreatureSetDropLoot(monster, false)

                doSendMagicEffect({x=fromPosition.x+infos.x,y=fromPosition.y+infos.y,z=fromPosition.z}, infos.eff)
                actionsUsed[actionid] = true

                for x = fromPosition.x-2, fromPosition.x+2 do
                    local currentPos = {x=x,y=fromPosition.y,z=fromPosition.z}
                    local itemid = getTileInfo(currentPos).itemid

                    if itemid == 473 then
                        doCreateItem(infos.item, 1, currentPos)
                        doSendMagicEffect(currentPos, 11)
                        doTransformLever(item)
                        return true
                    end
                end
            end

            doPlayerSendCancel(cid, getLangString(cid, "This boss is already consumed.", "Esse boss jï¿½ foi consumido."))
            return true
        end
    end

    if item.actionid == 3503 then
        if not actionsUsed[item.actionid] then
            for _, pos in pairs(bosses.altarPositions) do
                local current = getTileItemById(pos, bosses.posesPotions[pos.actionid].item)

                if not (current.uid > 0) then
                    doPlayerSendCancel(cid, getLangString(cid, "The Profecy isn't complete.", "A Profecia não estï¿½ completa."))
                    return true
                end
            end

            for _, pos in pairs(bosses.altarPositions) do
                doCreateItem(guards.raiosID, 1, pos)
                doSendMagicEffect(pos, guards.magicEffect)
            end

            doAllBoses()
            actionsUsed = true
            return true
        end
    end
    
    
    return true
end