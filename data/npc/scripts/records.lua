local miniGames = {"Zumbi Snake", "Shooting The Bird", "Kill The Beast Easy", 
"Kill The Beast Medium", "Find The Doll", "Death Arena", "All Mini Games"}

local miniGamesInfo = {
    {consulta = "DESC", another = "bodies"}, {consulta = "DESC", another = "birds"},
    {consulta = "ASC", another = "seconds"}, {consulta = "ASC", another = "seconds"},
    {consulta = "ASC", another = "seconds"}, {consulta = "DESC", another = "gold coins"},
    {consulta = "DESC", another = ""}

}

local function doPlayerReceiveRewards(cid, rank)
    if rank == "global" then
        setMiniGameRank(cid, "All Mini Games", os.date("%d")..os.date("%m")..os.date("%y"))
        setPlayerStorageValue(cid, "challengeGlobalNpcLockeFinish", 1)
    end
end

local npcGen = newNpc("recordsNpc")

npcGen:setFuncStart(function(cid)
    local playerPos, lang = getThingPos(cid), getLang(cid)

    if getThingFromPos({x=playerPos.x, y=playerPos.y, z=playerPos.z, stackpos = 0}).itemid ~= 12707 then
        npcGen:say("Please enter in my room first.", "Porfavor entre na minha sala antes.", lang)
        return false
    end

    npcGen:say("Hello "..getCreatureName(cid).."! I've registred in my blackboards all RECORDS for all mini games. I also have some CHALLENGES available.", "Olá "..getCreatureName(cid).."! I tenho registrado em meus quadros todos RECORDS de todos mini-games. Eu também tenho algumas CHALLENGES disponíveis.", lang)
    return true
end)

npcGen:addOptionInNpc("help", {"I don't need your help, thanks.", "Eu não preciso de sua ajuda jovem."})
npcGen:addOptionInNpc("records", {"You want to see the records of which mini-game, I've records of: "..orgazineStrings(miniGames)..".", "Você deseja ver os records de algum minigame? Eu tenho registrado aqui os recordes dos seguintes games: "..orgazineStrings(miniGames).."."})
npcGen:addOptionInNpc("challenge", {"Sorry, I don't have any challenge right now.", "Desculpe, eu não tenho nenhuma challenge disponível nesse momento."})

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            for x = 1, #miniGames do
                if msgcontains(msg, string.lower(miniGames[x])) then
                    npcGen:say("You want to see GLOBAL records or your PERSONAL records, of this game?", "Você deseja ver o record GLOBAL ou INDIVIDUAL desse mini-game?")
                    npcGen:setStorage("getMinigame", x)
                    npcGen:setStage(2)
                    return true
                end
            end

        elseif stage == 2 then
            if msgcontains(msg, "personal") or msgcontains(msg, "individual") then
                npcGen:say("Let me look ... Here, read this part of blackboard.", "Deixe-me ver.... Aqui está, veja nesse quadro.")
                getMiniGameRank(cid, miniGames[npcGen:getStorage("getMinigame")], miniGamesInfo[npcGen:getStorage("getMinigame")].consulta, miniGamesInfo[npcGen:getStorage("getMinigame")].another, true)
            elseif msgcontains(msg, "global") then
                npcGen:say("Huuum, see this blackboard, please.", "Huuum, por favor veja esse quadro.")
                getMiniGameRank(cid, miniGames[npcGen:getStorage("getMinigame")], miniGamesInfo[npcGen:getStorage("getMinigame")].consulta, miniGamesInfo[npcGen:getStorage("getMinigame")].another)
            else
                npcGen:say("Sorry, I didn't understand what you wanna.", "Desculpe, eu não entendi o que você quer.")
            end
            npcGen:setStage(1)
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