local spellName = "earth wall"
local cf = {segundos = spellsInfo[spellName].segundos}

MyLocal = {}
MyLocal.barrierIdHorizontal = 13026
MyLocal.barrierIdVertical = 13027
MyLocal.timeBarrier = cf.segundos


local function getAddPoses(dirPos, playerDir)
	local finalPos1, finalPos2 = {}, {}
	if playerDir == 0 or playerDir == 2 then 
		finalPos1 = {x=dirPos.x+1, y=dirPos.y, z=dirPos.z}
		finalPos2 = {x=dirPos.x-1, y=dirPos.y, z=dirPos.z}
	else
		finalPos1 = {x=dirPos.x, y=dirPos.y+1, z=dirPos.z}
		finalPos2 = {x=dirPos.x, y=dirPos.y-1, z=dirPos.z}
	end 
	return {finalPos1, finalPos2}
end 

function canMakeWall(pos1, pos2, cid)
return getPlayerCanWalk({player = cid, position = pos1, checkPZ = true, checkHouse = true}) or getPlayerCanWalk({player = cid, position = pos2, checkPZ = true, checkHouse = true})
end 

function tryWall(cid, pos, dir)
local theTime = MyLocal.timeBarrier
if getDobrasLevel(cid) >= 7 then
	theTime = theTime+3
end
if getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true}) then 
	if dir == EAST or dir == WEST then
      addEvent(removeTileItemById, theTime*1000, pos, MyLocal.barrierIdVertical)

      addEvent(function(id, pos)
        local item = doCreateItem(id, pos)
        addEvent(removeTileItemById, theTime*1000, getThingPos(item), id)
      end, 300, MyLocal.barrierIdVertical, pos)
      doSendMagicEffect(pos, 73)
    else
      addEvent(function(id, pos)
        local item = doCreateItem(id, pos)
        addEvent(removeTileItemById, theTime*1000, getThingPos(item), id)  
      end, 300, MyLocal.barrierIdHorizontal, pos)
      doSendMagicEffect(pos, 72)
    end
end
end 
local function isNonPvp(cid)
return getPlayerStorageValue(cid, "canAttackable") == 1
end 
local function haveRecentPvPAround(pos)
	local players = getSpectators(pos, 5, 5)
	if players and #players >= 1 then 
		for i = 1, #players do 
			if isPlayer(players[i]) and exhaustion.check(players[i], "isInCombat") then 
				return true
			end				
		end
	end 
	return false
end
function onCastSpell(creature, var)
	local cid = creature:getId()
  if getSpellCancels(cid, "earth") == true then
      return false
    end
	if getTileInfo(getCreaturePosition(cid)).optional then 
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 
  if getPlayerExaust(cid, "earth", "wall") == false then
    return false
  end
  if isNonPvp(cid) and haveRecentPvPAround(getThingPos(cid)) then
		doPlayerSendCancelEf(cid, "You can't use this fold right now.")
	return false
  end 
  local playerDir = getPlayerLookDir(cid)
  local dirPos = getCreatureLookPosition(cid)
	local addPoses = getAddPoses(dirPos, playerDir)
	local posUm, posDois = addPoses[1], addPoses[2]

  if getPlayerCanWalk({player = cid, position = dirPos, checkPZ = true, checkHouse = true}) then
    doPlayerAddExaust(cid, "earth", "wall", earthExausted.wall)
    if getPlayerHasStun(cid) then
          return true
      end
	  local theTime = MyLocal.timeBarrier
		if getDobrasLevel(cid) >= 7 then
			theTime = theTime+3
		end
    if playerDir == EAST or playerDir == WEST then
      addEvent(removeTileItemById, theTime*1000, dirPos, MyLocal.barrierIdVertical)

      addEvent(function(id, pos)
        local item = doCreateItem(id, pos)
        addEvent(removeTileItemById, theTime*1000, getThingPos(item), id)
      end, 300, MyLocal.barrierIdVertical, dirPos)
      doSendMagicEffect(dirPos, 73)
    else
      addEvent(function(id, pos)
        local item = doCreateItem(id, pos)
        addEvent(removeTileItemById, theTime*1000, getThingPos(item), id)  
      end, 300, MyLocal.barrierIdHorizontal, dirPos)
      doSendMagicEffect(dirPos, 72)
    end
    setCreatureNoMoveTime(cid, 500) 
    return true
  elseif canMakeWall(posUm, posDois, cid) then 
		    doPlayerAddExaust(cid, "earth", "wall", earthExausted.wall)
			if getPlayerHasStun(cid) then
				return true
			end    
			tryWall(cid, posUm, playerDir)
			tryWall(cid, posDois, playerDir)
			setCreatureNoMoveTime(cid, 500) 
			return true
  else
    doPlayerSendCancel(cid, "There is not enough room.")
    return false
  end
end