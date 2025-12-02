local npcGen = newNpc("npcSpiritWorld")

npcGen:setHiMsg("Hello %s, I am the link between the SPIRIT WORLD and the human world...", "Olá %s, Eu sou a ligação entre o MUNDO ESPIRITUAL e o mundo dos humanos...")
npcGen:addOptionInNpc("job", {"I am the link between the SPIRIT WORLD and the human world...", "Eu sou a ligação entre o MUNDO ESPIRITUAL e o mundo dos humanos..."})
npcGen:addOptionInNpc("help", {"Help me? I think it would be easier for me to help you. Want to know the mysteries of the SPIRITUAL WORLD?", "Me ajudar? Acho que seria mais fácil eu te ajudar. Deseja conhecer os mistérios do MUNDO ESPIRITUAL?"})
npcGen:addOptionInNpc("quest", {"I'm not sure your location, but I know that is inside a house in the forest.", "Não sei muito bem sua localização, mas sei que é dentro de uma casa no meio da floresta."})


function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            if msgcontains(msg, "spirit world") or msgcontains(msg, "mundo espiritual") or msgcontains(msg, "iniciar") or msgcontains(msg, "entrar") then
                if getPlayerStorageValue(cid, "wayToSpiritOn") ~= 1 then
                    if getPlayerStorageValue(cid, "hasCompletedResetQuest") ~= 1 then
                        npcGen:say("Interesting ... so you can enter the world of spirits should make a QUEST and back to me. Accept?", "Interessante... para você poder entrar no mundo dos espíritos deve fazer uma QUEST e depois voltar aqui. Aceita?")
                        npcGen:setStage(2)
                    else
                        npcGen:say("You can now enter the world of spirits! Find a portal and be careful!", "Você já pode entrar no mundo dos espíritos! Encontre um portal e tome cuidado!")
                    end
                else
                    npcGen:say("You've finish?", "Você já terminou?")
                    npcGen:setStage(3)
                end
            end
        elseif stage == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "quest") then
                if getPlayerStorageValue(cid, "wayToSpiritOn") ~= 1 then
                    npcGen:say("Okay ... when you get back to talk to me.", "Muito bem... quando você conseguir volte a falar comigo.")
                    doCreatureSetStorage(cid, "wayToSpiritOn", 1)
                    doCreatureSetStorage(cid, "canStartResetQuest", 1)
                else
                    npcGen:say("You've brought what I asked?", "Você já trouxe o que eu pedi?")
                    npcGen:setStage(3)
                end
            end
        elseif stage == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerStorageValue(cid, "hasDoQuest") == 1 then
                    doCreatureSetStorage(cid, "hasCompletedResetQuest", 1)
                    doCreatureSetStorage(cid, "wayToSpiritOn", -1)
                    npcGen:say("Congratulations noble warrior, you can now access the spiritual world, find a portal and be careful!", "Parabéns nobre guerreiro, agora você pode acessar o mundo espiritual, encontre um portal e tome cuidado!")
                    npcGen:setStage(1)
                else
                    npcGen:say("Liar! Come back only when you have finished.", "Mentiroso! Volte somente quando tiver feito.")
                    npcGen:setStage(1)
                end
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