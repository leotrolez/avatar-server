
local function getPriceBless(cid)
    if getPlayerPremiumDays(cid) > 0 then
        return (((getPlayerLevel(cid)*1750)/2)*0.8)
    else
        return ((getPlayerLevel(cid)*1750)/2)
    end
end

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

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
shopModule:addBuyableItem('Amulet of Loss', 3000, 2173, '')
shopModule:addBuyableItem('Rune Remover I', 50000, 18114, '')

function creatureSayCallback(cid, type, msg)    
    if(not npcHandler:isFocused(cid)) then
        return false
    end    
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
    if not talkState[talkUser] or talkState[talkUser] <= 0 then
        talkState[talkUser] = 1 
    end
    local msg = msg:lower()

        if talkState[talkUser] == 1 then
            if msgcontains(msg, "bless") or msgcontains(msg, "blessed") or msgcontains(msg, "abençoado") then
                selfSay(getLangString(cid, "With this blessing you will lose 50% less experience when you die (and will not lose any item, unless you're red skulled). The price is {"..getPriceBless(cid).."} gold coins, are you interested?", "Ao adquirir isso você perderá 50% menos expêriencia ao morrer (e nenhum item, a menos que esteja com red skull). O preço é {"..getPriceBless(cid).."} gold coins, você está interresado?"), cid)
                talkState[talkUser] = 2
            end
        elseif talkState[talkUser] == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if getPlayerLevel(cid) >= 50 then
                    if getPlayerStorageValue(cid, "playerWithBless") ~= 1 then
                        if doPlayerRemoveMoney(cid, getPriceBless(cid)) then
                            setPlayerStorageValue(cid, "playerWithBless", 1)
                            setPlayerStorageValue(cid, "blessExpName", "Sony")
                            selfSay(getLangString(cid, "You will be protected until the next death, thank you.", "Agora você está protegido até a proxíma morte, obrigado."), cid)
                            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "You will be protected until the next death, thank you.", "Você recebeu a benção de Sony."))
                        else
                            selfSay(getLangString(cid, "You dont have money for this, I'm sorry.", "Você não tem dinheiro para isso, desculpe."), cid)
                        end
                    else
                        selfSay(getLangString(cid, "Sorry, you are already blessed.", "Desculpe, você já está abençoado."), cid)
                    end
                else
                    selfSay(getLangString(cid, "Sorry, only level 50 or higher players can get blessings.", "Desculpe, apenas jogadores level 50 ou mais podem adquirir blessings."), cid)
                end
            else
                selfSay(getLangString(cid, "Ok, I think.", "Ok então."), cid) 
            end
            talkState[talkUser] = 1
       end
        return true
end

function onGreet(cid) 
    talkState[cid] = 1      
    selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", do you want to be {blessed} by me or to {trade} with me?", "Olá "..getCreatureName(cid)..", deseja receber uma {bless} por mim ou {comprar} algo comigo?"), cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
