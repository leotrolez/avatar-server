local spellName = "water icebeam"
local cf = {atk = spellsInfo[spellName].atk, frozzenTime = spellsInfo[spellName].frozzenTime, frozzenChance = spellsInfo[spellName].frozzenChance}

local MyLocal = {}
MyLocal.players = {}
MyLocal.chance = cf.frozzenChance

local combat = createCombatObject()
setCombatArea(combat, createCombatArea(AREA_SQUAREWAVE5))

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 86)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 86)

local combats = {combat1, combat2}

for x = 1, #combats do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/3)*5.2)+math.random(35, 45)
        local max = (level+(magLevel/3)*6.0)+math.random(45, 60)

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
    end
setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end


local function sendAnimatedTextIceBeam(cid, text, color)
    if isCreature(cid) then
        doSendAnimatedText(getThingPos(cid), text, color)
    end
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
    doFrozzenCreature(target, cf.frozzenTime)            
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function sendMagicEffectWave(cid, pos1, pos2)
    if math.random(1, 100) <= MyLocal.chance then
        doCombat(cid, combat2, {type=2, pos=pos2})
        doSendDistanceShoot(pos1, pos2, 28)
    else
        doCombat(cid, combat1, {type=2, pos=pos2})
    end
end


function onTargetTile(creature, pos)
	local cid = creature:getId()
    addEvent(sendMagicEffectWave, 25*MyLocal.players[cid], cid, getThingPos(cid), pos)
    MyLocal.players[cid] = MyLocal.players[cid]+1
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")



local function removeTable(cid)
    MyLocal.players[cid] = nil
end

local function testWaterMan(cid)
	if #getCreatureSummons(cid) == 0 then return false end
	setPlayerStorageValue(getCreatureSummons(cid)[1], "executarBeam", 1)
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "iceBeam") == false then
        return false
    end

    if MyLocal.players[cid] == nil then
        if canUseWaterSpell(cid, 1, 3, false) then
			if getDobrasLevel(cid) >= 7 then
				doPlayerAddExaust(cid, "water", "iceBeam", waterExausted.iceBeam-2)
			else
				doPlayerAddExaust(cid, "water", "iceBeam", waterExausted.iceBeam)
			end
            if getPlayerHasStun(cid) then
                workAllCdAndAndPrevCd(cid, "water", "iceBeam", nil, 1)
                return true
            end
            MyLocal.players[cid] = 0
            addEvent(removeTable, 1000, cid)
            workAllCdAndAndPrevCd(cid, "water", "iceBeam", nil, 1)
			testWaterMan(cid)
            return doCombat(cid, combat, var)
        else
            return false
        end
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
