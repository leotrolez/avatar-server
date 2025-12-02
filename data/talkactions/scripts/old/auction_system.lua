local config = {
        levelRequiredToAdd = 20,
        maxOffersPerPlayer = 5,
        storageExhaustion = 9999,
        sendOffersOnlyInPZ = true,
        blocked_items = {},
        accepted_items = {11259, 13041, 12686, 12687, 12688, 12689}
}

local idsDoDesc = {
        [11259] = "You see elemental coin.",
        [13041] = "You see premium scroll.",
        [12686] = "You see Fire Stone. This stone is very rare and powerful, handle with extreme care.",
        [12687] = "You see Earth Stone. This stone is very rare and powerful, handle with extreme care.",
        [12688] = "You see Water Stone. This stone is very rare and powerful, handle with extreme care.",
        [12689] = "You see Air Stone. This stone is very rare and powerful, handle with extreme care."
}

local function setExhaustion(uid, time)
        return doCreatureSetStorage(uid, config.storageExhaustion, time + os.time())
end

local function getExhaustion(uid)
        local storage = getCreatureStorage(uid, config.storageExhaustion)
        if storage <= 0 then
                return 0
        end
        return storage - os.time()
end

local function isArmor(itemId)
    local item = getItemInfo(itemId)
    local armorWields = {1, 2, 4, 7, 8, 9}
    if isInArray(armorWields, item.wieldPosition) then
        return true
    end
    return false
end

local function isItemToOffer(itemId)
    local item = getItemInfo(itemId)
        if isInArray(config.accepted_items, itemId) then
                return true
        elseif isItemStackable(itemId) then
                return false
        elseif item.wieldPosition == 1 or item.wieldPosition == 2 or item.wieldPosition == 4 or item.wieldPosition == 7 or item.wieldPosition == 8 or item.wieldPosition == 9 then -- capacete, armadura, bota, calça, anel, amuleto
                return true
        elseif item.weaponType > 0 then -- sword, axe, club, distance , shield, wands, rods, ammunition
                return true
        end
        return false
end

