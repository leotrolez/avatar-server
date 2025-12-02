local config = {
	cooldown = 4,
	cooldownReduced = 2,
	duration = 20000,
}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)


local function sendInfoTime(pos, wallId, times)
	local v = getTileItemById(pos, wallId).uid
	if v <= 0 then
		return false
	end
	if times > 4 then 
		if times <= 25 and times % 5 == 0 then
			doSendAnimatedText(pos, times/5, 180)
		end
		addEvent(sendInfoTime, 200, pos, wallId, times-1)
	end 
end 

local function checkMw(pos, skyPos, wallId)
	local v = getTileItemById(pos, wallId).uid
	if v > 0 then
		addEvent(checkMw, 200, pos, skyPos, wallId)
	else
		local invisible = getTileItemById(skyPos, 8046).uid
		if invisible > 0 then
			doRemoveItem(invisible)
			removeTileItemById(skyPos, 460)
		end
	end
end

local function createWallAbove(pos, wallId)
	local skyPos = {x=pos.x, y=pos.y, z=pos.z-1}
	if not hasSqm(skyPos) and not(getThingFromPos(skyPos, false).uid > 0) and skyPos.z ~= 0 then 
		addEvent(checkMw, 200, pos, skyPos, wallId)
		doCreateTile(460, skyPos)
		doCreateItem(8046, skyPos)
	end
end

local function removeWall(pos, wallId, times)
	local v = getTileItemById(pos, wallId).uid
	if v > 0 then
		if times > 0 then
			addEvent(removeWall, 200, pos, wallId, times-1)
			return true
		end
		doRemoveItem(v)
		checkMw(pos, {x=pos.x, y=pos.y, z=pos.z-1}, wallId)
	end
end

function onTargetTile(creature, pos)
	local cid = creature:getId()
	local cooldown = config.cooldown
	if getPlayerStorageValue(cid, "isPromoted") == 1 then
		cooldown = config.cooldownReduced
	end
	exhaustion.set(cid, 31851, cooldown)
	local vocation = getPlayerVocation(cid)
	local runeId = 1498
	if vocation >= 1 and vocation <= 4 then
		local runes = {18139, 1498, 18137, 18138}
		local distances = {57, 58, 59, 60}
		doSendDistanceShoot(getThingPos(cid), pos, distances[vocation])
		runeId = runes[vocation]
    end
	local item = doCreateItem(runeId, pos)
	sendInfoTime(getThingPos(item), runeId, config.duration/200)
	removeWall(getThingPos(item), runeId, config.duration/200)
	createWallAbove(pos, runeId)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile") 

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).optional or getTileInfo(getCreaturePosition(cid)).hardcore then 
		doPlayerSendCancelEf(cid, "You can't use this here.")
		return false
	end 
	if getCreatureNoMove(cid) == true then
		return false
	end
	local pos = variantToPosition(var)
	local aguas = {4825, 4820, 4821, 4822, 4823, 4824, 4619, 4666, 4608, 4613, 4614, 
           4664, 4616, 4618, 4617, 4619, 4665, 4611, 493}
	local itemId = getThingFromPos({x=pos.x,y=pos.y,z=pos.z,stackpos=0}).itemid
	if isInArray(aguas, itemId) or getTileItemById(pos, 13025).uid > 0 then
		doPlayerSendCancel(cid, "There is not enough room.")
		doSendMagicEffect(getThingPos(cid), 2, cid)
		return false
	end
	if exhaustion.check(cid, 31851) then
		doPlayerSendCancel(cid, "You are exhausted.")
		doSendMagicEffect(getThingPos(cid), 2, cid)
		return false
	end
	return doCombat(cid, combat, var)
end