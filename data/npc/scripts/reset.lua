local npcGen = newNpc("resetSystemNpc")

local config = {
    needPremium = true,

    levelToReset = {
        100, 120, 130, 140, 160, 180, 
        200, 230, 245, 270, 300, 350
    },

    priceInGold = {
        250, 550, 800, 1300, 1800, 2200,
        3000, 4000, 5000, 7000, 9000, 13000
    },

    minTasks = 30,
    bonusHealthPerReset = 100,
    bonusManaPerReset = 20,
    bonusPointsPerReset = 10,

    elementSpirit = 12325, --ID
    hourToReset = 10,


    itemsToReset = {
        {itemid = 10605, amount = 100, name = "bundle of cursed straw"},
        {itemid = 10584, amount = 100, name = "boggy's dread"},
        {itemid = 2146, amount = 80, name = "small sapphire"},
        {itemid = 9955, amount = 1, name = "vampiric crest", notIncrement = true}
    },

    incrementPerReset = 0.1 --inPercent (0.1 = 10%)
}

local function getListItemsString(items, resets)
    local string = ""

    for x = 1, #items do
        local amount = items[x].amount

        if not items[x].notIncrement then
            amount = math.ceil(amount+(amount*(config.incrementPerReset*(resets+1))))
        end

        if x < #items then
            string = string..amount.." "..items[x].name.."(s), "
        else
            string = string..amount.." "..items[x].name.."(s)"
        end
    end

    return string
end

local function doPlayerRemoveResetItems(cid, items, resets)
    local nItems = {}

    for x = 1, #items do
        local amount = items[x].amount

        if not items[x].notIncrement then
            amount = math.ceil(amount+(amount*(config.incrementPerReset*(resets+1))))
        end

        table.insert(nItems, {itemid = items[x].itemid, amount = amount})
    end

    if doPlayerRemoveItens(cid, nItems) then
        return true
    end

    return false
end

--[[
Logica:

vem até o NPC
Pega Bless.

NPC Tira grana do player
NPC da Storage para entrar na porta ("canStartResetQuest")
Player faz a quest.

NPC Checa se o player fez a quest com storage ("hasCompletedResetQuest")
NPC Checa se o player tem o item. (elementSpirit)

Npc Tira o item
NPC tira as 2 storages acima ("canStartResetQuest") ("hasCompletedResetQuest")
NPC da stoage ("inWaitToReset"), com 10 horas.

player aguarda 10 horas.

Player vem no NPC e pega o reset no char e tira a storage "hasCompletedResetQuest"
--falta testar



Logica global da quest
    --não esquecer: Desabilitar teleport dentro dela;
    --Fechar ela após 20 min da entrada do primeiro;
    --Alguma forma de "marcar o item", para que ele não seja perdido (alternativa: bloquear o move dele.)
    --
]]--

npcGen:needPremium(config.needPremium)
npcGen:addOptionInNpc("help", {"Hahaha, I don't need help from one mortal.", "Hahaha, eu não preciso de ajuda de um pobre mortal."})
npcGen:addOptionInNpc("tutorial", {"http://avatarlegends.webnode.com/tutoriais/reset-system/", "http://avatarlegends.webnode.com/tutoriais/reset-system/"})

npcGen:setFuncStart(function(cid)
    local lang, time, currentReset = getLang(cid), getPlayerStorageValue(cid, "inWaitToReset"), getPlayerResets(cid)

    if time ~= -1 then
        if time > os.time() then
            local stringTime = getSecsString(time-os.time())
            npcGen:say("You need wait I prepare your reset, keep calm. Come back in "..stringTime..".", "Você precisa esperar eu prepara o seu reset, mantenha a calma. Volte em "..stringTime..".", lang)
        else
            npcGen:say("Congratulations! Now you have "..(currentReset+1).." reset(s), remember: now you have a lot of responsibility and power! Use with wisdom!",
                       "Parábens! Agora você tem "..(currentReset+1).." reset(s), lembre-se: agora você tem muito responsabilidade e poder! Use com sabedoria!", lang)
            doPlayerAddReset(cid, config.bonusHealthPerReset, config.bonusManaPerReset, config.bonusPointsPerReset)
            doCreatureSetStorage(cid, "inWaitToReset", -1)
            doTeleportCreature(cid, getTownTemplePosition(getPlayerTown(cid)))
            --pronto para outro reset.
        end

        return false
    end

    npcGen:say("Hello little mortal, I can RESET you, but you need pay a small sacrifice, or maybe you can see a small TUTORIAL.", "Olá pequeno mortal, eu posso RESETAR você, porém você terá de me pagar um pequeno sacrificio, ou talvez você deseje ver um pequeno TUTORIAL.", lang)
    return true
end)


