dofile(getDataDir().."talkactions/scripts/mount/configs.lua")
local active = true

local mounts = {}

for mountName, value in pairs(dataMounts) do
    mounts[mountName] = {}

    mounts[mountName] = createConditionObject(CONDITION_OUTFIT)
    setConditionParam(mounts[mountName], CONDITION_PARAM_TICKS, -1)
    addOutfitCondition(mounts[mountName], {lookType = value})
end

local function haveAllMounts(cid)
return getPlayerStorageValue(cid, 93911) == 1
end 

local freeMounts = {"blacksheep", "warbear", "uniwheel", "hellgrip", "ladybug"}

function mountPlayer(cid, mountID) 
    if not active then
        return false
    end

  --  if not isPremium(cid) then
   --     sendBlueMessage(cid, getLangString(cid, WITHOUTPREMIUM, WITHOUTPREMIUMBR))
    --    return false
   -- end

    local thingPos, outfit = getThingPos(cid), getCreatureOutfit(cid)
    local currentMount = dataMounts[mountID..outfit.lookType]
	
	if getPlayerStorageValue(cid, mountID) == -1 and not haveAllMounts(cid) then
        sendBlueMessage(cid, getLangString(cid, "Sorry, you don't have this mount.", "Desculpe, você não tem essa montaria."))
        return false
    end
    if getPlayerStorageValue(cid, "playerOnAir") == 1 then
        sendBlueMessage(cid, getLangString(cid, "You can't mount with fly or surf, sorry.", "Você não pode montar utilizando fly ou surf, desculpe."))
        return false
    end
	
	if getTileInfo(getCreaturePosition(cid)).protection then
        sendBlueMessage(cid, getLangString(cid, "Sorry, you can't mount in a protection zone.", "Desculpe, você não pode montar dentro de uma zona protegida (PZ)."))
        return false
    end

    if getCreatureCondition(cid, CONDITION_OUTFIT) or currentMount == nil then
        sendBlueMessage(cid, getLangString(cid, "You need to be wearing your normal outfit to get mounted. You can't also mount with fly or surf, sorry.", "Você precisa estar com sua roupa normal para montar. Você também não pode montar utilizando fly ou surf, desculpe."))
        return false
    end
        local currentCondition = mounts[mountID..outfit.lookType]
        local myoutfit = getCreatureOutfit(cid)
        local value = dataMounts[mountID..outfit.lookType]
        addOutfitCondition(currentCondition, {lookType = value, lookHead = myoutfit.lookHead})
        currentCondition = mounts[mountID..outfit.lookType]

    if currentCondition then
        doAddCondition(cid, currentCondition)
        doCreatureSetStorage(cid, "inMount", 1)
        local bonusAtual = getCreatureStorage(cid, "bonusMount")
        if bonusAtual < 1 then 
			bonusAtual = 0
        end
		local vddSpeed = moreSpeed
		if isInArray(freeMounts, mountID) then 
			vddSpeed = 40
			if mountID == "uniwheel" or mountID == "hellgrip" then 
				vddSpeed = 40
			end 
		end 
        if bonusAtual < vddSpeed then
			doChangeSpeed(cid, vddSpeed-bonusAtual)
			doCreatureSetStorage(cid, "bonusMount", vddSpeed)
        end
    end

    return true
end

local mountsByVoc = {"nethersteed", "crystalwolf", "wacoon", "kongra"}

function onSay(cid, words, param, channel)
	if isCreature(cid) then 
		return true
	end
	local vocation = getPlayerVocation(cid)
	if vocation < 1 or vocation > 4 then 
		return true 
	end 
    local mountID = mountsByVoc[vocation]
	local activeMount = getPlayerStorageValue(cid, "activeMount") 
	if activeMount ~= -1 then 
		mountID = activeMount
	end 
    if getPlayerStorageValue(cid, "inMount") ~= 1 then
        mountPlayer(cid, mountID)
    else
        dismountPlayer(cid)
    end

  return true
end