local config = {
   
    posesToEnter = {
        {x=778,y=237,z=9},
        {x=778,y=238,z=9},
        {x=778,y=239,z=9},
        {x=778,y=240,z=9}
    },

    posesEnter = {
        {x=770,y=251,z=9},
        {x=771,y=251,z=9},
        {x=772,y=251,z=9},
        {x=773,y=251,z=9}
    },

    monsterPoses = {
        {x=770,y=249,z=9},
        {x=772,y=249,z=9},
        {x=771,y=253,z=9},
        {x=773,y=253,z=9}
    },

	    monsterPoses2 = {
        {x=775,y=251,z=9},
        {x=774,y=251,z=9}
    },

    monsterName = "Diabolic Imp1",
    monsterName2 = "Hellfire Fighter1",
    timeToDoAgain = 60, --time in minutes
    storageCompleted = "90500",
    clockPosition = {x=776,y=242,z=9},
    roomPoses = registrePosesBetween({x=770,y=249,z=9}, {x=775,y=253,z=9}, 253)
}

local dVar = {
    timeToDoAgain = 0,
    loopHasActive = false,
}

function config.loopClock()
    local currentTime = os.time()

    if dVar.timeToDoAgain >= currentTime then
        clockWork(config.clockPosition, dVar.timeToDoAgain)
    end

    addEvent(config.loopClock, 1000)
end

function config.clearAnihiRoom()
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

function config.start(cid)
    local players = {}

    for x = 1, #config.posesToEnter do
        local possiblePlayer = getTopCreature(config.posesToEnter[x]).uid

        if possiblePlayer > 0 and isPlayer(possiblePlayer) then
            if getPlayerStorageValue(possiblePlayer, config.storageCompleted) == 1 then
                doPlayerSendCancel(cid, getLangString(cid, "Someone on your team has already completed this quest.", "Alguém do seu time já completou essa quest."))
                return false
            else
                players[x] = possiblePlayer
            end
        else
            doPlayerSendCancel(cid, getLangString(cid, "Your team needs an bender of each element to start the Four Elements Quest.", "Seu time precisa de um dobrador de cada elemento para iniciar a Quest dos Quatro Elementos."))
            return false
        end
    end
	
	local elements = {}
	for x = 1, #players do
		if isInArray(elements, getPlayerVocation(players[x])) then 
			doPlayerSendCancel(cid, getLangString(cid, "Your team needs an bender of each element to start the Four Elements Quest.", "Seu time precisa de um dobrador de cada elemento para iniciar a Quest dos Quatro Elementos."))
			return false
		end 
        table.insert(elements, getPlayerVocation(players[x]))
    end
	
    dVar.timeToDoAgain = os.time()+(config.timeToDoAgain*60)
    config.clearAnihiRoom()

    for x = 1, #players do
        doTeleportCreature(players[x], config.posesEnter[x], 10)
    end

    for x = 1, #config.monsterPoses do
        doCreateMonster(config.monsterName, config.monsterPoses[x])
    end
	for x = 1, #config.monsterPoses2 do
        doCreateMonster(config.monsterName2, config.monsterPoses2[x])
    end

    return true
end


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    local currentTime = os.time()

    if not dVar.loopHasActive then
        config.loopClock()
    end 

    if dVar.timeToDoAgain < currentTime then
        local start = config.start(cid)

        if start then
            doTransformLever(item)
        end
    else
        doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(dVar.timeToDoAgain-currentTime).." to start the Four Elements Quest.", "Você precisa esperar "..getSecsString(dVar.timeToDoAgain-currentTime).." para iniciar a Quest dos Quatro Elementos."))
    end

    return true
end