local cf = {}
cf.ticks = 15 -- quantas vezes a dobra vai procar
cf.interval = 500 -- cf.intervalo entre cada tick (milisegundos)
cf.cooldown = 2 -- tempo de cf.cooldown para poder usar a spell novamente

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 29)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 22)

arr = {{0, 0, 1, 1, 1, 0, 0}, {0, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 0}, {0, 1, 1, 1, 1, 1, 0},
       {0, 0, 1, 1, 1, 0, 0}, {0, 0, 0, 2, 0, 0, 0}}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local function getDmg(cid)
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
    return dano
end

function onTargetTile(creature, pos)
    local cid = creature:getId()
    for i = 1, (cf.ticks - 1) do
        addEvent(function()
            if isCreature(cid) and not isPzPos(pos) then
                if math.random(1, 2) == 1 then
                    doSendMagicEffect(pos, 21)
                else
                    doSendMagicEffect(pos, 22)
                end
                doCombatAreaHealth(cid, COMBAT_PHYSICALDAMAGE, pos, area, -getDmg(cid), -getDmg(cid))
            end
        end, i * cf.interval)
    end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, var)
    local cid = creature:getId()

    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "cyclones") == false then
        return false
    end
    doPlayerAddExaust(cid, "air", "cyclones", cf.cooldown)
    if getPlayerHasStun(cid) then
        return true
    end
    doCombat(cid, combat, var)

    return true
end
