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
npcHandler:setMessage(MESSAGE_WALKAWAY, "")

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
        if talkState[talkUser] == 1 then
    		if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "viajar") or msgcontains(msg, "travel") then
				if getPlayerStorageValue(cid, "tutorialback") ~= 1 then
					selfSay(getLangString(cid, "You didn't spoke with the master Tenzin yet. Follow the north path, you'll find him.", "Você ainda não falou com o mestre Tenzin. Siga ao norte para encontrá-lo."), cid)
					talkState[talkUser] = 1         
				else
					selfSay(getLangString(cid, "I see that you are already fit to {travel}. It will be a long trip, are you ready?", "Vejo que você já está apto para {viajar}. Será uma viagem longa, está preparado?"), cid)
					talkState[talkUser] = 2
            	end
			end
		elseif talkState[talkUser] == 2 then
    		if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "viajar") or msgcontains(msg, "travel") then
				selfSay(getLangString(cid, "Alright then, get ready, we are leaving!", "Certo então, se segure, estamos saindo!"), cid)
				doTeleportThing(cid, {x = 529, y = 683, z = 7})
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
				--sendInitialItens(cid)
				doPlayerSetTown(cid, 3)
				setPlayerStorageValue(cid, "finishedTutorial", 1)
			end
		end
        return true
end

function onGreet(cid) 
	if getPlayerStorageValue(cid, "tutorialback") ~= 1 then
		selfSay(getLangString(cid, "You didn't spoke with the master Tenzin yet. Follow the north path, you'll find him.", "Você ainda não falou com o mestre Tenzin. Siga ao norte para encontrá-lo."), cid)
		talkState[cid] = 1         
	else
		selfSay(getLangString(cid, "I see that you are already fit to {travel}. It will be a long trip, are you ready?", "Vejo que você já está apto para {viajar}. Será uma viagem longa, está preparado?"), cid)
		talkState[cid] = 2
    end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())