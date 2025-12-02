dofile("data/actions/scripts/old/games/arenaDeath/const.lua")
local game = {}

local function canJoin(cid)
    local players, totalLevel = {}, 0

    for x = 1, #const.positionsToEnter do
        local current = getThingfromPos(const.positionsToEnter[x]).uid

        if current > 0 then
            if isPlayer(current) then
                if getPlayerLevel(cid) >= const.minLevel then
                    table.insert(players, current)

                    local count = getPlayerItemCount(current, const.itemToMonsterBorn.id)

                    if count > 0 then
                        doPlayerRemoveItem(current, const.itemToMonsterBorn.id, count)
                    end

                    totalLevel = totalLevel+getPlayerLevel(current)
                end
            end
        end
    end

    if totalLevel > const.maxLevelTeam then
        doPlayerSendCancel(cid, getLangString(cid, const.msgErrors.levelSomado[1], const.msgErrors.levelSomado[2]))
    end

    local canStart = true

    for x = 1, #players do
        local current = players[x]

        if getPlayerMoney(current) < totalLevel*const.pricePerLevel then
            canStart = false
        end
    end

    if #players < #const.positionsToEnter or canStart == false then
        doPlayerSendCancel(cid, string.format(getLangString(cid, const.msgErrors.errorEnter[1], const.msgErrors.errorEnter[2]), const.minLevel, totalLevel*const.pricePerLevel))
        return false
    end

    return players
end

local function clearRoom()
    for x = const.topLeftPosition.x, const.underRightPosition.x do
        for y = const.topLeftPosition.y, const.underRightPosition.y do
            for z = 9, 10 do
                local current = {x=x,y=y,z=z, stackpos=253}
                local creature = getThingfromPos(current).uid

                if creature > 0 then
                    if isMonster(creature) then
                        doRemoveCreature(creature)
                    end
                end
            end

            local current = {x=x,y=y,z=const.topLeftPosition.z}
            local item = getTileItemById(current, const.itemToMonsterBorn.id)

            if item.uid > 0 then
                doRemoveItem(item.uid)
                doSendMagicEffect(current, 2)
            end
        end
    end  
end

local function reset()
    game.started = false
    game.players = false
    game.timeLeft = 0
    game.totalLevel = 0
    game.waves = 0

    if game.reseted then
        clockWork(const.clock, os.time())
        clearRoom()
    end

    game.reseted = true
end

local function stop(win)
    local win = win and game.waves > 0
    local goldToWin = game.waves*game.totalLevel*const.rewardPerLevel

    for x = 1, #game.players do
        local current = game.players[x]

        if isCreature(current) then
            if win then
                doPlayerAddMoney(current, goldToWin)
                sendBlueMessage(current, "Arena of Death: "..string.format(getLangString(current, const.msgsStartEnd.msgEndWin[1], const.msgsStartEnd.msgEndWin[2]), goldToWin, game.waves))
            else
                sendBlueMessage(current, "Arena of Death: "..string.format(getLangString(current, const.msgsStartEnd.msgEndLost[1], const.msgsStartEnd.msgEndLost[2]), game.waves))
            end

            setMiniGameRank(current, "Death Arena", goldToWin)
            doTeleportCreature(current, {x=const.positionsToEnter[x].x, y=const.positionsToEnter[x].y+1, z=const.positionsToEnter[x].z}, 10)
            setPlayerStorageValue(current, "hasActiveInQuest", -1)
        end
    end

    reset()
end

local function loop()
    if game.started then
        local currentTime = os.time()

        if game.timeLeft > currentTime then
            for x = 1, #game.players do
                if not isCreature(game.players[x]) or (getStorage("deathArena"..x) ~= game.players[x]) then
                    return stop()
                end
            end

            doSendAnimatedText(const.itemToMonsterBorn.position, "$"..(game.totalLevel*const.rewardPerLevel*game.waves), COLOR_DARKYELLOW)
            clockWork(const.clock, game.timeLeft)
            sendTimesOnAnimatedText(const.clock2, game.timeLeft)
            game.currentEvent = addEvent(loop, 1000, nil)
        else
            stop(true)
        end
    end
end

local function start(players)
    stopEvent(game.currentEvent)

    for x = 1, #players do
        local current = players[x]

        registerPlayerInQuest(
            {
                player = current, 
                posExit = getThingPos(current), 
                globalStorage = "deathArena"..x,
                cantUseSpells = const.cantUseSpells,
                blockDeath = true 
            }
        )

        doSetStorage("deathArena"..x, current)
        local positionEntrance = {x=const.positionEnterInicial.x+(x-1),y=const.positionEnterInicial.y,z=const.positionEnterInicial.z}
        doTeleportCreature(current, positionEntrance, 10)
        game.totalLevel = game.totalLevel+getPlayerLevel(current)
    end

    for x = 1, #players do
        doPlayerRemoveMoney(players[x], game.totalLevel*const.pricePerLevel)
        sendBlueMessage(players[x], string.format(getLangString(players[x], const.msgsStartEnd.msgStart[1], const.msgsStartEnd.msgStart[2]), game.totalLevel*const.rewardPerLevel))
    end

    game.players = players
    game.started = true
    game.timeLeft = os.time()+const.clock.time
    doCreateItem(const.itemToMonsterBorn.id, 1, const.itemToMonsterBorn.position)
    loop()
end

local function createWave(cid, item)
    local itemMonster = getTileItemById(const.itemToMonsterBorn.position, const.itemToMonsterBorn.id)

    if itemMonster.uid > 0 and itemMonster.type >= game.waves+1 then
        doRemoveItem(itemMonster.uid, game.waves+1)
        doSendMagicEffect(const.itemToMonsterBorn.position, 5)
        game.waves = game.waves+1

        for x = 1, game.waves+1 do
            local monster = doCreateMonster(const.monster.name, const.monster.bornPosition, nil, true)

            setCreatureMaxHealth(monster, getCreatureMaxHealth(monster)+(const.monster.lifePerWave*game.waves))
            doCreatureAddHealth(monster, getCreatureMaxHealth(monster))
        end

        doSendMagicEffect(const.monster.bornPosition, 5)
        doTransformLever(item)
    else
        doPlayerSendCancel(cid, string.format(getLangString(cid, const.msgErrors.needPutItem[1], const.msgErrors.needPutItem[2]), game.waves+1))
    end    
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if item.uid == const.uniqueIdEnter then
        if not game.started then
            if not game.reseted then
                reset()
            end

            local canStart = canJoin(cid)

            if canStart then
                start(canStart)
                doTransformLever(item)
            end
        else
            doPlayerSendCancel(cid, getLangString(cid, const.miniGameStarted[1], const.miniGameStarted[2]))
        end
    else
        if game.started then
            createWave(cid, item)
        end
    end

    return true
end