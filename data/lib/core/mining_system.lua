-- data/lib/core/mining_system.lua

Mining = {
    -- Storages para salvar o progresso do jogador
    storages = {
        level = 50000,
        experience = 50001,
        stats_points = 50002 -- Para usar na Skill Tree futura
    },

    -- Configurações Gerais
    base_success_chance = 40, -- 40% de chance base
    respawn_time = 60, -- Segundos para a pedra voltar (se não usar decay.xml)
    
    -- Item especial que cai de Boss (Cross-Progression)
    geologist_gloves_id = 12345, -- Coloque o ID do item real aqui (ex: um par de luvas raro)
    geologist_bonus = 20, -- +20% de chance de sucesso se estiver usando as luvas

    -- Ferramentas e seus poderes (Breaking Power)
    tools = {
        [2553] = {power = 10, name = "Picareta Enferrujada"}, -- Pickaxe comum
        [2422] = {power = 30, name = "Picareta de Ferro"}, -- Iron Hammer (exemplo visual)
        [2420] = {power = 50, name = "Picareta de Mithril"}, -- Machete (exemplo visual)
        -- Adicione IDs de sprites customizadas aqui
    },

    -- Minérios (As pedras no mapa)
    -- ID da Pedra: {hardness = Dureza, level = Nivel Necessario, rewards = Tabela de Loot}
    ores = {
        -- Exemplo: Pedras comuns (ID 1285, 1357 no Tibia padrão)
        [1285] = {
            hardness = 0, 
            minLevel = 1,
            xp = 10,
            transformTo = 1359, -- Pedra quebrada
            rewards = {
                {itemId = 2148, count = {1, 3}, chance = 100}, -- Gold Coins (apenas exemplo)
                {itemId = 5880, count = {1, 1}, chance = 5},   -- Minério de Ferro (Iron Ore)
            }
        },
        -- Exemplo: Minério de Ouro (Crie um item novo ou use uma pedra dourada)
        [1357] = {
            hardness = 25, -- Precisa de picareta melhor
            minLevel = 15,
            xp = 50,
            transformTo = 1359,
            rewards = {
                {itemId = 2157, count = {1, 1}, chance = 50}, -- Gold Nugget
                {itemId = 2156, count = {1, 1}, chance = 5},  -- Red Gem (Raro)
            }
        },
    }
}

-- Fórmulas de XP
function Mining.getExpForLevel(level)
    -- Fórmula simples: 50 * (level - 1) + exp anterior (curva linear para teste)
    -- Você pode usar curva exponencial: 50 * (level ^ 1.5)
    return 500 * (level - 1)
end

function Mining.getLevel(player)
    return math.max(1, player:getStorageValue(Mining.storages.level))
end

function Mining.addExp(player, amount)
    local currentExp = math.max(0, player:getStorageValue(Mining.storages.experience))
    local currentLevel = Mining.getLevel(player)
    
    player:setStorageValue(Mining.storages.experience, currentExp + amount)
    player:sendTextMessage(MESSAGE_EXPERIENCE, "Você ganhou " .. amount .. " de experiência em Mineração.", position, primaryExp, color)
    
    -- Checa Level Up
    local nextLevelExp = Mining.getExpForLevel(currentLevel + 1)
    if (currentExp + amount) >= nextLevelExp then
        player:setStorageValue(Mining.storages.level, currentLevel + 1)
        player:setStorageValue(Mining.storages.stats_points, math.max(0, player:getStorageValue(Mining.storages.stats_points)) + 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabéns! Você alcançou o nível " .. (currentLevel + 1) .. " de Mineração!")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
    end
end