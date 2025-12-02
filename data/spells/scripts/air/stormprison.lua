local cf = {}
cf.ticks = 20 -- quantas vezes a dobra vai procar
cf.interval = 500 -- cf.intervalo entre cada tick (milisegundos)
cf.cooldown = 5 -- tempo de cf.cooldown para poder usar a spell novamente (em segundos)
cf.effectz1 = 24
cf.effectz2 = 23
cf.effectx = 45

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, cf.effectx)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 2)

arr =
    {{0, 0, 1, 1, 1, 0, 0}, {0, 0, 1, 1, 1, 0, 0}, {0, 0, 1, 1, 1, 0, 0}, {0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 2, 0, 0, 0}}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local vitality = getPlayerStorageValue(cid, "healthvalue")
    if not vitality then
        vitality = 0
    end
    local mana = getPlayerStorageValue(cid, "manavalue")
    if not mana then
        mana = 0
    end
    local dodge = getPlayerStorageValue(cid, "dodgevalue")
    if not dodge then
        dodge = 0
    end
    local level = getPlayerLevel(cid)
    local magLevel = getPlayerMagLevel(cid)

    local min = ((level * 1) + (magLevel * 1) + (vitality * 0) + (mana * 0) + (dodge * 0))
    local max = ((level * 1) + (magLevel * 1) + (vitality * 0) + (mana * 0) + (dodge * 0))

    local dano = remakeValue(3, math.random(min, max), cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

function onTargetTile(creature, pos)
    local cid = creature:getId()
    if not getTileInfo(pos).protection then
        if isCreature(getThingFromPos(pos)) then
            for i = 1, (cf.ticks - 1) do
                addEvent(function()
                    if isCreature(cid) then
                        if math.random(1, 2) == 1 then
                            doSendMagicEffect(pos, cf.effectz1)
                        else
                            doSendMagicEffect(pos, cf.effectz2)
                        end
                    end
                end, i * cf.interval)
            end
        end
    end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
    local cid = creature:getId()
    local tid = target:getId()
    local tPos = getCreaturePosition(target)
    if isImune(cid, target) or (cid == target) or getTileInfo(tPos).protection then
        return false
    else
        doSendAnimatedText(getCreaturePosition(target), "Prisioned!", 215)
        for i = 1, (cf.ticks - 1) do
            addEvent(function()
                if isCreature(tid) then
                    doSendMagicEffect(getCreaturePosition(tid), cf.effectz1)
                    addEvent(doSendDistanceShoot, 200, getCreaturePosition(tid), tPos, cf.effectx)
                    addEvent(doTeleportThing, 200, tid, tPos, true)
                end
            end, i * cf.interval)
        end
    end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
    local cid = creature:getId()

    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "stormprison") == false then
        return false
    end
    doPlayerAddExaust(cid, "air", "stormprison", cf.cooldown)
    if getPlayerHasStun(cid) then
        return true
    end
    doCombat(cid, combat, var)

    return true
end
