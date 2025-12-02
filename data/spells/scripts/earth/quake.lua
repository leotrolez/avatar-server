local spellName = "earth quake"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}


local function getMin(cid)
	if not isPlayer(cid) then return 10 end
  local level = getPlayerLevel(cid)
  local magLevel = getPlayerMagLevel(cid)
  local min = ((level+(magLevel/6)*2.5)+math.random(20, 30)) * 2,6
  	if getPlayerInWaterWithUnderwater(cid) then 
		min = min*0.6
	end
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		min = min * (atk/100)
		min = min+1
	end
	min = remakeAirEarth(cid, min)
  return min
end

local function getMax(cid)
	if not isPlayer(cid) then return 20 end
  local level = getPlayerLevel(cid)
  local magLevel = getPlayerMagLevel(cid)
 local max = ((level+(magLevel/6)*3.2)+math.random(30, 40))* 2,6
 	if getPlayerInWaterWithUnderwater(cid) then 
		max = max*0.6
	end
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		max = max * (atk/100)
		max = max+1
	end
	max = remakeAirEarth(cid, max)
 return max
end

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 34)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 34)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 34)

local combats = {combat1, combat2, combat3, combat4}


local direction = {WEST, SOUTH, NORTH, EAST}

function onTargetCreature1(cid, target)
	if getCreatureName(target) ~= "target" then
		if math.random(1, 2) == 2 then
			doPushCreature(target, math.random(1, 4))
		end
	end
	  doSlow(cid, target, 15, 2000)   
	doTargetCombatHealth(cid, target, COMBAT_EARTHDAMAGE, -getMin(cid), -getMax(cid), 34)
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature1")

function onTargetCreature2(cid, target)
  if getCreatureName(target) ~= "target" then
		if math.random(1, 2) == 2 then
			doPushCreature(target, math.random(1, 4))
		end
	end
	  doSlow(cid, target, 15, 2000)    
	doTargetCombatHealth(cid, target, COMBAT_EARTHDAMAGE, -getMin(cid), -getMax(cid), 34)
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature2")

function onTargetCreature3(cid, target)
  if getCreatureName(target) ~= "target" then
		if math.random(1, 2) == 2 then
			doPushCreature(target, math.random(1, 4))
		end
	end
	  doSlow(cid, target, 15, 2000)   
	doTargetCombatHealth(cid, target, COMBAT_EARTHDAMAGE, -getMin(cid), -getMax(cid), 34)  
end

setCombatCallback(combat3, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature3")

function onTargetCreature4(cid, target)
	--print(getCreatureName(target)) --,getCreatureName(cid))
	if getCreatureName(target) ~= "target" then
		if math.random(1, 2) == 2 then
			doPushCreature(target, math.random(1, 4))
		end
	end
	  doSlow(cid, target, 15, 2000)   
	doTargetCombatHealth(cid, target, COMBAT_EARTHDAMAGE, -getMin(cid), -getMax(cid), 34)
end

setCombatCallback(combat4, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature4")

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


local function sendQuakePos(cid, pos)
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
    if (not hasSqm(pos) or not getTileInfo(pos).protection) and isSightClear(getCreaturePosition(cid), pos, true) then
		doCombat(cid, combats[math.random(1,4)], {pos=pos, type=2})  
		doSendMagicEffect(pos, 34)
		local skyPos = {x=pos.x, y=pos.y, z=pos.z-1}
		local player = getThingFromPosition(skyPos)
			if player.uid > 0 then 
				if isPlayer(player.uid) then 
					if not isImune(cid, player.uid) and getPlayerStorageValue(player.uid, "playerOnAir") == 1 then
						doPushCreature(player.uid, math.random(0, 3), 1, 500, false, true)
					end 
				end 
			end
	end
end

local function quakeWork(cid, id, isEnd)
	
  if not isCreature(cid) then
    return false
  end
  if getTileInfo(getCreaturePosition(cid)).protection then return false end
  local poses = shuffleList(MyLocal.players[cid])
  for counter = 1, math.ceil(#poses/6) do
    for h = 1, #poses do
      if poses[h].used == false then
        sendQuakePos(cid, poses[h])
        poses[h].used = true
        break
      end
    end
  end
  if id and isEnd then
    MyLocal.players[cid] = nil
    --doPlayerAddExaust(cid, "earth", "quake", earthExausted.quake)
  else
    MyLocal.players[cid] = poses
  end
end

local function posQuakeWork(cid, isEnd)
  if not isCreature(cid) then
    return false
  end
  local playerPos = getCreaturePosition(cid)
  local poses = {}
  for x = -math.random(5, 7), math.random(5, 7) do
    for y = -math.random(3, 5), math.random(3, 5) do
      table.insert(poses, {x=playerPos.x+x,y=playerPos.y+y,z=playerPos.z, used=false})
    end
  end
  MyLocal.players[cid] = poses

  for x = 1, 4 do
    addEvent(quakeWork, 200*x, cid, x == 4, isEnd)
  end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
	if getTileInfo(getCreaturePosition(cid)).optional or isInWarGround(cid) then
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 

    if getPlayerExaust(cid, "earth", "quake") == false then
      return false
    end
    if getPlayerHasStun(cid) then
		if getDobrasLevel(cid) >= 18 then
          doPlayerAddExaust(cid, "earth", "quake", earthExausted.quake-9)
		else
          doPlayerAddExaust(cid, "earth", "quake", earthExausted.quake)
		  end
          return true
      end
      for a = 0, 3 do
        addEvent(posQuakeWork, 1000*a, cid, a == 3)
      end
      --workAllCdAndAndPrevCd(cid, "earth", "quake", 9*1000, 1)
		if getDobrasLevel(cid) >= 18 then
			doPlayerAddExaust(cid, "earth", "quake", earthExausted.quake-9)
		else
			doPlayerAddExaust(cid, "earth", "quake", earthExausted.quake)
		end
    return true

end