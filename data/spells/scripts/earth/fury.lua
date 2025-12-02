local function isPzPos(pos)
if not hasSqm(pos) then 
	return false
end 
return getTileInfo(pos).protection
end

local spellName = "earth fury"
local cf = {atk = spellsInfo[spellName].atk}

local combat=createCombatObject() 
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE) 

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/5)*7.1)+math.random(3, 7)
    local max = (level+(magLevel/5)*8.3)+math.random(7, 15)
	local dano = math.random(min, max)
	if exhaustion.check(cid, "isFocusSkyfall") then 
		dano = dano*2
	end 
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
    doPushCreature(target, getCreatureLookDirection(cid))
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local MyLocal = {}
MyLocal.players = {}
MyLocal.magicEffect = 93
 
local function stopMove(cid)
    if isCreature(cid) then
        MyLocal.players[cid] = nil
        setPlayerStorageValue(cid, "playerCanMoveDirection", 0)
		if getDobrasLevel(cid) >= 10 then
			doPlayerAddExaust(cid, "earth", "fury", earthExausted.fury-3)  
		else
			doPlayerAddExaust(cid, "earth", "fury", earthExausted.fury)  
		end
    end  
end
 
 local dirLados = {
 {3, 1},
 {0, 2},
 {3, 1},
 {0, 2}
 }
 
local function MoveAutomatic(cid, speed, times)
         if not isCreature(cid) or exhaustion.check(cid, "stopDashs") or getTileInfo(getCreaturePosition(cid)).protection or exhaustion.check(cid, "airtrapped") then
            stopMove(cid)
            return false
         end
 
         local playerPos = getThingPos(cid)
		 local dir = getCreatureLookDirection(cid)
         local posToGo = getPositionByDirection({x=playerPos.x, y=playerPos.y, z=playerPos.z}, dir, 1)
		 if isPzPos(posToGo) then 
			stopMove(cid)
			return false 
		end 
		-- causar dmg nos 3 sqm da frente empurrando
		local lookPos = getCreatureLookPosition(cid)
		local poses = {lookPos, getPositionByDirection({x=lookPos.x, y=lookPos.y, z=lookPos.z}, dirLados[dir+1][1], 1), getPositionByDirection({x=lookPos.x, y=lookPos.y, z=lookPos.z}, dirLados[dir+1][2], 1)}
		for i = 1, #poses do 
			local posHit = poses[i]
			if not isPzPos(posHit) then
				doCombat(cid, combat, {type=2, pos=posHit})
				doSendMagicEffect(posHit, 34)
			end
		end 
         if getPlayerCanWalk({player = cid, position = posToGo, createTile = true, checkPZ = true, checkHouse = true, checkWater = true}) and not exhaustion.check(cid, "airtrapped") then
            doTeleportThing(cid, posToGo)
            doSendMagicEffect(playerPos, MyLocal.magicEffect) 
        else
            stopMove(cid)
            return false
        end
		local crossPositions = {{x=playerPos.x-1, y=playerPos.y-1, z=playerPos.z}, {x=playerPos.x+1, y=playerPos.y-1, z=playerPos.z}, {x=playerPos.x-1, y=playerPos.y+1, z=playerPos.z}, {x=playerPos.x+1, y=playerPos.y+1, z=playerPos.z}}
		local orderByDir = 
		{
		{crossPositions[4], crossPositions[1], crossPositions[3], crossPositions[2]},
		{crossPositions[3], crossPositions[2], crossPositions[1], crossPositions[4]},
		{crossPositions[1], crossPositions[4], crossPositions[2], crossPositions[3]},
		{crossPositions[2], crossPositions[3], crossPositions[4], crossPositions[1]}
		}
		if times == 3 or times == 1 or times == 0 then 
			if times == 0 then 
				crossPositions = {{x=posToGo.x-1, y=posToGo.y-1, z=posToGo.z}, {x=posToGo.x+1, y=posToGo.y-1, z=posToGo.z}, {x=posToGo.x-1, y=posToGo.y+1, z=posToGo.z}, {x=posToGo.x+1, y=posToGo.y+1, z=posToGo.z}}
				orderByDir = 
				{
				{crossPositions[4], crossPositions[1], crossPositions[3], crossPositions[2]},
				{crossPositions[3], crossPositions[2], crossPositions[1], crossPositions[4]},
				{crossPositions[1], crossPositions[4], crossPositions[2], crossPositions[3]},
				{crossPositions[2], crossPositions[3], crossPositions[4], crossPositions[1]}
				}	
			end 
			if not isPzPos(orderByDir[dir+1][2]) and not isPzPos(orderByDir[dir+1][1]) then
				doSendDistanceShoot(orderByDir[dir+1][1], orderByDir[dir+1][2], 11)
			end 
			if not isPzPos(orderByDir[dir+1][4]) and not isPzPos(orderByDir[dir+1][3]) then
				doSendDistanceShoot(orderByDir[dir+1][3], orderByDir[dir+1][4], 11)
			end 
		end
		if times <= 0 then  
			stopMove(cid)
		else 
            setCreatureNoMoveTime(cid, speed+50)
			addEvent(MoveAutomatic, speed, cid, speed, times-1) 
		end
end
 
function onCastSpell(creature, var)
	local cid = creature:getId()
        if not isPlayer(cid) then
            return false
        end  
 
        if getSpellCancels(cid, "earth") == true and not exhaustion.check(cid, "earthArmorActive") then
            return false
        end
 
        if getPlayerExaust(cid, "earth", "fury") == false then
            return false
        end
 
        if MyLocal.players[cid] == nil then
            if getPlayerHasStun(cid) then
				if getDobrasLevel(cid) >= 10 then
					doPlayerAddExaust(cid, "earth", "fury", earthExausted.fury-3)
				else
					doPlayerAddExaust(cid, "earth", "fury", earthExausted.fury)
				end
                return true
            end
			if exhaustion.check(cid, "earthArmorActive") then
				setPlayerStorageValue(cid, "earthArmorActive", os.time()-1)
				setPlayerStorageValue(cid, "playerHasTotalAbsorve", os.time()-1)
			end
            local newPos = getPositionByDirection(getThingPos(cid), getCreatureLookDirection(cid))
        --    if not getPlayerCanWalk({player = cid, position = newPos, createTile = true, checkPZ = true, checkHouse = true, checkWater = true}) then
         --       doPlayerSendCancelEf(cid, "It isn't possible use this fold here.")
         --       return false
         --   end
            MoveAutomatic(cid, 100, 3)
            setCreatureNoMoveTime(cid, 150)
            --workAllCdAndAndPrevCd(cid, "earth", "fury", 1, 1)
            setPlayerStorageValue(cid, "playerCanMoveDirection", os.time()+1)
			if getDobrasLevel(cid) >= 10 then
				doPlayerAddExaust(cid, "earth", "fury", earthExausted.fury-3)  
			else
				doPlayerAddExaust(cid, "earth", "fury", earthExausted.fury)  
			end
            return true
         else
            doPlayerSendCancelEf(cid, "You're already using this fold.")
            return false
         end
end