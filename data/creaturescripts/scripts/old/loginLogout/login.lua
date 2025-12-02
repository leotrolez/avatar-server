local config = {
    protectMessageEN = "Your items were not lost on your death due to the protection of the adventurers (protection up to level 50).",
    protectMessagePT = "Seus itens não foram perdidos em sua morte devido à proteção dos aventureiros (proteção até o nível 50)."
}

local noobTutorial = {
    posesToArrowComing = {
        [1] = {{
            x = 1252,
            y = 748,
            z = 7
        }, {
            x = 1248,
            y = 747,
            z = 7
        }, {
            x = 1243,
            y = 744,
            z = 7
        }, {
            x = 1240,
            y = 740,
            z = 7
        }, {
            x = 1243,
            y = 736,
            z = 7
        }, {
            x = 1248,
            y = 733,
            z = 7
        }, {
            x = 1250,
            y = 737,
            z = 7
        }, {
            x = 1247,
            y = 741,
            z = 6
        }},
        [2] = {{
            x = 1457,
            y = 554,
            z = 7
        }, {
            x = 1457,
            y = 557,
            z = 7
        }, {
            x = 1456,
            y = 562,
            z = 7
        }, {
            x = 1452,
            y = 567,
            z = 7
        }, {
            x = 1449,
            y = 568,
            z = 8
        }, {
            x = 1446,
            y = 566,
            z = 8
        }, {
            x = 1442,
            y = 562,
            z = 8
        }, {
            x = 1443,
            y = 560,
            z = 8
        }},
        [3] = {{
            x = 1221,
            y = 671,
            z = 7
        }, {
            x = 1222,
            y = 669,
            z = 7
        }, {
            x = 1222,
            y = 664,
            z = 7
        }, {
            x = 1223,
            y = 659,
            z = 7
        }, {
            x = 1223,
            y = 656,
            z = 7
        }, {
            x = 1220,
            y = 652,
            z = 6
        }},
        [4] = {{
            x = 1115,
            y = 574,
            z = 7
        }, {
            x = 1117,
            y = 572,
            z = 7
        }, {
            x = 1120,
            y = 571,
            z = 7
        }, {
            x = 1123,
            y = 571,
            z = 7
        }, {
            x = 1126,
            y = 567,
            z = 7
        }, {
            x = 1128,
            y = 564,
            z = 7
        }, {
            x = 1129,
            y = 561,
            z = 7
        }, {
            x = 1130,
            y = 559,
            z = 7
        }}
    },
    posesToArrowLeaving = {
        [1] = {{
            x = 1250,
            y = 737,
            z = 6
        }, {
            x = 1249,
            y = 733,
            z = 7
        }, {
            x = 1244,
            y = 735,
            z = 7
        }, {
            x = 1242,
            y = 738,
            z = 7
        }, {
            x = 1240,
            y = 743,
            z = 7
        }, {
            x = 1245,
            y = 745,
            z = 7
        }, {
            x = 1246,
            y = 747,
            z = 7
        }, {
            x = 1250,
            y = 748,
            z = 7
        }, {
            x = 1253,
            y = 748,
            z = 7
        }, {
            x = 1256,
            y = 749,
            z = 7
        }},
        [2] = {{
            x = 1447,
            y = 566,
            z = 8
        }, {
            x = 1452,
            y = 567,
            z = 8
        }, {
            x = 1455,
            y = 561,
            z = 7
        }, {
            x = 1457,
            y = 556,
            z = 7
        }, {
            x = 1456,
            y = 552,
            z = 7
        }, {
            x = 1455,
            y = 550,
            z = 7
        }},
        [3] = {{
            x = 1223,
            y = 656,
            z = 6
        }, {
            x = 1222,
            y = 662,
            z = 7
        }, {
            x = 1221,
            y = 667,
            z = 7
        }, {
            x = 1221,
            y = 672,
            z = 7
        }, {
            x = 1225,
            y = 674,
            z = 7
        }},
        [4] = {{
            x = 1124,
            y = 562,
            z = 7
        }, {
            x = 1121,
            y = 567,
            z = 7
        }, {
            x = 1118,
            y = 572,
            z = 7
        }, {
            x = 1115,
            y = 575,
            z = 7
        }, {
            x = 1112,
            y = 575,
            z = 7
        }, {
            x = 1110,
            y = 576,
            z = 7
        }}
    },
    messageArriveCityEng = "Now you're free to explore the Avatar! The city has some weak underground monsters, explore a little and you'll find them.",
    messageArriveCityBr = "Agora você está livre para explorar o mundo de Avatar! A cidade possui alguns monstros com força iniciante em seu subsolo, explore um pouco e você os achará.",
    messageTargetEng = "When you find a monster, click with the right button and select the option 'attack'. After killing it, you can open the corpse by clicking and selecting the option 'open'. Have a nice game!",
    messageTargetBr = "Quando encontrar um monstro, clique com o botão direito e selecione a opção 'atacar'. Após matá-lo, você poderá abrir o corpo com o botão direito, selecionando a opção 'abrir', e depois arrastar os itens para a sua backpack. Tenha um bom jogo!",
    messageTalkNpcEng = "Type 'hi' close from an NPC to start a conversation.",
    messageTalkNpcBr = "Envie 'oi' próximo a um NPC para iniciar uma conversa.",
    messageStartBoatBr = {
        [1] = "Chegamos. Siga o percurso para encontrar a senhora do fogo Izumi, mostre-a que merece fazer parte da nação do fogo! Seja rápido, não temos muito tempo, a lava já está cobrindo a nossa saída..",
        [2] = "Chegamos. Siga ao sul para encontrar a chefe Eska, mostre-a que merece fazer parte da tribo da água!",
        [3] = "Chegamos. Siga ao norte para encontrar o mestre Tenzin, mostre-o que merece ser um nômade do ar!",
        [4] = "Chegamos. Siga o percurso para encontrar a comandante Kuvira, mostre-a que merece fazer parte do reino da terra!"
    },
    messageStartBoatEng = {
        [1] = "We arrived. Follow the path to find the fire lord Izumi, show that you deserve to be part of the fire nation! Be quick, we don't have much time, the lava is closing our way out..",
        [2] = "We arrived. Follow the south path to find the chief Eska, show that you deserve to be part of the water tribe!",
        [3] = "We arrived. Follow the north path to find the master Tenzin, show that you deserve to be a air nomad!",
        [4] = "We arrived. Follow the path to find the commander Kuvira, show that you deserve to be part of the earth kingdom!"
    },
    startBoatPos = {
        [1] = {
            x = 1256,
            y = 749,
            z = 7
        },
        [2] = {
            x = 1455,
            y = 550,
            z = 7
        },
        [3] = {
            x = 1225,
            y = 674,
            z = 7
        },
        [4] = {
            x = 1110,
            y = 576,
            z = 7
        }
    }
}

