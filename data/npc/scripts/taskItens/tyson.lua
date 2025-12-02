local npcGen = newNpc("tysonTaskItens")

npcGen:setHiMsg("I'm living in this house for years and I can't stand those cyclops anymore, would you HELP me by killing them?", 
"Estou vivendo nesta casa há anos e eu não suporto aqueles cyclops mais, você poderia me AJUDAR a matá-los?")

npcGen:addOptionInNpc("job", {"I don't have job.", "Eu não tenho emprego."})
npcGen:setTaskItens("Tyson", "Thank you! Now I can will sleep in peace.", "Obrigado! Agora vou poder ir dormir em paz.")


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