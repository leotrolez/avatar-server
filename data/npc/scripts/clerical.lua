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

local items = {
    [6500] = 25,
	[11322] = 3,
	[11334] = 5,
	[12409] = 20,
	[11325] = 2
}

local function checkItems(cid)
	for i,v in pairs (items) do
		if not (getPlayerItemCount(cid, i) >= v) then
			return false
		end
	end
	return true
end

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
        if talkState[talkUser] == 1 then
            if msgcontains(msg, "help") or msgcontains(msg, "ajuda") then
				if getPlayerStorageValue(cid, Huahua) >= 1 then
					selfSay(getLangString(cid, "You've helped me enough.", "Você já me ajudou o suficiente."), cid)
					talkState[talkUser] = 1         
				elseif ((getPlayerLevel(cid) >= 120) and (getPlayerResets(cid) >= 50)) then
					selfSay(getLangString(cid, "Would you like to help me?", "Você gostaria de me ajudar?"), cid)
					talkState[talkUser] = 2
				else
					selfSay(getLangString(cid, "You need Level 120+ and Paragon 50+ to help me.", "Você precisa de Level 120+ e Paragon 50+ para me ajudar."), cid)
					talkState[talkUser] = 1
				end
			end
		elseif talkState[talkUser] == 2 then
			if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
				it = "A igreja confiou a enorme e responsável tarefa de combater a heresia e a magia negra à profanação. Se você desejar se alistar, como membro, é seu dever lutar contra o mal e sempre se manter em alerta, pois a maldade pode se apresentar nos mais diversos disfarces. Caso queira se alistar, eu preciso que você colete algumas coisas para mim: 25 demonic essence, 3 metal bracelets, 5 legionnaire's flags, 20 broken elmo e 2 spiked iron balls"
				it = it .. ". Você já coletou tudo?"
				selfSay(getLangString(cid, "The church entrusted the huge and responsible task of combating heresy and black magic to the profaned. If you wish to enroll as a member, it is your duty to fight against evil and always keep on alert because evil can appear in the most diverse disguises. If you want to enlist, I need you to gather some things for me: 25 demonic essence, 3 metal bracelets, 5 legionnaire's flags, 20 broken elmo e 2 spiked iron balls. You have collected all?", it), cid)
				talkState[talkUser] = 3			
			end
			
		elseif talkState[talkUser] == 3 then
			if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
				if checkItems(cid) then
					for i,v in pairs(items) do
						doPlayerRemoveItem(cid, i, v)
					end
					selfSay(getLangString(cid, "Thanks for helping me, you're listed! Go to the Tunico guard, he needs the help of warriors like you.", "Obrigado por me ajudar, você está alistado! Vá até o protetor Tunico, ele precisa da ajuda de guerreiros como você."), cid)
					setPlayerStorageValue(cid, Huahua, 1)
					talkState[talkUser] = 1
				else
					selfSay(getLangString(cid, "You did not collect anything yet.", "Você não coletou tudo ainda."), cid)
					talkState[talkUser] = 1
				end
			end
		end
        return true
end

function onGreet(cid) 
	talkState[cid] = 1 	
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", this new plague has affected us! At this moment i'm a little busy blessing this poor corpse, but i'm accepting any kind of {help}!", "Olá "..getCreatureName(cid)..", essa nova praga tem nos afetado bastante! No momento estou um pouco ocupado abençoando esse pobre cadáver, mas estou disposto a aceitar qualquer tipo de {ajuda}."), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
