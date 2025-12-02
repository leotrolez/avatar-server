local spellName = "air doom"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 76)
 
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 76)
 
local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 76)
 
local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 76)
 
local combats = {combat1, combat2, combat3, combat4}
 
for x = 1, #combats do
        function onTargetCreature(creature, target)
  local cid = creature:getId()
                if math.random(1, 5) >= 3 then
					if getCreatureName(target) ~= "target" then
                        doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, isPlayer(cid))
					end
					--setPlayerStuned(target, math.random(5, 10))
                end
        end
 
        function onGetPlayerMinMaxValues(cid, level, magLevel)
                local min = (level+(magLevel/3)*4.5)+math.random(30, 40)
                local max = (level+(magLevel/3)*5.7)+math.random(40, 50)
				local dano = math.random(min, max)
				local atk = cf.atk
				if atk and type(atk) == "number" then 
					dano = dano * (atk/100)
					dano = dano+1
				end
				dano = remakeAirEarth(cid, dano)
				return -dano, -dano
        end
 
        setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
        setCombatCallback(combats[x], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
end
 
 local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true)
end

local function sendQuakePos(cid, pos)
	 if getTileInfo(getCreaturePosition(cid)).protection then return false end
-- if getTileInfo(pos) and not getTileInfo(pos).protection then
  if math.random(1, 2) == 2 and (not hasSqm(pos) or not getTileInfo(pos).protection) then
   doSendDistanceShoot(getThingPos(cid), pos, 48)
  end
  doCombat(cid, combats[math.random(1,4)], {pos=pos, type=2})
-- end
end
 
local function quakeWork(cid, id, isEnd)
        if not isCreature(cid) then
                return false
        end
		if getTileInfo(getCreaturePosition(cid)).protection then return false end
 
        local poses = shuffleList(MyLocal[cid])
        for counter = 1, math.ceil(#poses/6) do
                for h = 1, #poses do
                        if poses[h].used == false and poses[h] and isProjectable(poses[h]) and isSightClear(getCreaturePosition(cid), poses[h], true) then
                                sendQuakePos(cid, poses[h])
                                poses[h].used = true
                                break
                        end
                end
        end
 
        if id and isEnd then
                MyLocal[cid] = nil
        else
                MyLocal[cid] = poses
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
 
        MyLocal[cid] = poses
        for x = 1, 4 do
                addEvent(quakeWork, 200*x, cid, x == 4, isEnd)
        end
end

 

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getTileInfo(getCreaturePosition(cid)).optional or isInWarGround(cid) then 
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 
	if MyLocal.players[cid] == nil then
		if getPlayerExaust(cid, "air", "doom") == false then
			return false
		end
		if getPlayerHasStun(cid) then
			if getDobrasLevel(cid) >= 18 then
				doPlayerAddExaust(cid, "air", "doom", airExausted.doom-9)
			else
				doPlayerAddExaust(cid, "air", "doom", airExausted.doom)
			end
			return true
		end
		for a = 0, 3 do
			addEvent(posQuakeWork, 1000*a, cid, a == 3)
		end
		if getDobrasLevel(cid) >= 18 then
			doPlayerAddExaust(cid, "air", "doom", airExausted.doom-9)
		else
			doPlayerAddExaust(cid, "air", "doom", airExausted.doom)
		end
		--workAllCdAndAndPrevCd(cid, "air", "doom", 9*1000, 1)
		workAllCdAndAndPrevCd(cid, "air", "doom", 3000, 1)
		refreshSpellsFunc(cid)
		return true
	else
		doPlayerSendCancelEf(cid, "You're already using this fold.")
		return false
	end
end