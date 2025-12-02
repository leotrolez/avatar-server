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
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid).."! How can i help you? Do you want to see my {offers}?", "Olá "..getCreatureName(cid).."! Você deseja ver minhas {ofertas}?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- nome, preco, id, '' vazio

shopModule:addBuyableItem('wooden chair', 500, 3901, '') -- furniture
shopModule:addBuyableItem('sofa chair', 500, 3902, '') -- furniture
shopModule:addBuyableItem('red cushioned chair', 500, 3903, '') -- furniture
shopModule:addBuyableItem('green cushioned chair', 500, 3904, '') -- furniture
shopModule:addBuyableItem('tusk chair', 500, 3905, '') -- furniture
shopModule:addBuyableItem('ivory chair', 500, 3906, '') -- furniture
shopModule:addBuyableItem('small tree stump', 500, 3907, '') -- furniture
shopModule:addBuyableItem('small table', 500, 3908, '') -- furniture
shopModule:addBuyableItem('big table', 500, 3909, '') -- furniture
shopModule:addBuyableItem('square table', 500, 3910, '') -- furniture
shopModule:addBuyableItem('small round table', 500, 3911, '') -- furniture
shopModule:addBuyableItem('coal basin', 500, 3912, '') -- furniture
shopModule:addBuyableItem('stone table', 500, 3913, '') -- furniture
shopModule:addBuyableItem('tusk table', 500, 3914, '') -- furniture
shopModule:addBuyableItem('pendulum clock', 500, 3917, '') -- furniture
shopModule:addBuyableItem('bamboo table', 500, 3919, '') -- furniture
shopModule:addBuyableItem('tree stump', 500, 3920, '') -- furniture
shopModule:addBuyableItem('harp', 500, 3921, '') -- furniture
shopModule:addBuyableItem('birdcage', 500, 3922, '') -- furniture
shopModule:addBuyableItem('globe', 500, 3923, '') -- furniture
shopModule:addBuyableItem('table lamp', 500, 3924, '') -- furniture
shopModule:addBuyableItem('rocking chair', 500, 3925, '') -- furniture
shopModule:addBuyableItem('piano', 500, 3926, '') -- furniture
shopModule:addBuyableItem('knight statue', 500, 3927, '') -- furniture
shopModule:addBuyableItem('large amphora of water', 500, 3929, '') -- furniture
shopModule:addBuyableItem('globin statue', 500, 3930, '') -- furniture
shopModule:addBuyableItem('indoor plant', 500, 3931, '') -- furniture
shopModule:addBuyableItem('christmas tree', 500, 3933, '') -- furniture
shopModule:addBuyableItem('rocking horse', 500, 3934, '') -- furniture
shopModule:addBuyableItem('telescope', 500, 3935, '') -- furniture
shopModule:addBuyableItem('monkey statue', 500, 5087, 'monkey statue') -- furniture
shopModule:addBuyableItem('oven', 500, 6372, '') -- furniture
shopModule:addBuyableItem('chimney', 500, 8692, '') -- furniture
shopModule:addBuyableItem('small purple pillow', 500, 1678, '') -- furniture
shopModule:addBuyableItem('small green pillow', 500, 1679, '') -- furniture
shopModule:addBuyableItem('small red pillow', 500, 1680, '') -- furniture
shopModule:addBuyableItem('small blue pillow', 500, 1681, '') -- furniture
shopModule:addBuyableItem('small orange pillow', 500, 1682, '') -- furniture
shopModule:addBuyableItem('small turquiose pillow', 500, 1683, '') -- furniture
shopModule:addBuyableItem('small white pillow', 500, 1684, '') -- furniture
shopModule:addBuyableItem('round blue pillow', 500, 1690, '') -- furniture
shopModule:addBuyableItem('round red pillow', 500, 1691, '') -- furniture
shopModule:addBuyableItem('round purple pillow', 500, 1692, '') -- furniture
shopModule:addBuyableItem('round turquiose pillow', 500, 1693, '') -- furniture
shopModule:addBuyableItem('heart pillow', 500, 1685, '') -- furniture
shopModule:addBuyableItem('blue pillow', 500, 1686, '') -- furniture
shopModule:addBuyableItem('red pillow', 500, 1687, '') -- furniture
shopModule:addBuyableItem('green pillow', 500, 1688, '') -- furniture
shopModule:addBuyableItem('yellow pillow', 500, 1689, '') -- furniture