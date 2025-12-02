--------- FUNCTIONS ------------
local function onAddAtributo(cid, atributo, quantia)
	if atributo == "health" then                     
		setCreatureMaxHealth(cid, getCreatureMaxHealth(cid, true)+(50*quantia))
        doCreatureAddHealth(cid, 1)
	elseif atributo == "bend" then 
        doPlayerAddMagicLevel(cid, quantia)
	elseif atributo == "dodge" then 
		local oldDodge = getPlayerStorageValue(cid, "AttributesPointsInDodge")
		if oldDodge < 1 then 
			oldDodge = 0
		end 
		setPlayerStorageValue(cid, "AttributesPointsInDodge", oldDodge+quantia)
		doChangeSpeed(cid, 6*quantia)
	elseif atributo == "speed" then 
		--doChangeSpeed(cid, 2*quantia)
	end 

end
local function getAgility(cid)
return getPlayerStorageValue(cid, "AttributesPointsInDodge")
end 
local function getVitality(cid)
return getPlayerStorageValue(cid, "healthvalue")
end 
local function getManality(cid)
return getPlayerStorageValue(cid, "speedvalue")
end 
function resetAtributos(cid)
	if not isCreature(cid) then return false end
	if getAgility(cid) > 0 then 
		doChangeSpeed(cid, -(6*(getAgility(cid))))
	end
	if getVitality(cid) > 1 then 
		local novaHealth = getCreatureMaxHealth(cid, true)-(50*(getVitality(cid)))
		local myHealth = getCreatureHealth(cid)
		if myHealth > novaHealth then 
			doCreatureAddHealth(cid, -(myHealth - novaHealth))
		elseif myHealth > 4 then
			doCreatureAddHealth(cid, -1) 
		else 
			doCreatureAddHealth(cid, 1) 
		end 
		setCreatureMaxHealth(cid, novaHealth)
	end 
	if getManality(cid) > 1 then 
		local novaMana = getCreatureMaxMana(cid, true)-(20*(getManality(cid)))
		local myMana = getCreatureMana(cid)
		if myMana > novaMana then 
			doCreatureAddMana(cid, -(myMana - novaMana))
		elseif myMana > 4 then
			doCreatureAddMana(cid, -1) 
		else 
			doCreatureAddMana(cid, 1) 
		end 
		setCreatureMaxMana(cid, novaMana)
	end 
	local atributosList = {"speed", "health", "bend", "dodge"}
	for i = 1, #atributosList do 
		local storageAtributo = atributosList[i] .. "value"
		setPlayerStorageValue(cid, storageAtributo, 0)
	end 
		setPlayerStorageValue(cid, "AttributesPointsInDodge", 0)
		local lastLevel = getPlayerStorageValue(cid, 188100)
		lastLevel = lastLevel > 0 and lastLevel or 1
		setPlayerStorageValue(cid, "AttributesPoints", lastLevel+4+getParagonExtraPoints(cid))
		--doSendPlayerExtendedOpcode(cid, 40, getAtributosString(cid))
		--exhaustion.set(cid, "lastReset", (60*60)*24)
		--doSendMagicEffect(getCreaturePosition(cid), 29)
		--doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Seus atributos foram resetados.")
		doPlayerResetMagicLevel(cid)
return true
end 

--------------------------------------------------------
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
	if not isInPz(cid) and (isPlayerPzLocked(cid) or getCreatureCondition(cid, CONDITION_INFIGHT)) then
		selfSay(getLangString(cid, 'Não posso falar com você agora.', 'Não posso falar com você agora.'), cid)
		return false
	end
	if getPlayerStorageValue(cid, "ativoBot") == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa responder ao Anti-Bot primeiro.")
		return false
	end
    if talkState[talkUser] == 1 then            
        if msgcontains(msg, "reset") or msgcontains(msg, "resetar") or msgcontains(msg, "yes") or msgcontains(msg, "sim") then
			local price = getPlayerLevel(cid) * 5000
			selfSay(getLangString(cid, "All your attributes (health, bend level, mana and dodge) will reset and you will receive the points wasted back. This will cost you "..price.." gold coins. Do you want to pay?", "Todos os seus atributos (health, bend level, mana e dodge) irão zerar e você receberá os pontos gastos de volta. Isso irá te custar "..price.." gold coins. Deseja pagar?"), cid)
            talkState[talkUser] = 2
		else 
			selfSay(getLangString(cid, "I don't understand you. Do you want to reset your attributes?", "Eu não te entendi. Você deseja resetar seus atributos?"), cid)
        end
    elseif talkState[talkUser] == 2 then
		if msgcontains(msg, "gold") or msgcontains(msg, "gold coins") or msgcontains(msg, "moedas") or msgcontains(msg, "ouro") or msgcontains(msg, "sim") or msgcontains(msg, "yes") then
			local price = getPlayerLevel(cid) * 5000
			if doPlayerRemoveMoney(cid, price) then 	
				selfSay(getLangString(cid, "Your attributes have been reset and your points wasted returned. Enjoy!", "Seus atributos foram resetados e seus pontos gastos devolvidos. Aproveite!"), cid)
				doSendMagicEffect(getCreaturePosition(cid), 29)
				talkState[talkUser] = 1
				addEvent(resetAtributos, 1500, cid)
			else
				selfSay(getLangString(cid, "You don't have "..price.." gold coins, sorry.", "Você não possui "..price.." gold coins, desculpe."), cid)
			end
		else 
			local price = getPlayerLevel(cid) * 5000
			selfSay(getLangString(cid, "I don't understand you. Do you want to reset your attributes for "..price.." gold coins?", "Eu não te entendi. Você deseja resetar seus atributos por "..price.." gold coins?"), cid)
        end
    end
	return true
end


function onGreet(cid) 
	talkState[cid] = 1 	
	selfSay(getLangString(cid, "Hello, "..getCreatureName(cid)..". I can {reset} your stats.", "Olá, "..getCreatureName(cid)..". Eu posso {resetar} seus atributos."), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
