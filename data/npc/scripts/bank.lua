local focus, talk_start, target, days, money, amountOfItem = 0, 0, 0, 0, 0, 0

function onThingMove(creature, thing, oldpos, oldstackpos) return true end
function onCreatureAppear(creature) return true end
function onCreatureTurn(creature) return true end

function onCreatureDisappear(cid, pos)
    if focus == cid then
        selfSay('Good bye then.')
        focus = 0
        talk_start = 0
    end
end

local function getValidAmount(number)
    if number == nil or type(number) ~= "number" then
        return false
    end

    if number <= 0 or number >= 1000000000 then
        return false
    else
        return number
    end
end

local isClosed = true

function onCreatureSay(cid, type, msg)
    local msg = string.lower(msg)

    if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
        selfSay("Welcome "..getCreatureName(cid)..". What can I do for you? DEPOSIT, WITHDRAW, check BALANCE or TRANSFER?")
        focus = cid
        talk_start = os.clock()
        talk_state = 0

    elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
        selfSay(creatureGetName(cid)..", please wait for your turn.")

    elseif focus == cid then
        talk_start = os.clock()

        if msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
            selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
            focus = 0
            talk_start = 0
            return true
        elseif msgcontains(msg, 'hi') and talk_state == 0 then
            selfSay("I'm already talking with you.")
        end

        if talk_state == 0 then
            if msgcontains(msg, "offer") or msgcontains(msg, "offers") or msgcontains(msg, "offering") then
                selfSay("You can check the BALANCE of your bank account, DEPOSIT money or WITHDRAW it.")
                return true

            elseif msgcontains(msg, "job") then
                selfSay("I work in this bank. I can help you with your bank account.")
                return true
            elseif msgcontains(msg, "help") then
                selfSay("I don't need your help, thanks a lot.")
                return true

            -- balance --
            elseif msgcontains(msg, "balance") then
                selfSay("Your account balance is "..getPlayerBalance(cid).." gold.")
                return true

            -- deposit --
            elseif msgcontains(msg, "deposit") then
                if isClosed then
                    selfSay("This bank is temporarily closed. You only can WITHDRAW your money.")
                    return true
                end

                selfSay("Please tell me how much gold it is you would like to deposit.")
                talk_state = 1
                return true

            -- withdraw --
            elseif msgcontains(msg, "withdraw all") then
                local balance = npcGen:setStorage("withdrawCount", getPlayerBalance(cid))
                if balance > 0 then
                    selfSay("Are you sure you wish to withdraw "..balance.." gold from your bank account?")
                    talk_state, money = 4, balance
                else
                    selfSay("You don't have gold in your bank's account to withdraw.")
                end
            elseif msgcontains(msg, "withdraw") then
                selfSay("Please tell me how much gold you would like to withdraw.")
                talk_state = 3
                return true
            
            -- transfer --
            elseif msgcontains(msg, "transfer") then
                if isClosed then
                    selfSay("This bank is temporarily closed. You only can WITHDRAW your money.")
                    return true
                end

                selfSay("Please tell me the AMOUNT of gold you would like to transfer.")
                talk_state = 5
                return true
            end

        elseif talk_state == 3 then
            local number = getValidAmount(getNumbersInString(msg)[1])
            if number then
                selfSay("Are you sure you wish to withdraw "..number.." gold from your bank account?")
                talk_state, money = 4, number
                return true
            else
                selfSay("Please tell me a valid NUMBER to withdraw, only positive numbers are allowed.")
                return true
            end

        elseif talk_state == 4 then
            if msgcontains(msg, "yes") then
                if doPlayerWithdrawMoney(cid, money) then
                    selfSay("Here you are, "..money.." gold. Please let me know if there is something else I can do for you.")
                    talk_state = 0
                    return true
                else
                    selfSay("There is not enough gold on your account. Your account balance is "..getPlayerBalance(cid)..". Please tell me the amount of gold coins you would like to withdraw.")
                    talk_state = 0
                    return true
                end
            else
                selfSay("OK, I think..")
                talk_state = 0    
            end
        end
    end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
    doNpcSetCreatureFocus(focus)
    if (os.clock() - talk_start) > 30 then
        if focus > 0 then
            selfSay('Next please!')
        end
        focus = 0
    end
    if focus ~= 0 then
        if getDistanceToCreature(focus) > 5 then
            selfSay('How rude!')
            focus = 0
        end
    end
end 