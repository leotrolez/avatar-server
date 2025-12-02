local spellName = "fire wave"
local cf = {atk = spellsInfo[spellName].atk}
local AREA_WAVENEW = {
  {1, 1, 1, 1, 1},
  {0, 1, 1, 1, 0},
  {0, 1, 1, 1, 0},
  {0, 1, 3, 1, 0}
}
--focus ready--

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
local area = createCombatArea(AREA_WAVENEW, AREADIAGONAL_WAVE4)
setCombatArea(combat, area)

local combatFocus = createCombatObject()
local areaFocus = createCombatArea(AREA_WAVENEW, AREADIAGONAL_WAVE4)
setCombatArea(combatFocus, areaFocus)


local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 6)
setAttackFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 1.2, 2)

local combat1Focus = createCombatObject()
setCombatParam(combat1Focus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat1Focus, COMBAT_PARAM_EFFECT, 6)
setAttackFormula(combat1Focus, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 1.2, 2)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.0)+math.random(20, 30)
    local max = (level+(magLevel/2)*4.0)+math.random(30, 35)
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
	if getDobrasLevel(cid) >= 2 then
		dano = dano*1.2
	end
	dano = remakeValue(1, dano)
    return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*3.0)+math.random(20, 30))*1.5
    local max = ((level+(magLevel/2)*4.0)+math.random(30, 35))*2.3
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
	if getDobrasLevel(cid) >= 2 then
		dano = dano*1.2
	end
	dano = remakeValue(1, dano)
    return -dano, -dano
end
setCombatCallback(combat1Focus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local function sendMagicEffectWave(pos1, pos2, cid)
    if math.random(1, 3) == 3 then
        doSendDistanceShoot(pos1, pos2, 3)
    end
    doCombat(cid, combat1, {type=2, pos=pos2})
end

local function sendMagicEffectWaveFocus(pos1, pos2, cid)
    if math.random(1, 3) == 3 then
        doSendDistanceShoot(pos1, pos2, 3)
    end
    doCombat(cid, combat1Focus, {type=2, pos=pos2})
end

function onTargetTile(creature, pos)
	local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
  addEvent(sendMagicEffectWave, 25*MyLocal.players[cid], getThingPos(cid), pos, cid)
  MyLocal.players[cid] = MyLocal.players[cid]+1
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetTileFocus(cid, pos)
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
  addEvent(sendMagicEffectWaveFocus, 25*MyLocal.players[cid], getThingPos(cid), pos, cid)
  MyLocal.players[cid] = MyLocal.players[cid]+1
end

setCombatCallback(combatFocus, CALLBACK_PARAM_TARGETTILE, "onTargetTileFocus")

local function retireTable(cid)
    MyLocal.players[cid] = nil
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if MyLocal.players[cid] == nil then
        if doPlayerAddExaust(cid, "fire", "wave", fireExausted.wave) == false then
            return false
        end
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "fire", "wave", nil, 1)
            return true
        end
        MyLocal.players[cid] = 0
        if getPlayerOverPower(cid, "fire", true, true) == true then
            doCombat(cid, combatFocus, var)
        else
            doCombat(cid, combat, var)
        end
        addEvent(retireTable, 1000, cid)
        workAllCdAndAndPrevCd(cid, "fire", "wave", nil, 1)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
