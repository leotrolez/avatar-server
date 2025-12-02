local npcGen = newNpc("jamboTaskItens")

npcGen:setHiMsg("I study hydras and hydramats, I'm totaly fascined for these creatures, do you want HELP me?", "Eu estudo hydras, especificamente hydramats, sou totalmente fascinado por essas criaturas, deseja me AJUDAR?")

npcGen:addOptionInNpc("job", {"My job is the cience.", "Meu emprego é a ciência."})
npcGen:setTaskItens("Jambo", "Ohhhhhh, thanks! Now I can continue my studys.", "Ohhhhh, muito obrigado, agora vou poder continuar meus estudos.")


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