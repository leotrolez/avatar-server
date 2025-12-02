local spellName = "earth aura"
local cf = {
    atk = spellsInfo[spellName].atk,
    duracao = spellsInfo[spellName].duracao
}

local MyLocal = {}
MyLocal.players = {}
MyLocal.positions = {}

local cf2 = {
    missile = 43,
    effect = 34
}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
-- setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effect)
setCombatArea(combat,
    createCombatArea({{0, 0, 0, 0, 0, 0, 0}, {0, 0, 1, 1, 1, 0, 0}, {0, 0, 1, 3, 1, 0, 0}, {0, 0, 1, 1, 1, 0, 0},
                      {0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0}}))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, cf2.effect)
setCombatArea(combat2,
    createCombatArea({{0, 0, 1, 1, 1, 0, 0}, {0, 1, 0, 0, 0, 1, 0}, {0, 1, 0, 2, 0, 1, 0}, {0, 1, 0, 0, 0, 1, 0},
                      {0, 0, 1, 1, 1, 0, 0}, {0, 0, 0, 0, 0, 0, 0}}))

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
-- setCombatParam(comba3, COMBAT_PARAM_EFFECT, cf.effect)
setCombatArea(combat3,
    createCombatArea({{0, 1, 0, 0, 0, 1, 0}, {0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 2, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0},
                      {0, 1, 0, 0, 0, 1, 0}, {0, 0, 0, 0, 0, 0, 0}}))

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatArea(combat4,
    createCombatArea({{0, 0, 1, 1, 1, 0, 0}, {0, 1, 0, 0, 0, 1, 0}, {0, 1, 0, 2, 0, 1, 0}, {0, 1, 0, 0, 0, 1, 0},
                      {0, 0, 1, 1, 1, 0, 0}, {0, 0, 0, 0, 0, 0, 0}}))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level + (magLevel / 3) * 5.2) + math.random(35, 45)
    local max = (level + (magLevel / 3) * 6.0) + math.random(45, 60)
    if getPlayerInWaterWithUnderwater(cid) then
        min = min * 0.6
        max = max * 0.6
    end
    local dano = math.random(min, max)
    local atk = cf.atk
    if atk and type(atk) == "number" then
        dano = dano * (atk / 100)
        dano = dano + 1
    end
    dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level + (magLevel / 3) * 5.2) + math.random(35, 45)
    local max = (level + (magLevel / 3) * 6.0) + math.random(45, 60)
    if getPlayerInWaterWithUnderwater(cid) then
        min = min * 0.6
        max = max * 0.6
    end
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
    exhaustion.set(target, "stopDashs", 1)
    doSlow(cid, target, 50, 1000)
    return true
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetCreature(creature, target)
    local cid = creature:getId()
    local posOrigem = getThingPos(target)
    exhaustion.set(target, "stopDashs", 1)
    doPushCreature(target, getDirectionTo(posOrigem, getThingPos(cid)), nil, nil, nil, isPlayer(cid))
    if posOrigem.x ~= getThingPos(target).x or posOrigem.y ~= getThingPos(target).y then
        doSlow(cid, target, 50, 2000)
    end
    return true
end

