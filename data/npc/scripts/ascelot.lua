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
	if getPlayerLevel(cid) < 230 or getPlayerResets(cid) < 110 then
		selfSay(getLangString(cid, "You need Level 230+ and Paragon 110+ to help me.", "Você precisa de Level 230+ e Paragon 110+ para me ajudar."), cid)
		return true
	end
	if getPlayerStorageValue(cid, "demonAccess") == 2 then
		setPlayerStorageValue(cid, "demonAccess", 3)
		setPlayerStorageValue(cid, "90518", 1)
		selfSay(getLangString(cid, "Did you kill him?! Good job, you're the strongest bender that i have ever seen! Please, accept this reward.", "Você o matou?! Bom trabalho, você é o dobrador mais forte que já vi! Por favor, aceite esta minha recompensa."), cid)
		doPlayerAddMoney(cid, 300000)
		doPlayerAddItem(cid, 17980, 1)
		local finalExp = getExperienceForLevel(221) - getExperienceForLevel(220)
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você completou a The Source of Power Quest. Como recompensa, você recebeu "..finalExp.." pontos de experiência, 1x Power Source Ring e 300000 gold coins.")
		return true
	elseif getPlayerStorageValue(cid, "demonAccess") == 1 then
		selfSay(getLangString(cid, "What are you waiting for? You need to defeat the demon quickly!", "O que você está esperando?! Você precisa derrotar o demônio imediatamente!"), cid)
		return true
	end
        if talkState[talkUser] == 1 then
            if msgcontains(msg, "access") or msgcontains(msg, "acesso") or msgcontains(msg, "mission") or msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerStorageValue(cid, "90518") >= 1 then
                    selfSay(getLangString(cid, "Sorry, you already did your job.", "Desculpe, você já fez sua parte."), cid)
                    talkState[talkUser] = 1         
                else
                    selfSay(getLangString(cid, "I'm trying to make an access for a long time, but no succeed. I believe that we can stop those monsters if we kill the source of power, the boss. Maybe i need some sacrifices to make it work.. Bringe to me {35x demon prey} and i'll try to make the access. Can you get it for me?", "Estou há muito tempo tentando criar um acesso por este portal. Eu acredito que podemos parar estes monstros se matarmos a fonte do poder, seu líder. Talvez eu precise de alguns sacrifícios para fazê-lo funcionar.. Poderia me trazer {35x demon prey}?"), cid)
                    talkState[talkUser] = 2
                end
            end
        elseif talkState[talkUser] == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "prey") then
                if doPlayerRemoveItem(cid, 12447, 35) then
                    selfSay(getLangString(cid, "Thank you, now you probably can access the portal to defeat him, but you should go with more benders. Good luck!", "Obrigado, agora você deve conseguir acessar o portal para derrotá-lo, mas eu não aconselharia a ir sozinho. Boa sorte!"), cid)
                    setPlayerStorageValue(cid, "demonAccess", 1)
					doSendMagicEffect(getCreaturePosition(cid), 14)
                    talkState[talkUser] = 2
                else
                    selfSay(getLangString(cid, "Get the demon preys and come back immediately!", "Junte as demon preys e volte imediatamente!"), cid)
                    talkState[talkUser] = 2
                end
            end
        end
        return true
end

function onGreet(cid) 
    talkState[cid] = 1  
	selfSay(getLangString(cid, "Hello, "..getCreatureName(cid)..". I'm busy trying to make an {access} to the portal.", "Olá, "..getCreatureName(cid)..". Eu estou ocupado tentando criar um {acesso} ao portal."), cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
