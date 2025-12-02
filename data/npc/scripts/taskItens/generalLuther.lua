local npcGen = newNpc("generalLutherTaskItens")

npcGen:setHiMsg("Our Army is running out of equipaments! Could you HELP our kingdon?", 
"Nosso exército está precisando de novos equipamentos! Você poderia AJUDAR o nosso reino?")

npcGen:addOptionInNpc("job", {"My job is to manage all the army of this great city.", "O meu trabalho é gerenciar todos o exercito dessa grande cidade."})
npcGen:setTaskItens("generalLuther", "Thank you! Now our army is well equipped.", "Obrigado! Agora nosso exercito está bem equipado.")


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