local MyLocal = {}
MyLocal.outfitNadadorMale = {lookType = 267, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0}
MyLocal.outfitNadadorFemale = {lookType = 396, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0}

local conditionMale = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionMale, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionMale, MyLocal.outfitNadadorMale)

local conditionFemale = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionFemale, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionFemale, MyLocal.outfitNadadorFemale)


local conditionSpeed = createConditionObject(CONDITION_HASTE)
setConditionParam(conditionSpeed, CONDITION_PARAM_TICKS, -1)
setConditionFormula(conditionSpeed, 0.4, -36, 0.4, -36)

local conditionSpeed2 = createConditionObject(CONDITION_HASTE)
setConditionParam(conditionSpeed2, CONDITION_PARAM_TICKS, -1)
setConditionFormula(conditionSpeed2, 0.6, -46, 0.6, -46)


local freeMounts = {"blacksheep", "warbear", "uniwheel", "hellgrip", "ladybug"}

function onStepIn(cid, item, position, fromPosition)

	if isPlayer(cid) then
		if getPlayerStorageValue(cid, "inMount") == 1 then 
			setPlayerStorageValue(cid, "entroumontado", 1)
		else 
			setPlayerStorageValue(cid, "entroumontado", -1)
		end 
	    dismountPlayer(cid)
        if getPlayerSex(cid) == 0 then
            doAddCondition(cid, conditionFemale)
        else
            doAddCondition(cid, conditionMale)
        end
        if getPlayerElement(cid) == "water" then
			doAddCondition(cid, conditionSpeed2)
		else 
			doAddCondition(cid, conditionSpeed)
        end    
    else
		doTeleportThing(cid, fromPosition, false)
	end
  return true
end


dofile("data/talkactions/scripts/old/mount/configs.lua")
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


function mountPlayer(cid, mountID) 
	if isCreature(cid) then 
		return true
	end
    if not active then
        return false
    end

 --   if not isPremium(cid) then
      --  sendBlueMessage(cid, getLangString(cid, WITHOUTPREMIUM, WITHOUTPREMIUMBR))
  --      return false
   -- end

    local thingPos, outfit = getThingPos(cid), getCreatureOutfit(cid)
    local currentMount = dataMounts[mountID..outfit.lookType]
	
	if getPlayerStorageValue(cid, mountID) == -1 and (isInArray(freeMounts, mountID) or not haveAllMounts(cid)) then
       -- sendBlueMessage(cid, getLangString(cid, "Sorry, you don't have a mount.", "Desculpe, você não tem uma montaria."))
        return false
    end
    if getPlayerStorageValue(cid, "playerOnAir") == 1 then
    --    sendBlueMessage(cid, getLangString(cid, "You can't mount with fly or surf, sorry.", "Você não pode montar utilizando fly ou surf, desculpe."))
        return false
    end

    if getCreatureCondition(cid, CONDITION_OUTFIT) or currentMount == nil then
    --    sendBlueMessage(cid, getLangString(cid, "You need to be wearing your normal outfit to get mounted. You can't also mount with fly or surf, sorry.", "Você precisa estar com sua roupa normal para montar. Você também não pode montar utilizando fly ou surf, desculpe."))
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
function onStepOut(cid, item, position, fromPosition)
  if isPlayer(cid) then
    doRemoveCondition(cid, CONDITION_OUTFIT)
   -- if getPlayerElement(cid) == "water" then
      doRemoveCondition(cid, CONDITION_HASTE)
   -- end
  end
    if isPlayer(cid) and getPlayerStorageValue(cid, "entroumontado") == 1 and getPlayerStorageValue(cid, "inMount") ~= 1 then
		local mountID = mountsByVoc[getPlayerVocation(cid)]
		local activeMount = getPlayerStorageValue(cid, "activeMount") 
		if activeMount ~= -1 then 
			mountID = activeMount
		end 
        mountPlayer(cid, mountID)
	end 
  return true
end