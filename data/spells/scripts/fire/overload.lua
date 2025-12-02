local spellName = "fire overload"
local cf = {atk = spellsInfo[spellName].atk}

local function isInPvpZone(cid)
local pos = getCreaturePosition(cid)
	if getTileInfo(pos).hardcore then
		return true 
	end
return false
end

local function isInSameGuild(cid, target)
if isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
	local cidGuild = getPlayerGuildId(cid)
	local targGuild = getPlayerGuildId(target)
	if cidGuild > 0 and cidGuild == targGuild then
		return true
	end
end
	return false
end

local skulls = {1,3,4,5,6}
local function isImune(cid, creature)
	if isNpc(creature) or (isPlayer(creature) and getPlayerAccess(creature) >= 3)  then
		return true
	end
	if isMonster(creature) and isSummon(creature) and getCreatureMaster(creature) ~= cid then
		return isImune(cid, getCreatureMaster(creature))
	end
    if isMonster(creature) or isMonster(cid) then 
        return false 
    end
	if isPlayer(cid) and isPlayer(creature) and (getPlayerStorageValue(cid, "canAttackable") == 1 or getPlayerStorageValue(creature, "canAttackable") == 1) then 
		return true 
	end 
    if isInParty(cid) and isInParty(creature) and getPlayerParty(cid) == getPlayerParty(creature) then
        return true
    end 
	if isInSameGuild(cid, target) then
		return true
	end
    local modes = getPlayerModes(cid)
    if isInArray(skulls, getCreatureSkullType(creature)) then
        return false
    end     
    if (modes.secure == SECUREMODE_OFF) then
        return false
    end
    return true
end

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 148)
setCombatArea(combat, createCombatArea(AREA_SQUARE1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*7.5)+math.random(40, 50)
    local max = (level+(magLevel/2)*8.0)+math.random(50, 55)
	if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
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

local config = {
	effectx = 4, --- efeito de distancia
	percent = 70, --- porcentagem de ir pra outro target apos hitar
	delay = 120 --- velocidade com que se move (milisegundos)
}

function doBlast(uid, target, delay, effectx, effectz, hits, fromPos, n)
	if fromPos ~= nil and (fromPos.x ~= getCreaturePosition(target).x or fromPos.y ~= getCreaturePosition(target).y) then
		doSendDistanceShoot(fromPos, getCreaturePosition(target), effectx)
		fromPos = (fromPos.x ~= getCreaturePosition(target).x or fromPos.y ~= getCreaturePosition(target).y) and getCreaturePosition(target) or nil
	else
		fromPos = getCreaturePosition(target)
	end	
	doCombat(uid, combat, {type=3, pos=fromPos})
	n = n or 1
	possible = {}
	for _, possivel in ipairs(getSpectators(fromPos, 2, 2)) do
		if isSightClear(fromPos, getCreaturePosition(possivel), true) and not isInPz(possivel) and not isImune(uid, possivel) and possivel ~= target and possivel ~= uid then
			table.insert(possible, possivel)
		end
	end
	target = #possible > 0 and possible[math.random(#possible)] or uid
	local range = getDistanceBetween(fromPos, getCreaturePosition(target))
	range = range > 0 and range or 1
	if n < hits then
		addEvent(function()
		if isCreature(uid) and isCreature(target) then
			doBlast(uid, target, delay, effectx, effectz, hits, fromPos, (n + 1))
		end
		end, delay*range)
	end

return true
end

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "fire") == true then
       return false
	end
	local theCooldown = fireExausted.overload
	if getDobrasLevel(cid) >= 18 then
		theCooldown = theCooldown-6
	end
	if doPlayerAddExaust(cid, "fire", "overload", theCooldown) == false then
       return false
	end
	if getPlayerHasStun(cid) then
       return true
	end
	local target = getCreatureTarget(cid)
	if getPlayerOverPower(cid, "fire", true, true) then
		doBlast(cid, target, config.delay, config.effectx, config.effectz, 5, getCreaturePosition(cid), nil)
	end
	
	doBlast(cid, target, config.delay, config.effectx, config.effectz, 5, getCreaturePosition(cid), nil)
return true
end