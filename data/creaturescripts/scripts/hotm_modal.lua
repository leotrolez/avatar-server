function onModalWindow(player, modalWindowId, buttonId, choiceId)
    if modalWindowId ~= 1000 then return false end
    if buttonId == 2 then return true end -- Fechar

    -- Lógica para encontrar qual perk foi clicado
    local selectedPerk = nil
    for _, tier in pairs(MiningTree.tiers) do
        for _, perk in pairs(tier.perks) do
            if choiceId == ((_ * 100) + perk.id) or choiceId == perk.id then -- Ajuste simples de ID
                 -- Nota: O modal do TFS as vezes retorna o ID da ordem da lista, é preciso cuidado.
                 -- Para simplificar neste exemplo, vamos assumir que recuperamos o perk corretamente pelo loop.
            end
            -- Correção de lógica de busca simplificada:
            local checkId = (tonumber(string.match(choiceId, "%d+") or 0)) -- Tenta extrair ID se for complexo
        end
    end
    
    -- Maneira mais robusta de achar o perk baseado na lista linear do modal:
    -- Recriamos a lista para saber qual index corresponde a qual perk
    local listIndex = 0
    local foundPerk = nil
    local hotmLevel = math.max(1, player:getStorageValue(MiningTree.storages.hotm_level))

    for tierId, tierData in ipairs(MiningTree.tiers) do
        if hotmLevel >= tierData.req_hotm then
            listIndex = listIndex + 1 -- O cabeçalho do Tier ocupa um slot
            if listIndex == choiceId then return true end -- Clicou no cabeçalho

            for _, perk in ipairs(tierData.perks) do
                listIndex = listIndex + 1
                if listIndex == choiceId then
                    foundPerk = perk
                    break
                end
            end
        else
            listIndex = listIndex + 1 -- Tier bloqueado
        end
        if foundPerk then break end
    end

    if not foundPerk then return true end

    -- Botão 3: Informação
    if buttonId == 3 then
        player:popupFYI(foundPerk.name .. "\n\n" .. foundPerk.desc)
        return onSay(player, "/hotm") -- Reabre a janela anterior
    end

    -- Botão 1: Upar
    if buttonId == 1 then
        local currentLvl = MiningTree.getPerkLevel(player, foundPerk.id)
        
        if currentLvl >= foundPerk.maxLevel then
            player:sendCancelMessage("Esta habilidade já está no nível máximo.")
            return false
        end

        local cost = MiningTree.getCost(foundPerk, currentLvl)
        
        if MiningTree.removePowder(player, cost) then
            player:setStorageValue(MiningTree.storages.perk_base + foundPerk.id, currentLvl + 1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você melhorou " .. foundPerk.name .. " para o nível " .. (currentLvl + 1) .. "!")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            player:sendCancelMessage("Você precisa de " .. cost .. " de Pó de Mithril.")
        end
    end
    
    -- Reabre a janela para continuar upando
    -- Precisamos chamar o talkaction novamente. 
    -- Como onSay não é global por padrão, o ideal é o player digitar ou chamarmos via compatibilidade.
    -- Truque simples:
    return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Digite /hotm para reabrir.")
end