local spellInfos = {
    ["fire"] = 
        {
            {words = "Focus"}, {words = "Lightning"},
            {words = "Bomb"}, {words = "Clock"}, {words = "Thunderbolt"}, {words = "Meteor"},
            {words = "Striker"}, {words = "Overload"}, {words = "Explosion"}, {words = "Voltage"}, {words = "Thunderstorm"}, {words = "Discharge"}, {words = "Conflagration"}
        },

    ["water"] = 
        {
           {words = "BloodControl"},
            {words = "Punch"}, {words = "Dragon"}, {words = "Rain"}, {words = "Bubbles"}, {words = "Protect"},
            {words = "Icebolt"}, {words = "Flow"}, {words = "IceGolem"}, {words = "Tsunami"}, {words = "Clock"}, {words = "Blizzard"}, {words = "BloodBending"}
        },

    ["air"] = 
        {
            {words = "Suffocation"}, {words = "Hurricane"},
            {words = "Tempest"}, {words = "Windblast"}, {words = "Tornado"}, {words = "Barrier"}, {words = "Trap"}, 
            {words = "Doom"}, {words = "Bomb"}, {words = "Windstorm"}, {words = "Stormcall"}, {words = "Vortex"}, {words = "Deflection"}
        },

    ["earth"] = 
        {
           {words = "Control"}, {words = "Leech"},
            {words = "Smash"}, {words = "Ingrain"}, {words = "Fists"}, {words = "Arena"}, {words = "Curse"},
            {words = "Quake"}, {words = "Cataclysm"}, {words = "Aura"}, {words = "Armor"}, {words = "Lavaball"}, {words = "Metalwall"}
        }
}

function getHasBuyAll(cid)
    local element = getPlayerElement(cid)
    local string = "#j#1;"
	
	if not spellInfos[element] then
		return ""
	end
	
    for x = 1, #spellInfos[element] do
        if hasFoldIsBuy(cid, element.." "..spellInfos[element][x].words:lower()) then
            string = string.."#j#"..11+x..";"
        end
    end

    return string
end

function refreshBuySpells(cid)
    local string = getHasBuyAll(cid)
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
end

function hasFoldIsBuy(cid, words)
    return getPlayerStorageValue(cid, "hasBuy"..words) == 1
end

function setFoldBuy(cid, words)
    return doPlayerSetStorageValue(cid, "hasBuy"..words, 1)
end

function getFoldPrice(cid, words)
    local element = getPlayerElement(cid)
    local spells, words = spellInfos[element], words:lower()

    for x = 1, #spells do
        if spells[x].words:lower() == words then
            local info = getInstantSpellInfo(element.." "..words)
            local price = (1150*info.level)

            if getPlayerPremiumDays(cid) > 0 then --Desconto de 20%
                price = price-(price*0.2)
                price = math.ceil(price)
            end
            return price
        end
    end

    return false
end

function getListLearnFold(cid, organized)
    local level, element, string = getPlayerLevel(cid), getPlayerElement(cid), ""
    local spells, names = spellInfos[element], {}

    for x = 1, #spells do
        if not hasFoldIsBuy(cid, element.." "..spells[x].words:lower()) then
            if level >= getInstantSpellInfo(element.." "..spells[x].words).level then
                if not organized then
                    if string == "" then
                        string = spells[x].words
                    else
                        string = string..", "..spells[x].words
                    end
                else
                    table.insert(names, spells[x].words)
                end
            end
        end
    end

    if not organized then
        return string
    else
        return orgazineStrings(names)
    end
end

local cf = {
id = 13848
}
local theStones = {12686, 12688, 12689, 12687}
function canBuyUltimateFold(cid, words, sequencia)
    local level, element = getPlayerLevel(cid), getPlayerElement(cid)
    local spells, words = spellInfos[element], words:lower()

    for x = 1, #spells do
        if spells[x].words:lower() == words then
            local info = getInstantSpellInfo(element.." "..words)

            if not hasFoldIsBuy(cid, element.." "..words) then
                if level >= info.level then
                    local reqStones = 2
					local reqTasks = 100
					if sequencia == 13 then
						reqStones = 5
						reqTasks = 150
					end
					local counter = getPlayerResets(cid)
					if type(counter) ~= "number" then
						counter = 0
					end
					if (counter >= reqTasks) and (doPlayerRemoveItem(cid, theStones[getPlayerVocation(cid)], reqStones)) then
						setFoldBuy(cid, element.." "..words)

                        if spells[x].var then
                            setFoldBuy(cid, element.." "..spells[x].var:lower())
                        end

                        local element = getPlayerElement(cid, true)
                        sendBlueMessage(cid, getLangString(cid, "You've unlocked "..element.." "..spells[x].words.."!", "Vocï¿½ aprendeu a usar a dobra "..element.." "..spells[x].words.."!"))
                        refreshBuySpells(cid)
                        return true
                    else
                        return {"You don't have what takes to learn this bend.", "Vocï¿½ não tem o necessï¿½rio para aprender esta dobra."}
                    end
                else
                    return {"Sorry, you need be level "..info.level.." or more to learn this bend.", "Desculpe, vocï¿½ precisa ter level "..info.level.." ou mais para aprender esta dobra."}
                end
            else
                return {"Sorry, you already learned this bend.", "Desculpe, vocï¿½ jï¿½ aprendeu essa dobra."}
            end

            break
        end
    end

    print("Error in canBuyFold in fold: "..words)
end

function canBuyFold(cid, words, tipo)
    local level, element = getPlayerLevel(cid), getPlayerElement(cid)
    local spells, words = spellInfos[element], words:lower()

    for x = 1, #spells do
        if spells[x].words:lower() == words then
            local info = getInstantSpellInfo(element.." "..words)

            if not hasFoldIsBuy(cid, element.." "..words) then
                if level >= info.level then
                    local price = getFoldPrice(cid, words)
					if (tipo == 1 and doPlayerRemoveMoney(cid, price)) or (tipo == 2 and doPlayerRemoveItem(cid, cf.id, 1)) then
                   -- if (tipo == 1 and x+1 < #spells and doPlayerRemoveMoney(cid, price)) or (tipo == 2 and x+1 < #spells and doPlayerRemoveItem(cid, cf.id, 1)) or (tipo == 2 and x < #spells and doPlayerRemoveItem(cid, cf.id, 2)) or (tipo == 2 and doPlayerRemoveItem(cid, cf.id, 3)) then
                        setFoldBuy(cid, element.." "..words)

                        if spells[x].var then
                            setFoldBuy(cid, element.." "..spells[x].var:lower())
                        end

                        local element = getPlayerElement(cid, true)
                        sendBlueMessage(cid, getLangString(cid, "You've unlocked "..element.." "..spells[x].words..".", "Vocï¿½ aprendeu a usar a dobra "..element.." "..spells[x].words.."."))
                        refreshBuySpells(cid)
                        return true
                    else
                        return {"You don't have money to learn this fold.", "Vocï¿½ não tem dinheiro ou bender scroll para aprender essa dobra."}
                    end
                else
                    return {"Sorry, you need be level "..info.level.." or more to buy this fold.", "Desculpe, vocï¿½ precisa ter level "..info.level.." ou mais para comprar essa dobra."}
                end
            else
                return {"Sorry, you already bought this fold.", "Desculpe, vocï¿½ jï¿½ comprou essa dobra."}
            end

            break
        end
    end

    print("Error in canBuyFold in fold: "..words)
end