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
	if isPlayerPzLocked(cid) then
		return true
	end
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
	msg = string.lower(msg)
	if not talkState[talkUser] or talkState[talkUser] <= 0 then
		talkState[talkUser] = 1 
	end
        if talkState[talkUser] == 1 then
            if msgcontains(msg, "routes") or msgcontains(msg, "rotas") or msgcontains(msg, "travel") then
                selfSay(getLangString(cid, "I can take you to: {Ba Sing Se}, {Fire Nation Capital} or {North Water Tribe} for 50 gold coins.", "Eu posso levar você para: {Ba Sing Se}, {Fire Nation Capital} ou {North Water Tribe} por 50 gold coins."), cid)
			elseif msgcontains(msg, "sing") then
				if doPlayerRemoveMoney(cid, 50) then
					selfSay(getLangString(cid, "We are leaving!", "Estamos saindo!"), cid)
					doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=573,y=352,z=6})
					doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
				else
					selfSay(getLangString(cid, "You dont have 50 gold coins.", "Você não tem 50 gold coins."), cid)
				end
			elseif msgcontains(msg, "north") then
				if doPlayerRemoveMoney(cid, 50) then
					selfSay(getLangString(cid, "We are leaving!", "Estamos saindo!"), cid)
					doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=348,y=253,z=6})
					doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
				else
					selfSay(getLangString(cid, "You dont have 50 gold coins.", "Você não tem 50 gold coins."), cid)
				end
			elseif msgcontains(msg, "fire") then
				if doPlayerRemoveMoney(cid, 50) then
					selfSay(getLangString(cid, "We are leaving!", "Estamos saindo!"), cid)
					doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
					doTeleportThing(cid, {x=286,y=455,z=6})
					doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
				else
					selfSay(getLangString(cid, "You dont have 50 gold coins.", "Você não tem 50 gold coins."), cid)
				end
            end
        end
   return true
end

function onGreet(cid) 
	talkState[cid] = 1 	
    selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", do you want to {travel}?", "Olá "..getCreatureName(cid).."! Eu posso lhe transportar para vários lugares, deseja ver minhas {rotas}?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
