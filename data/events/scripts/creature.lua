function Creature:onChangeOutfit(outfit)
	if hasEventCallback(EVENT_CALLBACK_ONCHANGEMOUNT) then
		if not EventCallback(EVENT_CALLBACK_ONCHANGEMOUNT, self, outfit.lookMount) then
			return false
		end
	end
	if hasEventCallback(EVENT_CALLBACK_ONCHANGEOUTFIT) then
		return EventCallback(EVENT_CALLBACK_ONCHANGEOUTFIT, self, outfit)
	else
		return true
	end
end

function Creature:onAreaCombat(tile, isAggressive)
	if hasEventCallback(EVENT_CALLBACK_ONAREACOMBAT) then
		return EventCallback(EVENT_CALLBACK_ONAREACOMBAT, self, tile, isAggressive)
	end
	return RETURNVALUE_NOERROR
end

function Creature:onTargetCombat(target)
	if hasEventCallback(EVENT_CALLBACK_ONTARGETCOMBAT) then
		return EventCallback(EVENT_CALLBACK_ONTARGETCOMBAT, self, target)
	end
	return RETURNVALUE_NOERROR
end

function Creature:onHear(speaker, words, type)
	if hasEventCallback(EVENT_CALLBACK_ONHEAR) then
		EventCallback(EVENT_CALLBACK_ONHEAR, self, speaker, words, type)
	end
end

local function checkStillInAir(cid, oldOnAir, oldCantDown)
	if not isCreature(cid) then return false end
    local newPos = getCreaturePosition(cid)
	if getPlayerStorageValue(cid, "playerOnAir") == -1 then
		local item = getThingfromPos({x=newPos.x,y=newPos.y,z=newPos.z,stackpos=0})
		if item.itemid == 1 or item.itemid == 460 or item.itemid == 0 then
			setPlayerStorageValue(cid, "playerOnAir", oldOnAir)
			setPlayerStorageValue(cid, "playerCantDown", oldCantDown)
		end
	end
end

function Creature:onMove(direction)
	local cid = self
	if getPlayerStorageValue(cid, "playerOnAir") == 1 then
		local newPos = getPosByDir(getCreaturePosition(cid), direction, 1)
	
		if isWaterBlock({x=newPos.x,y=newPos.y,z=7,stackpos=0}) then
			return false
		end
	
		local item = getThingfromPos({x=newPos.x,y=newPos.y,z=newPos.z,stackpos=0})
	
		if item.itemid == 1 or item.itemid == 460 or item.itemid == 0 then
			if (getPlayerCanWalk({player = cid, position = {x=newPos.x,y=newPos.y,z=newPos.z+1}, checkPZ = false, checkHouse = true}) == false and hasSqm({x=newPos.x, y=newPos.y, z=newPos.z+1}) == true) or getPlayerStorageValue(cid, "playerCantDown") == 1 then
				doCreateTile(460, newPos)
			else
				doCreateTile(460, newPos)
				addEvent(doPlayerDown, 100, self:getId(), true)
			end
		elseif not (isPlayerPzLocked(cid) and getTileInfo(newPos).protection) then
			--todo acho que aqui tb ta entrando quando nao consegue dar move pro sqm (pz locked indo pra pz)
			-- ocasionando em bugs como o earth podendo usar dobras, novo jump etc estando no ar
			--doRemoveCondition(cid, CONDITION_OUTFIT)
			addEvent(checkStillInAir, 30, self:getId(), getPlayerStorageValue(cid, "playerOnAir"), getPlayerStorageValue(cid, "playerCantDown"))
			setPlayerStorageValue(cid, "playerOnAir", -1)
			setPlayerStorageValue(cid, "playerCantDown", -1)
		end
	end
	--if getTileInfo(newPos).protection then 
	--	 dismountPlayer(cid)
	-- end 
	return true
end
