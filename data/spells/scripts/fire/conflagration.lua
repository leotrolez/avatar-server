local spellName = "fire conflagration"
local cf = {atk = spellsInfo[spellName].atk}
local centerPoses = {}

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combat1Focus = createCombatObject()
local combat2Focus = createCombatObject()
local combats = {combat1, combat2, combat1Focus, combat2Focus}

local arr = {	{0, 0, 1, 1, 1, 0, 0},
				{0, 1, 1, 1, 1, 1, 0},
				{1, 1, 1, 1, 1, 1, 1},
				{1, 1, 1, 3, 1, 1, 1},
				{1, 1, 1, 1, 1, 1, 1},
				{0, 1, 1, 1, 1, 1, 0},
				{0, 0, 1, 1, 1, 0, 0}
}
for x = 1, 4 do
	setCombatParam(combats[x], COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
	setCombatArea(combats[x], createCombatArea(arr))
	function onGetPlayerMinMaxValues(cid, level, magLevel)
		local min = level+(magLevel/4)*0.3
		local max = level+(magLevel/4)*0.7
		local dano = math.random(min, max)
		local atk = cf.atk
		if atk and type(atk) == "number" then 
			dano = dano * (atk/100)
			dano = dano+1
		end
		if x == 1 or x == 3 then
			dano = dano*2.5
		end
		if x > 2 then
			dano = dano*1.8
		end
		dano = remakeValue(1, dano, cid)
		return -dano, -dano
	end
	setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
	
    function onTargetTile(creature, pos)
	local cid = creature:getId()
		addEvent(doSendMagicEffect, getDistanceBetween(pos, centerPoses[cid]) * 100, pos, 144)
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
	
	function onTargetCreature(creature, target)
  local cid = creature:getId()
		doSlow(cid, target, 30, 500)
		doSendMagicEffect(getThingPos(target), 144)
	end
	setCombatCallback(combats[x], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
end



local function sendDistances(pos)
	doSendDistanceShoot(pos, {x=pos.x-1, y=pos.y-1, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x+1, y=pos.y+1, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x+1, y=pos.y-1, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x-1, y=pos.y+1, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x-1, y=pos.y, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x+1, y=pos.y, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x, y=pos.y-1, z=pos.z}, 52)
	doSendDistanceShoot(pos, {x=pos.x, y=pos.y+1, z=pos.z}, 52)
end

local function doConflagration(cid, pos, haveFocus, times)
	if not isCreature(cid) or isInPz(cid) then return true end
	local theCombat = 2
	if not times then
		theCombat = 1
		times = 10
		pos = getThingPos(cid)
		addEvent(sendDistances, 75, pos)
	end
	if haveFocus then
		theCombat = theCombat+2
	end
	doCombat(cid, combats[theCombat], {type=2, pos=pos})
	
	if times > 0 then
		addEvent(doConflagration, 500, cid, pos, haveFocus, times-1)
	end
end

local function doCharges(cid, haveFocus, times)
	if not isCreature(cid) or isInPz(cid) then return true end
	if not times then times = 5 end
	local pos = getThingPos(cid)
	doSendDistanceShoot({x=pos.x-2, y=pos.y-2, z=pos.z}, pos, 52)
	doSendDistanceShoot({x=pos.x+2, y=pos.y+2, z=pos.z}, pos, 52)
	doSendDistanceShoot({x=pos.x+2, y=pos.y-2, z=pos.z}, pos, 52)
	doSendDistanceShoot({x=pos.x-2, y=pos.y+2, z=pos.z}, pos, 52)
      doSendMagicEffect(pos, 144)
	if times > 0 then
		addEvent(doCharges, 400, cid, haveFocus, times-1)
	else
		centerPoses[cid] = pos
		addEvent(doConflagration, 250, cid, pos, haveFocus)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if getPlayerExaust(cid, "fire", "conflagration") == false then
        return false
    end
	if getDobrasLevel(cid) >= 23 then
		doPlayerAddExaust(cid, "fire", "conflagration", fireExausted.conflagration-18)
	else	
		doPlayerAddExaust(cid, "fire", "conflagration", fireExausted.conflagration)
	end
    if getPlayerHasStun(cid) then
        return true
    end
	local haveFocus = getPlayerOverPower(cid, "fire", true, true)
	doCharges(cid, haveFocus)
	addEvent(function() 
		centerPoses[cid] = nil 
	end, 10000)

    return true
end
