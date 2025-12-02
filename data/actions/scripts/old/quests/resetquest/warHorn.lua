dofile("data/actions/scripts/old/quests/resetquest/const.lua")
local isSpammed = false

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if not isSpammed then
        local pos = getThingPos(cid)

        if warHorn.positionToSong.x == pos.x and warHorn.positionToSong.y == pos.y and warHorn.positionToSong.z == pos.z then
            doCreateMonster(warHorn.bossName, warHorn.bossBorn, nil, true)
            doSendMagicEffect(warHorn.bossBorn, warHorn.effect)
            isSpammed = true
        end
    end

    doSendMagicEffect(fromPosition, CONST_ME_SOUND_BLUE)
    return true
end