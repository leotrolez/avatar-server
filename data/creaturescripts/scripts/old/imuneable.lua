local effects = {5, 86, 76, 36}

local config = {
    passiveWater = {
        healthGain = 0.25,
        delay = 3 * 60 * 60
    }
}

----------------------------------------------------------------------------
-- ARMOR PASSIVE SYSTEM

local function havePassiveChest(cid)
    return getPlayerSlotItem(cid, 4).itemid == 13402
end

local function havePassiveSet(cid)
    local slots = {
        [1] = 13401, -- helmet
        [4] = 13402, -- armor
        [7] = 13403, -- legs
        [8] = 13404 -- boots
    }
    local numbersSl = {1, 4, 7, 8}
    for i = 1, #numbersSl do
        if getPlayerSlotItem(cid, numbersSl[i]).itemid ~= slots[numbersSl[i]] then
            return false
        end
    end
    return true
end

local combatArmorAir = createCombatObject()
setCombatParam(combatArmorAir, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combatArmorAir, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
local combatArmorEarth = createCombatObject()
setCombatParam(combatArmorEarth, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combatArmorEarth, COMBAT_PARAM_EFFECT, 34)
local combatArmorFire = createCombatObject()
setCombatParam(combatArmorFire, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combatArmorFire, COMBAT_PARAM_EFFECT, 6)
local combatArmorWater = createCombatObject()
setCombatParam(combatArmorWater, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatArmorWater, COMBAT_PARAM_EFFECT, 53)

local combatArmorAir2 = createCombatObject()
setCombatParam(combatArmorAir2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combatArmorAir2, COMBAT_PARAM_EFFECT, CONST_ME_POFF)
local combatArmorEarth2 = createCombatObject()
setCombatParam(combatArmorEarth2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combatArmorEarth2, COMBAT_PARAM_EFFECT, 34)
local combatArmorFire2 = createCombatObject()
setCombatParam(combatArmorFire2, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combatArmorFire2, COMBAT_PARAM_EFFECT, 6)
local combatArmorWater2 = createCombatObject()
setCombatParam(combatArmorWater2, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combatArmorWater2, COMBAT_PARAM_EFFECT, 53)

local combatChestByElement = {combatArmorFire, combatArmorWater, combatArmorAir, combatArmorEarth}
local combatSetByElement = {combatArmorFire2, combatArmorWater2, combatArmorAir2, combatArmorEarth2}

local combatsArmor = {combatArmorAir, combatArmorEarth, combatArmorFire, combatArmorWater, combatArmorAir2,
                      combatArmorEarth2, combatArmorFire2, combatArmorWater2}

for i = 1, #combatsArmor do
    if i > 4 then
        setCombatArea(combatsArmor[i],
            createCombatArea(
                {{0, 0, 0, 0, 0, 0, 0}, {0, 0, 1, 1, 1, 0, 0}, {0, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 2, 1, 1, 0},
                 {0, 1, 1, 1, 1, 1, 0}, {0, 0, 1, 1, 1, 0, 0}}))
    else
        setCombatArea(combatsArmor[i],
            createCombatArea(
                {{0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0}, {0, 0, 1, 1, 1, 0, 0},
                 {0, 0, 1, 2, 1, 0, 0}, {0, 0, 1, 1, 1, 0, 0}}))
    end
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level + (magLevel / 3) * 2.7) + 5
        local max = (level + (magLevel / 3) * 3.0) + 5
        local dano = math.random(min, max)
        local atk = spellsInfo["air barrier"].atk
        if atk and type(atk) == "number" then
            dano = dano * (atk / 100)
            dano = dano + 1
        end
        dano = dano * 2
        if i > 4 then
            dano = dano * 2
        end
        return -dano, -dano
    end

    setCombatCallback(combatsArmor[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

----------------------------------------------------------------------------

local combatBarrier = createCombatObject()
setCombatParam(combatBarrier, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
local combatStriker = createCombatObject()
setCombatParam(combatStriker, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
local combatIceSpikes = createCombatObject()
setCombatParam(combatIceSpikes, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combatIceSpikes, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
local combatEarthSpikes = createCombatObject()
setCombatParam(combatEarthSpikes, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
local combates = {combatBarrier, combatStriker, combatEarthSpikes, combatIceSpikes}

for i = 1, #combates do
    if i == 2 then
        setCombatArea(combates[i],
            createCombatArea(
                {{0, 0, 0, 0, 0, 0, 0}, {0, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 3, 1, 1, 0},
                 {0, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 0}}))
    else
        setCombatArea(combates[i],
            createCombatArea(
                {{0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0}, {0, 0, 1, 1, 1, 0, 0},
                 {0, 0, 1, 3, 1, 0, 0}, {0, 0, 1, 1, 1, 0, 0}}))
    end
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level + (magLevel / 3) * 2.7) + 5
        local max = (level + (magLevel / 3) * 3.0) + 5
        local dano = math.random(min, max)
        local atk = spellsInfo["air barrier"].atk
        if atk and type(atk) == "number" then
            dano = dano * (atk / 100)
            dano = dano + 1
        end
        return -dano, -dano
    end

    setCombatCallback(combates[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end
local function effectsPqp(cid, pos, times)
    if not isCreature(cid) or isInPz(cid) then
        return false
    end
    local oldpos = getThingPos(cid)
    if oldpos.x ~= pos.x or oldpos.y ~= pos.y or oldpos.z ~= pos.z then
        doSendMagicEffect({
            x = oldpos.x + 1,
            y = oldpos.y + 1,
            z = oldpos.z
        }, 134)
    end
    if times > 1 then
        addEvent(effectsPqp, 50, cid, oldpos, times - 1)
    end
end

local function doAirBarrier(cid)
    exhaustion.set(cid, "AirBarrierReduction", 5)
    for i = 0, 10 do
        addEvent(function()
            if isCreature(cid) and not isInPz(cid) then
                local pos = getThingPos(cid)
                doSendMagicEffect({
                    x = pos.x + 1,
                    y = pos.y + 1,
                    z = pos.z
                }, 121)
                doSendMagicEffect({
                    x = pos.x + 1,
                    y = pos.y + 1,
                    z = pos.z
                }, 134)
                if i % 2 == 0 then
                    doCombat(cid, combatBarrier, {
                        type = 2,
                        pos = pos
                    })
                end
            end
        end, 500 * i)
    end
    effectsPqp(cid, getThingPos(cid), 100)
end

local function doFireStriker(cid)
    for i = 0, 6 do
        addEvent(function()
            if isCreature(cid) and not isInPz(cid) then
                local pos = getThingPos(cid)
                doCombat(cid, combatStriker, {
                    type = 2,
                    pos = pos
                })
            end
        end, 800 * i)
    end
end

local function doEarthSpikes(cid)
    for i = 0, 5 do
        addEvent(function()
            if isCreature(cid) and not isInPz(cid) then
                local pos = getThingPos(cid)
                doCombat(cid, combatEarthSpikes, {
                    type = 2,
                    pos = pos
                })
                for i = 1, 3 do
                    doSendMagicEffect({
                        x = pos.x + math.random(-1, 1),
                        y = pos.y + math.random(-1, 1),
                        z = pos.z
                    }, 96)
                end
            end
        end, 900 * i)
    end
end
local xizes1 = {0, -1, -1, 0} -- cima pra esquerda, esquerda pra baixo
local yizes1 = {-1, 0, 0, 1} -- cima pra esquerda, esquerda pra baixo
local xizes2 = {0, 1, 1, 0} -- baixo pra direita, direita pra cima
local yizes2 = {1, 0, 0, -1} -- baixo pra direita, direita pra cima
local function shardsWork(cid, state)
    if not isCreature(cid) or isInPz(cid) then
        return false
    end
    local pos = getCreaturePosition(cid)
    doSendDistanceShoot({
        x = pos.x + xizes1[state],
        y = pos.y + yizes1[state],
        z = pos.z
    }, {
        x = pos.x + xizes1[state + 1],
        y = pos.y + yizes1[state + 1],
        z = pos.z
    }, 28)
    doSendDistanceShoot({
        x = pos.x + xizes2[state],
        y = pos.y + yizes2[state],
        z = pos.z
    }, {
        x = pos.x + xizes2[state + 1],
        y = pos.y + yizes2[state + 1],
        z = pos.z
    }, 28)
    if state == 3 then
        state = -1
        local target = getCreatureTarget(cid)
        if isCreature(target) and getDistanceBetween(pos, getCreaturePosition(target)) <= 4 and
            isSightClear(pos, getCreaturePosition(target), true) then
            doCombat(cid, combatIceSpikes, numberToVariant(target))
        end
    end
    if exhaustion.get(cid, "AvatarMode") then
        addEvent(shardsWork, 150, cid, state + 2)
    end
end

local function doIceSpikes(cid)
    shardsWork(cid, 1)
end

local combatMiniRegen = createCombatObject()
setCombatParam(combatMiniRegen, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combatMiniRegen, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatArea(combatMiniRegen,
    createCombatArea({{0, 0, 1, 0, 0}, {0, 1, 1, 1, 0}, {1, 1, 3, 1, 1}, {0, 1, 1, 1, 0}, {0, 0, 1, 0, 0}}))

local function isInPvpZone(cid)
    local pos = getCreaturePosition(cid)
    if getTileInfo(pos).hardcore then
        return true
    end
    return false
end

local function isInSameGuild(cid, target)
    if isPlayer(cid) and isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
        local cidGuild = getPlayerGuildId(cid)
        local targGuild = getPlayerGuildId(target)
        if cidGuild > 0 and cidGuild == targGuild then
            return true
        end
    end
    return false
end

local function isNonPvp(cid)
    return isMonster(cid) or getPlayerStorageValue(cid, "canAttackable") == 1
end

function onTargetCreature(cid, target)
    if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or
        (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or
        (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then
        if isNonPvp(cid) and not isNonPvp(target) then
        else
            local heal = getPlayerMagLevel(cid) + (getPlayerLevel(cid) / 2)
            heal = heal + math.random(15, 30)
            local atk = spellsInfo["water heal"].atk
            if atk and type(atk) == "number" then
                heal = heal * (atk / 100)
                heal = heal + 1
            end
            doCreatureAddHealth(target, heal * 2)
        end
    end
end

setCombatCallback(combatMiniRegen, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function doMiniRegen(cid)
    if not isCreature(cid) then
        return false
    end
    return doCombat(cid, combatMiniRegen, {
        type = 2,
        pos = getCreaturePosition(cid)
    })
end

local combatMiniExp = createCombatObject()
setCombatParam(combatMiniExp, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level + (magLevel / 4) * 0.3
    local max = level + (magLevel / 4) * 0.7
    local dano = math.random(min, max)
    local atk = spellsInfo["air burst"].atk
    if atk and type(atk) == "number" then
        dano = dano * (atk / 100)
        dano = dano + 1
    end
    dano = dano * 2
    return -dano, -dano
end
setCombatCallback(combatMiniExp, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(cid, target)
    doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, isPlayer(cid))
end
setCombatCallback(combatMiniExp, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local miniExplosionArea = {{1, 1, 1}, {1, 2, 1}, {1, 1, 1}}
setCombatArea(combatMiniExp, createCombatArea(miniExplosionArea))
local function doMiniExplosion(cid)
    if not isCreature(cid) then
        return false
    end
    local mypos = getThingPos(cid)
    doSendMagicEffect({
        x = mypos.x + 1,
        y = mypos.y + 1,
        z = mypos.z
    }, 132)
    return doCombat(cid, combatMiniExp, {
        type = 2,
        pos = mypos
    })
end

----------------------------------------------------------------------------
local speed = createConditionObject(CONDITION_HASTE)
setConditionParam(speed, CONDITION_PARAM_TICKS, 5000)
setConditionFormula(speed, 0.9, -120, 0.9, -120)

local speedPromote = createConditionObject(CONDITION_HASTE)
setConditionParam(speedPromote, CONDITION_PARAM_TICKS, 3000)
setConditionFormula(speedPromote, 0.5, 0, 0.5, 0)

local function executePassive(cid, attacker)
    if getPlayerStorageValue(cid, "hasPassiveDeathActive") < os.time() and
        not getTileInfo(getCreaturePosition(cid)).hardcore and not getTileInfo(getCreaturePosition(cid)).optional then
        local element = getPlayerElement(cid)
        local passiveCd = config.passiveWater.delay
        local hpRec = config.passiveWater.healthGain

        if getPlayerStorageValue(cid, "revivelevel2") == 1 then
            hpRec = 0.5
            passiveCd = 2 * 60 * 60
        end
        if getPlayerResets(cid) >= 140 then
            passiveCd = passiveCd - (30 * 60)
        end

        doCreatureAddHealth(cid, getCreatureMaxHealth(cid) * hpRec)
        setPlayerStorageValue(cid, "hasPassiveDeathActive", os.time() + passiveCd)
        if getPlayerStorageValue(cid, "90519") == 1 then
            doSendAnimatedText(getThingPos(cid), "AVATAR MODE!", COLOR_LIGHTBLUE)
            exhaustion.set(cid, "AvatarMode", 5)
            doAirBarrier(cid)
            doFireStriker(cid)
            doEarthSpikes(cid)
            doIceSpikes(cid)
        else
            doSendMagicEffect(getThingPos(cid), effects[getPlayerVocation(cid)])
            doSendAnimatedText(getThingPos(cid), "REVIVED!", COLOR_LIGHTBLUE)
        end
        if element == "air" then
            doAddCondition(cid, speed)
        elseif element == "fire" then
            setPlayerOverPower(cid, "fire", 120)
        elseif element == "earth" then
            if isCreature(attacker) then
                setPlayerStuned(attacker, 3)
            end
        elseif element == "water" then
            setPlayerHasImune(cid, 3)
        end

        return true
    end

    return false
end

local rarods = {"Brown Rarod", "Swamp Rarod", "Flaming Rarod", "Frozen Rarod"}

local potions = {7618, 7588, 8473, 13366, 13367, 13368, 15014}

local function isInQuestRarods(cid)
    local pos = getCreaturePosition(cid)
    return pos.x > 870 and pos.x < 1070 and pos.y > 810 and pos.y < 968
end

local function haveReduction(cid)
    if exhaustion.check(cid, "AirBarrierReduction") or exhaustion.check(cid, "vortexProtection") or
        exhaustion.check(cid, "defBreak") then
        return true
    end
    return false
end

local function getValueAfterReduction(cid, value, isAttackerPlayer)
    if exhaustion.check(cid, "defBreak") then
        if isAttackerPlayer then
            value = value * 0.84
        else
            value = value * 1.25
        end
    end
    if exhaustion.check(cid, "vortexProtection") then
        value = value * 0.46
    end
    if exhaustion.check(cid, "AirBarrierReduction") then
        if getPlayerElement(cid) ~= "earth" then
            value = value * 0.40
        else
            value = value * 0.25
        end
    end
    return value
end

local function runeEffect(cid, attacker, combat)
    if isMonster(cid) or isMonster(attacker) then
        return true
    end
    if combat == COMBAT_METALDAMAGE or combat == COMBAT_ICEDAMAGE then
        local theStorage = tonumber(getPlayerStorageValue(attacker, "36295")) -- 2 is ranged
        if theStorage ~= 1 and theStorage ~= 2 then
            return true
        end
        setPlayerStorageValue(attacker, "36295", "0")
        if exhaustion.check(cid, "weaponEffImmune") then
            return true
        end
        local weaponLevel = tonumber(getPlayerStorageValue(attacker, "36296"))
        if weaponLevel <= 0 then
            weaponLevel = 1
        end
        if combat == COMBAT_METALDAMAGE then
            local chanceByLevel = {6, 12}
            local theChance = chanceByLevel[weaponLevel]
            if theStorage == 1 then
                theChance = theChance * 2
            end
            if math.random(1, 100) <= theChance then
                doSlow(0, cid, 40, 3000)
                exhaustion.set(cid, "weaponEffImmune", 6)
                addEvent(function(cid, text, color)
                    if isCreature(cid) then
                        doSendAnimatedText(getThingPos(cid), text, color)
                    end
                end, 300, cid, "Slowed!", COLOR_LIGHTBLUE)
            end
        elseif not isDisableImmune(cid) and not getCreatureNoMove(cid) then
            local chanceByLevel = {2, 4}
            local theChance = chanceByLevel[weaponLevel]
            if theStorage == 1 then
                theChance = theChance * 2
            end
            if math.random(1, 100) <= theChance then
                doFrozzenCreature(cid, 2000)
                exhaustion.set(cid, "weaponEffImmune", 6)
            end
        end
    end
end

function onHealthChange(cid, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not isCreature(attacker) then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    if isPlayer(cid) and isPlayer(attacker) and getCreatureTarget(attacker) ~= cid and
        getPlayerStorageValue(cid, "antiloopDois") == -1 then
        setPlayerStorageValue(cid, "antiloopDois", 1)
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    elseif isPlayer(cid) and getPlayerStorageValue(cid, "antiloopDois") == 1 then
        setPlayerStorageValue(cid, "antiloopDois", -1)
    end

    if isPlayer(cid) and haveReduction(cid) and getPlayerStorageValue(cid, "antiloop") == -1 then
        primaryDamage = getValueAfterReduction(cid, primaryDamage, isPlayer(attacker))
        setPlayerStorageValue(cid, "antiloop", 1)
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    elseif isPlayer(cid) and getPlayerStorageValue(cid, "antiloop") == 1 then
        setPlayerStorageValue(cid, "antiloop", -1)
    end

    if isPlayer(cid) and exhaustion.check(cid, "BendReflection") then
        local refletido = primaryDamage * 0.3
        local refCombat = COMBAT_AIRDAMAGE
        if getPlayerElement(cid) ~= "air" then
            refletido = primaryDamage * 0.45
            refCombat = COMBAT_ENERGYDAMAGE
        end
        if isPlayer(attacker) then
            if getPlayerStorageValue(attacker, "mandeiReflect") ~= 1 then -- nao refletir uma reflexao
                refletido = refletido * 2 -- garante dano correto por causa do pvp reduct
                setPlayerStorageValue(cid, "mandeiReflect", 1)
                doTargetCombatHealth(cid, attacker, refCombat, -refletido, -refletido, 0)
            end
        else
            doTargetCombatHealth(cid, attacker, refCombat, -refletido, -refletido, 0)
        end
    end
    if isPlayer(attacker) and getPlayerStorageValue(attacker, "mandeiReflect") == 1 then
        setPlayerStorageValue(attacker, "mandeiReflect", -1)
    end

    if isPlayer(cid) then
        setPlayerStorageValue(cid, "lastHit", attacker)
    end
    if isPlayer(cid) and getPlayerStorageValue(cid, "belzeAtivo") > os.time() and isCreature(attacker) and
        not isPlayer(attacker) then
        if primaryDamage < 0 then
            primaryDamage = 1
        end
        local reflected = primaryDamage * 0.4
        doTargetCombatHealth(cid, attacker, primaryType, -reflected, -reflected, 0)
    end
    --  if isPlayer(cid) and getPlayerStorageValue(cid, "canPotion") == 1 then 
    --    setPlayerStorageValue(cid, "canPotion", -1)
    --  end 
    if isPlayer(cid) and isCreature(attacker) and isPlayer(attacker) then
        exhaustion.set(cid, "isInCombat", 6)
        addEvent(function()
            if isCreature(cid) and exhaustion.check(cid, "isInCombat") and exhaustion.get(cid, "isInCombat") <= 1 then
                setPlayerStorageValue(cid, "isInCombat", os.time() - 1)
                for i = 1, #potions do
                    if getPlayerItemCount(cid, potions[i]) >= 1 then
                        doPlayerSendCancel(cid, "Fora de combate recente - potions regenerando normalmente.")
                        break
                    end
                end
            end
        end, 5000)
    end
    if attacker.uid > 0 then
        --[[
  if not canDoAttack(attacker, cid) then
    return false
    end
  ]]

        if isPlayer(cid) then
            if getPlayerStorageValue(cid, "playerHasTotalAbsorve") > os.time() then
                doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
                return 0, primaryType, 0, secondaryType
            end
            if math.random(1, 100) >= 10 and havePassiveChest(cid) and not exhaustion.check(cid, "setPassiveExh") then
                exhaustion.set(cid, "setPassiveExh", 12)
                local theSetPos = getCreaturePosition(cid)
                if havePassiveSet(cid) then
                    doCombat(cid, combatSetByElement[getPlayerVocation(cid)], {
                        type = 2,
                        pos = theSetPos
                    })
                    exhaustion.set(cid, "AirBarrierReduction", 2)
                else
                    doCombat(cid, combatChestByElement[getPlayerVocation(cid)], {
                        type = 2,
                        pos = theSetPos
                    })
                    exhaustion.set(cid, "AirBarrierReduction", 1)
                end
            end
            if getPlayerStorageValue(cid, "isPromoted") == 1 and getCreatureHealth(cid) - primaryDamage <
                getCreatureMaxHealth(cid) / 2 and 30 >= math.random(1, 100) and
                not exhaustion.check(cid, "promoteDefExh") then
                exhaustion.set(cid, "promoteDefExh", 10)
                if getPlayerElement(cid) == "earth" then
                    doSendAnimatedText(getThingPos(cid), "Block!", 120)
                    doSendMagicEffect(getThingPos(cid), 113)
                    return 0, primaryType, 0, secondaryType
                elseif getPlayerElement(cid) == "air" then
                    -- doAddCondition(cid, speedPromote)
                    doSlow(cid, cid, -50, 4000)
                    doSendAnimatedText(getThingPos(cid), "Speed!", 209)
                    doSendMagicEffect(getThingPos(cid), 129)
                elseif getPlayerElement(cid) == "water" then
                    doSendAnimatedText(getThingPos(cid), "Save!", 59)
                    addEvent(doMiniRegen, 200, cid)
                elseif getPlayerElement(cid) == "fire" then
                    doSendAnimatedText(getThingPos(cid), "Protect!", 186)
                    addEvent(doMiniExplosion, 200, cid)
                end
            end
            if getPlayerSkullType(cid) < 4 then
                if getPointsUsedInSkill(cid, "dodge") >= math.random(1, 100) then
                    doSendAnimatedText(getThingPos(cid), "Dodge!", COLOR_LIGHTBLUE)
                    doSendMagicEffect(getThingPos(cid), CONST_ME_BLOCKHIT)
                    return 0, primaryType, 0, secondaryType
                end
            end

            local playerHealth = getCreatureHealth(cid)

            if getPlayerStorageValue(cid, "isAvatar") == 1 then
                if not exhaustion.check(cid, "avatarProtec") and not exhaustion.check(cid, "AvatarMode") and
                    (playerHealth - primaryDamage) < (getCreatureMaxHealth(cid) / 4) then
                    exhaustion.set(cid, "avatarProtec", 30)
                    exhaustion.set(cid, "AvatarMode", 5)
                    doAirBarrier(cid)
                    doFireStriker(cid)
                    doEarthSpikes(cid)
                    doIceSpikes(cid)
                end
            end
            runeEffect(cid, attacker, primaryType)
            if primaryDamage >= playerHealth then -- VaiMorrer
                if getPlayerStorageValue(cid, "hasActiveInQuest") == 1 then
                    if getPlayerStorageValue(cid, "genericQuestBlockDeath") == 1 then
                        setPlayerStorageValue(cid, "hasActiveInQuest", -1)
                        addEvent(doTeleportThing, 1, cid, getPosInStorage(cid, "genericQuestPos"), false)
                        doSetStorage(getPlayerStorageValue(cid, "genericQuestString"), -1)
                        doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
                        return 0, primaryType, 0, secondaryType
                    end

                    return primaryDamage, primaryType, secondaryDamage, secondaryType
                end

                if isInArray(rarods, getCreatureName(attacker)) and not isInQuestRarods(attacker) then
                    doTeleportCreature(cid, {
                        x = 505,
                        y = 342,
                        z = 7
                    }, 10)
                    sendBlueMessage(cid,
                        getLangString(cid, "You have been teleported back to temple. Be careful, Rarods are dangerous!",
                            "Você foi teleportado para o templo! Tenha cuidado com os Rarods, eles são muito perigosos!"))
                    doCreatureAddHealth(cid, getCreatureMaxHealth(cid) - getCreatureHealth(cid))
                    return 0, primaryType, 0, secondaryType
                end

                if executePassive(cid, attacker) then
                    return 0, primaryType, 0, secondaryType
                end
            end
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
