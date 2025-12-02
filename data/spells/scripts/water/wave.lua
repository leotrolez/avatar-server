local spellName = "water wave"
local cf = {atk = spellsInfo[spellName].atk}
local AREA_WAVENEW = {
  {1, 1, 1, 1, 1},
  {0, 1, 1, 1, 0},
  {0, 1, 1, 1, 0},
  {0, 1, 3, 1, 0}
}
local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatArea(combat, createCombatArea(AREA_WAVENEW, AREADIAGONAL_WAVE4))

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 86)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*4.1)+math.random(5, 10)
    local max = (level+(magLevel/3)*4.5)+math.random(10, 15)

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function sendMagicEffectWave(pos1, pos2, cid)
    if math.random(1, 3) == 3 then
        doSendDistanceShoot(pos1, pos2, 28)
    end
    doCombat(cid, combat1, {type=2, pos=pos2})
end

function onTargetTile(creature, pos)
	local cid = creature:getId()
    addEvent(sendMagicEffectWave, 25*MyLocal.players[cid], getThingPos(cid), pos, cid)
    MyLocal.players[cid] = MyLocal.players[cid]+1
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")


local function removeTable(cid)
    MyLocal.players[cid] = nil
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "wave") == false then
        return false
    end
    if canUseWaterSpell(cid, 1, 3, false) then
        if MyLocal.players[cid] == nil then
            workAllCdAndAndPrevCd(cid, "water", "wave", nil, 1)
            doPlayerAddExaust(cid, "water", "wave", waterExausted.wave)
            if getPlayerHasStun(cid) then
                return true
            end
            MyLocal.players[cid] = 0
            doCombat(cid, combat, var)
            addEvent(removeTable, 1000, cid)
            return true
        else
            doPlayerSendCancelEf(cid, "You're already using this fold.")
            return false
        end
    else
        return false
    end
end
