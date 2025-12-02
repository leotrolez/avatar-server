local cf = {}
cf.cooldown = 4

local AREA_WAVENEW = {
    {1, 1, 1},
    {1, 3, 1},
    {1, 1, 1},
}
local MyLocal = {}
MyLocal.players = {}

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
local area = createCombatArea(AREA_WAVENEW)
setCombatArea(combat1, area)

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

    local dano = remakeValue(4, math.random(min, max), cid)
    return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

local function retireTable(cid)
    MyLocal.players[cid] = nil
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end

    if MyLocal.players[cid] == nil then
        if doPlayerAddExaust(cid, "earth", "throw", cf.cooldown) == false then
            return false
        end
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "earth", "throw", nil, 1)
            return true
        end
        MyLocal.players[cid] = 0
        local cPos = getCreaturePosition(cid)
        local tPos = Position(cPos)
        local delta = { x = tPos.x - cPos.x, y = tPos.y - cPos.y }
        tPos:getNextPosition(creature:getDirection(), 4)
        doSendDistanceShoot(cPos, tPos, 61)
        addEvent(function(cid)
            if isCreature(cid) then
                doCombat(cid, combat1, {
                    type = 2,
                    pos = tPos
                })
                doSendMagicEffect({
                    x = tPos.x + 2,
                    y = tPos.y + 2,
                    z = tPos.z
                }, 189)
            end
        end, 150 * math.sqrt(math.sqrt(delta.x*delta.x + delta.y*delta.y)), cid)
        addEvent(retireTable, 1000, cid)
        workAllCdAndAndPrevCd(cid, "earth", "throw", nil, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end

