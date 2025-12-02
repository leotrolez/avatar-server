local spellName = "air burst"
local cf = {atk = spellsInfo[spellName].atk}


local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 2)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level+(magLevel/4)*0.3
    local max = level+(magLevel/4)*0.7
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	if getDobrasLevel(cid) >= 2 then 
		dano = dano*1.2
	end 
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combat3 = createCombatObject()
local combats = {combat1, combat2, combat3}

local arr = {}

arr[1] = {{1, 1, 1},
          {1, 2, 1},
          {1, 1, 1}}

arr[2] = {{0, 1, 1, 1, 0},
          {1, 0, 0, 0, 1},
          {1, 0, 2, 0, 1},
          {1, 0, 0, 0, 1},
          {0, 1, 1, 1, 0}}

for x = 1, 2 do
    setCombatArea(combats[x], createCombatArea(arr[x]))
    function onTargetTile(creature, pos)
	local cid = creature:getId()
        doCombat(cid, combat, {type=2, pos=pos})
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
    doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, isPlayer(cid))
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid, exaust)
    if not isCreature(cid) then
        return true
    end
    if exaust then
        doPlayerAddExaust(cid, "air", "burst", airExausted.burst)
    end
    MyLocal.players[cid] = nil
end

local function sendCombat(cid, combatId, final)
    if not isCreature(cid) then
        return true
    end
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
    doCombat(cid, combatId, {type=2, pos=getThingPos(cid)}) 
    if final then
        removeTable(cid, true)
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "burst") == false then
        return false
    end
    if getPlayerHasStun(cid) then
        removeTable(cid, true)
        return true
    end

    if MyLocal.players[cid] == nil then
        MyLocal.players[cid] = true
        for x = 0, 1 do
            addEvent(sendCombat, 100*x, cid, combats[x+1], x == 1)
        end
        workAllCdAndAndPrevCd(cid, "air", "burst", 200, 1) 
		doSendMagicEffect(getThingPos(cid), 120)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
