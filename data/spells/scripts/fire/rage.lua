local cf = {}
cf.cooldown = 4

local centerPoses = {}

local combat1 = createCombatObject()
local combat2 = createCombatObject()
local combats = {combat1, combat2}

local arr = {	{0, 0, 1, 1, 1, 0, 0},
				{0, 1, 1, 1, 1, 1, 0},
				{1, 1, 1, 1, 1, 1, 1},
				{1, 1, 1, 3, 1, 1, 1},
				{1, 1, 1, 1, 1, 1, 1},
				{0, 1, 1, 1, 1, 1, 0},
				{0, 0, 1, 1, 1, 0, 0}
}
for x = 1, 2 do
	setCombatParam(combats[x], COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
	setCombatArea(combats[x], createCombatArea(arr))
	
	function onGetPlayerMinMaxValues(cid, level, magLevel)
		local vitality = getPlayerStorageValue(cid, "healthvalue")
		if not vitality then vitality = 0 end
		local mana = getPlayerStorageValue(cid, "manavalue")
		if not mana then mana = 0 end
		local dodge = getPlayerStorageValue(cid, "dodgevalue")
		if not dodge then dodge = 0 end
		local level = getPlayerLevel(cid)
		local magLevel = getPlayerMagLevel(cid)
		
		local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
		local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
		
		local dano = remakeValue(1, math.random(min, max), cid)	
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
		doSlow(cid, target, 25, 500)
		doSendMagicEffect(getThingPos(target), 36)
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

local function doConflagration(cid, pos, times)
	if not isCreature(cid) or isInPz(cid) then return true end
	local theCombat = 2
	if not times then
		theCombat = 1
		times = 10
		pos = getThingPos(cid)
		addEvent(sendDistances, 75, pos)
	end
	doCombat(cid, combats[theCombat], {type=2, pos=pos})
	
	if times > 0 then
		addEvent(doConflagration, 500, cid, pos, times-1)
	end
end

local function doCharges(cid, times)
	if not isCreature(cid) or isInPz(cid) then return true end
	if not times then times = 5 end
	local pos = getThingPos(cid)
	doSendDistanceShoot({x=pos.x-2, y=pos.y-2, z=pos.z}, pos, 52)
	doSendDistanceShoot({x=pos.x+2, y=pos.y+2, z=pos.z}, pos, 52)
	doSendDistanceShoot({x=pos.x+2, y=pos.y-2, z=pos.z}, pos, 52)
	doSendDistanceShoot({x=pos.x-2, y=pos.y+2, z=pos.z}, pos, 52)
      doSendMagicEffect(pos, 144)
	if times > 0 then
		addEvent(doCharges, 400, cid, times-1)
	else
		centerPoses[cid] = pos
		addEvent(doConflagration, 250, cid, pos)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "fire") == true then
		return false
	end
	if getPlayerExaust(cid, "fire", "rage") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "rage", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	doCharges(cid)
	addEvent(function() 
		centerPoses[cid] = nil 
	end, 10000)

    return true
end