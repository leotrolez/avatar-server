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
    if getPlayerStorageValue(cid, "tutorialback") ~= 1 then
        if not msgcontains(msg, "yes") and not msgcontains(msg, "sim") and not msgcontains(msg, "interested") and not msgcontains(msg, "interessado") and not msgcontains(msg, "join") and not msgcontains(msg, "juntar") then
			selfSay(getLangString(cid, "Oh, are not you {interested}? Well, if you change your mind, talk to me again.", "Oh, achei que estivesse {interessado}. Bom, se mudar de ideia, fale comigo novamente."), cid)		
			return true
		end
		setPlayerStorageValue(cid, "jadissesim", 1)
		selfSay(getLangString(cid, "Show me what you can do.", "Me mostre o que sabe fazer."), cid) 		
		doPlayerSendTextMessage(cid, 22, getLangString(cid, "Show to Tenzin the bend Air Ball. You can use it by clicking on the bending list, or by saying the word 'Air Ball', that can be automatically sent with a shortcut using the hotkey system (CTRL+K).", "Mostre à Tenzin a dobra Air Ball. Você pode utilizá-la clicando na mesma na janela de dobras, ou enviando a mensagem 'Air Ball', podendo ser configurada como um atalho de envio automático na janela de atalhos (CTRL + K)."))
	else
		selfSay(getLangString(cid, "What are you waiting for?! Go back and talk with Felicia, she'll travel with you to the South Air Temple.", "O que você está esperando?! Volte e fale com a Felicia, ela irá viajar com você para o South Air Temple."), cid)
	end

    return true
end

function ensinarYes(cid)
	if isCreature(cid) and getPlayerStorageValue(cid, "jadissesim") ~= 1 then
		doPlayerSendTextMessage(cid, 22, getLangString(cid, "For simple questions like that, you can just type 'yes' in the NPCs tab.", "Para perguntas simples como esta, você pode responder com apenas um 'sim', na aba de conversa com NPCs no chat."))
	end
end

function onGreet(cid) 
	talkState[cid] = 1 	
	if getPlayerStorageValue(cid, "tutorialback") ~= 1 then
		selfSay(getLangString(cid, "Hello, kid. I see that you have potential to be an air bender! We are a pacific tribe, and, sadly, that leaded us to ruin. Now we are small, but we'll never lose the hope. Would you like to {join} us and help to rebuild our nation?", "Olá, jovem. Vejo que possui potencial para se tornar um dobrador de ar! Somos uma tribo pacífica e, infelizmente, isso nos trouxe à ruína. Hoje somos poucos, mas nunca perderemos a esperança. Gostaria de se {juntar} a nós e reerguer nossa nação?"), cid)
		setPlayerStorageValue(cid, "jadissesim", 0)
		addEvent(ensinarYes, 3000, cid)
	else
		selfSay(getLangString(cid, "What are you waiting for?! Go back and talk with Felicia, she'll travel with you to the South Air Temple.", "O que você está esperando?! Volte e fale com a Felicia, ela irá viajar com você para o South Air Temple."), cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
