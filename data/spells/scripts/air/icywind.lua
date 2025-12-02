local spellName = "air icywind"
local cf = {atk = spellsInfo[spellName].atk, frozzenTime = spellsInfo[spellName].frozzenTime}

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 76)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.3, -30, -0.4, 0)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*3.7)+math.random(25, 35)
    local max = (level+(magLevel/4)*4.0)+math.random(35, 40)
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combat1 = createCombatObject()
setCombatArea(combat1, createCombatArea(AREA_SQUAREWAVE5))

function onTargetTile(creature, pos)
	local cid = creature:getId()
    addEvent(doCombat, 25*MyLocal.players[cid], cid, combat, {type=2, pos=pos})
    MyLocal.players[cid] = MyLocal.players[cid]+1
end
setCombatCallback(combat1, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if isMonster(target) then 
		doFrozzenCreature(target, cf.frozzenTime)
	else 
		doSlow(cid, target, 35, 2000)
	end 
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid)
    if not isCreature(cid) then
        return true
    end

    MyLocal.players[cid] = nil
    doPlayerAddExaust(cid, "air", "icywind", airExausted.icywind)
    doCreatureSetNoMove(cid, false)
end


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "icywind") == false then
        return false
    end
    if getPlayerHasStun(cid) then
        removeTable(cid)
        return true
    end

    if MyLocal.players[cid] == nil then
        MyLocal.players[cid] = 0
        doCombat(cid, combat1, var)
        doCreatureSetNoMove(cid, true)
        workAllCdAndAndPrevCd(cid, "air", "icywind", 500, 1)
        addEvent(removeTable, 500, cid)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
