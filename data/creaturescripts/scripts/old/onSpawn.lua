local MyLocal = {}
MyLocal.monstersSpawmed = {}
MyLocal.maxDistance = 25

local function loopMonstersExists(cid)
  if not isMonster(cid) then
    return true
  else
    local currentPos = getCreaturePosition(cid)
    local originalPos = MyLocal.monstersSpawmed[cid].pos

    if getCreatureMaster(cid) ~= nil then
      local masterCidPos = getCreaturePosition(getCreatureMaster(cid))
      if getDistanceBetween(masterCidPos, currentPos) > 7 then
        if getTileInfo(masterCidPos).protection ~= true and getTileInfo(masterCidPos).house ~= true then
          doTeleportCreature(cid, masterCidPos, 10)
        end
      end
    elseif getDistanceBetween(currentPos, originalPos) > MyLocal.maxDistance then
      if getCreatureMaster(cid) == cid then
        doSendAnimatedText(currentPos, "Too Far!", COLOR_WHITE)
        doTeleportCreature(cid, originalPos, 10)
      end  
    end
    addEvent(loopMonstersExists, 5*1000, cid)
  end
end

local function registerMonsters()
  local monsters = getMonstersOnline()
  for x = 1, #monsters do
    local currentMonster = monsters[x]
    local monsterPos = getCreaturePosition(currentMonster)
    MyLocal.monstersSpawmed[currentMonster] = {pos=monsterPos}
    addEvent(loopMonstersExists, 10*1000, currentMonster)
  end
end

function onSpawn(cid)
  local monsterPos = getCreaturePosition(cid)
  MyLocal.monstersSpawmed[cid] = {pos=monsterPos}
  addEvent(loopMonstersExists, 10*1000, cid)
  return true
end

addEvent(registerMonsters, 10*1000, nil)