local spellName = "earth metalwall"
local cf = {atk = spellsInfo[spellName].atk}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 9)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/4)*2.56)+(math.random(30, 35))
    local max = (level+(magLevel/4)*2.8)+(math.random(35, 45))
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = dano*1.5
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local function tryStun(cid)
	if getCreatureNoMove(cid) == false then
		setCreatureNoMoveTime(cid, 3000) 
		addEvent(function(cid, text, color)
			if isCreature(cid) then
				doSendAnimatedText(getThingPos(cid), text, color)
			end
		end, 300, cid, "Stunned!", 173)  
	end
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
	tryStun(target)
	setPlayerStuned(target, 4)
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function canMetalTarget(cid, metalPos)
	local target = getCreatureTarget(cid)
	if isCreature(target) then
		local targpos = getCreaturePosition(target)
		if isSightClear(metalPos, targpos, true) and getDistanceBetween(metalPos, targpos) < 5 then
			doSendDistanceShoot(metalPos, targpos, 51)
			doCombat(cid, combat, numberToVariant(target))
			return true
		end
	end
	return false
end

local function isProjectable(pos)
	if hasSqm(pos) and getTileInfo(pos).protection then 
		return false 
	end 
	return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true)
end 

local function hitPosesOnDir(cid, metalPos, dir)
	for i = 1, 3 do
		local posHit = getPosByDir({x=metalPos.x,y=metalPos.y,z=metalPos.z}, dir, i)
		if isProjectable(posHit) then
			doCombat(cid, combat, {type=2, pos=posHit})
		end
	end
end

local function sendShootToDestiny(metalPos, dir)
	local farProject = false
	for i = 1, 3 do
		local posHit = getPosByDir({x=metalPos.x,y=metalPos.y,z=metalPos.z}, dir, i)
		if isProjectable(posHit) then
			farProject = posHit
		end
	end
	if farProject then
		doSendDistanceShoot(metalPos, farProject, 51)
	else
		doSendMagicEffect(metalPos, 9)
	end
end

local function metalWorks(cid, metalPos, times, direction)
	if not isCreature(cid) then return false end
	if isInPz(cid) or not canMetalTarget(cid, metalPos) then -- direcional version, se tiver em pz lembrar de so mandar o distance p fazer sentido o magiceffect
		if not isInPz(cid) then
			hitPosesOnDir(cid, metalPos, direction)
		end
		sendShootToDestiny(metalPos, direction)
	end

	if times > 0 then
		addEvent(metalWorks, 225, cid, metalPos, times-1, direction)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
  if getSpellCancels(cid, "earth") == true then
      return false
    end 
  if getPlayerExaust(cid, "earth", "metalwall") == false then
    return false
  end
  local playerDir = getPlayerLookDir(cid)
  local dirPos = getCreatureLookPosition(cid)
  
  if getPlayerCanWalk({player = cid, position = dirPos, checkPZ = true, checkHouse = true}) then
  
	if getDobrasLevel(cid) >= 23 then
		doPlayerAddExaust(cid, "earth", "metalwall", earthExausted.metalwall-18)
	else
		doPlayerAddExaust(cid, "earth", "metalwall", earthExausted.metalwall)
	end
    if getPlayerHasStun(cid) then
          return true
      end
	  local theTime = 3
		if playerDir == EAST or playerDir == WEST then

		  local item = doCreateItem(18030, dirPos)
		  addEvent(removeTileItemById, 1950, getThingPos(item), 18030)
		doSendMagicEffect(dirPos, 142)
		else
		   local item = doCreateItem(18030, dirPos)
		  addEvent(removeTileItemById, 1950, getThingPos(item), 18030)
		doSendMagicEffect(dirPos, 141)
		end
		addEvent(metalWorks, 600, cid, dirPos, 6, playerDir)
    return true
  else
    doPlayerSendCancel(cid, "There is not enough room.")
    return false
  end
end