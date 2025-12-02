local spellName = "air deflection"
local cf = {
    atk = spellsInfo[spellName].atk
}

local alvos = {}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatArea(combat, createCombatArea({{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                                        {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0}, {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
                                        {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0}, {0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
                                        {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0}, {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
                                        {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                                        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 77)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level + (magLevel / 3) * 2.1) + 5
    local max = (level + (magLevel / 3) * 2.4) + 5
    local dano = math.random(min, max)
    local atk = cf.atk
    if atk and type(atk) == "number" then
        atk = atk * 0.7
        dano = dano * (atk / 100)
        dano = dano + 1
    end
    dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
    local cid = creature:getId()
    if alvos[cid] == nil then
        alvos[cid] = 0
    end
    if alvos[cid] < 8 then
        alvos[cid] = alvos[cid] + 1
        doSendDistanceShoot(getThingPos(cid), getThingPos(target), 41)
        doCombat(cid, combat2, Variant(target:getId()))
        return true
    end
    return false
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local xizes1 = {0, -1, -1, 0} -- cima pra esquerda, esquerda pra baixo
local yizes1 = {-1, 0, 0, 1} -- cima pra esquerda, esquerda pra baixo
local xizes2 = {0, 1, 1, 0} -- baixo pra direita, direita pra cima
local yizes2 = {1, 0, 0, -1} -- baixo pra direita, direita pra cima

local function bolasWork(cid, times, state)
    if not isCreature(cid) then
        return false
    end

    local pos = getCreaturePosition(cid)
    if not isInPz(cid) then
        doSendDistanceShoot({
            x = pos.x + xizes1[state],
            y = pos.y + yizes1[state],
            z = pos.z
        }, {
            x = pos.x + xizes1[state + 1],
            y = pos.y + yizes1[state + 1],
            z = pos.z
        }, 41)
        doSendDistanceShoot({
            x = pos.x + xizes2[state],
            y = pos.y + yizes2[state],
            z = pos.z
        }, {
            x = pos.x + xizes2[state + 1],
            y = pos.y + yizes2[state + 1],
            z = pos.z
        }, 41)
        if times % 3 == 0 then
            doSendMagicEffect(getThingPos(cid), 120)
        end
    end

    if state >= 3 then
        state = -1
    end
    if times > 0 then
        addEvent(bolasWork, 150, cid, times - 1, state + 2)
    end
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "deflection") == false then
        return false
    end
    if getDobrasLevel(cid) >= 23 then
        doPlayerAddExaust(cid, "air", "deflection", airExausted.deflection - 18)
    else
        doPlayerAddExaust(cid, "air", "deflection", airExausted.deflection)
    end
    if getPlayerHasStun(cid) then
        return true
    end
    doSlow(cid, cid, -25, 5000)
    exhaustion.set(cid, "BendReflection", 5)
    bolasWork(cid, 33, 1)
    alvos[cid] = nil
    for i = 0, 14 do
        addEvent(function()
            if isCreature(cid) then
                local pos = getThingPos(cid)
                alvos[cid] = nil
                doCombat(cid, combat, {
                    type = 3,
                    pos = pos
                })
            end
        end, 350 * i)
    end
  
    addEvent(function()
        alvos[cid] = nil
    end, 5000)

    return true
end
