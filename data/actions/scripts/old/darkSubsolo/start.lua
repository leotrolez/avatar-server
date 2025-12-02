local config = {
    posesToEnter = {
        {x=86,y=728,z=9},
        {x=86,y=729,z=9},
        {x=86,y=730,z=9},
        {x=86,y=731,z=9}
    }
}

local posesToGo = {
        {x=80,y=834,z=10},
        {x=79,y=834,z=10},
        {x=78,y=834,z=10},
        {x=77,y=834,z=10}
}

local darkAnihiVar = {
    timeToDoAgain = 0,
    loopHasActive = false,
}



local function doClearAnihiRoom()
	local theRoomPoses = registrePosesBetween({x=75,y=831,z=10}, {x=82,y=837,z=10}, 253)
    for x = 1, #theRoomPoses do
        local possibleCreature

        repeat
            possibleCreature = getTopCreature(theRoomPoses[x]).uid

            if possibleCreature > 0 then
                doRemoveCreature(possibleCreature)
            end
        until possibleCreature == 0

    end
	-- TODO
	local monsterPoses = {
        {x=78,y=832,z=10},
        {x=80,y=832,z=10},
        {x=77,y=836,z=10},
        {x=79,y=836,z=10}
    }

	local monsterPoses2 = {
        {x=81,y=834,z=10},
        {x=82,y=834,z=10}
    }

	for x = 1, #monsterPoses do
        doCreateMonster("Dark Warlock Anihi", monsterPoses[x])
    end
	for x = 1, #monsterPoses2 do
        doCreateMonster("Dark Fury Anihi", monsterPoses2[x])
    end
end

function doTheLoopClock()
    local currentTime = os.time()

    if darkAnihiVar.timeToDoAgain >= currentTime then
        clockWork({x=84,y=726,z=9}, darkAnihiVar.timeToDoAgain) 
    end

    addEvent(doTheLoopClock, 1000)
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid 
    local currentTime = os.time()

    if not darkAnihiVar.loopHasActive then
		doTheLoopClock()
    end 

    if darkAnihiVar.timeToDoAgain < currentTime then
    else
        doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(darkAnihiVar.timeToDoAgain-currentTime).." to start.", "Você precisa esperar "..getSecsString(darkAnihiVar.timeToDoAgain-currentTime).." para iniciar."))
		return true
    end
	local players = {}
	local elements = {}
    for x = 1, #config.posesToEnter do
        local possiblePlayer = getTopCreature(config.posesToEnter[x]).uid
		if possiblePlayer > 0 and isPlayer(possiblePlayer) and not isInArray(elements, getPlayerVocation(possiblePlayer)) then
            players[x] = possiblePlayer
			elements[x] = getPlayerVocation(possiblePlayer)
        else
			doPlayerSendCancel(cid, getLangString(cid, "Your team needs an bender of each element to start.", "Seu time precisa de um dobrador de cada elemento para iniciar."))
            return true
        end
    end
	doClearAnihiRoom()
	for i = 1, #players do 
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
		doTeleportThing(players[i], posesToGo[i])
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
	end 
	
    darkAnihiVar.timeToDoAgain = os.time()+(60*60)
	return true
end