function onSay(cid, words, param, channel)
    if (param == '') then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Comando inválido.")
                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                return true
        elseif config.sendOffersOnlyInPZ and not getTilePzInfo(getPlayerPosition(cid)) then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você necessita estar em área PZ para utilizar o market.")
                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                return true
        elseif getExhaustion(cid) > 0 then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você está exhausted.")
                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                return true
        end

        local word = string.explode(param, ",")
        if word[1] == "add" then
                if not word[2] or not word[3] or not word[4] then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] É necessário informar todos os dados.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                local itemCount = tonumber(word[3])
                local itemValue = tonumber(word[4])
                if (not itemCount or not itemValue) or (itemCount < 1 or itemValue < 1) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Insira valores válidos.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif string.len(itemCount) > 3 then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Esta quantidade está acima do limite.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif itemCount > 100 then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não pode vender mais do que 100 itens.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif itemValue > 9999999 then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Este preço está acima do limite.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif itemValue < 1000 then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Este preço está abaixo do limite.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif not isPremium(cid) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Apenas jogadores Premium Account podem adicionar ofertas no market.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif getPlayerLevel(cid) < config.levelRequiredToAdd then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] É necessário level " .. config.levelRequiredToAdd .. " para adicionar ofertas no market.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                setExhaustion(cid, 3)

                local resultId = db.getResult("SELECT `id` FROM `auction_system` WHERE `player` = " .. getPlayerGUID(cid) .. " AND `world_id` = " .. getConfigValue('worldId') .. ";")
                if (resultId:getID() ~= -1) then
                        if resultId:getRows(true) >= config.maxOffersPerPlayer then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Desculpe, você não pode adicionar mais ofertas (máximo de " .. config.maxOffersPerPlayer .. " ofertas por personagem).")
                                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                                return true
                        end
                end

                local itemId = getItemIdByName(word[2])
                itemCount = math.floor(itemCount)
                if not itemId then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Não existe item com este nome.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif isInArray(config.blocked_items, itemId) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Este item não pode ser vendido no market.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif not isItemToOffer(itemId) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Este item não pode ser vendido no market.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif itemCount > 1 and not isItemStackable(itemId) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Este tipo de item só pode ser anunciado com a quantidade limitada a 1.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif getPlayerItemCount(cid, itemId) < itemCount then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Desculpe, você não tem este item ou a quantia deste item.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                local theDesc = ""
                if idsDoDesc[itemId] then
                        theDesc = idsDoDesc[itemId]
                else
                        local theItem = getPlayerItemById(cid, true, itemId)
                        local elementalRuneType = getItemAttribute(theItem.uid, 'elementalrunetype')
                        local elementalRuneCharges = getItemAttribute(theItem.uid, 'elementalrunecharges')
                        if elementalRuneType then
                                if elementalRuneType >= 1 and (isArmor(theItem.itemid) or (elementalRuneCharges and elementalRuneCharges > 0)) then
                                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não pode colocar um item encantado no market.")
                                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                                        return true
                                end
                        end

                        if theItem.type == 0 then 
                            doItemSetAttribute(theItem.uid, "description", getItemDescriptions(itemId).description)
                            theDesc = "You see " .. getItemDescr(theItem.uid)
                        end
                end

                if not doPlayerRemoveItem(cid, itemId, itemCount) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Desculpe, você não tem este item ou a quantidade deste item.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                else
                        local itemName = string.lower(getItemNameById(itemId))
                        itemValue = math.floor(itemValue)
                        db.executeQuery("INSERT INTO `auction_system` (`player`, `item_name`, `item_id`, `count`, `desc`, `cost`, `date`, `expired`, `world_id`) VALUES (" .. getPlayerGUID(cid) .. ", \"" .. itemName .. "\", " .. itemId .. ", " .. itemCount .. ", \"" .. theDesc .. "\", " .. itemValue ..", " .. os.time() .. ", 0, " .. getConfigValue('worldId') .. ");")
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você adicionou " .. itemCount .." " .. itemName .." por " .. itemValue .. " gold coins nas ofertas de venda do market.")
                end

                return true

        elseif word[1] == "buy" then
                if not word[2] then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Digite o ID da oferta que deseja comprar.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                local id = tonumber(word[2])
                if not id then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não digitou um número válido para o ID da oferta.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                setExhaustion(cid, 3)

                local resultId = db.getResult("SELECT * FROM `auction_system` WHERE `id` = " .. id .. " AND `world_id` = " .. getConfigValue('worldId') .. ";")
                if resultId:getID() == -1 then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] ID da oferta incorreto.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                local expired = resultId:getDataInt("expired")
                local playerId = resultId:getDataInt("player")
                local playerName = getPlayerNameByGUID(resultId:getDataInt("player"))
                local itemValue = resultId:getDataInt("cost")
                local itemId = resultId:getDataInt("item_id")
                local itemCount = resultId:getDataInt("count")
                local itemName = resultId:getDataString("item_name")
                resultId:free()

                if expired == 1 then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Esta oferta já expirou.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif getPlayerName(cid) == playerName then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não pode comprar seus próprios itens.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif getPlayerMoney(cid) < itemValue then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não possui dinheiro suficiente.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif getPlayerFreeCap(cid) < getItemWeightById(itemId, itemCount) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você está tentando comprar o item " .. itemName .. " de " .. getItemWeightById(itemId, itemCount) .. " de cap, você possui apenas " .. getPlayerFreeCap(cid) .. " de cap. disponível. Coloque alguns itens em seu depot ou em sua house, e tente refazer a compra.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                elseif not doPlayerRemoveMoney(cid, itemValue) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não possui dinheiro suficiente.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                else
                        if isItemStackable(itemId) then
                                doPlayerAddItem(cid, itemId, itemCount)
                        else
                                for i = 1, itemCount do
                                        doPlayerAddItem(cid, itemId, 1)
                                end
                        end
                        db.executeQuery("DELETE FROM `auction_system` WHERE `id` = " .. id .. " AND `world_id` = " .. getConfigValue('worldId') .. ";")
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você comprou " .. itemCount .. " ".. itemName .. " por " .. itemValue .. " gps!")
                        db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. itemValue .. " WHERE `id` = " .. playerId .. ";")
                end

                return true

        elseif word[1] == "remove" then
                if not word[2] then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Digite o ID da oferta que quer remover.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                local id = tonumber(word[2])
                if not id then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você não digitou um número válido para o ID da oferta.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        return true
                end

                setExhaustion(cid, 3)

                local resultId = db.getResult("SELECT * FROM `auction_system` WHERE `id` = " .. id .. " AND `world_id` = " .. getConfigValue('worldId') .. ";")
                if (resultId:getID() == -1) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] ID da oferta incorreto.")
                        return true
                end

                local playerId = resultId:getDataInt("player")
                local itemId = resultId:getDataString("item_id")
                local itemCount = resultId:getDataInt("count")
                local itemName = resultId:getDataString("item_name")
                resultId:free()

                if getPlayerGUID(cid) == playerId then
                        if getPlayerFreeCap(cid) < getItemWeightById(itemId, itemCount) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Você está tentando retirar o item " .. itemName .. " de " .. getItemWeightById(itemId, itemCount) .. " de capacidade e você tem " .. getPlayerFreeCap(cid) .. " de capacidade disponível. Coloque alguns itens em seu depot ou em sua house, e tente remover a oferta.")
                                doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                        else
                                db.executeQuery("DELETE FROM `auction_system` WHERE `id` = " .. id .. " AND `world_id` = " .. getConfigValue('worldId') .. ";")
                                if isItemStackable(itemId) then
                                        doPlayerAddItem(cid, itemId, itemCount)
                                else
                                        for i = 1, itemCount do
                                                doPlayerAddItem(cid, itemId, 1)
                                        end
                                end
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Sua oferta foi removida do market.")
                        end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[MARKET] Esta oferta não pertence a você.")
                        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
                end
        end
        return true
end