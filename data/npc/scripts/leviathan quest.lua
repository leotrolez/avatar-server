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

local function hasEndNeededTasks(cid)
local tasks = {122, 130, 134}
for i = 1, #tasks do
	if not getPlayerHasEndTask(cid, tasks[i]) then
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
            if msgcontains(msg, "pass") or msgcontains(msg, "passar") then
                if getPlayerStorageValue(cid, "evilAvatarQuest") >= 1 then
                    selfSay(getLangString(cid, "You've already proved your strength.", "Você já provou a sua força."), cid)
                    talkState[talkUser] = 1         
                else
                    selfSay(getLangString(cid, "Would you wanna prove your strength?", "Você deseja provar sua força?"), cid)
                    talkState[talkUser] = 2
                end
            end
        elseif talkState[talkUser] == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                it = "Eu preciso que você derrote certos monstros que estão destruindo o nosso mundo. Preciso que você complete as tasks {Kollos Easy}, {Leviathan Easy} e {Elder Wyrm Easy}."
                it = it .. " Você já os derrotou?"
                selfSay(getLangString(cid, "I need you to defeat certain monsters that are destroying our world. I need you to complete the tasks {Kollos Easy}, {Leviathan Easy} and {Elder Wyrm Easy}. Did you defeat them?", it), cid)
                talkState[talkUser] = 3         
            end
            
        elseif talkState[talkUser] == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if hasEndNeededTasks(cid) then
                    selfSay(getLangString(cid, "Well, that's enough to prove that you are worthy. Follow your destiny, bender.", "Bem, isto é suficiente para provar que você é digno. Siga o seu destino, dobrador."), cid)
                    setPlayerStorageValue(cid, "evilAvatarQuest", 1)
                    talkState[talkUser] = 1
                else
                    selfSay(getLangString(cid, "You did not finished your test.", "Você não terminou seu teste."), cid)
                    talkState[talkUser] = 1
                end
            end
        end
        return true
end

function onGreet(cid) 
    talkState[cid] = 1  
	selfSay(getLangString(cid, "Hello, "..getCreatureName(cid)..". I'm surprised that you came here. This show your courage, but that's not enough to {pass}.", "Olá, "..getCreatureName(cid)..". Estou surpreso de ter chegado até aqui. Isto mostra sua coragem, mas somente coragem não é necessário para {passar}."), cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
