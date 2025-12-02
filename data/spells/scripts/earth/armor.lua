local outfitDelay = 500
local animationEffectId = {113, 78}
local animationOutfit = {
    lookType = 1092,
    lookHead = 0,
    lookBody = 0,
    lookLegs = 0,
    lookFeet = 0,
    lookTypeEx = 0,
    lookAddons = 0
}

local spellName = "earth armor"
local cf = {
    duracao = spellsInfo[spellName].duracao
}

local MyLocal = {}
MyLocal.players = {}

local conditionOutfit = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionOutfit, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionOutfit, animationOutfit)

local function removeTable(cid, exaust)
    if exaust then
        if getDobrasLevel(cid) >= 21 then
            -- doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor-14)
        else
            -- doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor)
        end
    end
    MyLocal.players[cid] = nil
end

local function sendsArmorionEffect(cid, id)
    if not isCreature(cid) or not exhaustion.check(cid, "earthArmorActive") then
        if isCreature(cid) and not getPlayerInWater(cid) then
            doRemoveCondition(cid, CONDITION_OUTFIT)
        end
        return false
    end

    if id < cf.duracao then
        setCreatureNoMoveTime(cid, 300)
        addEvent(sendsArmorionEffect, 250, cid, id + 250)
    else
        removeTable(cid, true)
        if not getPlayerInWater(cid) then
            doRemoveCondition(cid, CONDITION_OUTFIT)
        end
    end
end

local function setAnimationOutfit(cid)
    if not isCreature(cid) or not exhaustion.check(cid, "earthArmorActive") then
        return false
    end

    if not getPlayerInWater(cid) then
        doAddCondition(cid, conditionOutfit)
    end
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if getPlayerInWater(cid) then
        doPlayerSendCancel(cid, getLangString(cid, "You can't use earth armor inside the water.",
            "Você n?o pode usar essa dobra na água."))
        return false
    end
    if getCreatureCondition(cid, CONDITION_OUTFIT) then
        doPlayerSendCancel(cid, getLangString(cid, "You can't use earth armor right now.",
            "Você n?o pode utilizar a earth armor agora."))
        return false
    end

    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if exhaustion.check(cid, "cantEarthArmor") then
        local timeLeft = exhaustion.get(cid, "cantEarthArmor")
        local secString = "seconds"
        if timeLeft <= 1 then
            timeLeft = 1
            secString = "second"
        end
        doPlayerSendCancel(cid, "You can't use Earth Armor immediately after Earth Leech. Wait " .. timeLeft .. " " ..
            secString .. ".")
        return false
    end
    if getDobrasLevel(cid) >= 21 then
        if (doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor - 14)) == false then
            return false
        end
    else
        if (doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor)) == false then
            return false
        end
    end
    if getPlayerHasStun(cid) then
        return true
    end
    exhaustion.set(cid, "earthArmorActive", 10)
    setPlayerHasImune(cid, cf.duracao / 1000)
    setCreatureNoMoveTime(cid, cf.duracao)
    local lookDir = getCreatureLookDirection(cid)
    sendsArmorionEffect(cid, 0)
    addEvent(setAnimationOutfit, outfitDelay, cid)
    doSendAnimatedText(getCreaturePosition(cid), "Invulnerable!", 120, cid)
    if lookDir == 0 or lookDir == 2 then
        doSendMagicEffect(getCreaturePosition(cid), animationEffectId[1])
    else
        doSendMagicEffect(getCreaturePosition(cid), animationEffectId[2])
    end
    if isPlayer(cid) and getPlayerStorageValue(cid, "nuncaUsouArmor") ~= 1 then
        setPlayerStorageValue(cid, "nuncaUsouArmor", 1)
        sendBlueMessage(cid,
            "Dica: Você pode sair do estado de defesa antes da duraç?o acabar utilizando a dobra Earth Fury, Earth Track ou Earth Cataclysm. É importante informar também que esta dobra não pode ser usada imediatamente após o Earth Leech, haverá uma recarga pequena de 4 segundos.")
    end
    return true
end
