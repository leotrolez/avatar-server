local spellName = "air windstorm"
local cf = {
    atk = spellsInfo[spellName].atk
}

local extraDano = 10

local alvos = {}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatArea(combat, createCombatArea({{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                                        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                                        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0},
                                        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                                        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                                        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
-- setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 41)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 77)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level + (magLevel / 3) * 2.1) + 5
    local max = (level + (magLevel / 3) * 2.4) + 5
    local dano = math.random(min, max)
    local atk = cf.atk
    if atk and type(atk) == "number" then
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
    if alvos[cid] < 5 then
        alvos[cid] = alvos[cid] + 1
        doSendDistanceShoot(getThingPos(cid), getThingPos(target), 48)
        doCombat(cid, combat2, Variant(target:getId()))
        return true
    end
    return false
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetCreature(creature, target)
    local cid = creature:getId()
    doSlow(cid, target, 20, 1000)
    addEvent(function()
        if isCreature(cid) and isCreature(target) and not isInPz(target) then
            doPushCreature(target, getCreatureLookDirection(cid), nil, nil, nil, isPlayer(cid))
        end
    end, 50)
    return true
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
    local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "windstorm") == false then
        return false
    end
    if getDobrasLevel(cid) >= 20 then
        doPlayerAddExaust(cid, "air", "windstorm", airExausted.windstorm - 9)
    else
        doPlayerAddExaust(cid, "air", "windstorm", airExausted.windstorm)
    end
    if getPlayerHasStun(cid) then
        return true
    end
    alvos[cid] = nil
    for i = 0, 8 do
        addEvent(function()
            if isCreature(cid) then
                local pos = getThingPos(cid)
                doSendMagicEffect({
                    x = pos.x,
                    y = pos.y,
                    z = pos.z
                }, 120)
                alvos[cid] = nil
                doCombat(cid, combat, {
                    type = 3,
                    pos = pos
                })
            end
        end, 250 * i)

    end
    addEvent(function()
        alvos[cid] = nil
    end, 3000)

    return true
end