local events = {"hasImuneable", "onAdvancePoint", "flySystem", "GuildEvents", "killTask", "loot", "onMoveItem", "onSee",
                "deathChecks", "deathGamesCheck", "onDirection", "onTextEdit", "Idle", "Mail", "ReportBug",
                "SkullCheck", "onAddInjustInPlayer", "onGainExp", "castSpell", "onChangeOutfit", "combats", "pushs",
                "onmount", "prepareCheck", "combatss", "ExtendedOpcode", "onTradeStart", "onjogar", "trainer",
                "onAttackAvatar", "Inquisition"}

function registerEvents(cid)
    for _, event in pairs(events) do
        registerCreatureEvent(cid, event)
    end
end

function sendBonusExpIfNeed(cid)
    if getPlayerStorageValue(cid, "hasInPotionExp") > os.time() then
        local time = getPlayerStorageValue(cid, "hasInPotionExp") - os.time()
        if getPlayerStorageValue(cid, "Archangel") ~= 1 then
            doPlayerSetExperienceRate(cid, 3.6)
        else
            doPlayerSetExperienceRate(cid, 4.2)
        end
        addEvent(removePotionExp, time * 1000, cid)
    end
end

function sendTestEquipamentsIfActive(cid)
    --[[
    if serverInTest then
        if getPlayerStorageValue(cid, "testMoney") == -1 then
            sendBlueMessage(cid, "Atenção! Servidor em teste, você recebeu 1kk e 30 dias de premium account. Qualquer informação sobre balanceamento e bugs é util para nós. Servidor está com rate 3x.")
            doPlayerAddItem(cid, 2160, 100)
            doPlayerAddPremiumDays(cid, 30)
            setPlayerStorageValue(cid, "testMoney", 1)
        end
    else
        print("MIRTO TIRA ISSO DO LOGIN :D")
    end]]
end

