local npcGen = newNpc("NpcRecepconistBaSingSee")
local storageRegister = 8932

npcGen:setHiMsg("Hello %s, Welcome to Central Academy, I can help you with REGISTERs.", "Olá %s, seja bem vindo a academia central, eu posso lhe ajudar com os REGISTROs?")
npcGen:addOptionInNpc("job", {"I'm the receptionist at this academy, my job is to be very polite to all customers.", "Eu sou a recepcionista dessa academia, meu trabalho é ser muito educada com todos os clientes."})
npcGen:addOptionInNpc("help", {"I have a loooot of work, but I don't need help, ty.", "Eu tenho muuuuito trabalho a fazer, porém não posso aceitar ajuda, muito obrigada."})

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
                        npcGen:say("CONGRATULATIONS! Now you are a member of academy, enjoy it.", "Parábens! Você é o mais novo membro de nossa academia, entre e aproveite!")
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

local tablePlayers = {}

local function getSexPronuciation(cid, lang)
    local strings = nil
    if lang == EN then
        strings = {"Mrs.", "Mr."}
    else
        strings = {"Sra.", "Sr."}
    end
    return strings[getPlayerSex(cid)+1]
end


function onThink()
    npcGen:onThink(function(cid)
        if cid == nil then
            local players = getSpectators({x=477,y=344,z=8}, 2, 3)
        
            if #players > 0 then
                local currentTime = os.time()
                for x = 1, #players do
                    if isPlayer(players[x]) then
                        if tablePlayers[players[x]] ~= nil then
                            if tablePlayers[players[x]] > currentTime then
                                return false
                            end
                        end
                        local currentName, lang = getCreatureName(players[x]), getLang(players[x])

                        if not msgcontains(currentName, "GM") then
                            npcGen:say("Welcome to academy "..getSexPronuciation(players[x]).." "..currentName.."!", "Seja bem-vindo á academia "..getSexPronuciation(players[x], lang).." "..currentName.."!", lang)
                            doCreatureSetLookDirection(getNpcId(), NORTH)
                            tablePlayers[players[x]] = currentTime+600
                        end
                    end
                end
            end 
        end
    end)
end

function onCreatureDisappear(cid, pos)
    npcGen:onDisappear(cid, pos)
end