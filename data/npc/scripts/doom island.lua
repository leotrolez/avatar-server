
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 4
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end
npcHandler:setMessage(MESSAGE_GREET, "")
npcHandler:setMessage(MESSAGE_WALKAWAY, "")

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end    
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
	if not talkState[talkUser] or talkState[talkUser] <= 0 then
		talkState[talkUser] = 1 
	end
    local msg = msg:lower()
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "viagem") or msgcontains(msg, "interested") then
		if getPlayerLevel(cid) < 175 or getPlayerResets(cid) < 80 then
			selfSay(getLangString(cid, "You need Level 175+ and Paragon 80+ to start this quest.", "Você precisa de Level 175+ e Paragon 80+ para iniciar esta missão."), cid)
		elseif doPlayerRemoveMoney(cid, 50000) then
			selfSay(getLangString(cid, "Thank you. Get ready, this will be a dangerous trip!", "Obrigado. Se segure, será uma viagem perigosa!"), cid)
			doTeleportThing(cid, {x = 1120, y = 691, z = 7})
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
		else
			selfSay(getLangString(cid, "Sorry, i can't make it for free. You don't have enough gold.", "Desculpe, eu não posso fazer isso de graça. Você não tem ouro suficiente."), cid)
		end
	end
    return true
end

function onGreet(cid) 
	talkState[cid] = 1
	selfSay(getLangString(cid, "You should not be here. This place is dangerous.. Unless you're the chosen one, of course! In this case, i can help you to get into the Doom Island and finish your mission. But, i can't risk my life for free.. I can make it for 50.000 gold coins, are you {interested}?", "Você não deveria estar aqui, este lugar é muito perigoso. A menos que você seja o dobrador escolhido, é claro! Neste caso eu posso te ajudar a chegar na Doom Island e continuar sua missão. Mas claro, eu não irei arriscar minha vida de graça. Posso fazer esta {viagem} por 50.000 gold coins, você aceita?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