setCombatCallback(combat4, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onTargetTile(creature, pos)
    local cid = creature:getId()
    local mypos = getThingPos(cid)
    if pos.x ~= mypos.x or pos.y ~= mypos.y then
        doSendMagicEffect(pos, cf2.effect)
    end

    if math.random(1, 10) > 6 then
        if pos.x ~= mypos.x or pos.y ~= mypos.y then
            doSendMagicEffect(pos, 96)
        end
    end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function isAndavel(pos, cid)
    return getPlayerCanWalk({
        player = cid,
        position = pos,
        checkPZ = false,
        checkHouse = true,
        createTile = itsFlySpell and isPlayer(cid)
    })
end

local function isProjectable(pos)
    return isSightClear({
        x = pos.x - 1,
        y = pos.y,
        z = pos.z
    }, {
        x = pos.x + 1,
        y = pos.y,
        z = pos.z
    }, true) and not getTileInfo(pos).protection
end

function onTargetTile(creature, pos)
    local cid = creature:getId()
    if not isProjectable(pos) or not isAndavel(pos, cid) then
        return true
    end
    local pilarId = 17821
    local pilar = doCreateItem(pilarId, pos)
    addEvent(removeTileItemById, cf.duracao, getThingPos(pilar), pilarId)
end
setCombatCallback(combat3, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function removeTable(cid)
    MyLocal.players[cid] = nil
end

local function auraWork(cid, times)
    if not isCreature(cid) or isInPz(cid) then
        return false
    end
    local pos = getThingPos(cid)
    if times % 4 == 0 then
        doCombat(cid, combat, {
            type = 2,
            pos = pos
        })
        doCombat(cid, combat2, {
            type = 2,
            pos = pos
        })
    end
    local poses = {{
        x = pos.x - 1,
        y = pos.y - 2,
        z = pos.z
    }, {
        x = pos.x,
        y = pos.y - 2,
        z = pos.z
    }, {
        x = pos.x + 1,
        y = pos.y - 2,
        z = pos.z
    }, {
        x = pos.x + 2,
        y = pos.y - 1,
        z = pos.z
    }, {
        x = pos.x + 2,
        y = pos.y,
        z = pos.z
    }, {
        x = pos.x + 2,
        y = pos.y + 1,
        z = pos.z
    }, {
        x = pos.x + 1,
        y = pos.y + 2,
        z = pos.z
    }, {
        x = pos.x,
        y = pos.y + 2,
        z = pos.z
    }, {
        x = pos.x - 1,
        y = pos.y + 2,
        z = pos.z
    }, {
        x = pos.x - 2,
        y = pos.y + 1,
        z = pos.z
    }, {
        x = pos.x - 2,
        y = pos.y,
        z = pos.z
    }, {
        x = pos.x - 2,
        y = pos.y - 1,
        z = pos.z
    }}
    for i = 1, #poses do
        local x = i + 1
        if x == #poses + 1 then
            x = 1
        end
        local pos1 = poses[i]
        local pos2 = poses[x]
        if isProjectable(pos1) and isProjectable(pos2) and isSightClear(pos, pos1, true) and
            isSightClear(pos, pos2, true) then
            doSendDistanceShoot(pos1, pos2, cf2.missile)
        end
    end
    if times > 1 then
        addEvent(auraWork, 150, cid, times - 1)
    end
end
local function prisionAura(cid, times)
    if not isCreature(cid) or times < 1 then
        return false
    end
    doCombat(cid, combat4, {
        type = 2,
        pos = getThingPos(cid)
    })
    addEvent(prisionAura, 50, cid, times - 50)
end
function onCastSpell(creature, var)
    local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if getPlayerExaust(cid, "earth", "aura") == false then
        return false
    end
    if MyLocal.players[cid] == nil then
        positionsimune = {}
        if getDobrasLevel(cid) >= 18 then
            doPlayerAddExaust(cid, "earth", "aura", earthExausted.aura - 9)
        else
            doPlayerAddExaust(cid, "earth", "aura", earthExausted.aura)
        end
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "earth", "aura", nil, 1)
            return true
        end
        MyLocal.players[cid] = 0
        addEvent(removeTable, cf.duracao - 100, cid)
        setCreatureNoMoveTime(cid, cf.duracao - 100)
        workAllCdAndAndPrevCd(cid, "earth", "aura", nil, 1)
        auraWork(cid, (cf.duracao - 100) / 150)
        doCombat(cid, combat3, {
            type = 2,
            pos = getThingPos(cid)
        })
        prisionAura(cid, (cf.duracao - 100) / 50)
        exhaustion.set(cid, "AirBarrierReduction", cf.duracao / 1000)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
