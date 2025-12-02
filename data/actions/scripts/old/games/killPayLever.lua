local MyLocal = {}
local config = {maxLevel = 25}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
         if getThingfromPos({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z, stackpos=253}).uid > 0 then
            doPlayerSendCancel(cid, "First you have to kill the creature has summoned.")
            doSendMagicEffect(fromPosition, 2)
            return true
         end
         if item.actionid == 10252 then
            if doPlayerRemoveMoney(cid, 25) == true then
               if item.itemid == 1945 then
                  doTransformItem(item.uid, 1946)
               else
                  doTransformItem(item.uid, 1945)
               end
               doSendMagicEffect({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z}, 11) 
               local monster = doCreateMonster("Bandit", {x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z}, nil, true)
               doCreatureSetNoMove(monster, true)
            else
               doPlayerSendCancel(cid, "You don't have enough money.")
            end
         elseif item.actionid == 10256 then
             if doPlayerRemoveMoney(cid, 65) == true then
                if item.itemid == 1945 then
                   doTransformItem(item.uid, 1946)
                else
                   doTransformItem(item.uid, 1945)
                end
                doSendMagicEffect({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z}, 11) 
                local monster = doCreateMonster("Dark Monk", {x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z}, nil, true)
                doCreatureSetNoMove(monster, true)
             else
                doPlayerSendCancel(cid, "You don't have enough money.")
             end
         else
            if doPlayerRemoveMoney(cid, 65) == true then
                if item.itemid == 1945 then
                   doTransformItem(item.uid, 1946)
                else
                   doTransformItem(item.uid, 1945)
                end
                doSendMagicEffect({x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z}, 11) 
                local monster = doCreateMonster("Dark Monk", {x=fromPosition.x+1,y=fromPosition.y,z=fromPosition.z})
                doCreatureSetNoMove(monster, true)
             else
                doPlayerSendCancel(cid, "You don't have enough money.")
             end
         end
   return true
end