-- se for mudar essa tabela, precisa copiar a atualizacao tambem na que esta em tasksKill lua creaturescripts
-- pois la tb pega p fazer checagem de qual mob eh e qnts precisa matar na parte atual do evento
local pascoaMissions = 
{
	[1] = {monsterName = "Crystal Spider", count = 25},
	[2] = {monsterName = "Frost Giantess", count = 30},
	[3] = {monsterName = "Draken Elite", count = 40},
	[4] = {monsterName = "Crystal Golem", count = 80},
	[5] = {monsterName = "Water Outlaw", count = 100},
	[6] = {monsterName = "Dark Fury", count = 120},
	[7] = {monsterName = "Dread Intruder", count = 140},
}

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

local stonesNameByVoc = {"Fire Stone", "Water Stone", "Air Stone", "Earth Stone"}
local theStoneIds = {12686, 12688, 12689, 12687}

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
	if getPlayerLevel(cid) < 80 then
		selfSay(getLangString(cid, "Sorry, you need at least level 80 to start this mission.", "Desculpe, mas você precisa de pelo menos nível 80 para iniciar as minhas missões."), cid)
		return true
	end
	if getPlayerStorageValue(cid, "pascoa2018") == 1 then
		selfSay(getLangString(cid, "Sorry, but you already received your present!", "Desculpe, mas você já recebeu o seu presente!"), cid)
		return true
	end
	local atual = getPlayerStorageValue(cid, "easter2018State")
	if atual < 0 then
		atual = 0
	end
    if getPlayerStorageValue(cid, "inPascoaTask") == 1 and atual > 0 and pascoaMissions[atual] then
		if getPlayerStorageValue(cid, "easter2018Kills") >= pascoaMissions[atual].count then
			if not pascoaMissions[atual+1] then
				setPlayerStorageValue(cid, "inPascoaTask", 0)
				setPlayerStorageValue(cid, "pascoa2018", 1)
				local vocId = getPlayerVocation(cid)
				doPlayerAddItem(cid, theStoneIds[vocId], 2)
				local delayExp = getPlayerStorageValue(cid, "delayPotionExp")
				if delayExp > os.time() then -- ja tem pot exp, vamos adicionar
					setPlayerStorageValue(cid, "hasInPotionExp", delayExp+7*24*60*60)
					setPlayerStorageValue(cid, "delayPotionExp", delayExp+7*24*60*60)
				else
					setPlayerStorageValue(cid, "hasInPotionExp", os.time()+7*24*60*60)
					setPlayerStorageValue(cid, "delayPotionExp", os.time()+7*24*60*60)
				end
				doPlayerAddItem(cid, 18057, 1)
				local finalExp = 2000000
				doPlayerAddExperience(cid, finalExp)
				selfSay(getLangString(cid, "Awesome, you finished all the missions! Here is my present for you: 2x "..stonesNameByVoc[vocId]..", 1x Gift Scroll, "..finalExp.." XP and 20% extra experience for 7 days. Merry Christmas, HOW HOW HOW!", "Incrível, você completou todas as missões! Aqui está meu presente para você: 2x "..stonesNameByVoc[vocId]..", 1x Gift Scroll, "..finalExp.." de XP e 20% de experiência extra durante 7 dias. Feliz Natal, HOW HOW HOW!"), cid)
			else			
				setPlayerStorageValue(cid, "inPascoaTask", 0)
				selfSay(getLangString(cid, "Great! Are you ready for your "..(atual+1).."º mission?", "Ótimo! Pronto para a sua "..(atual+1).."ª missão?"), cid)
			end
		else
			selfSay(getLangString(cid, "You did not kill all the {"..pascoaMissions[atual].count.." "..pascoaMissions[atual].monsterName.."} yet! Come back only when you finish it.", "Você não matou {"..pascoaMissions[atual].count.." "..pascoaMissions[atual].monsterName.."} ainda! Volte aqui somente quando acabar."), cid)		
		end
		return true
	end
    if not msgcontains(msg, "yes") and not msgcontains(msg, "sim") and not msgcontains(msg, "present") and not msgcontains(msg, "presents") and not msgcontains(msg, "presente") and not msgcontains(msg, "presentes") then
		selfSay(getLangString(cid, "I dont get it. Do you want or not a {present}?", "Não entendi. Você quer ou não um {presente}?"), cid)		
		return true
	end
	if not pascoaMissions[atual+1] then -- nao deveria chegar aqui
		print("Alguem chegou em parte que nao devia no npc easter")
		return true
	end
	atual = atual+1
	if atual >= 7 and getPlayerLevel(cid) < 125 then
		selfSay(getLangString(cid, "Sorry, you need at least level 125 to start the last mission.", "Desculpe, mas você precisa de pelo menos nível 125 para iniciar a última missão."), cid)
		return true
	end
	setPlayerStorageValue(cid, "inPascoaTask", 1)
	setPlayerStorageValue(cid, "easter2018State", atual)
	setPlayerStorageValue(cid, "easter2018Kills", 0)
	if atual == 1 then
		selfSay(getLangString(cid, "You thought that this would be easy? HOW HOW HOW! To receive the present, you need to complete some missions for me first.", "Achou que seria fácil? HOW HOW HOW! Para conseguir seus presentes, você deve completar algumas missões primeiro."), cid)		
		selfSay(getLangString(cid, "In your first mission, you have to kill {"..pascoaMissions[atual].count.." "..pascoaMissions[atual].monsterName.."}. Come back when you finish it.", "Sua primeira missão é matar {"..pascoaMissions[atual].count.." "..pascoaMissions[atual].monsterName.."}, volte aqui quando acabar."), cid)		
	else		
		selfSay(getLangString(cid, "In your "..atual.."º mission, you have to kill {"..pascoaMissions[atual].count.." "..pascoaMissions[atual].monsterName.."}. Come back when you finish it.", "Na sua "..atual.."ª missão, você precisa matar {"..pascoaMissions[atual].count.." "..pascoaMissions[atual].monsterName.."}. Volte aqui quando acabar."), cid)		
	end
	

    return true
end

function onGreet(cid) 
	talkState[cid] = 1 	
	if getPlayerLevel(cid) < 80 then
		selfSay(getLangString(cid, "Sorry, you need at least level 80 to start this mission.", "Desculpe, mas você precisa de pelo menos nível 80 para iniciar as minhas missões."), cid)
		return true
	end
	if getPlayerStorageValue(cid, "pascoa2018") ~= 1 then
		if getPlayerStorageValue(cid, "inPascoaTask") == 1 or getPlayerStorageValue(cid, "easter2018State") >= 1 then
			selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", did you finish your mission?", "Olá "..getCreatureName(cid)..", você já terminou a sua missão?"), cid)
		else
			selfSay(getLangString(cid, "HOW HOW HOW! Merry Christmas, "..getCreatureName(cid).."! I brought a {present} for you!", "HOW HOW HOW! Feliz Natal, "..getCreatureName(cid).."! Eu trouxe alguns {presentes} para você!"), cid)
		end
	else
		selfSay(getLangString(cid, "Sorry, but you already received your present!", "Desculpe, mas você já recebeu o seu presente!"), cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
