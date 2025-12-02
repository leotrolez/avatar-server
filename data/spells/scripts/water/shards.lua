local spellName = "water shards"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatArea(combat1, createCombatArea(AREA_SQUARE1X1))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 28)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.1)+math.random(5, 10)
    local max = (level+(magLevel/2)*4.5)+math.random(10, 15)

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

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*4.1)+math.random(5, 10))*0.75
    local max = ((level+(magLevel/2)*4.5)+math.random(10, 15))*0.75

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(2, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local xizes1 = {0, -1, -1, 0} -- cima pra esquerda, esquerda pra baixo
local yizes1 = {-1, 0, 0, 1} -- cima pra esquerda, esquerda pra baixo
local xizes2 = {0, 1, 1, 0} -- baixo pra direita, direita pra cima
local yizes2 = {1, 0, 0, -1} -- baixo pra direita, direita pra cima



local function shardsWork(cid, state)
	if not isCreature(cid) or isInPz(cid) then return false end
		local pos = getCreaturePosition(cid)
        doSendDistanceShoot({x=pos.x+xizes1[state], y=pos.y+yizes1[state], z=pos.z}, {x=pos.x+xizes1[state+1], y=pos.y+yizes1[state+1], z=pos.z}, 28)
        doSendDistanceShoot({x=pos.x+xizes2[state], y=pos.y+yizes2[state], z=pos.z}, {x=pos.x+xizes2[state+1], y=pos.y+yizes2[state+1], z=pos.z}, 28)
	if state == 3 then 
		state = -1
		local target = getCreatureTarget(cid)
		if isCreature(target) and getDistanceBetween(pos, getCreaturePosition(target)) <= 4 and isSightClear(pos, getCreaturePosition(target), true) then
			doCombat(cid, combat2, numberToVariant(target))
		end
	else 
		doCombat(cid, combat1, {type=2, pos=pos})
	end
	if MyLocal.players[cid] ~= nil then
		addEvent(shardsWork, 150, cid, state+2)
	end
end

local function removeTable(cid)
    MyLocal.players[cid] = nil
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "shards") == false then
        return false
    end
    if canUseWaterSpell(cid, 1, 3, false) then
        if MyLocal.players[cid] == nil then
            workAllCdAndAndPrevCd(cid, "water", "shards", nil, 1)
			if getDobrasLevel(cid) >= 7 then
				doPlayerAddExaust(cid, "water", "shards", waterExausted.shards-2)
			else
				doPlayerAddExaust(cid, "water", "shards", waterExausted.shards)
			end
            if getPlayerHasStun(cid) then
                return true
            end
            MyLocal.players[cid] = 0
            shardsWork(cid, 1)
            addEvent(removeTable, 3000, cid)
            return true
        else
            doPlayerSendCancelEf(cid, "You're already using this fold.")
            return false
        end
    else
        return false
    end
end
