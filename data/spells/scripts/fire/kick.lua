local spellName = "fire kick"
local cf = {atk = spellsInfo[spellName].atk}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*3.5)+math.random(20, 25)
    local max = (level+(magLevel/2)*5.0)+math.random(25, 35)
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
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*3.5)+math.random(20, 25))*2.25
    local max = ((level+(magLevel/2)*5.0)+math.random(25, 35))*2.25
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
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end 
    if getPlayerExaust(cid, "fire", "kick") == false then
        return false
    end
    if getPlayerHasStun(cid) then
        doPlayerAddExaust(cid, "fire", "kick", fireExausted.kick)
        workAllCdAndAndPrevCd(cid, "fire", "kick", nil, 1)
        return true
    end
    local target = getCreatureTarget(cid)

    if target > 0 then
        if getDistanceBetween(getThingPos(cid), getThingPos(target)) < 5 then
				doPlayerAddExaust(cid, "fire", "kick", fireExausted.kick)
			    workAllCdAndAndPrevCd(cid, "fire", "kick", nil, 1)
				local mypos = getThingPos(cid)
				doSendMagicEffect(mypos, 90)
				local targpos = getThingPos(target)
				doSendDistanceShoot({x=mypos.x+1, y=mypos.y, z=mypos.z}, targpos, 3)
				doSendDistanceShoot({x=mypos.x-1, y=mypos.y, z=mypos.z}, targpos, 3)
				doSendDistanceShoot({x=mypos.x, y=mypos.y+1, z=mypos.z}, targpos, 3)
				doSendDistanceShoot({x=mypos.x, y=mypos.y-1, z=mypos.z}, targpos, 3)
				doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 137)
            if getPlayerOverPower(cid, "fire", true, true) then
                return doCombat(cid, combatFocus, {pos=targpos, type=2})
            else
                return doCombat(cid, combat, {pos=targpos, type=2})
            end
        else
            doPlayerSendCancelEf(cid, "Creature is not reachable.")
            return false
        end
    end
end