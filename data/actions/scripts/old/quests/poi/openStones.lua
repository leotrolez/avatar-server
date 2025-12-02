dofile("data/actions/scripts/old/quests/poi/const.lua")

local stoneId = 1304

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if not openStones[item.actionid].used then
        for x = openStones[item.actionid].posInitial.x, openStones[item.actionid].posInitial.x+1 do
            removeTileItemById({x=x,y=openStones[item.actionid].posInitial.y,z=openStones[item.actionid].posInitial.z}, stoneId, 2)
        end

        openStones[item.actionid].used = true
        doTransformLever(item)
        return true
    end

    
    return false
end