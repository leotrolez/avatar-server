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

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
shopModule:addBuyableItem('helmet of the deep', 20000, 5461, '')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	return true
end

function onGreet(cid) 
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", welcome to my water shop! I'm selling a special helmet that helps to survive underwater. Are you interested to see my {offer}?", "Olá "..getCreatureName(cid)..". Seja bem-vindo à minha loja aquática! Eu estou vendendo um helmet especial que lhe dá oxigênio enquanto você estiver mergulhando, você está interessado em {comprar}?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
