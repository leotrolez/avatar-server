local npcGen = newNpc("aluisioTaskItens")

npcGen:setHiMsg("Hello %s I need HELP to do a study with spiders.", "Olá %s eu preciso de AJUDA para estudar uma espécie de aranha.")

npcGen:addOptionInNpc("job", {"I'm a studian from Ba Sing Se and I'm fascinated by spiders.", "Eu sou um estudioso de Ba Sing Se e sou fascinado por aranhas."})
npcGen:setTaskItens("Aluisio", "Thank you! Now I will can finish my studies!", "Obrigado! Agora vou poder terminar meus estudos sobre aranhas.")


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