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
					selfSay(getLangString(cid, "You didn't spoke with fire lord Izumi yet. Follow the path, you'll find her. Be quick, we don't have much time, the lava is closing our way out!", "Você ainda não falou com a senhora do fogo Izumi. Siga o caminho para encontrá-la. Seja rápido, não temos muito tempo, a lava já está fechando a nossa saída!"), cid)
					talkState[talkUser] = 1         
				else
					selfSay(getLangString(cid, "I see that you are already fit to {travel}. It will be a long trip, are you ready?", "Vejo que você já está apto para {viajar}. Será uma viagem longa, está preparado?"), cid)
					talkState[talkUser] = 2
            	end
			end
		elseif talkState[talkUser] == 2 then
    		if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "viajar") or msgcontains(msg, "travel") then
				selfSay(getLangString(cid, "Alright then, get ready, we are leaving!", "Certo então, se segure, estamos saindo!"), cid)
				doTeleportThing(cid, {x = 226, y = 441, z = 7})
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
				--sendInitialItens(cid)
				doPlayerSetTown(cid, 5)
				setPlayerStorageValue(cid, "finishedTutorial", 1)
			end
		end
        return true
end

function onGreet(cid) 
	if getPlayerStorageValue(cid, "tutorialback") ~= 1 then
		selfSay(getLangString(cid, "You didn't spoke with fire lord Izumi yet. Follow the path, you'll find her. Be quick, we don't have much time, the lava is closing our way out!", "Você ainda não falou com a senhora do fogo Izumi. Siga o caminho para encontrá-la. Seja rápido, não temos muito tempo, a lava já está fechando a nossa saída!"), cid)
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