dofile("data/actions/scripts/old/quests/poi/const.lua")


local used = {
    [8712] = false,
    [8713] = false
}

local stoneId = 1304

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if not used[item.actionid] then
        for x = toPosition.x-3, toPosition.x+3 do
            if removeTileItemById({x=x,y=toPosition.y,z=toPosition.z}, stoneId, 2) then
                used[item.actionid] = true
                doTransformLever(item)
                break
            end
        end
    end
    
    return true
end



--[[Pré condições (NPC)

level 100;
5 tasks diarias;
1 stone da vocação;

task especial, 50 dragons e 5 dragon lord; (1x)
npc teleport (pos: 802, 1102 9)


fluxo: 
puxa alanvacas, abre pedras, cada alavanca libera par de pedras.

quando pisa no tile, é teleportado um dragon lord e o player teleportado para entrada novamento
pisa no trono e vai liberando.
--]]