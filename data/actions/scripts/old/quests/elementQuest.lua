--já está na ordem das vocations.

local config = {
   
    posesToEnter = {
        {x=601,y=550,z=12},
        {x=596,y=543,z=12},
        {x=597,y=553,z=12},
        {x=599,y=546,z=12}
    },

    posesEnter = {
        {x=565,y=566,z=12},
        {x=567,y=566,z=12},
        {x=565,y=568,z=12},
        {x=567,y=568,z=12}
    },

    monsterPoses = {
        {x=775,y=251,z=9, name = ""},
        {x=774,y=251,z=9, name = ""},
        {x=770,y=249,z=9, name = ""},
        {x=772,y=249,z=9, name = ""},
    },

    gates = {
        {x=559,y=566,z=12, id = 1546},
        {x=567,y=570,z=12, id = 1547},
        {x=574,y=566,z=12, id = 1546}
    }

    wallId = 12733,
    timeToDoAgain = 60, --time in minutes
    storageCompleted = "questElementCompleted",
    clockPosition = {x=776,y=242,z=9},
    roomPoses = registrePosesBetween({x=548,y=557,z=12}, {x=586,y=577,z=12}, 253)
}

function config.clearRoom()
    for x = 1, #config.roomPoses do
        local possibleCreature

        repeat
            possibleCreature = getTopCreature(config.roomPoses[x]).uid

            if possibleCreature > 0 then
                doRemoveCreature(possibleCreature)
            end
        until possibleCreature == 0
    end

    
end



function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
end