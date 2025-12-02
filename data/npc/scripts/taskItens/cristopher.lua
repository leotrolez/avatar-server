local npcGen = newNpc("cristopherTaskItens")

npcGen:setHiMsg("Here is very cold, and witches make this place even worse, please HELP me, kill them and bring me their belongings for proof.", 
"Aqui é muito frio, e as bruxas tornam esse lugar ainda pior, por favor me AJUDE, mate-as e me traga seus pertences como prova.")
npcGen:needPremium(true)

npcGen:addOptionInNpc("job", {"My job is to maintain the harmony of this continent, and at the moment I'm having trouble with witches.", "Meu trabalho é manter a harmonia de todo continente, e nesse momento estou tendo problemas com as bruxas."})
npcGen:setTaskItens("Cristopher", "Thank you! With your help, the continent becomes a better place.", "Obrigado! Com sua ajuda esse continente se torna um lugar melhor.")


function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            npcGen:loadTasksItens(msg)
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