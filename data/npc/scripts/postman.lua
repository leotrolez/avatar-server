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
	selfSay(getLangString(cid, "Hello, "..getCreatureName(cid).."! Do you want to see my {offers}?", "Olá, "..getCreatureName(cid).."! Você deseja ver minhas {ofertas}? Lembre-se: na hora de escrever o label da parcel, a escrita correta das cidades disponíveis é: {Ba Sing Se}, {South Air Temple}, {North Water Tribe}, {Fire Nation Capital} e {South Water Tribe}."), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- nome, preco, id, '' vazio



shopModule:addBuyableItem('dice', 150, 5792, '') -- postman
shopModule:addBuyableItem('label', 45, 2599, '') -- postman
shopModule:addBuyableItem('parcel', 55, 2595, '') -- postman
shopModule:addBuyableItem('letter', 45, 2597, '') -- postman