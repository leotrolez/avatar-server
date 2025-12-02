local spellName = "fire clock"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--
local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 15)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/2)*4.3)+math.random(15, 20))*0.8
    local max = ((level+(magLevel/2)*5.1)+math.random(20, 21))*0.8
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
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local combatFocus = createCombatObject()
setCombatParam(combatFocus, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combatFocus, COMBAT_PARAM_EFFECT, 15)

function onGetPlayerMinMaxValuesFocus(cid, level, magLevel)
    local min = (((level+(magLevel/2)*4.3)+math.random(15, 20))*1.5)*0.8
    local max = (((level+(magLevel/2)*5.1)+math.random(20, 21))*2.0)*0.8
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
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
end
setCombatCallback(combatFocus, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValuesFocus")



local function getPositionsAroundPlayer(cid)
    local pos, poses = getThingPos(cid), {}
    table.insert(poses, {x=pos.x,y=pos.y-1,z=pos.z, dir = WEST})
    table.insert(poses, {x=pos.x-1,y=pos.y-1,z=pos.z, dir = SOUTH})
    table.insert(poses, {x=pos.x-1,y=pos.y,z=pos.z, dir = SOUTH})
    table.insert(poses, {x=pos.x-1,y=pos.y+1,z=pos.z, dir = EAST})
    table.insert(poses, {x=pos.x,y=pos.y+1,z=pos.z, dir = EAST})
    table.insert(poses, {x=pos.x+1,y=pos.y+1,z=pos.z, dir = NORTH})
    table.insert(poses, {x=pos.x+1,y=pos.y,z=pos.z, dir = NORTH})
    table.insert(poses, {x=pos.x+1,y=pos.y-1,z=pos.z, dir = WEST})
    return poses
end

--[[function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if doPlayerAddExaust(cid, "fire", "field", fireExausted.field) == false then
      return false
    end
    if getPlayerHasStun(cid) then
      return true
    end
    getPlayerOverPower(cid, "fire", true, true)
  return doCombat(cid, combat, var)
end--]]


function onTargetCreature(creature, target)
  local cid = creature:getId()
    if isNpc(target) then
        return false
    end
    local poses = MyLocal.players[cid]
        if poses == nil then 
        poses = getPositionsAroundPlayer(cid)
     end 
    local targetPos = getThingPos(target)
    doPlayerCancelFollow(target)
    for x = 1, #poses do
        if poses[x].x == targetPos.x and poses[x].y == targetPos.y and poses[x].z == targetPos.z then
            if getCreatureName(target) ~= "target" then
				doPushCreature(target, poses[x].dir) 
				setCreatureNoMoveTime(target, 95) 
				exhaustion.set(target, "airtrapped", 1)
            end
        end
    end
end

function onTargetCreatureFocus(cid, target)
    if isNpc(target) then
        return false
    end
    local poses = MyLocal.players[cid]
        if poses == nil then 
        poses = getPositionsAroundPlayer(cid)
     end 
    local targetPos = getThingPos(target)
    doPlayerCancelFollow(target)
    for x = 1, #poses do
        if poses[x].x == targetPos.x and poses[x].y == targetPos.y and poses[x].z == targetPos.z then
			if getCreatureName(target) ~= "target" then
				doPushCreature(target, poses[x].dir)
				setCreatureNoMoveTime(target, 90) 
				exhaustion.set(target, "airtrapped", 1)
            end
        end
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
setCombatCallback(combatFocus, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreatureFocus")

local function sendSpell(cid, pos, focus, isEnd, centerPos, xis)
    if not isCreature(cid) then
        return false
    end
    if getTileInfo(pos).protection then return false end
	if xis % 3 == 0 then
		doSendMagicEffect(centerPos, 91)
	end
    if focus then
        doCombat(cid, combatFocus, {type=2, pos=pos})
    else
        doCombat(cid, combat, {type=2, pos=pos})
    end
    if isEnd then
    end  
end


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if getPlayerExaust(cid, "fire", "clock") == false then
        return false
    end
	
        MyLocal.players[cid] = nil
    --if MyLocal.players[cid] == nil then
        if getPlayerHasStun(cid) then
			if getDobrasLevel(cid) >= 14 then
				doPlayerAddExaust(cid, "fire", "clock", fireExausted.clock-4)
			else
				doPlayerAddExaust(cid, "fire", "clock", fireExausted.clock)
			end
            workAllCdAndAndPrevCd(cid, "fire", "clock", nil, 1)
            return true
        end
        MyLocal.players[cid] = getPositionsAroundPlayer(cid)
       -- setCreatureNoMoveTime(cid, 5.75*1000)
        exhaustion.set(cid, "fireclockTime", 3)
       -- doPlayerCancelFollow(cid)
		local focusR = getPlayerOverPower(cid, "fire", true, true)
		local centerPos = getCreaturePosition(cid)
        for h = 0, 2 do
            for x = 1, #MyLocal.players[cid] do
                addEvent(sendSpell, (801*h)+100*x, cid, MyLocal.players[cid][x], focusR, x == #MyLocal.players[cid] and h == 2, centerPos, x)
            end
        end
		if getDobrasLevel(cid) >= 14 then
			doPlayerAddExaust(cid, "fire", "clock", fireExausted.clock-4)
		else
			doPlayerAddExaust(cid, "fire", "clock", fireExausted.clock)
		end
        workAllCdAndAndPrevCd(cid, "fire", "clock", nil, 1)
        return true
    --else
     --   doPlayerSendCancelEf(cid, "You're already using this fold.")
      --  return false
   -- end
end