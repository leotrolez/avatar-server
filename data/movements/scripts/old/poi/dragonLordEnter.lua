local posToBack = {x=827,y=1132,z=9}
local monsterName = "Dragon Lord"

function onStepIn(cid, item, position, fromPosition)

    if isPlayer(cid) and getPlayerAccess(cid) < 4 then
        if getPlayerStorageValue(cid, "DragonPOI") == -1 then
            setPlayerStorageValue(cid, "DragonPOI", 1)
            doTeleportCreature(cid, posToBack, 10)
            doCreateMonster(monsterName, position, nil, true)
            doSendMagicEffect(position, 10)
        end
    end

  return true
end
