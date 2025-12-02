local function isTrainer(cid)
local target = getCreatureTarget(cid)
	if not target or target == 0 then 
		return false 
	end
return target and getCreatureName(target) == "Target"
end 

function onThink(interval)
	local oldAvatar = 0
	if getStorage(73991) > 0 then
		oldAvatar = getPlayerByNameWildcard(getPlayerNameByGUID(getStorage(73991)))
	end
	--doSetStorage(73991, getPlayerGUIDByName(getCreatureName(avatar)))
	if oldAvatar and oldAvatar > 0 and isCreature(oldAvatar) and isTrainer(oldAvatar) then
		randomizeNewAvatar()
	elseif not oldAvatar or not isCreature(oldAvatar) then
		randomizeNewAvatar()
	end
return TRUE
end