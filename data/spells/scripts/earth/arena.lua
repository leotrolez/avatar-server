local spellName = "earth arena"
local cf = {duracao = spellsInfo[spellName].duracao}

local MyLocal = {}
MyLocal.players = {}
MyLocal.earthId = 17823

local combat = createCombatObject()

local arr = {
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0},
{0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
{1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1},
{1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1},
{1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1},
{0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
{0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
}

setCombatArea(combat, createCombatArea(arr))

local function getDrewMap(map)
  local points = 0
  for x = 1, #map do
    for y = 1, #map[x] do
      if map[x][y] == 1 then
        points = points+1
      end
    end
  end
  return points
end

local function zerarTable(cid)
  MyLocal.players[cid] = nil  
  if isCreature(cid) then
  if getDobrasLevel(cid) >= 16 then
	doPlayerAddExaust(cid, "earth", "arena", earthExausted.arena-11)
  else
	doPlayerAddExaust(cid, "earth", "arena", earthExausted.arena)
  end
  end
end

function onTargetTile(creature, pos)
	local cid = creature:getId()  
    if getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true}) then
      addEvent(doCreateItem, MyLocal.players[cid].number*15+50, MyLocal.earthId, pos)
      addEvent(removeTileItemById, cf.duracao, pos, MyLocal.earthId)
      doSendMagicEffect(pos, 34)
	  local skyPos = {x=pos.x, y=pos.y, z=pos.z-1}
	  if not hasSqm(skyPos) and not(getThingFromPos(skyPos, false).uid > 0) and skyPos.z ~= 0 then 
		doCreateTile(460, skyPos)
		addEvent(removeTileItemById, cf.duracao, skyPos, 460)
		 addEvent(doCreateItem, MyLocal.players[cid].number*15+50, MyLocal.earthId, skyPos)
		addEvent(removeTileItemById, cf.duracao, skyPos, MyLocal.earthId)
	  end 
      for x = 1, 5 do
        addEvent(doSendMagicEffect, (cf.duracao/5)*x, pos, 34)
      end
    end
    MyLocal.players[cid].number = MyLocal.players[cid].number+1
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")     

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
	if getTileInfo(getCreaturePosition(cid)).optional then 
		doPlayerSendCancelEf(cid, "You can't use this fold here.")
		return false
	end 
  if MyLocal.players[cid] == nil then
    if getPlayerExaust(cid, "earth", "arena", earthExausted.arena) == false then
      return false
    end
    if getPlayerHasStun(cid) then
			if getDobrasLevel(cid) >= 16 then
				doPlayerAddExaust(cid, "earth", "arena", earthExausted.arena-11)
			else
				doPlayerAddExaust(cid, "earth", "arena", earthExausted.arena)
			end
          return true
      end
    MyLocal.players[cid] = {number = 1}
    doCombat(cid, combat, var)
    addEvent(zerarTable, cf.duracao, cid)
    workAllCdAndAndPrevCd(cid, "earth", "arena", cf.duracao, 1)
    return true
  else
    doPlayerSendCancelEf(cid, "You're already using this fold.")
    return false
  end
end



