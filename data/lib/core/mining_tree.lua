MiningTree = {
    -- Storages
    storages = {
        powder = 50100, -- Quantidade de Pó de Mithril
        hotm_level = 50101, -- Nível do "Coração" (Tier liberado)
        perk_base = 50200 -- Base para salvar o nível de cada habilidade
    },

    -- Configurações da Árvore
    tiers = {
        [1] = {
            name = "Iniciante",
            req_hotm = 1,
            perks = {
                {id = 1, name = "Velocidade de Mineração", maxLevel = 50, costBase = 50, costMult = 1.1, desc = "Reduz o tempo para quebrar minérios."},
                {id = 2, name = "Sorte de Mithril", maxLevel = 50, costBase = 50, costMult = 1.2, desc = "Aumenta a chance de dropar Pó de Mithril ao minerar."}
            }
        },
        [2] = {
            name = "Explorador",
            req_hotm = 2,
            perks = {
                {id = 3, name = "Minerador Eficiente", maxLevel = 20, costBase = 200, costMult = 1.3, desc = "Chance de minerar 2 ou 3 minérios de uma vez."},
                {id = 4, name = "Visão do Geólogo", maxLevel = 10, costBase = 500, costMult = 1.5, desc = "Chance de encontrar gemas raras dentro das pedras."}
            }
        },
        [3] = {
            name = "Mestre da Montanha",
            req_hotm = 3,
            perks = {
                {id = 5, name = "Frenesi de Mineração", maxLevel = 1, costBase = 5000, costMult = 1, desc = "Habilidade Ativa: Garante 3x drops por 10 segundos. (Use !miningfrenzy)"},
                {id = 6, name = "Titânio Humano", maxLevel = 5, costBase = 2000, costMult = 2.0, desc = "Aumenta sua defesa física baseado no seu nível de mineração."}
            }
        }
    }
}

-- Funções Auxiliares
function MiningTree.getPowder(player)
    return math.max(0, player:getStorageValue(MiningTree.storages.powder))
end

function MiningTree.addPowder(player, amount)
    player:setStorageValue(MiningTree.storages.powder, MiningTree.getPowder(player) + amount)
    player:sendTextMessage(MESSAGE_STATUS_SMALL, "+" .. amount .. " Mithril Powder")
end

function MiningTree.removePowder(player, amount)
    local current = MiningTree.getPowder(player)
    if current >= amount then
        player:setStorageValue(MiningTree.storages.powder, current - amount)
        return true
    end
    return false
end

function MiningTree.getPerkLevel(player, perkId)
    return math.max(0, player:getStorageValue(MiningTree.storages.perk_base + perkId))
end

function MiningTree.getCost(perk, currentLevel)
    -- Fórmula: CustoBase * (Multiplicador ^ NivelAtual)
    return math.floor(perk.costBase * (perk.costMult ^ currentLevel))
end

function MiningTree.getBonuses(player)
    -- Retorna uma tabela com todos os bônus calculados para uso no script de mineração
    return {
        speed = MiningTree.getPerkLevel(player, 1) * 2, -- 2% mais rápido por nivel
        powderChance = MiningTree.getPerkLevel(player, 2) * 1, -- 1% chance extra
        doubleDrop = MiningTree.getPerkLevel(player, 3) * 2, -- 2% chance
        rareFind = MiningTree.getPerkLevel(player, 4) * 0.5 -- 0.5% chance
    }
end