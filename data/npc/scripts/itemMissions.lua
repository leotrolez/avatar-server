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

function getRequiredItems(tabela) -- retorna uma string com os necessários exemplo "5x dragon tail e 300 gold coins"
if not tabela or not tabela.itens then return "" end 
	local string = ""
	for i = 1, #tabela.itens do 
		string = string .. tabela.itens[i][2] .. "x " .. getItemNameById(tabela.itens[i][1])
		local opaStr = string .. ", "
		string = i ~= #tabela.itens and opaStr or string
	end 
	if tabela.goldReq and tabela.goldReq ~= 0 then 
		string = string .. " e " .. tabela.goldReq .. " gold coins"
	end 
	return string
end 

function getMissionItemString(cid) -- retorna mensagem completa informando quais tem disponíveis, caso não tenha retorna falso
	local tabela = itemTaskInfo
	local missions = ""
	local count = 0
	for k, v in pairs(itemTaskInfo) do  
		local task = v
		if canDoMission(cid, task) then 
			if count == 0 then 
				missions = getLangString(cid, "The following missions are available for you: ", "As seguintes missões estão disponíveis para você: ")
				missions = missions .. "{" .. k .. "}"
				count = 1
			else 
				missions = missions .. ", {" .. k .. "}"
			end 
		end 
	end
	if count == 0 then 
		return false 
	end 
	if missions then 
		missions = missions .. ". "
		missions = missions .. getLangString(cid, "Choose one.", "Qual deseja executar?")
	end 
return missions 
end 

function haveAllItems(cid, tabela) -- checa se tem todos os itens da tabela e remove
	if not tabela or not tabela.itens then return false end 
	for i = 1, #tabela.itens do
		if getPlayerItemCount(cid, tabela.itens[i][1]) < tabela.itens[i][2] then 
			return false 
		end 
	end 
	if tabela.goldReq and tabela.goldReq ~= 0 then 
		if getPlayerMoney(cid) < tabela.goldReq then 
			return false 
		end 
	end 
	for i = 1, #tabela.itens do
		doPlayerRemoveItem(cid, tabela.itens[i][1], tabela.itens[i][2])
	end 
	if tabela.goldReq and tabela.goldReq ~= 0 then 
		doPlayerRemoveMoney(cid, tabela.goldReq)
	end 
	return true
end 

function rewardPlayer(cid, tabela) -- finaliza a missao dando os itens exp storage etc
	if tabela.storageId ~= 0 then 
		setPlayerStorageValue(cid, tabela.storageId .. "ItemTask", 1)
	end
	local premios = ""
	if tabela.itensReward then 
		for i = 1, #tabela.itensReward do 
			doPlayerAddItem(cid, tabela.itensReward[i][1], tabela.itensReward[i][2])
			if i == 1 then 
				premios = "Você recebeu: "
				premios = premios .. tabela.itensReward[i][2] .. "x " .. getItemNameById(tabela.itensReward[i][1])
			elseif i == #tabela.itensReward then
				premios = premios .. ", " .. tabela.itensReward[i][2] .. "x " .. getItemNameById(tabela.itensReward[i][1])
			else 
				premios = premios .. ", " .. tabela.itensReward[i][2] .. "x " .. getItemNameById(tabela.itensReward[i][1])
			end 
		end 
	end
	local finalExp = 0
	if tabela.exp and tabela.exp[1] ~= 0 then 
		finalExp = getExperienceForLevel(tabela.exp[2]) - getExperienceForLevel(tabela.exp[2]-1)
		finalExp = finalExp * (tabela.exp[1]/100)
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
		if tabela.itensReward then 
			premios = premios .. ", " .. finalExp .. " pontos de experiência"
		else 
			premios = "Você recebeu: " .. finalExp .. " pontos de experiência"
		end
	end 
	if tabela.goldReward and tabela.goldReward ~= 0 then 
		doPlayerAddMoney(cid, tabela.goldReward)
		if tabela.itensReward or (tabela.exp and tabela.exp[1] ~= 0) then 
			premios = premios .. " e " .. tabela.goldReward .. " gold coins"
		else 
			premios = "Você recebeu: " .. tabela.goldReward .. " gold coins"
		end
	end 

	if tabela.givestorage and tabela.givestorage ~= 0 then 
		setPlayerStorageValue(cid, tabela.givestorage, 1)
	end 
	if tabela.effect and tabela.effect ~= 0 then 
		doSendMagicEffect(getCreaturePosition(cid), tabela.effect)
	end 
	premios = premios .. "."
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, premios)
end

