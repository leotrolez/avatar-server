local spellName = "fire striker"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*2.1)+math.random(30, 40)
    local max = (level+(magLevel/2)*2.7)+math.random(50, 60)
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.5
        max = max*0.5
    end
    local dano = math.random(min, max)
    local atk = cf.atk
    if atk and type(atk) == "number" then 
        dano = dano * (atk/100)
        dano = dano+1
    end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValuesFocus(cid, level, magLevel)
    local min = ((level+(magLevel/2)*2.1)+math.random(30, 40))*1.3
    local max = ((level+(magLevel/2)*2.7)+math.random(50, 60))*1.7
    if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.5
        max = max*0.5
    end
    local dano = math.random(min, max)
    local atk = cf.atk
    if atk and type(atk) == "number" then 
        dano = dano * (atk/100)
        dano = dano+1
    end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValuesFocus")

local arr = {
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1}
}

setCombatArea(combat, createCombatArea(arr))
setCombatArea(combatFocus, createCombatArea(arr))

local function sendDamage(cid, finish, focus)
    if getTileInfo(getCreaturePosition(cid)).protection then return false end
    if not isCreature(cid) then
        return true
    end
    local playerPos = getCreaturePosition(cid)
    doSendMagicEffect({x=playerPos.x+1, y=playerPos.y+1, z=playerPos.z}, 121)
    if focus then
        doCombat(cid, combatFocus, {pos=playerPos, type=2})
    else
        doCombat(cid, combat, {pos=playerPos, type=2}) 
    end
    if finish then

    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if getPlayerExaust(cid, "fire", "striker", fireExausted.striker) == false then
        return false
    end
    if MyLocal.players[cid] == nil then
        if getPlayerHasStun(cid) then
            if getDobrasLevel(cid) >= 17 then
                doPlayerAddExaust(cid, "fire", "striker", fireExausted.striker-9)
            else
                doPlayerAddExaust(cid, "fire", "striker", fireExausted.striker)
            end
            workAllCdAndAndPrevCd(cid, "fire", "striker", nil, 1)
            return true
        end
        MyLocal.players[cid] = true

        local focused = getPlayerOverPower(cid, "fire", true, true)
        for x = 0, 8 do
            addEvent(sendDamage, 1000*x, cid, x == 8, focused)
        end
        workAllCdAndAndPrevCd(cid, "fire", "striker", nil, 1)
            if getDobrasLevel(cid) >= 17 then
            doPlayerAddExaust(cid, "fire", "striker", fireExausted.striker-9)
        else
            doPlayerAddExaust(cid, "fire", "striker", fireExausted.striker)
        end
    
        MyLocal.players[cid] = nil
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end