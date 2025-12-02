local spellName = "fire cannon"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 79)

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combatFocus, COMBAT_PARAM_EFFECT, 79)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.1)+math.random(3, 7)
    local max = (level+(magLevel/2)*5.3)+math.random(7, 15)
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

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*4.1)+math.random(3, 7))*1.5
    local max = ((level+(magLevel/2)*4.3)+math.random(7, 15))*2.0
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
setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
    if isNpc(target) then
        return false
    end
	if getTileInfo(getCreaturePosition(cid)).protection then return false end

    local dir = getCreatureLookDirection(cid)
    doPushCreature(target, dir)
end

function onTargetCreatureFocus(cid, target)
    if isNpc(target) then
        return false
    end
    local dir = getCreatureLookDirection(cid)
    doPushCreature(target, dir)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
setCombatCallback(combatFocus, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureFocus")

local function doCannonEffect(cid, pos, overPower)
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
    if not isCreature(cid) then
        return false
    end
    
    if overPower then
        doCombat(cid, combatFocus, {type=2, pos=pos})
    else
        doCombat(cid, combat, {type=2, pos=pos})
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end 
    if getPlayerExaust(cid, "fire", "cannon") == false then
        return false
    end
	if getDobrasLevel(cid) >= 9 then
		doPlayerAddExaust(cid, "fire", "cannon", fireExausted.cannon-2)
	else
		doPlayerAddExaust(cid, "fire", "cannon", fireExausted.cannon)
	end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "fire", "cannon", nil, 1)
        return true
    end
    local playerDir, posEdit = getCreatureLookDirection(cid), nil

    if playerDir == NORTH or playerDir == SOUTH then
        posEdit = {x=1, y=0}
    else
        posEdit = {x=0, y=1}
    end

    local isPower, current = getPlayerOverPower(cid, "fire", true, true), 1

    for x = -1, 4 do
        local pos = getThingPos(cid)
        for h = 1, 2 do
            if h == 1 then
                addEvent(doCannonEffect, current*50, cid, getPositionByDirection({x=pos.x+posEdit.x, y=pos.y+posEdit.y, z=pos.z}, playerDir, x), isPower)
            else
                addEvent(doCannonEffect, current*50, cid, getPositionByDirection({x=pos.x-posEdit.x, y=pos.y-posEdit.y, z=pos.z}, playerDir, x), isPower)
            end
        end
        current = current+1
    end
    return true
end
