	local npcGen = newNpc("Rob")

npcGen:setHiMsg("Greetings %s, I am the guardian of the Blood Caste, I could HELP you if you want to participate.", "Olá %s, eu sou o guardião do Blood Castle, eu posso te AJUDAR se você desejar participar.")
npcGen:needPremium(false)

function onCreatureSay(cid, type, msg)
if isPlayerPzLocked(cid) then
    npcGen:say('Não posso falar com você agora.', 'Não posso falar com você agora.') 
return false
end
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            if msgcontains(msg, "help") or msgcontains(msg, "ajudar") or msgcontais(msg, "ajuda") then
            	if getPlayerLevel(cid) >= 20 then
					npcGen:say("Long ago, some demons have taken over the castle. Some riders see trying to regain it for centuries, but never succeeded. I charge a fee of (20k) for transport to the castle. You want to try to conquer the castle?", "Há muito tempo atrás, alguns demônios se apossaram do castelo. Alguns cavaleiros vêem tentando reconquistá-lo faz séculos, mas nunca conseguiram. Eu cobro uma taxa de (20k) para o transporte até o castelo. Deseja tentar conquistar o castelo?")
					npcGen:setStage(2)
				else
					npcGen:say("You are not strong enough to help me.", "Você não é forte o suficiente para me ajudar.")
					npcGen:setStage(1)   
				end        
            end
		elseif stage == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
				if doPlayerRemoveMoney(cid, 20000) then
					npcGen:say("Good Luck, my friend.", "Boa sorte, meu amigo.")
					setGlobalStorageValue(bloodconfig.playersStorage, getPlayersInBlood()+1)
					print(getPlayersInBlood().. " Jogadores no Blood Castle") 
					doTeleportThing(cid, bloodconfig.positionEvento)
					doSendMagicEffect(getThingPos(cid), 10)
					npcGen:setStage(1)
				else
					npcGen:say("You don't have enough money.", "Você não tem dinheiro suficiente.")
					npcGen:setStage(1)
				end
			end
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