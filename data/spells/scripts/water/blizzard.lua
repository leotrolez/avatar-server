local spellName = "water blizzard"
local cf = {atk = spellsInfo[spellName].atk}
local centerPoses = {}
local combat = createCombatObject()

local arr = {{0, 1, 1, 1, 0},
			{1, 1, 1, 1, 1},
			{1, 1, 3, 1, 1},
			{1, 1, 1, 1, 1},
			{0, 1, 1, 1, 0}
}

setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatArea(combat, createCombatArea(arr))
function onGetPlayerMinMaxValues(cid, level, magLevel)
		local min = (level+(magLevel/4)*0.3)*4.5
		local max = (level+(magLevel/4)*0.7)*5
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
	
function onTargetTile(creature, pos)
	local cid = creature:getId()
	addEvent(doSendMagicEffect, getDistanceBetween(pos, centerPoses[cid]) * 100, pos, 43)
 end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")
	
function onTargetCreature(creature, target)
  local cid = creature:getId()
	doFrozzenCreature(target, 2000)
	--local mypos = getCreaturePosition(target)
		--doSendMagicEffect({x=mypos.x+1, y=mypos.y+1, z=mypos.z}, 52)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")




local function sendDistances(pos)
	doSendDistanceShoot(pos, {x=pos.x-1, y=pos.y-1, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x+1, y=pos.y+1, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x+1, y=pos.y-1, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x-1, y=pos.y+1, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x-1, y=pos.y, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x+1, y=pos.y, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x, y=pos.y-1, z=pos.z}, 44)
	doSendDistanceShoot(pos, {x=pos.x, y=pos.y+1, z=pos.z}, 44)
end

local function doBlizzard(cid, pos)
	if not isCreature(cid) or isInPz(cid) then return true end
	pos = getThingPos(cid)
	doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 116)
	addEvent(sendDistances, 75, pos)
	doCombat(cid, combat, {type=2, pos=pos})
end

local function doCharges(cid, times)
	if not isCreature(cid) or isInPz(cid) then return true end
	if not times then times = 10 end
	local pos = getThingPos(cid)
	doSendDistanceShoot({x=pos.x+math.random(-2, 2), y=pos.y+math.random(-2, 2), z=pos.z}, pos, 44)
	doSendDistanceShoot({x=pos.x+math.random(-2, 2), y=pos.y+math.random(-2, 2), z=pos.z}, pos, 44)
	doSendDistanceShoot({x=pos.x+math.random(-2, 2), y=pos.y+math.random(-2, 2), z=pos.z}, pos, 44)
	doSendDistanceShoot({x=pos.x+math.random(-2, 2), y=pos.y+math.random(-2, 2), z=pos.z}, pos, 44)
	if times > 0 then
		if times % 2 == 0 then
			doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 116)
		end
		addEvent(doCharges, 200, cid, times-1)
	else
		centerPoses[cid] = pos
		addEvent(doBlizzard, 250, cid, pos)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
    if getPlayerExaust(cid, "water", "blizzard") == false then
        return false
    end
    if not canUseWaterSpell(cid, 1, 3, false) then
		return false
	end
	if getDobrasLevel(cid) >= 22 then
		doPlayerAddExaust(cid, "water", "blizzard", waterExausted.blizzard-12)
	else	
		doPlayerAddExaust(cid, "water", "blizzard", waterExausted.blizzard)
	end
    if getPlayerHasStun(cid) then
        return true
    end
	doCharges(cid)
	addEvent(function() 
		centerPoses[cid] = nil 
	end, 10000)
    return true
end
