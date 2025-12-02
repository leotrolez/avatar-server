local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 5
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'apprentice health potion'}, 8704, 2, 1, 'apprentice health potion')
shopModule:addBuyableItem({'health potion'}, 7618, 5, 1, 'health potion')
shopModule:addBuyableItem({'strong health potion'}, 7588, 15, 1, 'strong health potion')
shopModule:addBuyableItem({'great health potion'}, 7591, 35, 1, 'great health potion')
shopModule:addBuyableItem({'ultimate health potion'}, 8473, 80, 1, 'ultimate health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 5, 1, 'mana potion')
shopModule:addBuyableItem({'strong mana potion'}, 7589, 15, 1, 'strong mana potion')
shopModule:addBuyableItem({'great mana potion'}, 7590, 30, 1, 'great mana potion')
shopModule:addBuyableItem({'brown mushroom'}, 2789, 1, 1, 'brown mushroom')
shopModule:addBuyableItem({'magic wall rune'}, 2293, 20, 1, 'magic wall rune')
shopModule:addBuyableItem({'wild growth rune'}, 2269, 20, 1, 'wild growth rune')
shopModule:addBuyableItem({'sudden death rune'}, 2268, 60, 1, 'sudden death rune')
shopModule:addBuyableItem({'ultimate healing rune'}, 2273, 60, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'speed potion'}, 8474, 40, 1, 'speed potion')


local items = {[1] = 2190, [2] = 2182, [5] = 2190, [6] = 2182}
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if(msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand')) then
		if(isSorcerer(cid) or isDruid(cid)) then
			if(getPlayerStorageValue(cid, 30002) <= 0) then
				selfSay('So you ask me for a {' .. getItemNameById(items[getPlayerVocation(cid)]) .. '} to begin your advanture?', cid)
				talkState[talkUser] = 1
			else
				selfSay('What? I have already gave you one {' .. getItemNameById(items[getPlayerVocation(cid)]) .. '}!', cid)
			end
		else
			selfSay('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif(msgcontains(msg, 'yes')) then
		if(talkState[talkUser] == 1) then
			doPlayerAddItem(cid, items[getPlayerVocation(cid)], 1)
			selfSay('Here you are young adept, take care yourself.', cid)
			setPlayerStorageValue(cid, 30002, 1)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and isInArray({1}, talkState[talkUser])) then
		selfSay('Ok then.', cid)
		talkState[talkUser] = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
