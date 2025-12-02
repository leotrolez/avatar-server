local spellName = "water cannon"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}
MyLocal.range = 5

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 153)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*4.1)+math.random(3, 5)
    local max = (level+(magLevel/3)*4.9)+math.random(5, 8)

	
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
    if isNpc(target) then
        return false
    end
    local dir = getCreatureLookDirection(cid)
    doPushCreature(target, dir)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid)
    if isCreature(cid) then
        MyLocal.players[cid] = nil
    end
end

local function addCannonInPos(cid, pos, isFinal)
    if isCreature(cid) then
        doCombat(cid, combat, {type=2, pos=pos})
        if isFinal then
            removeTable(cid)
        end
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end 
    if getPlayerExaust(cid, "water", "cannon") == false then
        return false
    end
    if MyLocal.players[cid] ~= nil then
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false 
    end
    if canUseWaterSpell(cid, 1, 3, false) then
        MyLocal.players[cid] = 0
        addEvent(removeTable, 1000, cid)
		if getDobrasLevel(cid) >= 9 then
			doPlayerAddExaust(cid, "water", "cannon", waterExausted.cannon-2)
		else
			doPlayerAddExaust(cid, "water", "cannon", waterExausted.cannon)
		end
        if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "water", "cannon", nil, 1)
            return true
        end
        workAllCdAndAndPrevCd(cid, "water", "cannon", nil, 1)
        for x = 1, MyLocal.range do
            addEvent(addCannonInPos, x*50, cid, getPositionByDirection(getThingPos(cid), getCreatureLookDirection(cid), x), x == MyLocal.range)
        end
        return true
    else
        return false
    end
end