function sendBlessIfActive(cid)
    local bless = getPlayerStorageValue(cid, "blessExp")
    local expLoss = getPlayerStorageValue(cid, "expBeforeDie") - getPlayerExperience(cid)
    local expToWin = expLoss
    local supremeBless = getPlayerStorageValue(cid, "playerWithSupremeBless")

    if bless > 0 then
        if supremeBless > 0 then
            expToWin = expLoss
        else
            expToWin = (expLoss / 2)
        end

        if expToWin > 0 then
            doPlayerAddExperience(cid, math.floor(expToWin))
            if supremeBless > 0 then
                setPlayerStorageValue(cid, "playerWithSupremeBless", -1)
                local text = getLangString(cid,
                    "You have lost the supreme bless, but all your experience lost has been recovered!",
                    "Você acabou de perder a benção suprema, entretanto você teve toda sua exp perdida recuperada!")
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, text)
            else
                local text = getLangString(cid,
                    "You has lost the bless of %s, but half of experience lost has been recovered!",
                    "Você acabou de perder a benção de %s, entretanto você teve metade da exp perdida recuperada.")
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR,
                    string.format(text, getPlayerStorageValue(cid, "blessExpName")))
            end
            setPlayerStorageValue(cid, "blessExp", -1)
        end
    end

    setPlayerHasDeath(cid, "unknow", expToWin, bless > 0)
    setPlayerStorageValue(cid, "expBeforeDie", -1)
end

local initialItens = {
    normalItens = {{
        itemid = 13734,
        amount = 1,
        slot = CONST_SLOT_FEET
    }, {
        itemid = 13733,
        amount = 1,
        slot = CONST_SLOT_LEGS
    }, {
        itemid = 13732,
        amount = 1,
        slot = CONST_SLOT_ARMOR
    }, {
        itemid = 13412,
        amount = 1,
        slot = CONST_SLOT_RIGHT
    }, {
        itemid = 2389,
        amount = 7,
        slot = CONST_SLOT_LEFT
    }, {
        itemid = 1998,
        amount = 1,
        slot = CONST_SLOT_BACKPACK
    }, {
        itemid = 7379,
        amount = 1,
        slot = CONST_SLOT_BACKPACK
    }, {
        itemid = 3963,
        amount = 1,
        slot = CONST_SLOT_BACKPACK
    }, {
        itemid = 2428,
        amount = 1,
        slot = CONST_SLOT_BACKPACK
    }, {
        itemid = 2002,
        amount = 1,
        slot = CONST_SLOT_BACKPACK
    }},
    vocItens = {{{
        itemid = 13731,
        amount = 1,
        slot = CONST_SLOT_HEAD
    }}, {{
        itemid = 13731,
        amount = 1,
        slot = CONST_SLOT_HEAD
    }, {
        itemid = 4864,
        amount = 1,
        slot = CONST_SLOT_AMMO,
        waterFull = true
    }, {
        itemid = 4864,
        amount = 1,
        slot = CONST_SLOT_BACKPACK,
        waterFull = true
    }, {
        itemid = 4864,
        amount = 1,
        slot = CONST_SLOT_BACKPACK,
        waterFull = true
    }}, {{
        itemid = 13731,
        amount = 1,
        slot = CONST_SLOT_HEAD
    }}, {{
        itemid = 13731,
        amount = 1,
        slot = CONST_SLOT_HEAD
    }}},

    slots = {CONST_SLOT_HEAD, CONST_SLOT_NECKLACE, CONST_SLOT_ARMOR, CONST_SLOT_RIGHT, CONST_SLOT_LEFT, CONST_SLOT_LEGS,
             CONST_SLOT_FEET, CONST_SLOT_RING, CONST_SLOT_AMMO},
}

function sendInitialItens(cid)
    local playerVoc = getPlayerVocation(cid)

    if playerVoc == 0 then
        return true
    end

    if getPlayerStorageValue(cid, "playerHasGetInitialItens") == 1 then
        return true
    end

    for x = 1, #initialItens.slots do
        local possibleItemInSlot = getPlayerSlotItem(cid, initialItens.slots[x]).uid
        if possibleItemInSlot > 0 then
            doRemoveItem(possibleItemInSlot)
        end
    end

    for x = 1, #initialItens.normalItens do
        doPlayerAddItem(cid, initialItens.normalItens[x].itemid, initialItens.normalItens[x].amount, false,
            initialItens.normalItens[x].slot)
    end

    for x = 1, #initialItens.vocItens[playerVoc] do
        local itemUid = doPlayerAddItem(cid, initialItens.vocItens[playerVoc][x].itemid,
            initialItens.vocItens[playerVoc][x].amount, false, initialItens.vocItens[playerVoc][x].slot)
        setItemWaterFullByBorean(itemUid, initialItens.vocItens[playerVoc][x].waterFull)
    end

    setPlayerStorageValue(cid, "playerHasGetInitialItens", 1)
end

function sendAllCheckFunctions(cid)
    sendInitialItens(cid)
    --sendBackupToPlayer(cid)
    setPlayerStorageValue(cid, "getAwnserAntiBot", -1) -- antiBot System
    setPlayerStorageValue(cid, "currentCid", cid)
end

