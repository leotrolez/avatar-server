local spellName = "air gale"
local cf = {atk = spellsInfo[spellName].atk}

function print_r ( t ) 
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end

local MyLocal = {}
MyLocal.airId = 17112
MyLocal.airTime = 2
MyLocal.players = {}
MyLocal.direction = {}
MyLocal.imunes = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_HITEFFECT, 34)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = ((level+(magLevel/3)*2.6)+math.random(1, 2))*1.68
    local max = ((level+(magLevel/3)*3.1)+math.random(2, 3))*1.68

	min = min*1.5
	max = max*1.5
	min = remakeAirEarth(cid, min)
	max = remakeAirEarth(cid, max)
    return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function getAnotherDirs(dir)
if dir == 0 or dir == 2 then 
	return {1, 3}
else 
	return {0, 2}
end 
end 

local function getToPushDir(dir)
dir = dir +1 
local convert = {3, 0, 1, 2}
return convert[dir]
end 

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
  if isNpc(target) then
    return false
  end    
  if not MyLocal.direction[cid] then 
		MyLocal.direction[cid] = 0
	end
	--if MyLocal.imunes[cid] == nil or #MyLocal.imunes[cid] == 0 or not isInArray(MyLocal.imunes[cid], target) then 
		--doSlow(cid, target, 15, 100)
		doPushCreature(target, getToPushDir(MyLocal.direction[cid]))
	--	table.insert(MyLocal.imunes[cid], target)
	--end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

--        doPushCreature(target, dir)

local function isAndavel(pos, cid)
return getPlayerCanWalk({player = cid, position = pos, checkPZ = true, checkHouse = true, createTile = false and isPlayer(cid)})
end 

local function isProjectable(pos)
return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not (hasSqm(pos) and getTileInfo(pos).protection)
end 



local function getGalePositions(mypos, dir)
     local pos1 = getPositionByDirection({x=mypos.x, y=mypos.y, z=mypos.z}, dir, 1)
	 local anotherDirs = getAnotherDirs(dir)
	 local pos2 = getPositionByDirection({x=pos1.x, y=pos1.y, z=pos1.z}, anotherDirs[1], 1)
	 local pos3 = getPositionByDirection({x=pos1.x, y=pos1.y, z=pos1.z}, anotherDirs[2], 1)
	 if dir == 2 or dir == 1 then 
	 return {pos3, pos1, pos2}
	 else 
	 return {pos2, pos1, pos3}
	 end
end

local function workGale(cid, fromPos, nextPos, dir, times)
	if times == 0 or not isCreature(cid) or (hasSqm(getCreaturePosition(cid)) and getTileInfo(getCreaturePosition(cid)).protection) or not nextPos or (hasSqm(nextPos) and getTileInfo(nextPos).protection) or not isProjectable(nextPos) then return false end
	doSendDistanceShoot(fromPos, nextPos, 45)
	doSendMagicEffect(nextPos, 77)
	doCombat(cid, combat, {type=2, pos=nextPos})
	local newPos = getPositionByDirection({x=nextPos.x, y=nextPos.y, z=nextPos.z}, dir, 1)
	addEvent(workGale, 125, cid, nextPos, newPos, dir, times-1)
end 

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end

    if getPlayerExaust(cid, "air", "gale") == false then
        return false
    end

  if getPlayerHasStun(cid) then
		if getDobrasLevel(cid) >= 7 then
			doPlayerAddExaust(cid, "air", "gale", airExausted.gale-3)
		else
			doPlayerAddExaust(cid, "air", "gale", airExausted.gale)
		end
        return true
    end
	MyLocal.imunes[cid] = {}
	local mypos = getCreaturePosition(cid)
	local dir = getCreatureLookDirection(cid)
	MyLocal.direction[cid] = dir
	local positions = getGalePositions(mypos, dir)
	local haveSpell = false
    for i = 1, #positions do 
		if isProjectable(positions[i]) then 
			workGale(cid, mypos, positions[i], dir, 4)
			haveSpell = true
		end 
	end 

  if haveSpell then
		if getDobrasLevel(cid) >= 7 then
			doPlayerAddExaust(cid, "air", "gale", airExausted.gale-3)
		else
			doPlayerAddExaust(cid, "air", "gale", airExausted.gale)
		end
      return true
  else
         doPlayerSendCancelEf(cid, "There is not enough room.")
    return false
  end
end