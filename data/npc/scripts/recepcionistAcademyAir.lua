local npcGen = newNpc("NpcRecepconistFire")
local storageRegister = 8934

npcGen:setHiMsg("Hello %s, Welcome to trainer room of Air Academy, I can help you with REGISTERs.", "Olá %s, seja bem vindo a sala de treinamento da Air Academy, eu posso lhe ajudar com os REGISTROs?")
npcGen:addOptionInNpc("job", {"I'm the receptionist at this academy, my job is to be very polite to all customers.", "Eu sou a recepcionista dessa academia, meu trabalho é ser muito educada com todos os clientes."})
npcGen:addOptionInNpc("help", {"I have a loooot of work, but I don't need help, ty.", "Eu tenho muuuuito trabalho a fazer, porém não posso aceitar ajuda, muito obrigada."})
npcGen:needPremium(true)

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            if msgcontains(msg, "register") or msgcontains(msg, "registro") then
                if getPlayerStorageValue(cid, storageRegister) == -1 then
                    npcGen:say("Huum, you are a new here, to enter in the Academy, you need only a once payment, so you can enter in academy when you want, it's costs 5.000 gold coins, you want to join?", "Huum, você é novo por aqui? Para entrar na academia você precisa fazer um pagamento único, então você poderá entrar aqui quando quiser, esse pagamento custa 5.000 gold coins, você deseja se inscrever?")
                    npcGen:setStage(2)
                else
                    npcGen:say("Let's me see... You was already registered in academy, enter and enjoy!", "Deixe-me ver... Você já é membro da academia, entre e aproveite!")
                end
            end

        elseif stage == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerStorageValue(cid, storageRegister) == -1 then
                    if doPlayerRemoveMoney(cid, 5000) then
                        npcGen:say("CONGRATULATIONS! Now you are a member of Air Academy, enjoy it.", "Parábens! Você é o mais novo membro de nossa academia, entre e aproveite!")
                        setPlayerStorageValue(cid, storageRegister, 1)
                    else
                        npcGen:say("Sorry sir, you don't have money for it, please come back when you have the money.", "Desculpe, mas você não tem o dinheiro necessário para isso, porfavor volte quando tiver.")
                    end
                else
                    npcGen:say("Sorry sir but you was already registered in academy, enter and enjoy!", "Desculpe, mas você já é membro de nossa academia, entre e aproveite!")
                end
            else
                npcGen:say("Ok, I think...", "Ok então...") 
            end
            npcGen:setStage(1)
        end
        return true
    end)
end

function onThink()
    npcGen:onThink(false)
end

function onCreatureDisappear(cid, pos)
    npcGen:onDisappear(cid, pos)
end