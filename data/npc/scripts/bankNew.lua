local maxGoldToWork = 1000000000

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 3
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)        npcHandler:onCreatureAppear(cid)      end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)     end
function onCreatureSay(cid, type, msg)    npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()              npcHandler:onThink()            end
function onPlayerEndTrade(cid)        npcHandler:onPlayerEndTrade(cid)      end
function onPlayerCloseChannel(cid)      npcHandler:onPlayerCloseChannel(cid)    end
npcHandler:setMessage(MESSAGE_GREET, "")


local function getNumberMsg(number, maxGold)
  number = tonumber(number)
  if type(number) ~= "number" or number > maxGold then
    return maxGold
  end
  return number
end

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
      if msgcontains(msg, "offer") or msgcontains(msg, "offers") or msgcontains(msg, "offering") then
               selfSay(getLangString(cid, "You can check the balance of your bank account, deposit money or withdraw it.", "Você pode checar o balance da sua conta, deposit gold ou withdraw."), cid)
            
            elseif msgcontains(msg, "balance") then
                local balance = getPlayerBalance(cid)
               selfSay(getLangString(cid, "Your account balance is "..balance.." gold coins.", "O seu saldo é de "..balance.." gold coins."), cid)
            
            elseif msgcontains(msg, "deposit all") then
                local count = getPlayerMoney(cid)
        setPlayerStorageValue(cid, "depositCount", count)

                if count > 0 then
                   selfSay(getLangString(cid, "Are you sure you wish to deposit "..count.." gold coins into your account?", "Você tem certeza que deseja depositar "..count.." gold coins em sua conta?"), cid)
                    talkState[talkUser] = 3
                else
                   selfSay(getLangString(cid, "You don't have any money to deposit.", "Você não tem nenhum dinheiro para depositar."), cid)
                end

            elseif msgcontains(msg, "deposit") then
               selfSay(getLangString(cid, "Please tell me how much gold it is you would like to deposit.", "Me diga quantos gold coins você deseja depositar."), cid)
                talkState[talkUser] = 2

            elseif msgcontains(msg, "withdraw all") then
                local balance = getPlayerBalance(cid)
        setPlayerStorageValue(cid, "withdrawCount", balance)

                if balance > 0 then
                   selfSay(getLangString(cid, "Are you sure you wish to withdraw "..balance.." gold from your bank account?", "Você tem certeja que deseja sacar "..balance.." gold coins da sua conta?"), cid)
                    talkState[talkUser] = 5
                else
                   selfSay(getLangString(cid, "You don't have any money to withdraw in your account.", "Você não tem nenhuma quantia disponível em sua conta para sacar."), cid)
                end

            elseif msgcontains(msg, "withdraw") then
               selfSay(getLangString(cid, "Please tell me how much gold you would like to withdraw.", "Me diga quantos gold coins você deseja sacar."), cid)
                talkState[talkUser] = 4
            end


        elseif talkState[talkUser] == 2 then
            local count = getNumberMsg(msg, maxGoldToWork) > 0 and getNumberMsg(msg, maxGoldToWork) or 0
      if count == maxGoldToWork or count < 1 then count = getPlayerMoney(cid) end
      setPlayerStorageValue(cid, "depositCount", count)
           selfSay(getLangString(cid, "Are you sure you wish to deposit "..count.." gold coins into your account?", "Você tem certeza que deseja depositar "..count.." gold coins em sua conta?"), cid)
            talkState[talkUser] = 3

        elseif talkState[talkUser] == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if doPlayerDepositMoney(cid, getPlayerStorageValue(cid, "depositCount")) then
                    local balance = getPlayerBalance(cid)

                   selfSay(getLangString(cid, "Done. The money was deposited, now your balance is "..balance.." gold coins.", "Feito. Seu dinheiro foi depositado, agora seu saldo é de "..balance.." gold coins."), cid)
                else
                   selfSay(getLangString(cid, "Sorry, you don't have this money to deposit.", "Desculpe, você não tem essa quantia para depositar."), cid)
                end
            else
               selfSay(getLangString(cid, "OK, I think.", "OK, eu acho."), cid)
            end

            talkState[talkUser] = 1

        elseif talkState[talkUser] == 4 then
            local count = getNumberMsg(msg, maxGoldToWork) > 0 and getNumberMsg(msg, maxGoldToWork) or 0
      if count == maxGoldToWork or count < 1 then count = getPlayerBalance(cid) end
      setPlayerStorageValue(cid, "withdrawCount", count)
           selfSay(getLangString(cid, "Are you sure you wish to withdraw "..count.." gold coins from your account?", "Você tem certeza que você deseja retirar "..count.." gold coins da sua conta?"), cid)
            talkState[talkUser] = 5

        elseif talkState[talkUser] == 5 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if doPlayerWithdrawMoney(cid, getPlayerStorageValue(cid, "withdrawCount")) then
                    local balance = getPlayerBalance(cid)

                   selfSay(getLangString(cid, "Done. there is your money, now your balance is "..balance.." gold coins.", "Feito. Aqui está o seu dinheiro, agora seu saldo é de "..balance.." gold coins."), cid)
                else
                   selfSay(getLangString(cid, "Sorry, you don't have this money in the bank to withdraw.", "Desculpe, você não tem essa quantia para sacar."), cid)
                end
            else
               selfSay(getLangString(cid, "OK, I think.", "OK, eu acho."), cid)
            end

            talkState[talkUser] = 1


        end

        return true
end

function onGreet(cid) 
  talkState[cid] = 1
  setPlayerStorageValue(cid, "withdrawCount", 0)
  setPlayerStorageValue(cid, "depositCount", 0)
  selfSay(getLangString(cid, "Hello, "..getCreatureName(cid)..". What can i do for you? {Deposit}, {withdraw} or maybe check {balance}?", "Olá, "..getCreatureName(cid)..". O que eu posso fazer por você? {Deposit}, {withdraw}, ou check {balance}?"), cid)
  return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
