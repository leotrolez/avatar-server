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

local function isPzPos(pos)
if not hasSqm(pos) then 
	return false
end 
return getTileInfo(pos).protection
end

local function isAndavel(pos, cid)
return getPlayerCanWalk({player = cid, position = pos, checkPZ = false, checkHouse = true, createTile = itsFlySpell and isPlayer(cid)})
end 

local function isProjectable(pos)
if not hasSqm(pos) then 
	return true 
end 
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end 
local skulls = {1,3,4,5,6}
local function isImune(cid, creature)
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

local combat=createCombatObject() 
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE) 


local spellName = "earth collapse"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
--[[
function onTargetTile(creature, pos)
	local cid = creature:getId()
    return doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, cf.effectExplo)
end
    setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")]]
	
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.1)+math.random(3, 7)
    local max = (level+(magLevel/2)*5.3)+math.random(7, 15)
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
	return -dano, -dano
 end
    setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
    
function onTargetCreature(creature, target)
  local cid = creature:getId()
    if isNpc(target) then
        return false
    end
	if getPlayerStorageValue(target, "playerOnAir") == 1 then 
		doPushCreature(player.uid, math.random(0, 3), 1, 500, false, true)
	end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function startExplosion(cid, poses)
    if not isCreature(cid) then
        return false
    end
	local mypos = getCreaturePosition(cid)
    if getTileInfo(mypos).protection then return false end
        for i = 1, #poses do 
			local posHit = poses[i]
			if isProjectable(posHit) and not isPzPos(posHit) and isSightClear(mypos, posHit, true) then 
				doCombat(cid, combat, {type=2, pos=posHit})
				local random = 200+(-20*i)
				addEvent(doSendMagicEffect, random+50, Position(posHit), 34)
				local skyPos = {x=posHit.x, y=posHit.y, z=posHit.z-1}
				local player = getThingFromPosition(skyPos)
				if player.uid > 0 then 
					if isPlayer(player.uid) then 
						if not isImune(cid, player.uid) and getPlayerStorageValue(player.uid, "playerOnAir") == 1 then
						 local level, magLevel = 50, 30
						 if isPlayer(cid) then 
							level, magLevel = getPlayerLevel(cid), getPlayerMagLevel(cid)
						  end 
						 local min = (level+(magLevel/2)*4.1)+math.random(3, 7)
						 local max = (level+(magLevel/2)*5.3)+math.random(7, 15)
					     local dano = math.random(min, max)
					     local atk = cf.atk
					 	 if atk and type(atk) == "number" then 
							dano = dano * (atk/100)
							dano = dano+1
						 end
							dano = remakeValue(1, dano)
							doTargetCombatHealth(cid, player.uid, COMBAT_EARTHDAMAGE, -dano, -dano, 0)
							doPushCreature(player.uid, math.random(0, 3), 1, 500, false, true)
						end
					end 
				end 
			end
        end 
end

local combat1 = createCombatObject()
local area1 = {
	{1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1},
	{0, 0, 3, 0, 0}
}
setCombatArea(combat1, createCombatArea(area1))

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "earth") == true then
       return false
	end
	local theCooldown = earthExausted.collapse
	if getDobrasLevel(cid) >= 7 then
		theCooldown = theCooldown-2
	end
	if doPlayerAddExaust(cid, "earth", "collapse", theCooldown) == false then
       return false
	end
	if getPlayerHasStun(cid) then
       workAllCdAndAndPrevCd(cid, "earth", "collapse", nil, 1)
       return true
	end

	local poses = combat1:getPositions(creature, var)
	addEvent(startExplosion, 800, cid, poses)
	local yizes = {-1, 0, 1, 0}
	local xizes = {0, -1, 0, 1}
	local mypos = getThingPos(cid)
	for i = 1, #yizes do 
		local toPos = {x=mypos.x+xizes[i], y=mypos.y+yizes[i], z=mypos.z}
		if isProjectable(toPos) then 
			addEvent(function() doSendDistanceShoot(mypos, {x=mypos.x-7, y=mypos.y-7, z=mypos.z}, 11) end, 50+(i*30))
			addEvent(function () 
					if isCreature(cid) then 
						doSendDistanceShoot({x=toPos.x-7, y=toPos.y-7, z=mypos.z}, toPos, 11)
					end 
			end, 500 + (i*30))
		end
	end 
    return true
end