-- funcs de reset, retiradas--
local function returnStatsPoints(cid)
    local playerElement = getPlayerElement(cid)
    local pointsUsed = (getPointsWasted(cid, "health") + getPointsWasted(cid, "mana") + getPointsWasted(cid, "bend") +
                           getPointsWasted(cid, "dodge")) + getPlayerElementPoints(cid, playerElement)

    --[[for x = 1, 120 do
        if getPlayerStorageValue(cid, "onGainPointsLv"..x) == 1 then
            pointsLevel = pointsLevel+1
        end
    end--]]

    local pointsLevel = getPlayerLevel(cid) - 1
    local totalPoints = pointsLevel + getPointsUsedInSkill(cid, "stones")

    if totalPoints ~= pointsUsed then
        if getPlayerStorageValue(cid, "hasResetedBug2") == -1 then
            local msg = {
                en = "",
                pt = ""
            }

            if pointsUsed < totalPoints then
                msg.en = "BUG Correct: " .. (totalPoints - pointsUsed) ..
                             " elemental points returned to you, use in NPC Sthuart."
                msg.pt = "Correção BUG: " .. (totalPoints - pointsUsed) ..
                             " ponto(s) elementa(is) foram devolvidos á você, use no NPC Sthuart."
                doPlayerSetElementPoints(cid, playerElement,
                    getPlayerElementPoints(cid, playerElement) + (totalPoints - pointsUsed))
            else
                msg.en = "BUG Correct: All your stats have been reset, please go to NPC Sthuart for redistribute it."
                msg.pt =
                    "Correção BUG: Todos seus stats foram resetados, por favor vá até o NPC Sthuart para redistribuir."

                setPlayerMagLevel(cid, 10)

                setCreatureMaxHealth(cid, getCreatureMaxHealth(cid) - getPointsUsedInSkill(cid, "health"))
                setCreatureMaxMana(cid, getCreatureMaxMana(cid) - getPointsUsedInSkill(cid, "mana"))
                doCreatureAddHealth(cid, -getCreatureHealth(cid) + getCreatureMaxHealth(cid))
                doCreatureAddMana(cid, -getCreatureMana(cid) + getCreatureMaxMana(cid))

                setPlayerStorageValue(cid, "AttributesPointsInDodge", -1)
                setPlayerStorageValue(cid, "AttributesPointsInHealth", -1)
                setPlayerStorageValue(cid, "AttributesPointsInMana", -1)
                setPlayerStorageValue(cid, "AttributesPointsInBendLevel", -1)

                doPlayerSetElementPoints(cid, playerElement, totalPoints)
            end

            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, getLangString(cid, msg.en, msg.pt))
            setPlayerStorageValue(cid, "hasResetedBug2", 1)
        end
    end
end

local function tutorialCity(cid)
    if not isCreature(cid) then
        return false
    end
    doPlayerSendTextMessage(cid, 22,
        getLangString(cid, noobTutorial.messageArriveCityEng, noobTutorial.messageArriveCityBr))
    setPlayerStorageValue(cid, "finishedTutorial", 2)
    addEvent(function(cid)
        if isCreature(cid) then
            doPlayerSendTextMessage(cid, 22,
                getLangString(cid, noobTutorial.messageTargetEng, noobTutorial.messageTargetBr))
        end
    end, 8000, cid)
end

local function tryHiTip(cid)
    if getPlayerStorageValue(cid, "alreadyhitip") ~= 1 then
        doPlayerSendTextMessage(cid, 22,
            getLangString(cid, noobTutorial.messageTalkNpcEng, noobTutorial.messageTalkNpcBr))
        setPlayerStorageValue(cid, "alreadyhitip", 1)
    end
    return false
end

