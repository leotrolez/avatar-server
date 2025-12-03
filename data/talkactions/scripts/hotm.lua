-- data/talkactions/scripts/hotm.lua
function onSay(player, words, param)
    -- Se o jogador digitar apenas "/hotm", mostra o status
    if param == "" then
        local text = "--- [ HEART OF THE MOUNTAIN ] ---\n"
        text = text .. "Seu Po de Mithril: " .. MiningTree.getPowder(player) .. "\n\n"
        
        local hotmLevel = math.max(1, player:getStorageValue(MiningTree.storages.hotm_level))

        for tierId, tierData in ipairs(MiningTree.tiers) do
            if hotmLevel >= tierData.req_hotm then
                text = text .. "[Tier " .. tierId .. " - " .. tierData.name .. "]\n"
                for _, perk in ipairs(tierData.perks) do
                    local pLvl = MiningTree.getPerkLevel(player, perk.id)
                    local cost = MiningTree.getCost(perk, pLvl)
                    local status = (pLvl >= perk.maxLevel) and "MAX" or (cost .. " Po")
                    
                    -- Mostra o ID para o jogador saber o que digitar
                    text = text .. "   (ID: " .. perk.id .. ") " .. perk.name .. " [Lvl: " .. pLvl .. "/" .. perk.maxLevel .. "] - Custo: " .. status .. "\n"
                    text = text .. "      > " .. perk.desc .. "\n"
                end
            else
                text = text .. "[Tier " .. tierId .. " - Bloqueado]\n"
            end
            text = text .. "\n"
        end
        
        text = text .. "\n[COMO UPAR]: Digite /hotm buy, ID_DA_SKILL\nExemplo: /hotm buy, 1"
        player:popupFYI(text) -- Abre uma janela de texto simples (livro)
        return false
    end

    -- Sistema de Compra via comando: /hotm buy, 1
    local split = param:split(",")
    if split[1] == "buy" then
        local perkId = tonumber(split[2])
        if not perkId then
            player:sendCancelMessage("Comando incorreto. Use: /hotm buy, ID (ex: /hotm buy, 1)")
            return false
        end

        -- Busca a skill pelo ID
        local foundPerk = nil
        for _, tier in pairs(MiningTree.tiers) do
            for _, perk in pairs(tier.perks) do
                if perk.id == perkId then
                    foundPerk = perk
                    break
                end
            end
        end

        if not foundPerk then
            player:sendCancelMessage("Skill nao encontrada.")
            return false
        end

        -- Lógica de compra
        local currentLvl = MiningTree.getPerkLevel(player, foundPerk.id)
        if currentLvl >= foundPerk.maxLevel then
            player:sendCancelMessage("Esta habilidade ja esta no maximo.")
            return false
        end

        local cost = MiningTree.getCost(foundPerk, currentLvl)
        if MiningTree.removePowder(player, cost) then
            player:setStorageValue(MiningTree.storages.perk_base + foundPerk.id, currentLvl + 1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Sucesso! Voce melhorou " .. foundPerk.name .. " para o nivel " .. (currentLvl + 1) .. ".")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            player:sendCancelMessage("Voce precisa de " .. cost .. " Po de Mithril.")
        end
    end
    return false
end