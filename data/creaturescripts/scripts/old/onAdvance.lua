local itemIdShow = 1921

function onAdvance(cid, skill, oldLevel, newLevel)
    if skill == SKILL_LEVEL and newLevel > oldLevel then
        if getPlayerStorageValue(cid, "getTurnMsgPoints") ~= 1 then
            local string = getLangString(cid,
                "Congratulations! You have gained element points.\nYou can use these element points for change with more stats as Bend Level, Speed, Hitpoints and Dodge Chance. Type CTRL + E.",
                "Parabéns! Você ganhou pontos.\nVocê pode utilizar esses pontos para trocar por stats como Bend Level, Mana, Health e Speed. Use CTRL + E.")
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
            setPlayerStorageValue(cid, "getTurnMsgPoints", 1)
        elseif newLevel >= 50 and getPlayerStorageValue(cid, "pvpLevelMessage") ~= 1 then
            setPlayerStorageValue(cid, "pvpLevelMessage", 1)
            local string = getLangString(cid,
                "Congratulations! You have reached level 50.\nYou are now blessed and will not lose items until your next death.\nYou can now attack others players of level 50 or higher.",
                "Parabéns! Você alcançou o nível 50.\nSeu personagem foi abençoado e não perderá nenhum item em sua próxima morte.\nAgora você pode atacar e ser atacado por outros jogadores de nível 50 ou superior, mas existe penalidades (skull system).")
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, getLangString(cid,
                "Now you'll lose your backpack on death (you can use an amulet of loss or buy blessing to prevent this). If you die while you're red skulled, you'll lose all your items (there's no prevent for that).",
                "Agora você poderá perder sua backpack em uma eventual morte (seja para monstro ou para um jogador, caso não esteja utilizando amulet of loss ou não esteja abençoado para prevenir). Caso morra estando com red skull (adquirido após matar muitos jogadores injustificadamente), perderá todos os itens, sem direito a prevenção."))
            -- doPlayerAddItem(cid, 2173, 1)
            setPlayerStorageValue(cid, "playerWithBless", 1)
            setPlayerStorageValue(cid, "blessExpName", "Sony")
        end

        doCreatureAddHealth(cid, getCreatureMaxHealth(cid) - getCreatureHealth(cid))
        doCreatureAddMana(cid, getCreatureMaxMana(cid) - getCreatureMana(cid))
        local posicao = getThingPos(cid)
        doSendMagicEffect({
            x = posicao.x + 1,
            y = posicao.y + 1,
            z = posicao.z
        }, 166)
        if getPlayerStorageValue(cid, 188100) < newLevel then
            local leveis = newLevel - getPlayerStorageValue(cid, 188100)
            setPlayerStorageValue(cid, 188100, newLevel)
            local resto = newLevel - oldLevel
            local pendentes = getPlayerStorageValue(cid, "AttributesPoints") + resto
            setPlayerStorageValue(cid, "AttributesPoints", pendentes)
            doSendPlayerExtendedOpcode(cid, 41, pendentes)
        end
    end

    return true
end
