dofile("data/actions/scripts/old/quests/poi/const.lua")

local monster = {
    pos = {x=685,y=487,z=10},
    monsterName = "Supreme Abadeer"
}

local used = false

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if not used then
        used = true

        doCreateMonster(monster.monsterName, monster.pos, nil, true)
        doSendMagicEffect(monster.pos, 10)
        doTransformLever(item)

        return true
    end

    return false
end