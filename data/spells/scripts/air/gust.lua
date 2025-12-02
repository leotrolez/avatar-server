local spellName = "air gust"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 76)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*0.9)
    local max = (level+(magLevel/4)*1.2)
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	if getDobrasLevel(cid) >= 6 then 
		dano = dano*1.2
	end 
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combat3 = createCombatObject()
local combat4 = createCombatObject()
local combat5 = createCombatObject()
local combat6 = createCombatObject()
local combats = {combat1, combat2, combat3, combat4, combat5, combat6}

local arr = {}

arr[1] = {{1, 3, 1}}

arr[2] = {{1, 1, 1},
          {0, 2, 0}}

arr[3] = {{1, 1, 1, 1, 1},
          {0, 0, 0, 0, 0},
          {0, 0, 2, 0, 0}}

arr[4] = {{1, 1, 1, 1, 1, 1, 1},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 2, 0, 0, 0}}

arr[5] = {{1, 1, 1, 1, 1, 1, 1},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 2, 0, 0, 0}}

arr[6] = {{1, 1, 1, 1, 1, 1, 1},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 2, 0, 0, 0}}

for x = 1, 4 do
    setCombatArea(combats[x], createCombatArea(arr[x]))
    function onTargetTile(creature, pos)
	local cid = creature:getId()
        doCombat(cid, combat, {type=2, pos=pos})  
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
    doPushCreature(target, MyLocal.players[cid].dir, nil, nil, nil, isPlayer(cid))
	doSlow(cid, target, 15, 2000)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid, exaust, final)
    if not isCreature(cid) then
        return true
    end
    MyLocal.players[cid] = nil
    if exaust then
        doPlayerAddExaust(cid, "air", "gust", airExausted.gust)
    end
end

local function sendCombat(cid, pos, combatId, final)
    if not isCreature(cid) then
        return true
    end
	local mypos = getCreaturePosition(cid)
	if hasSqm(mypos) and getTileInfo(mypos).protection then return false end
    doCombat(cid, combatId, {type=2, pos=pos}) 
    if final then
        removeTable(cid, true, final)
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "gust") == false then
        return false
    end
    if getPlayerHasStun(cid) then
        removeTable(cid, true)
        return true
    end

    if MyLocal.players[cid] == nil then
        MyLocal.players[cid] = {dir = getCreatureLookDirection(cid)}
        for x = 0, 3 do
            addEvent(sendCombat, 100*x, cid, getPositionByDirection(getThingPos(cid), getCreatureLookDirection(cid)), combats[x+1], x == 3)
        end 
        workAllCdAndAndPrevCd(cid, "air", "gust", 1000, 1) 
        setCreatureNoMoveTime(cid, 350) 
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
