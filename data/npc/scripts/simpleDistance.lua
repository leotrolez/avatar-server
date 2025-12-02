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
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid).."! How can i help you? Do you want to see my {offers}?", "Olá "..getCreatureName(cid).."! Eu fico aqui o dia todo vendendo armas para quem não sabe usar, haha. Enfim, diga-me o que deseja. Talvez {comprar} alguma arma?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- nome, preco, id, '' vazio



shopModule:addBuyableItem('crossbow', 210, 2455, '') -- distance
shopModule:addBuyableItem('bow', 130, 2456, '') -- distance
shopModule:addBuyableItem('royal spear', 70, 7378, '') -- distance
shopModule:addBuyableItem('enchanted spear', 140, 7367, '') -- distance
shopModule:addBuyableItem('spear', 20, 2389, '') -- distance

shopModule:addBuyableItem('assassin star', 400, 7368, '') -- distance
shopModule:addBuyableItem('throwing star', 70, 2399, '') -- distance
shopModule:addBuyableItem('throwing knife', 20, 2410, '') -- distance
shopModule:addBuyableItem('viper star', 200, 7366, '') -- distance
shopModule:addBuyableItem('poison arrow', 10, 2545, '') -- distance
shopModule:addBuyableItem('burst arrow', 10, 2546, '') -- distance
shopModule:addBuyableItem('sniper arrow', 80, 7364, '') -- distance
shopModule:addBuyableItem('onyx arrow', 170, 7365, '') -- distance
shopModule:addBuyableItem('piercing bolt', 15, 7363, '') -- distance
shopModule:addBuyableItem('power bolt', 35, 2547, '') -- distance
shopModule:addBuyableItem('infernal bolt', 400, 6529, '') -- distance
shopModule:addBuyableItem('arrow', 3, 2544, '') -- distance
shopModule:addBuyableItem('bolt', 4, 2543, '') -- distance


