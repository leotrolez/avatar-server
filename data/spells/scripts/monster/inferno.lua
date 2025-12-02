local MyLocal = {}
MyLocal.players = {}


local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 133)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 133)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 133)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 133)

local combats = {combat1, combat2, combat3, combat4}

for x = 1, #combats do
  function onTargetCreature(creature, target)
  local cid = creature:getId()
    if math.random(1, 5) == 5 then
      doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, isPlayer(cid))
      setPlayerStuned(target, math.random(5, 10))        
    end
  end

  function onGetPlayerMinMaxValues(cid, level, magLevel)
      local min = (level+(magLevel/3)*4.5)+math.random(30, 40)
      local max = (level+(magLevel/3)*5.7)+math.random(40, 50)

      return -min, -max
  end

  setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
  setCombatCallback(combats[x], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
end

local function sendQuakePos(cid, pos)
	if not getTileInfo(pos).protection then
		if math.random(1, 2) == 2 then
			doSendDistanceShoot(getThingPos(cid), pos, 3)
		end
		doCombat(cid, combats[math.random(1,4)], {pos=pos, type=2})
	end
end

local function quakeWork(cid, id, isEnd)
  if not isCreature(cid) then
    return false
  end
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
  --  doPlayerAddExaust(cid, "air", "doom", airExausted.doom)
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
	doCreatureSay(cid, "BUUUUUUUUURN!")
  for a = 0, 3 do
	addEvent(posQuakeWork, 1000*a, cid, a == 3)
  end
  return true
end

