local focus, talk_start, target, days, curentItem, pointsNumber, cost, amount, lang = 0, 0, 0, 0, 0, 0, 0, 0, 0 --PT E EN CONFIGURADOS

function onCreatureAppear(creature)  return true end

function onCreatureTurn(creature) return true end

function onCreatureDisappear(cid, pos)
    if focus == cid then
        if lang == EN then
            selfSay('Good bye then.')
        else
            selfSay("Então tá... tchau.")
        end
        focus = 0
        talk_start = 0
    end
end

local function getPriceOfMana(cid, number)
    local number = number or 0
    local playerMana = getCreatureMaxMana(cid)+number

    if playerMana >= 0 and playerMana <= 149 then
        return 1

    elseif playerMana >= 150 and playerMana <= 199 then
        return 2

    elseif playerMana >= 200 and playerMana <= 249 then
        return 3

    elseif playerMana >= 250 and playerMana <= 299 then
        return 4

    elseif playerMana >= 300 then
        return 5
    end
end

local function getPriceOfHealth(cid, number)
    local number = number or 0
    local playerHealth = getPointsUsedInSkill(cid, "health")+number

    if playerHealth >= 0 and playerHealth <= 299 then
        return 1

    elseif playerHealth >= 300 and playerHealth <= 499 then
        return 2

    elseif playerHealth >= 500 and playerHealth <= 799 then
        return 3

    elseif playerHealth >= 800 and playerHealth <= 999 then
        return 4

    elseif playerHealth >= 1000 and playerHealth <= 1699 then
        return 5

    elseif playerHealth >= 1700 then
        return 8
    end
end

local function getPriceOfDodge(cid, number)
    local number = number or 0
    local dodge = getPointsUsedInSkill(cid, "dodge")+number

    if dodge >= 0 and dodge <= 5 then
        return 1
    elseif dodge >= 6 and dodge <= 8 then
        return 2
    elseif dodge >= 9 and dodge <= 10 then
        return 3
    elseif dodge == 11 then
        return 4
    elseif dodge == 12 then
        return 5
    elseif dodge == 13 then
        return 8
    elseif dodge == 14 then
        return 12
    elseif dodge >= 15 then
        return 18
    end
end

local function getPriceOfBendLevel(cid, number)
local number = number or 0
    local bendLevel = getPlayerMagLevel(cid)+number

    if bendLevel >= 0 and bendLevel <= 19 then
        return 1

    elseif bendLevel >= 20 and bendLevel <= 29 then
        return 2

    elseif bendLevel >= 30 and bendLevel <= 49 then
        return 4

    elseif bendLevel >= 50 and bendLevel <= 59 then
        return 7

    elseif bendLevel >= 60 and bendLevel <= 69 then
        return 10

    elseif bendLevel >= 70 and bendLevel <= 79 then
        return 15

    elseif bendLevel >= 80 then
        return 25
    end
end

local function getPriceOffNumber(cid, point, number)
    local funcCheck, numberPlus = nil, 0
    if point == "health" then
        funcCheck = getPriceOfHealth
        numberPlus = 20
    elseif point == "mana" then
        funcCheck = getPriceOfMana
        numberPlus = 5
    elseif point == "bend" then
        funcCheck = getPriceOfBendLevel
        numberPlus = 1
    elseif point == "dodge" then
        funcCheck = getPriceOfDodge
        numberPlus = 1
    end

    local numberAggred = 0
    for x = 1, number do
        numberAggred = funcCheck(cid, numberPlus*x)+numberAggred
    end
    return numberAggred
end

local function setValidateNumber(number, max)
    local max = max or 100

    if number == nil then
        return 1
    end
    if number > max then
        return max
    end
    if number <= 0 then
        return 1
    else
        return number
    end
end

