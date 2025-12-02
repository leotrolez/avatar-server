-- pode adicionar quantos quiser na lista
-- chance é chance em porcentagem, no caso 1 = 1%
-- ele vai tentando a chance seguindo a ordem de cada presente, se nenhuma porcentagem passar no teste, ele entregará um presente random da lista.
-- aconselho colocar os itens com menores chance primeiro, para que ele percorra mais a lista antes de conseguir passar no teste de chance em algum
-- preenchi com alguns exemplos 
local presentes = {
{2123, 1, 1}, -- southern ring
{12830, 1, 1}, -- supreme bless potion
{12754, 1, 2}, -- potion xp
{12872, 1, 2}, -- boomerang
{11259, 4, 3}, -- ec
{2798, 3, 10}, -- blood herb
{5461, 1, 10}, -- helmet of the deep
{12934, 1, 10}, -- strange boh
{2160, 5, 20}, -- money
{2195, 1, 30}, --boh
{2177, 1, 40} -- life crystal
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



function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end    
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
	if not talkState[talkUser] or talkState[talkUser] <= 0 then
		talkState[talkUser] = 1 
	end
    local msg = msg:lower()
	if getPlayerLevel(cid) < 80 then
		if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "presente") or msgcontains(msg, "present") or msgcontains(msg, "presents") or msgcontains(msg, "presentes") then
			selfSay(getLangString(cid, 'You still do not deserve an Christmas gift! Come back when you reach level 80.', 'Você ainda não merece um presente de natal! Volte quando atingir o nível 80.'), cid)
			return true
		else 
			selfSay(getLangString(cid, 'Do you want a {present}?', 'Você quer um {presente}?'), cid) 
			return true
		end
	elseif getPlayerStorageValue(cid, "natal2018") == 1 then 
		if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "presente") or msgcontains(msg, "present") or msgcontains(msg, "presents") or msgcontains(msg, "presentes") then
			selfSay(getLangString(cid, 'You have already received your Christmas gift this year. Come back next Christmas!', 'Você já recebeu seu presente de natal este ano. Volte no próximo natal!'), cid)
			return true
		else 
			selfSay(getLangString(cid, 'Do you want a {present}?', 'Você quer um {presente}?'), cid) 
			return true
		end
	end
	if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "presente") or msgcontains(msg, "present") or msgcontains(msg, "presents") or msgcontains(msg, "presentes") then
		if getPlayerStorageValue(cid, "natal2018") ~= 1 and getPlayerLevel(cid) >= 80 then 
			local sorteado, quantia = 0, 0
			for i = 1, #presentes do 
				if math.random(1, 300) <= presentes[i][3] then 
					sorteado = presentes[i][1]
					quantia = presentes[i][2]
					break
				elseif i == #presentes then 
					local random = math.random(1, #presentes)
					sorteado = presentes[random][1]
					quantia = presentes[random][2]
				end 
			end 
			doPlayerAddItem(cid, sorteado, quantia)
			setPlayerStorageValue(cid, "natal2018", 1)
			selfSay(getLangString(cid, 'I have '..quantia..' '..getItemNameById(sorteado)..' for you. Merry Christmas!', 'Eu tenho '..quantia..' '..getItemNameById(sorteado)..' para você. Feliz natal!'), cid)
		end
	else 
		selfSay(getLangString(cid, 'Do you want a {present}?', 'Você quer um {presente}?'), cid) 
    end
	return true
end

function onGreet(cid) 
	talkState[cid] = 1 	
	selfSay(getLangString(cid, "HOW HOW HOW! Merry Christmas, "..getCreatureName(cid)..". I brought {presents} for the good people!", "HOW HOW HOW! Feliz natal, "..getCreatureName(cid)..". Eu trouxe {presentes} para as boas pessoas!"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
