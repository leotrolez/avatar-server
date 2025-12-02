local npcGen = newNpc("explorerTaskItens")

npcGen:setHiMsg("%s, I've been this cave for years and suddenly, some strange monsters started to appear in the mine. Could you HELP me to know more for these monsters?", 
"%s, eu estive nesta caverna durante anos e, de repente, alguns monstros estranhos começaram a aparecer na mina. Você poderia me AJUDAR á saber mais sobre eles?")

npcGen:addOptionInNpc("job", {"I'm a explorer from mines in all the world.", "Eu sou um explorador de minas conhecido em todo o mundo."})
npcGen:setTaskItens("Explorer", "Thank you! Now I will can finish my excavations!", "Obrigado! Agora vou poder terminar minhas escavações.")


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