local function tutorialIsland(cid)
    if not isCreature(cid) then
        return false
    end
    if getPlayerStorageValue(cid, "finishedTutorial") == 1 then -- already leave island
        tutorialCity(cid)
        return false
    end
    if getPlayerStorageValue(cid, "tutorialback") ~= 1 then -- coming
        local comingTable = noobTutorial.posesToArrowComing[getPlayerVocation(cid)]
        local myPos = getCreaturePosition(cid)
        for i = 0, #comingTable - 1 do
            local posAlvo = comingTable[#comingTable - i]
            if getDistanceBetween(myPos, posAlvo) <= 5 then
                if i == 0 then
                    if getDistanceBetween(myPos, posAlvo) > 2 then
                        doSendMagicEffect({
                            x = posAlvo.x - 1,
                            y = posAlvo.y - 1,
                            z = posAlvo.z
                        }, 55, cid)
                    end
                    tryHiTip(cid)
                else
                    doSendMagicEffect(posAlvo, 56, cid)
                    doSendMagicEffect(posAlvo, 55, cid)
                end
                break
            end
        end
    else -- leaving
        local leavingTable = noobTutorial.posesToArrowLeaving[getPlayerVocation(cid)]
        local myPos = getCreaturePosition(cid)
        for i = 0, #leavingTable - 1 do
            local posAlvo = leavingTable[#leavingTable - i]
            if getDistanceBetween(myPos, posAlvo) <= 5 then
                if i == 0 then
                    if getDistanceBetween(myPos, posAlvo) > 2 then
                        doSendMagicEffect({
                            x = posAlvo.x - 1,
                            y = posAlvo.y - 1,
                            z = posAlvo.z
                        }, 55, cid)
                    end
                else
                    doSendMagicEffect(posAlvo, 56, cid)
                    doSendMagicEffect(posAlvo, 55, cid)
                end
                break
            end
        end
    end
    addEvent(tutorialIsland, 3000, cid)
end

local function boartStartTalk(cid, npc)
    if not isCreature(cid) then
        return false
    end
    local vocId = getPlayerVocation(cid)
    local mensagem = getLangString(cid, noobTutorial.messageStartBoatEng[vocId], noobTutorial.messageStartBoatBr[vocId])
    doCreatureSay(npc, mensagem, 5, false, cid)
end

local function normalizeNumberStorage(cid)
    if getPlayerStorageValue(cid, "addedPointsMore2") == -1 then
        setPlayerStorageValue(cid, "AttributesPointsInStones", -1)

        local result = db.getResult(
            'SELECT * FROM  `web_ats_shop_historico` WHERE  `status` =  "entregue" AND `produto_type` = "pontos" AND `to_player` = "' ..
                getPlayerGUID(cid) .. '"')
        local pointsMore = 0

        if result:getID() ~= -1 then
            pointsMore = result:getDataInt("produto_quantidade")
        end

        pointsMore = pointsMore + getPlayerDailysCompleted(cid)
        addPointsInSkill(cid, "stones", pointsMore)

        setPlayerStorageValue(cid, "addedPointsMore2", 1)
    end
end

local function checkArchangel(cid)

    return true
end

function getDailysByTime(cid)
    --    local canDoAgain = checkDelayIsFree(cid)
    --    if canDoAgain.state then
    --		return 0 
    --	end 
    local total = 0
    local storages = {"TimeDailyUm", "TimeDailyDois", "TimeDailyTres", "TimeDailyQuatro"}
    for i = 1, #storages do
        if os.time() < getPlayerStorageValue(cid, storages[i]) then
            total = total + 1
        end
    end
    return total
end

local conditionE = createConditionObject(CONDITION_INFIGHT)
setConditionParam(conditionE, CONDITION_PARAM_TICKS, 6000)

-- 1 fire, 2 water, 3 air, 4 earth
local vocOuts = {{ -- MALE
{388, 718, 732}, {368, 720, 721, 723}, {457, 715, 730, 735}, {371, 716, 722}}, { -- FEMALE
{383, 717, 725, 728}, {387, 719, 727, 731}, {456, 714, 726, 734}, {384, 713, 724}}}

local function imNotAvatar(cid)
    local inStorage = getStorage(73991)
    if inStorage > 0 then
        local theAvatar = getPlayerByNameWildcard(getPlayerNameByGUID(inStorage))
        if theAvatar and theAvatar == cid then
            return false
        end
    end
    return true
end

local function calculateSetRegen(cid)
    local totalRegen = 0
    local slots = {1, 4, 7, 8}
    for i = 1, #slots do
        local equip = getPlayerSlotItem(cid, slots[i]).uid
        if equip ~= 0 then
            local runeType = getItemAttribute(equip, 'elementalrunetype')
            local runeLevel = getItemAttribute(equip, 'elementalrunelevel')
            if runeType == 2 and runeLevel > 0 and runeLevel < 5 then
                local percentByLevel = {0.008, 0.012, 0.016, 0.020}
                totalRegen = totalRegen + (getCreatureMaxHealth(cid) * percentByLevel[runeLevel])
            end
        end
    end
    return totalRegen
end

local function doRuneRegeneration(cid, sequenceCount, lastRegenCount)
    if not isCreature(cid) then
        return true
    end
    local newRegenCount = calculateSetRegen(cid)
    if sequenceCount == 5 and lastRegenCount and newRegenCount == lastRegenCount and newRegenCount > 0 then
        sequenceCount = 0
        doCreatureAddHealth(cid, newRegenCount, 1)
        -- doTargetCombatHealth(0, cid, newRegenCount, newRegenCount, -1, false)
    end
    if (not lastRegenCount and newRegenCount > 0) or (lastRegenCount == newRegenCount) then
        sequenceCount = sequenceCount + 1
    else
        sequenceCount = 1
    end

    if newRegenCount < 1 then
        sequenceCount = 1
    end
    addEvent(doRuneRegeneration, 1000, cid, sequenceCount, newRegenCount)
end

function onLogin(cid)
    if getPlayerVocation(cid) == 0 or getPlayerVocation(cid) > 4 then
        if getPlayerStorageValue(cid, "exaustedfirewhip") > 1000 then
            doPlayerSetVocation(cid, 1)
        elseif getPlayerStorageValue(cid, "exaustedwaterwhip") > 1000 then
            doPlayerSetVocation(cid, 2)
        elseif getPlayerStorageValue(cid, "exaustedairball") > 1000 then
            doPlayerSetVocation(cid, 3)
        elseif getPlayerStorageValue(cid, "exaustedearthcrush") > 1000 then
            doPlayerSetVocation(cid, 4)
        end
    end

	-- TODO: review
    -- Reward.setTime(cid)
    -- Reward.sendRewards(cid)

    if getPlayerStorageValue(cid, "canAttackable") == 1 then
        setPlayerStorageValue(cid, "canAttackable", 0)
        setPlayerStorageValue(cid, "Archangel", 0)
    end
    if imNotAvatar(cid) then
        setPlayerStorageValue(cid, "isAvatar", 0)
    else
        setPlayerStorageValue(cid, "isAvatar", 1)
        local avatarPos = getCreaturePosition(cid)
        doSendMagicEffect({
            x = avatarPos.x + 1,
            y = avatarPos.y + 1,
            z = avatarPos.z
        }, 134)
        doSendMagicEffect({
            x = avatarPos.x + 1,
            y = avatarPos.y + 1,
            z = avatarPos.z
        }, 135)
        doSendMagicEffect({
            x = avatarPos.x + 1,
            y = avatarPos.y + 1,
            z = avatarPos.z
        }, 121)
    end

    if getCreatureMaxHealth(cid, true) > getRealMaxHp(cid) then
        local old = getCreatureMaxHealth(cid, true)
        local new = getRealMaxHp(cid)
        setCreatureMaxHealth(cid, new)
        doCreatureAddHealth(cid, old - new, 1)
    elseif getCreatureMaxHealth(cid, true) < getRealMaxHp(cid) then
        local old = getCreatureMaxHealth(cid, true)
        local new = getRealMaxHp(cid)
        setCreatureMaxHealth(cid, new)
    end

    if getCreatureMaxMana(cid, true) ~= getRealMaxMana(cid) then
        local old = getCreatureMaxMana(cid, true)
        local new = getRealMaxMana(cid)
        setCreatureMaxMana(cid, new)
    end
    if getCreatureHealth(cid) > getCreatureMaxHealth(cid) then
        doCreatureAddHealth(cid, -(getCreatureHealth(cid) - getCreatureMaxHealth(cid)))
    end
    if getCreatureMana(cid) > getCreatureMaxMana(cid) then
        doCreatureAddMana(cid, -(getCreatureMana(cid) - getCreatureMaxMana(cid)))
    end

    --local vocId, sexId = getPlayerVocation(cid), getPlayerSex(cid)
    --local outList = vocOuts[2 - sexId][vocId]
    --	for i = 1, #outList do
    --		if not canPlayerWearOutfit(cid, outList[i], 0) then 
    --			doPlayerAddOutfit(cid, outList[i], 0)
    --		end
    --	end
    --	if (vocId ~= 3 and canPlayerWearOutfit(cid, 457, 0)) or getCreatureOutfit(cid).lookType == 75 then 	
    --		local outfit = getCreatureOutfit(cid)
    --		outfit.lookType = outList[2]
    --		doCreatureChangeOutfit(cid, outfit)	
    --		doPlayerRemoveOutfit(cid, 457)	
    --	end 
    --	if (vocId ~= 3 and canPlayerWearOutfit(cid, 456, 0))then 	
    --		local outfit = getCreatureOutfit(cid)
    --		outfit.lookType = outList[2]
    --		doCreatureChangeOutfit(cid, outfit)	
    --		doPlayerRemoveOutfit(cid, 456)	
    --	end 

    local lastLogin = getPlayerLastLoginSaved(cid)
    if getPlayerItemCount(cid, 9775) ~= 0 then
        doPlayerRemoveItem(cid, 9775, 1)
    end
    if getPlayerStorageValue(cid, "morreuD") == 1 then
        setPlayerStorageValue(cid, "morreuD", -1)
        doPlayerSendTextMessage(cid, 22, getLangString(cid, config.protectMessageEN, config.protectMessagePT))
    end
    addEvent(doRuneRegeneration, 1000, cid.uid, 1)
    if getPlayerStorageValue(cid, "AttributesPointsInDodge") == -1 then
        setPlayerStorageValue(cid, "AttributesPointsInDodge", 0)
    end
    if getPlayerStorageValue(cid, "AttributesPoints") == -1 then
        if getPlayerStorageValue(cid, "FirstAttributesPoints") ~= 1 then
            setPlayerStorageValue(cid, "FirstAttributesPoints", 1)
            setPlayerStorageValue(cid, "AttributesPoints", 5)
        else
            setPlayerStorageValue(cid, "AttributesPoints", 0)
        end
    end
    local agi = math.max(0, getPlayerStorageValue(cid, "AttributesPointsInDodge"))
    doChangeSpeed(cid, (agi * 6) + getParagonExtraSpeed(cid))
	local vocId = getPlayerVocation(cid)

    if getPlayerAccess(cid) >= 5 then
        vocId = vocId + 1
        if vocId > 4 then
            vocId = 1
        end
        doPlayerSetVocation(cid, vocId)
    else
        local posicao = getThingPos(cid)
        doSendMagicEffect({
            x = posicao.x + 1,
            y = posicao.y + 1,
            z = posicao.z
        }, 119)
    end

	if (lastLogin > 0) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT,
			getLangString(cid, "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. ".",
				"Sua ultima visita foi em " .. os.date("%a %b %d %X %Y", lastLogin) .. "."))
	end

	if (getPlayerStorageValue(cid, "tutorialback") ~= 1) and (getPlayerVocation(cid) == 1) then
		doPlayerAddOutfitId(cid, 1, 3)
		local initOuts = {1020, 1025}
		doCreatureChangeOutfit(cid, {
			lookType = initOuts[getPlayerSex(cid) + 1],
			lookHead = 115,
			lookBody = 114,
			lookFeet = 0,
			lookLegs = 68
		})
	end

	if (getPlayerStorageValue(cid, "tutorialback") ~= 1) and (getPlayerVocation(cid) == 2) then
		doPlayerAddOutfitId(cid, 6, 3)
		local initOuts = {1040, 1045}
		doCreatureChangeOutfit(cid, {
			lookType = initOuts[getPlayerSex(cid) + 1],
			lookHead = 115,
			lookBody = 114,
			lookFeet = 0,
			lookLegs = 68
		})
	end

	if (getPlayerStorageValue(cid, "tutorialback") ~= 1) and (getPlayerVocation(cid) == 3) then
		doPlayerAddOutfitId(cid, 11, 3)
		local initOuts = {1060, 1065}
		doCreatureChangeOutfit(cid, {
			lookType = initOuts[getPlayerSex(cid) + 1],
			lookHead = 115,
			lookBody = 114,
			lookFeet = 0,
			lookLegs = 68
		})
	end

	if (getPlayerStorageValue(cid, "tutorialback") ~= 1) and (getPlayerVocation(cid) == 4) then
		doPlayerAddOutfitId(cid, 16, 3)
		local initOuts = {1080, 1085}
		doCreatureChangeOutfit(cid, {
			lookType = initOuts[getPlayerSex(cid) + 1],
			lookHead = 115,
			lookBody = 114,
			lookFeet = 0,
			lookLegs = 68
		})
	end

	sendAllCheckFunctions(cid)
	if getPlayerStorageValue(cid, "tutorialback") ~= 1 and
		getDistanceBetween(getCreaturePosition(cid), noobTutorial.startBoatPos[vocId]) <= 4 then
		local posNpc = noobTutorial.startBoatPos[vocId]
		if isNpc(getTopCreature(posNpc).uid) then
			addEvent(boartStartTalk, 2000, cid, getTopCreature(posNpc).uid)
		end
	end

    if (getPlayerVocation(cid) == 1) and (getPlayerPremiumDays(cid) > 0) then
        doPlayerAddOutfitId(cid, 29, 3)
    elseif (getPlayerVocation(cid) == 2) and (getPlayerPremiumDays(cid) > 0) then
        doPlayerAddOutfitId(cid, 33, 3)
    elseif (getPlayerVocation(cid) == 3) and (getPlayerPremiumDays(cid) > 0) then
        doPlayerAddOutfitId(cid, 35, 3)
    elseif (getPlayerVocation(cid) == 4) and (getPlayerPremiumDays(cid) > 0) then
        doPlayerAddOutfitId(cid, 40, 3)
    end

    --[[ TODO: review
		if getPlayerPremiumDays(cid) == 0 then
        doPlayerRemoveOutfitId(cid, 29)
        doPlayerRemoveOutfitId(cid, 33)
        doPlayerRemoveOutfitId(cid, 35)
        doPlayerRemoveOutfitId(cid, 40)
    end]]

    if getPlayerStorageValue(cid, "finishedTutorial") ~= 2 then
        if getPlayerStorageValue(cid, "finishedTutorial") ~= 1 then
            tutorialIsland(cid.uid)
        else
            tutorialCity(cid.uid)
        end
    end

    local orbita = getStorage(57302)
    if type(orbita) == "number" then
        if orbita == 1 then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                "O Cometa de Sozin está afetando o mundo Avatar, os dobradores de Fogo estão fortificados com 20% de dano extra em suas dobras.")
        elseif orbita == 2 then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                "A Lua Cheia está presente no mundo Avatar, os dobradores de Água estão fortificados com 20% de dano extra em suas dobras.")
        elseif orbita == 3 then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                "O Eclipse Lunar está acontecendo, os dobradores de Água e Fogo estão enfraquecidos com 20% de dano reduzido em suas dobras.")
        end
    end                            --Flag para arrumar outfit;
    registerEvents(cid) -- Registra todos eventos;
    saida.login(cid) -- FlySystem, faz checagems, teleport, etc;
    sendBlessIfActive(cid) -- Manda bless exp, se ativa;
    setPlayerStorageValue(cid, "playerCanMoveDirection", -1) -- Tira bloqueio de movimento para os lados;

    if getPlayerStorageValue(cid, "hasActiveInQuest") == 1 then
        doTeleportThing(cid, getPosInStorage(cid, "genericQuestPos"))
        setPlayerStorageValue(cid, "hasActiveInQuest", -1)
    end

    --[[ TODO: review 
	local bcExhaust = getStorage(52341)
    local onlineCount = #getPlayersOnline()
    if onlineCount >= 400 then
        if onlineCount == 400 and type(bcExhaust) == "number" and bcExhaust <= os.time() then
            doSetStorage(52341, os.time() + 1800)
            doBroadcastMessage(
                "O servidor atingiu a incrível meta de 500 jogadores online e agora os jogadores estão com +50% de experiência bônus!",
                MESSAGE_STATUS_CONSOLE_BLUE)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                getLangString(cid, "There are 500 players online and all players received +50% exp bonus to celebrate!",
                    "O servidor atingiu a incrível meta de 500 jogadores online e agora os jogadores estão com +50% de experiência bônus!"))
        end
    elseif onlineCount >= 300 then
        if onlineCount == 300 and type(bcExhaust) == "number" and bcExhaust <= os.time() then
            doSetStorage(52341, os.time() + 1800)
            doBroadcastMessage(
                "A meta de 400 jogadores online foi atingida e agora os jogadores estão com +40% de experiência bônus!",
                MESSAGE_STATUS_CONSOLE_BLUE)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                getLangString(cid, "There are 400 players online and all players received +40% exp bonus to celebrate!",
                    "A meta de 400 jogadores online foi atingida e agora os jogadores estão com +40% de experiência bônus!"))
        end
    elseif onlineCount >= 200 then
        if onlineCount == 200 and type(bcExhaust) == "number" and bcExhaust <= os.time() then
            doSetStorage(52341, os.time() + 1800)
            doBroadcastMessage(
                "A meta de 300 jogadores online foi atingida e agora os jogadores estão com +30% de experiência bônus!",
                MESSAGE_STATUS_CONSOLE_BLUE)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                getLangString(cid, "There are 300 players online and all players received +20% exp bonus to celebrate!",
                    "A meta de 300 jogadores online foi atingida e agora os jogadores estão com +30% de experiência bônus!"))
        end
    elseif onlineCount >= 100 then
        if onlineCount == 100 and type(bcExhaust) == "number" and bcExhaust <= os.time() then
            doSetStorage(52341, os.time() + 1800)
            doBroadcastMessage(
                "A meta de 200 jogadores online foi atingida e agora os jogadores estão com +20% de experiência bônus!",
                MESSAGE_STATUS_CONSOLE_BLUE)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                getLangString(cid, "There are 200 players online and all players received +20% exp bonus to celebrate!",
                    "A meta de 200 jogadores online foi atingida e agora os jogadores estão com +20% de experiência bônus!"))
        end
    elseif onlineCount >= 40 then
        if onlineCount == 40 and type(bcExhaust) == "number" and bcExhaust <= os.time() then
            doSetStorage(52341, os.time() + 1800)
            doBroadcastMessage(
                "A meta de 100 jogadores online foi atingida e agora os jogadores estão com +10% de experiência bônus!",
                MESSAGE_STATUS_CONSOLE_BLUE)
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,
                getLangString(cid, "There are 100 players online and all players received +10% exp bonus to celebrate!",
                    "A meta de 100 jogadores online foi atingida e agora os jogadores estão com +10% de experiência bônus!"))
        end
    end]]
    return true
end
