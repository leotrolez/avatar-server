local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 4
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end
function onPlayerEndTrade(cid)              npcHandler:onPlayerEndTrade(cid)            end
function onPlayerCloseChannel(cid)          npcHandler:onPlayerCloseChannel(cid)        end

npcHandler:setMessage(MESSAGE_GREET, "")

local items = {
    [2177] = 5
}

local function checkItems(cid)
    for i,v in pairs (items) do
        if not (getPlayerItemCount(cid, i) >= v) then
            return false
        end
    end
    return true
end

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
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "entrar") or msgcontains(msg, "join") then
                if getPlayerStorageValue(cid, Huahua) < 1 then
                    selfSay(getLangString(cid, "You need to talk to the old man Clerical Jorge before coming to me.", "Você precisa falar com o ancião Clerical Jorge, antes de vir até mim."), cid)
                    talkState[talkUser] = 1         
                elseif getPlayerStorageValue(cid, Ahu) >= 2 then
                    selfSay(getLangString(cid, "You are already free to go.", "Você já está liberado para passar."), cid)
                    talkState[talkUser] = 1
                elseif getPlayerLevel(cid) >= 120 then
                    selfSay(getLangString(cid, "Ok, I see you're already listed, however, I need you to help me with one more thing. Are you willing?", "Ok, vejo que você já está alistado, no entanto, preciso que você me ajude com mais uma coisa. Você está disposto?"), cid)
                    talkState[talkUser] = 2
                else
                    selfSay(getLangString(cid, "You are not strong enough to help me.", "Você não é forte o suficiente para me ajudar."), cid)
                    talkState[talkUser] = 1
                end
            end
        elseif talkState[talkUser] == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                it = "Preciso que me traga 5 life crystal"
                it = it .. ". Você já coletou todos?"
                selfSay(getLangString(cid, "I need you to bring me 5 life crystal. You've collected all?", it), cid)
                talkState[talkUser] = 3         
            end
            
        elseif talkState[talkUser] == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if checkItems(cid) then
                    for i,v in pairs(items) do
                        doPlayerRemoveItem(cid, i, v)
                    end
                    selfSay(getLangString(cid, "Thanks for your help, you're free to go. Be careful!", "Obrigado por sua ajuda, você já está liberado para passar. Tenha cuidado!"), cid)
                    setPlayerStorageValue(cid, Ahu, 2)
                    talkState[talkUser] = 1
                else
                    selfSay(getLangString(cid, "You did not collect anything yet.", "Você não coletou tudo ainda."), cid)
                    talkState[talkUser] = 1
                end
            end
        end
        return true
end

function onGreet(cid) 
    talkState[cid] = 1  
	selfSay(getLangString(cid, "Hello, "..getCreatureName(cid)..". Would you like to {join} the Profaned Quest?", "Olá, "..getCreatureName(cid)..". Você deseja {entrar} na Profaned Quest?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
