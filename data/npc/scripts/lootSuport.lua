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



function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	return true
end
function onGreet(cid) 
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid).."! How can i help you? Do you want to see my {offers}?", "Olá "..getCreatureName(cid).."! O que lhe traz até minha loja de especiarias? Veja minhas {ofertas}, você ficará surpreso!"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- nome, preco, id, '' vazio


shopModule:addBuyableItem('rope', 25, 2120, '') -- loot suport
shopModule:addBuyableItem('shovel', 10, 2554, '') -- loot suport
shopModule:addBuyableItem('pick', 120, 2553, '') -- loot suport
shopModule:addBuyableItem('backpack', 20, 1988, '') -- loot suport
shopModule:addBuyableItem('fishing rod', 150, 2580, '') -- loot suport
shopModule:addBuyableItem('bag', 8, 1987, '') -- loot suport
shopModule:addBuyableItem('worm', 3, 3976, '') -- loot suport
shopModule:addBuyableItem('water pouch', 400, 4863, '') -- loot suport