local spellName = "fire lightning"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}
MyLocal.positions = {}
positionsimune = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 48)
setCombatArea(combat, createCombatArea(
{
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 3, 0, 0, 0}
}))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat2, createCombatArea(
{
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 2, 1, 0, 0}
}))

local combats = {combat, combat2}

for x = 1, #combats do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/3)*5.2)+math.random(35, 45)
        local max = (level+(magLevel/3)*6.0)+math.random(45, 60)
        if getPlayerInWaterWithUnderwater(cid) then
            min = min*1.3
            max = max*1.3
        end
        if exhaustion.check(cid, "isFocusLightning") then
            min = min*2
            max = max*2
        end
        if x == 2 then
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
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
    local targpos = getThingPos(target)
    targpos = {x=targpos.x, y=targpos.y, z=targpos.z}
    doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 131)
    local str = "lightning"..targpos.x..""..targpos.y..""..targpos.z..""
    if not exhaustion.check(cid, str) then
        exhaustion.set(cid, str, 2)
        addEvent(function() if isCreature(cid) then setPlayerStorageValue(cid, str, -1) end end, 50)
        doCombat(cid, combat2, {type=2, pos=targpos})
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid)
    MyLocal.players[cid] = nil
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if getPlayerExaust(cid, "fire", "lightning") == false then
        return false
    end
    if MyLocal.players[cid] == nil then
        positionsimune = {}
        if getDobrasLevel(cid) >= 12 then
            doPlayerAddExaust(cid, "fire", "lightning", fireExausted.lightning-2)
        else
            doPlayerAddExaust(cid, "fire", "lightning", fireExausted.lightning)
        end
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "fire", "lightning", nil, 1)
            return true
        end
        MyLocal.players[cid] = 0
        addEvent(removeTable, 1000, cid)
        workAllCdAndAndPrevCd(cid, "fire", "lightning", nil, 1)
        local mypos = getCreaturePosition(cid)
        doSendMagicEffect({x=mypos.x+1, y=mypos.y, z=mypos.z}, 95)
        if getPlayerOverPower(cid, "fire", true, true) then
            exhaustion.set(cid, "isFocusLightning", 3)
        end
        return doCombat(cid, combat, var)
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
