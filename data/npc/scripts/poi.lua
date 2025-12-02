local npcGen = newNpc("npcPOI")

local config = {
    levelMin = 100,
    dailyTasks = 5,
    posEnter = {x=802, y=1102, z=9}
}


npcGen:setFuncStart(function(cid)
    local level, lang = getPlayerLevel(cid), getLang(cid)

    if level < config.levelMin then
        npcGen:say("Hello "..getCreatureName(cid)..", you need be level "..config.levelMin.." or higher to enter here.", "Olá "..getCreatureName(cid)..", Você precisa ter level "..config.levelMin.." ou mais para entrar aqui.", lang)
        return false
    end

    if getPlayerHasEndTask(cid, 50) and getPlayerHasEndTask(cid, 51) then
        doCreatureSetStorage(cid, "canEnterPOI", 1)
        setPlayerStorageValue(cid, "POIQuestProgress", 2)
    end

    npcGen:say("Hello "..getCreatureName(cid).." you want enter in POI quest?", "Olá "..getCreatureName(cid)..", você deseja entrar na POI quest?", lang)
    return true
end)

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        local element = getPlayerElement(cid)

        if stage == 1 then
            if msgcontains(msg, "poi") or msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerStorageValue(cid, "canEnterPOI") == 1 then
                    npcGen:say("To enter in quest, you need pay 1 "..element.." stone, you accept?", "Para entrar na quest você precisa pagar 1 "..element.." stone, você aceita?")
                    npcGen:setStage(2)

                else
                    if not (playerHasTaskInProgress(cid, 50) or playerHasTaskInProgress(cid, 51)) then
                        npcGen:say("To enter in quest, you need kill 50 dragons and 5 dragon lords, are you accept? Bitch.", "Para entrar aqui, você precisa matar 50 dragons e 5 dragon lords, você aceita? Verme.")
                        npcGen:setStage(3)
                    else
                        npcGen:say("What you do here!? Come back when you did your tasks!", "O que você faz aqui, verme? Volte quando tiver completado as tasks.")
                        npcGen:forceBye()
                    end
                end
            end

        elseif stage == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if doPlayerRemoveItem(cid, getStoneItemId(element), 1) then
                    npcGen:say("God bless you.", "Que deus o abençoe, bronze.")

                    if getPlayerStorageValue(cid, "POIQuestProgress") == 2 then
                        setPlayerStorageValue(cid, "POIQuestProgress", 3)
                    end

                    doTeleportCreature(cid, config.posEnter, 10)
                else
                    npcGen:say("You don't have 1 stone, bitch!", "Você não tem uma stone para entrar, verme.")
                    npcGen:setStage(1)
                end
            end

        elseif stage == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                startTaskInPlayer(cid, 50, npcGen:getName())
                startTaskInPlayer(cid, 51, npcGen:getName())
                npcGen:say("Huum..., you need kill 50 dragon(s) and 5 dragon lord(s), when you finish back here to get your reward.", "Huum..., você precisa matar 50 dragon(s) and 5 dragon lord(s), quando você terminar volte aqui para pegar sua recompensa.")
                sendBlueMessage(cid, getLangString(cid, "New tasks added. For more information type !tasks.", "Novas tasks adicionada. Para mais informações digite !tasks."))
                setPlayerStorageValue(cid, "POIQuestProgress", 1)
                npcGen:forceBye()
            end
        end


        return true
    end)
end

function onThink()
    npcGen:onThink()
end

function onCreatureDisappear(cid, pos)
    npcGen:onDisappear(cid, pos)
end