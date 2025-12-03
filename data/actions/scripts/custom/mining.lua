-- data/actions/scripts/custom/mining.lua

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- 1. Verifica se o alvo é um minério válido configurado na Lib
    local oreInfo = Mining.ores[target.itemid]
    if not oreInfo then
        return false
    end

    -- 2. Verifica a ferramenta usada
    local toolInfo = Mining.tools[item.itemid]
    if not toolInfo then
        return false -- Não é uma picareta configurada
    end

    -- 3. Gatekeeping: Breaking Power vs Hardness
    if toolInfo.power < oreInfo.hardness then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Sua picareta é muito fraca para este minério! (Poder: " .. toolInfo.power .. " / Necessário: " .. oreInfo.hardness .. ")")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    -- 4. Gatekeeping: Nível do Jogador
    local playerLevel = Mining.getLevel(player)
    if playerLevel < oreInfo.minLevel then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você precisa de nível " .. oreInfo.minLevel .. " de mineração.")
        return true
    end

    -- === CARREGAR BÔNUS DA ÁRVORE (HOTM) ===
    -- Esta linha OBRIGATORIAMENTE tem que estar aqui dentro
    local bonuses = MiningTree.getBonuses(player) 
    
    -- 5. Cálculo de Sucesso Base
    local chance = Mining.base_success_chance + (playerLevel * 0.5) -- +0.5% por nível
    
    -- Aplica bônus da Skill Tree (Velocidade/Sucesso)
    chance = chance + (bonuses.speed or 0)

    -- Verifica Luvas do Geólogo (Exemplo de Cross-Progression)
    local ring = player:getSlotItem(CONST_SLOT_RING)
    if ring and ring.itemid == Mining.geologist_gloves_id then
        chance = chance + Mining.geologist_bonus
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Suas Luvas do Geólogo facilitam o trabalho!")
    end

    -- Limita chance a 100%
    chance = math.min(100, chance)

    -- Animação de tentar minerar
    target:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
    
    -- === 6. Executa a Mineração ===
    
    -- Tenta dropar Pó de Mithril (Independente de quebrar a pedra ou não)
    local powderChance = 5 + (bonuses.powderChance or 0)
    if math.random(1, 100) <= powderChance then
        local powderAmount = math.random(1, 5) * (1 + (playerLevel / 50))
        MiningTree.addPowder(player, math.floor(powderAmount))
    end

    if math.random(1, 100) <= chance then
        -- SUCESSO!
        
        -- Lógica de Double Drop (Efficient Miner da Skill Tree)
        local dropMultiplier = 1
        local doubleChance = (bonuses.doubleDrop or 0)
        if math.random(1, 100) <= doubleChance then
            dropMultiplier = 2
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Minerador Eficiente ativado! (Drops x2)")
        end

        -- Dar Loot
        for _, loot in pairs(oreInfo.rewards) do
            if math.random(1, 100) <= loot.chance then
                local count = math.random(loot.count[1], loot.count[2]) * dropMultiplier
                if count > 0 then
                    player:addItem(loot.itemId, count)
                end
            end
        end
        
        -- Lógica de Gema Rara (Visão do Geólogo da Skill Tree)
        local rareChance = (bonuses.rareFind or 0)
        if rareChance > 0 and math.random(1, 1000) <= (rareChance * 10) then
            player:addItem(2154, 1) -- Yellow Gem (Exemplo de drop raro extra)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua visão de geólogo encontrou uma gema escondida!")
        end
        
        -- Dar XP
        Mining.addExp(player, oreInfo.xp)
        
        -- Transformar a pedra (Respawn)
        target:transform(oreInfo.transformTo)
        target:decay() -- Usa o sistema de decay do items.xml
        
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Você minerou com sucesso!")
    else
        -- FALHA
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Você falhou em quebrar a rocha.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end

    return true
end