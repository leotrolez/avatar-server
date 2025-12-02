dofile("data/actions/scripts/old/quests/resetquest/const.lua")

local isOpen = false
local monstersSpammed = false

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if item.actionid == guards.initialActionID then
        if not monstersSpammed then

            for x = 1, #guards.guardPositions do
                doCreateMonster(guards.guardPositions[x].name, guards.guardPositions[x], nil, true)
                doSendMagicEffect(guards.guardPositions[x], 10)
            end

            monstersSpammed = true
        end

        if not isOpen then
            removeTileItemByIds(guards.gatePositions[1], guards.gateIDs, nil)
            isOpen = true
        else
            doCreateItem(guards.gateIDs[2], 1, guards.gatePositions[1])
            isOpen = false
        end

        doTransformLever(item)
    end

    if item.itemid == guards.lifeCrystalID then
        if itemEx.actionid > guards.initialActionID and itemEx.actionid < guards.initialActionID+#guards.gatePositions then
            local currentGate = (itemEx.actionid-guards.initialActionID)+1

            doRemoveItem(item.uid, 1)
            doCreateItem(guards.lifeCrystalID, 1, toPosition)
            doCreateItem(guards.raiosID, 1, toPosition)
            doSendMagicEffect(toPosition, guards.magicEffect)

            removeTileItemByIds(guards.gatePositions[currentGate], guards.gateIDs, nil)
        end
    end

    return true
end