local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 4
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local runeNames = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end
npcHandler:setMessage(MESSAGE_GREET, "")

local runesString = "{Air Rune II}, {Air Rune III}, {Earth Rune II}, {Earth Rune III}, {Fire Rune II}, {Fire Rune III}, {Water Rune II}, {Water Rune III}"
local runesTable = {"air rune ii", "air rune iii", "earth rune ii", "earth rune iii", "fire rune ii", "fire rune iii", "water rune ii", "water rune iii"}
local runeToReq = 
{
	["air rune ii"] = {itemId = 18101, count = 60, reward = 18106},
	["air rune iii"] = {itemId = 18106, count = 40, reward = 18111},
	["earth rune ii"] = {itemId = 18102, count = 60, reward = 18107},
	["earth rune iii"] = {itemId = 18107, count = 40, reward = 18112},
	["fire rune ii"] = {itemId = 18099, count = 60, reward = 18104},
	["fire rune iii"] = {itemId = 18104, count = 40, reward = 18109},
	["water rune ii"] = {itemId = 18100, count = 60, reward = 18105},
	["water rune iii"] = {itemId = 18105, count = 40, reward = 18110},
}

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end    
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
	msg = string.lower(msg)
	if not talkState[talkUser] or talkState[talkUser] <= 0 then
		talkState[talkUser] = 1 
	end
	
	if getPlayerLevel(cid) < 80 then
		selfSay(getLangString(cid, "You are not strong enough to trade with me. Come back when you reach level 80.", "Você não é forte o suficiente para negociar comigo. Volte quando atingir o nível 80."), cid)
		return false
	end

        if talkState[talkUser] == 1 then
            if msgcontains(msg, "rune") or msgcontains(msg, "runa") or msgcontains(msg, "runas") or msgcontains(msg, "runes") or msgcontains(msg, "yes") or msgcontains(msg, "upgrade") or msgcontains(msg, "canalizar") or msgcontains(msg, "craft") or msgcontains(msg, "sim") then
				selfSay(getLangString(cid, "Wich rune do you want to craft? "..runesString.."?", "Qual runa deseja criar? "..runesString.."?"), cid)
				talkState[talkUser] = 2
			else 
				selfSay(getLangString(cid, "I don't get it. Do you want to upgrade your {runes}?", "Não entendi. Você quer canalizar as suas {runas}?"), cid)
				talkState[talkUser] = 1
				return false
			end
        elseif talkState[talkUser] == 2 then
			if isInArray(runesTable, msg) then
				runeNames[talkUser] = msg
                selfSay(getLangString(cid, "To this creation i need "..runeToReq[msg].count.."x "..getItemNameById(runeToReq[msg].itemId)..", do you confirm?", "Para criar ela eu preciso de "..runeToReq[msg].count.."x "..getItemNameById(runeToReq[msg].itemId)..", você quer mesmo fazer isto?"), cid)
				talkState[talkUser] = 3
            else
                selfSay(getLangString(cid, "I don't get it. Tell me the exactly rune name: "..runesString.."?", "Não entendi. Me fale o nome da runa corretamente: "..runesString.."?"), cid)
				talkState[talkUser] = 2
            end
		elseif talkState[talkUser] == 3 then 
			if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
				local itemMission = runeNames[talkUser]
				if not itemMission or not runeToReq[itemMission] then 
					selfSay(getLangString(cid, "I didn't find the rune that you want. Choose another!", "Não encontrei a runa que você quer. Escolha outra!"), cid)
					talkState[talkUser] = 2
					return false 
				end 
				if doPlayerRemoveItem(cid, runeToReq[itemMission].itemId, runeToReq[itemMission].count) then 
					doPlayerAddItem(cid, runeToReq[itemMission].reward, 1)
					selfSay(getLangString(cid, "Here you are!", "Muito bem, aqui está!"), cid)
					talkState[talkUser] = 2
					return false
				else
					selfSay(getLangString(cid, "You don't have all the runes that i need. Come back when you have all!", "Você não me trouxe todas as runas que preciso. Volte quando tiver todas!"), cid)
					talkState[talkUser] = 2
					return false
				end 
			elseif msgcontains(msg, "no") or msgcontains(msg, "nao") or msgcontains(msg, "não") then
					selfSay(getLangString(cid, "Wich rune do you want to craft? "..runesString.."?", "Qual runa deseja criar? "..runesString.."?"), cid)
					talkState[talkUser] = 2
					return false 
			else 
					selfSay(getLangString(cid, "What? {Yes} or {no}?", "Não entendi. {Sim} ou {não}?"), cid)
            end
	   end
        return true
end


function onGreet(cid)
	if getPlayerLevel(cid) < 80 then
		selfSay(getLangString(cid, "You are not strong enough to trade with me. Come back when you reach level 80.", "Você não é forte o suficiente para negociar comigo. Volte quando atingir o nível 80."), cid)
		return true
	end
	talkState[cid] = 1
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", i can upgrade the elements in a superior {rune}.", "Olá "..getCreatureName(cid)..", eu posso canalizar os elementos em uma {runa} superior."), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