function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        local currentReset = getPlayerResets(cid)

        if stage == 1 then
            if msgcontains(msg, "reset") or msgcontains(msg, "resetar") then
                if currentReset+1 > #config.levelToReset then
                    npcGen:say("You already have a big font of power!", "Você já tem uma grande fonte de poder!")
                    return true
                end

                if getPlayerLevel(cid) < config.levelToReset[currentReset+1] then
                    npcGen:say("Huum, to your "..(currentReset+1).."° reset you need be a level "..config.levelToReset[currentReset+1].." or more, sorry.",
                    "Huum, para o seu "..(currentReset+1).."° reset você precisa ter no minimo level "..config.levelToReset[currentReset+1]..", sorry.")
                    return true
                end

                if getPlayerStorageValue(cid, "canStartResetQuest") == -1 and getPlayerStorageValue(cid, "hasCompletedResetQuest") == -1 then
                    
                    if currentReset+1 == 1 then
                        npcGen:say("Ok little mortal, to reset sucessfuly you need get my bless, in your first reset will be free of payments, do yoy accept?", 
                        "Ok pequeno mortal, para resetar com sucesso você precisa da minha bless, no primeiro reset será de graça, deseja ter a bless agora?")

                    else
                        local stringItems = getListItemsString(config.itemsToReset, currentReset)

                        npcGen:say("Ok little mortal, to reset sucessfuly you need have completed 30 normal tasks (monsters if you have level), pay "..(config.priceInGold[currentReset+1]).."k gold coins and bring-me "..stringItems..", are you interresed?",
                        "Ok pequeno mortal, para resetar com sucesso você precisa ter completado todas as tasks (monstros até o seu level), pagar "..(config.priceInGold[currentReset+1]).."k gold coins e me trazer "..stringItems..", você está interresado?")
                    end

                    npcGen:setStage(2)
                else
                    if getPlayerStorageValue(cid, "hasCompletedResetQuest") == 1 then
                        npcGen:say("Ohhhhhhh, you're with the Element Stone?", "Ohhhhhh, você está com a Element Stone?")
                        npcGen:setStage(3)
                    else
                        npcGen:say("Just come back here when you have completed the RESET QUEST!", "O que você faz aqui? Só volte quando tiver concluido a RESET QUEST!")
                        npcGen:forceBye()
                    end
                end
            end

        elseif stage == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                
                if currentReset+1 == 1 then
                    npcGen:say("OK! Now you need prove your skills. Please do the RESET QUEST and bring-me a element spirit.", "OK! Agora você precisa provar suas habilidades. Faça a RESET QUEST e me traga o element spirit, para que eu possa reseta-lo.")
                    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "You have received a Bless of Isolde to do RESET QUEST.", "Você recebeu a benção de Isolde para fazer a RESET QUEST."))
                    doCreatureSetStorage(cid, "canStartResetQuest", 1)
                    npcGen:forceBye()
                else
                    if getTasksCompleted(cid) >= config.minTasks and doPlayerRemoveResetItems(cid, config.itemsToReset, currentReset) then
                        if doPlayerRemoveMoney(cid, config.priceInGold[currentReset+1]*1000) then
                            npcGen:say("OK! Now you need prove your skills. Please do the RESET QUEST and bring-me a element spirit.", "OK! Agora você precisa provar suas habilidades. Faça a RESET QUEST e me traga o element spirit, para que eu possa reseta-lo.")
                            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "You have received a Bless of Isolde to do RESET QUEST.", "Você recebeu a benção de Isolde para fazer a RESET QUEST."))
                            doCreatureSetStorage(cid, "canStartResetQuest", 1)
                            npcGen:forceBye()
                        else
                            npcGen:say("Sorry, you need "..config.priceInGold[currentReset+1].."k gold coins to do it.", "Desculpe, você precisa de "..config.priceInGold[currentReset+1].."k gold coins para fazer isso.")
                        end
                    else
                        local stringItems = getListItemsString(config.itemsToReset, currentReset)

                        npcGen:say("To reset sucessfuly you need have completed "..config.minTasks.." normal tasks (monsters) and bring me "..stringItems..", do it and come back.", 
                        "Para resetar com sucesso você precisa ter completado "..config.minTasks.." normal tasks (monsters) e me trazer "..stringItems..", faça isso e volte aqui.")
                    end 
                end
            else
                npcGen:say("Ok, I think...", "Ok então...")
                npcGen:setStage(1)
            end

        elseif stage == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerStorageValue(cid, "canStartResetQuest") == -1 and getPlayerStorageValue(cid, "hasCompletedResetQuest") == 1 then
                    if doPlayerRemoveItem(cid, config.elementSpirit, 1) then
                        doCreatureSetStorage(cid, "hasCompletedResetQuest", -1)
                        doCreatureSetStorage(cid, "inWaitToReset", os.time()+(config.hourToReset*60*60))

                        npcGen:say("Ohhhhh god its real! You are stronger than I think! I will prepare your reset, come back in "..config.hourToReset.." hours.",
                                   "Ohhhhhh é real! Você é muito mais forte do que eu pensava! Vou preparar o seu reset, volte em "..config.hourToReset.." horas.")
                        npcGen:forceBye()
                    else
                        npcGen:say("You don't stay with Elemental Stone.", "Você não está com a Elemental Stone.")
                    end
                else
                    npcGen:say("Something wrong happens.", "Algo estranho aconteceu.")
                end
            else
                npcGen:say("Ok, I think...", "Ok então...")
                npcGen:setStage(1)   
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