function getMsgByMission(tabela) -- Mensagem informando os itens necessários e perguntando se tem
	local strbr = "On this mission you need to bring to me: " .. getRequiredItems(tabela) .. ". Do you have all of this?"
	local stren = "Nesta missão você precisa me trazer: " .. getRequiredItems(tabela) .. ". Você possui todos estes itens?"
return getLangString(cid, stren, strbr)
end 

function canDoMission(cid, tabela)
	if tabela.level and getPlayerLevel(cid) < tabela.level then 
		return false 
	end 
	if getPlayerStorageValue(cid, tabela.storageId .. "ItemTask") == 1 then 
		return false 
	end 
	if tabela.storage and tabela.storage ~= 0 and getPlayerStorageValue(cid, tabela.storage) ~= 1 then 
		return false 
	end 
	if tabela.dailyTasks and getPlayerDailysCompleted(cid) < tabela.dailyTasks then 
		return false
	end 
	if tabela.normalTasks and getTasksCompleted(cid) < tabela.normalTasks then 
		return false 
	end 
	return true 
end 

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end    
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
	msg = string.lower(msg)
	if not talkState[talkUser] or talkState[talkUser] <= 0 then
		talkState[talkUser] = 1 
	end

        if talkState[talkUser] == 1 then
            if msgcontains(msg, "mission") or msgcontains(msg, "missão") or msgcontains(msg, "missões") or msgcontains(msg, "missoes") or msgcontains(msg, "missao") then
				local missions = getMissionItemString(cid)
				if missions then
					local misStr = getMissionItemString(cid)
					selfSay(getLangString(cid, misStr, misStr), cid)
					talkState[talkUser] = 2
				else 
					selfSay(getLangString(cid, "I don't have missions for you right now or you're not strong enough to do then.", "Eu não tenho missões para você no momento ou você não é forte o suficiente para me ajudar com as mesmas."), cid)
					talkState[talkUser] = 1
					return false
				end 
			end
        elseif talkState[talkUser] == 2 then
			local itemMission = itemTaskInfo[msg]
			if itemMission then
				if canDoMission(cid, itemMission) then
					local msgByMis = getMsgByMission(itemMission)
					selfSay(getLangString(cid, msgByMis, msgByMis), cid)
					talkState[talkUser] = 3
					setPlayerStorageValue(cid, "itemMission", msg)
				else 
					selfSay(getLangString(cid, "You can't do this mission.", "Você somente pode fazer as missões que foram listadas."), cid)
				end 	
            else
                selfSay(getLangString(cid, "I don't get it. Tell me the exactly mission name.", "Não entendi. Fale o nome da missão corretamente."), cid)
				talkState[talkUser] = 2
            end
		elseif talkState[talkUser] == 3 then 
			if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
				local itemMission = itemTaskInfo[getPlayerStorageValue(cid, "itemMission")]
				if not itemMission then 
					talkState[talkUser] = 1
					return false 
				end 
				if haveAllItems(cid, itemMission) then 
					rewardPlayer(cid, itemMission)
					selfSay(getLangString(cid, "Here you are. Thank you!", "Obrigado! Aqui está a sua recompensa."), cid)
					talkState[talkUser] = 1
					return false
				else 					
				--	local itemsString = getRequiredItems(itemMission)
					selfSay(getLangString(cid, "You don't have all the items that i need. Come back when you have all!", "Você não me trouxe todos os itens que preciso. Volte quando terminar de coletar!"), cid)
					talkState[talkUser] = 1
					return false
				end 
			elseif msgcontains(msg, "no") or msgcontains(msg, "nao") or msgcontains(msg, "não") then
					talkState[talkUser] = 1
					return false 
			else 
					selfSay(getLangString(cid, "What? Yes or no?", "Não entendi. Sim ou não?"), cid)
            end
           -- talkState[talkUser] = 1
	   end
        return true
end


function onGreet(cid) 
	talkState[cid] = 1 	
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", i have important {missions} for you.", "Olá "..getCreatureName(cid)..", eu tenho {missões} importantes para você."), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