function onCreatureSay(cid, type, msg)
    local msg, elementPlayer, playerPos = msg:lower(), nil, nil


    if msgcontains(msg, "hi") or msgcontains(msg, "oi") then
        if isPlayer(cid) then
            elementPlayer, playerPos = getPlayerElement(cid), getThingPos(cid)
            if elementPlayer == nil then
                if getLang(cid) == EN then
                    selfSay("Sorry "..getCreatureName(cid)..", I can't talk to you while you are an Avatar.")
                else
                    selfSay("Desculpe "..getCreatureName(cid)..", eu não posso falar com você enquanto for um Avatar!")
                end
                return true
            end
        end
    end

    if ((msgcontains(msg, 'hi') or msgcontains(msg, "oi")) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
        if isPlayer(cid) then
            elementPlayer, playerPos = getPlayerElement(cid), getThingPos(cid)
            if getThingFromPos({x=playerPos.x, y=playerPos.y, z=playerPos.z, stackpos = 0}).itemid == 12707 then
                if getLang(cid) == EN then
                    selfSay("Hello "..getCreatureName(cid).."! Do you want to change your points for STATS, want to change STONES for points or you want to see your BALANCE?")
                else
                    selfSay("Olá "..getCreatureName(cid).."! Você deseja trocar seus pontos elementais por STATS? Você também pode trocar STONES por pontos, ou ver o seu SALDO.")
                end
                focus = cid
                talk_start = os.clock()
                talk_state = 0
            else
                if getLang(cid) == EN then
                    selfSay("Please enter in my room first.")
                else
                    selfSay("Porfavor entre na minha sala antes.")
                end
            end
        end

    elseif (msgcontains(msg, 'hi') or msgcontains(msg, "oi")) and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
        if isPlayer(cid) then
            if getLang(cid) == EN then
                selfSay(creatureGetName(cid)..", please wait for your turn.")
            else
                selfSay(getCreatureName(cid)..", porfavor espere por sua vez.")
            end
        end

    elseif focus == cid then
        talk_start = os.clock()
        lang = getLang(cid)

        if (msgcontains(msg, 'bye') or msgcontains(msg, "tchau")) and getDistanceToCreature(cid) < 4 then
            if lang == EN then
                selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
            else
                selfSay("Até logo, "..creatureGetName(cid).."!")
            end
            focus = 0
            talk_start = 0
            return true
        elseif (msgcontains(msg, 'hi') or msgcontains(msg, "oi")) and talk_state == 0 then
            if lang == EN then
                selfSay("I'm already talking with you.")
            else
                selfSay("Eu já estou falando com você.")
            end
        end

        elementPlayer, playerPos = getPlayerElement(cid), getThingPos(cid)
        if talk_state == 0 then
            if msgcontains(msg, "stats") then
                if lang == EN then
                    selfSay("You can change your points for MANA, HEALTH, BEND LEVEL or DODGE.")
                else
                    selfSay("Você pode trocar seus pontos por MANA, HEALTH, BEND LEVEL ou DODGE.")
                end
            elseif msgcontains(msg, "balance") or msgcontains(msg, "saldo") then
                if lang == EN then
                    selfSay("Now you balance are "..getPlayerElementPoints(cid, elementPlayer).." point(s).")
                else
                    selfSay("Seu saldo é de "..getPlayerElementPoints(cid, elementPlayer).." pontos.")
                end
            elseif msgcontains(msg, "stone") or msgcontains(msg, "stones") then
                local number = setValidateNumber(getNumbersInString(msg)[1])
                if lang == EN then
                    selfSay("You want to change "..number.." "..elementPlayer.." stones for "..number.." point(s)?")
                else
                    selfSay("Você deseja trocar "..number.." "..elementPlayer.." stones por "..number.." ponto(s)?")
                end
                amountOfItem = number
                talk_state = 2

            elseif msgcontains(msg, "mana") then
                local number = setValidateNumber(getNumbersInString(msg)[1])
                cost, amount = getPriceOffNumber(cid, "mana", number), number
                if lang == EN then
                    selfSay("I add +"..5*number.." of your total mana (+"..number.." attribute(s) in mana) for "..cost.." point(s), are you interested?")
                else
                    selfSay("Eu vou adicionar +"..5*number.." na sua mana total (+"..number.." atributo(s) em mana) por "..cost.." ponto(s), você está interresado?")
                end
                talk_state = 3

            elseif msgcontains(msg, "health") then
                local number = setValidateNumber(getNumbersInString(msg)[1])
                cost, amount = getPriceOffNumber(cid, "health", number), number
                if lang == EN then
                    selfSay("I add +"..20*number.." of your total health (+"..number.." attributes in health) for "..cost.." point(s), are you interested?")
                else
                    selfSay("Eu vou adicionar +"..20*number.." na sua vida total (+"..number.." atributo(s) em health) por "..cost.." ponto(s), você está interresado?")
                end
                talk_state = 4

            elseif msgcontains(msg, "bend level") or msgcontains(msg, "bend") then
                local number = setValidateNumber(getNumbersInString(msg)[1])
                cost, amount = getPriceOffNumber(cid, "bend", number), number

                if lang == EN then
                    selfSay("I add +"..1*number.." to your bend level (+"..number.." attributes in bend level) for "..cost.." point(s), are you interested?")
                else
                    selfSay("Eu vou adicionar +"..1*number.." no seu bend level (+"..number.." atributo(s) em bend level) por "..cost.." ponto(s), você está interresado?")
                end
                talk_state = 5

            elseif msgcontains(msg, "dodge") then
                local number = setValidateNumber(getNumbersInString(msg)[1], 15)
                cost, amount = getPriceOffNumber(cid, "dodge", number), number
                
                if getPointsUsedInSkill(cid, "dodge")+number > 15 then
                    if lang == EN then
                        selfSay("You can't add +"..number.." point(s) in dodge, because the max allowed are 15%, you already have "..getPointsUsedInSkill(cid, "dodge").."%.")
                    else
                        selfSay("Você não pode adicionar +"..number.." ponto(s) em dodge, porque o máximo permitido é 15%, e você já tem "..getPointsUsedInSkill(cid, "dodge").."%.")
                    end
                    return true
                end

                if lang == EN then
                    selfSay("I add +"..1*number.."% to your dodge ability (+"..number.." attributes in dodge ability) for "..cost.." point(s), are you interested?")
                else
                    selfSay("Eu vou adicionar +"..1*number.."% na sua capacidade de esquiva (+"..number.." atributo(s) em dodge) por "..cost.." pontos(s), você está interresado?")
                end
                talk_state = 6
            end

        elseif talk_state == 1 then
            local number = getNumbersInString(msg)[1]
            if number ~= nil then
                if lang == EN then
                    selfSay("You want to change "..number.." "..elementPlayer.." stone(s) for "..number.." point(s)?")
                else
                    selfSay("Você deseja trocar "..number.." "..elementPlayer.." stone(s) por "..number.." ponto(s)?")
                end
                talk_state = 2
                amountOfItem = number
            else
                selfSay("Please tell me amount of stone do you want change.")
            end

        elseif talk_state == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                if doPlayerRemoveItem(cid, getStoneItemId(elementPlayer), amountOfItem) then
                    doPlayerSetElementPoints(cid, elementPlayer, getPlayerElementPoints(cid, elementPlayer)+amountOfItem)
                    if lang == EN then
                        selfSay("Ok, thanks for change with me, now you have "..getPlayerElementPoints(cid, elementPlayer).." "..elementPlayer.." point(s).")
                    else
                        selfSay("Ok, obrigado por negociar comigo, agora você tem "..getPlayerElementPoints(cid, elementPlayer).." ponto(s).")
                    end
                    talk_state = 0
                    return true
                else
                    if lang == EN then
                        selfSay("You don't have "..amountOfItem.." "..elementPlayer.." stone(s) to change with me.")
                    else
                        selfSay("você não tem "..amountOfItem.." "..elementPlayer.." stone(s) para trocar comigo.")
                    end
                    talk_state = 0
                end
            else
                if lang == EN then
                    selfSay("Ok, I think...")
                else
                    selfSay("Ok então...")
                end
                talk_state = 0    
            end

        elseif talk_state == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                local price = getPriceOffNumber(cid, "mana", amount)
                if getPlayerElementPoints(cid, elementPlayer) >= price then
                    if lang == EN then
                        selfSay("Excellent choice! Here is +"..5*amount.." added to your total mana.")
                    else
                        selfSay("Exelente escolha! Aqui está +"..5*amount.." pontos adicionados em sua mana total.")
                    end
                    addPointsInSkill(cid, "mana", 5*amount)
                    setCreatureMaxMana(cid, getCreatureMaxMana(cid)+(5*amount))
                    doCreatureAddMana(cid, 5*amount)
                    doPlayerSetElementPoints(cid, elementPlayer, getPlayerElementPoints(cid, elementPlayer)-price)
                    talk_state = 0
                else
                    if lang == EN then
                        selfSay("You don't have "..price.." point(s) for buy this mana.")
                    else
                        selfSay("Você não tem "..price.." ponto(s) para comprar isso.")
                    end
                    talk_state = 0
                end
            else
                if lang == EN then
                    selfSay("Ok, I think...")
                else
                    selfSay("Ok então...")
                end
                talk_state = 0   
            end

        elseif talk_state == 4 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                local price = getPriceOffNumber(cid, "health", amount)
                if getPlayerElementPoints(cid, elementPlayer) >= price then
                    if lang == EN then
                        selfSay("Excellent choice! Here is +"..20*amount.." added to your total health.")
                    else
                        selfSay("Exelente escolha! Aqui está +"..20*amount.." pontos adicionados em sua vida total.")
                    end
                    addPointsInSkill(cid, "health", 20*amount)
                    setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)+(20*amount))
                    doCreatureAddHealth(cid, 20*amount)
                    doPlayerSetElementPoints(cid, elementPlayer, getPlayerElementPoints(cid, elementPlayer)-price)
                    talk_state = 0
                else
                    if lang == EN then
                        selfSay("You don't have "..price.." point(s) for buy this health.")
                    else
                        selfSay("Você não tem "..price.." ponto(s) para comprar isso.")
                    end
                    talk_state = 0
                end
            else
                if lang == EN then
                    selfSay("Ok, I think...")
                else
                    selfSay("Ok então...")
                end
                talk_state = 0   
            end

        elseif talk_state == 5 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                local price = getPriceOffNumber(cid, "bend", amount)
                if getPlayerElementPoints(cid, elementPlayer) >= price then
                    if lang == EN then
                        selfSay("Excellent choice! Here is +"..1*amount.." added to your bend level.")
                    else
                        selfSay("Exelente escolha! Aqui está +"..1*amount.." ponto(s) adicionado em seu bend level.")
                    end
                    addPointsInSkill(cid, "bend", 1*amount)
                    doPlayerAddMagicLevel(cid, amount)
                    doPlayerSetElementPoints(cid, elementPlayer, getPlayerElementPoints(cid, elementPlayer)-price)
                    talk_state = 0
                else
                    if lang == EN then
                        selfSay("You don't have "..price.." point(s) for buy this bend level.")
                    else
                        selfSay("Você não tem "..price.." ponto(s) para comprar isso.")
                    end
                    talk_state = 0
                end
            else
                if lang == EN then
                    selfSay("Ok, I think...")
                else
                    selfSay("Ok então...")
                end
                talk_state = 0   
            end

        elseif talk_state == 6 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                local price = getPriceOffNumber(cid, "dodge", amount)

                if getPointsUsedInSkill(cid, "dodge")+amount > 15 then
                    if lang == EN then
                        selfSay("You can't add +"..amount.." point(s) in dodge, because the max allowed are 15%, you already have "..getPointsUsedInSkill(cid, "dodge").."%.")
                    else
                        selfSay("Você não pode adicionar +"..amount.." ponto(s) em dodge, porque o máximo permitido é 15%, e você já tem "..getPointsUsedInSkill(cid, "dodge").."%.")
                    end
                    talk_state = 0
                    return true
                end
                if getPlayerElementPoints(cid, elementPlayer) >= price then
                    if lang == EN then
                        selfSay("Excellent choice! Here is +"..1*amount.." added to your dodge ability.")
                    else
                        selfSay("Exelente escolha! Aqui está +"..1*amount.." ponto(s) adicionados em sua capacidade de esquiva.")
                    end
                    addPointsInSkill(cid, "dodge", 1*amount)
                    doPlayerSetElementPoints(cid, elementPlayer, getPlayerElementPoints(cid, elementPlayer)-price)
                    talk_state = 0
                else
                    if lang == EN then
                        selfSay("You don't have "..price.." point(s) for buy this dodge ability.")
                    else
                        selfSay("Você não tem "..price.." ponto(s) para comprar isso.")
                    end
                    talk_state = 0
                end
            else
                if lang == EN then
                    selfSay("Ok, I think...")
                else
                    selfSay("Ok então...")
                end
                talk_state = 0   
            end
        end
    end
end


function onCreatureChangeOutfit(creature) return true end


function onThink()
    doNpcSetCreatureFocus(focus)
    if (os.clock() - talk_start) > 30 then
        if focus > 0 then
            if lang == EN then
                selfSay('Next please!')
            else
                selfSay('Proxímo porfavor!')
            end
        end
        focus = 0
    end
    if focus ~= 0 then
        if getDistanceToCreature(focus) > 5 then
            if lang == EN then
                selfSay('How rude!')
            else
                selfSay('Quanta educação...')
            end
            focus = 0
        end
    end
end 