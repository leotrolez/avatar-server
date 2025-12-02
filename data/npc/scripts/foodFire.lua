local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 3
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



function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	return true
end

function onGreet(cid) 
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid).."! How can i help you? Do you want to see my {offers}?", "Olá "..getCreatureName(cid).."! Você deseja ver minhas {ofertas}?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- nome, preco, id, '' vazio

shopModule:addBuyableItem('fish', 7, 2667, '') -- food fire
shopModule:addBuyableItem('ham', 6, 2671, '') -- food fire
shopModule:addBuyableItem('meat', 3, 2666, '') -- food fire
shopModule:addBuyableItem('salmon', 19, 2668, '') -- food fire
shopModule:addBuyableItem('red apple', 2, 2674, '') -- food fire
shopModule:addBuyableItem('banana', 3, 2676, '') -- food fire
shopModule:addBuyableItem('pear', 4, 2673, '') -- food fire