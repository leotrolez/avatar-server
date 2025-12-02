local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 4
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end
function onPlayerEndTrade(cid)              npcHandler:onPlayerEndTrade(cid)            end
function onPlayerCloseChannel(cid)          npcHandler:onPlayerCloseChannel(cid)        end

npcHandler:setMessage(MESSAGE_GREET, "")

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local msg = msg:lower() 
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
    msg = string.lower(msg)
    if not talkState[talkUser] or talkState[talkUser] <= 0 then
        talkState[talkUser] = 1 
    end
	if getPlayerLevel(cid) < 170 or getPlayerResets(cid) < 80 then
		selfSay(getLangString(cid, "You need Level 170+ and Paragon 80+ to help me.", "Você precisa de Level 170+ e Paragon 80+ para me ajudar."), cid)
		return true
	end
	if getPlayerStorageValue(cid, "outlawAccess") == 2 then
		setPlayerStorageValue(cid, "outlawAccess", 3)
		setPlayerStorageValue(cid, "90513", 1)
		selfSay(getLangString(cid, "Oh, you made it! Speaking truly, i was thinking that you died. Thanks to you, i can continue my research in peace. Here, accept this reward as my thanks!", "Oh, você conseguiu! Sinceramente, não achava que voltaria vivo. Graças a você, poderei continuar minha pesquisa em paz. Receba esta recompensa como minha gratidão!"), cid)
		doPlayerAddMoney(cid, 200000)
		doPlayerAddItem(cid, 2123, 1)
		local finalExp = getExperienceForLevel(181) - getExperienceForLevel(180)
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você completou a Outlaw's Secret Weapon Quest. Como recompensa, você recebeu "..finalExp.." pontos de experiência, 1x Southern Ring e 200000 gold coins.")
		return true
	elseif getPlayerStorageValue(cid, "outlawAccess") == 1 then
		selfSay(getLangString(cid, "What are you waiting for? You need to defeat this beast quickly!", "O que você está esperando?! Você precisa derrotar esta besta imediatamente!"), cid)
		return true
	end
        if talkState[talkUser] == 1 then
            if msgcontains(msg, "secret weapon") or msgcontains(msg, "arma secreta") or msgcontains(msg, "mission") or msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerStorageValue(cid, "90513") >= 1 then
                    selfSay(getLangString(cid, "Sorry, you already did your job.", "Desculpe, você já fez sua parte."), cid)
                    talkState[talkUser] = 1         
                else
                    selfSay(getLangString(cid, "The outlaws are making a MONSTER! We need to stop them quickly. Unfortunately, your access has been protected by a strong magic, and i need {40 midnight shards} to make a counter-magic on you. Can you get it for me?", "Os exilados estão criando um MONSTRO! Precisamos urgentemente detê-los. Infelizmente, seu acesso está restrito por uma forte magia, preciso que me traga {40 midnight shards} e eu poderei te fazer um encanto para quebrá-la. Você pode pegar para mim?"), cid)
                    talkState[talkUser] = 2
                end
            end
        elseif talkState[talkUser] == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "shards") then
                if doPlayerRemoveItem(cid, 10531, 40) then
                    selfSay(getLangString(cid, "Thank you, this should work! Now, go to the gate and defeat the beast. Be careful!", "Obrigado, isso deve funcionar! Agora, vá para o portão e derrote a besta. Seja cuidadoso!"), cid)
                    setPlayerStorageValue(cid, "outlawAccess", 1)
					doSendMagicEffect(getCreaturePosition(cid), 14)
                    talkState[talkUser] = 2
                else
                    selfSay(getLangString(cid, "Get the midnight shards and come back immediately!", "Junte as midnight shards e volte imediatamente!"), cid)
                    talkState[talkUser] = 2
                end
            end
        end
        return true
end

function onGreet(cid) 
    talkState[cid] = 1  
	selfSay(getLangString(cid, "Hello, "..getCreatureName(cid)..". We don't have much time! Sooner or later they will release the {secret weapon}.", "Olá, "..getCreatureName(cid)..". Nós não temos muito tempo! Mais cedo ou mais tarde eles irão liberar a sua {arma secreta}."), cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
