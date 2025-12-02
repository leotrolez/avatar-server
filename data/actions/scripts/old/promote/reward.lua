local function checkBossAlive()
local specs = getSpectators({x=892, y=148, z=10}, 30, 30)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Zorvorax" then 
				return true
			end 
		end 
	end 
	return false
end 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerLevel(cid) < 150 or getPlayerResets(cid) < 70 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa de Level 150+ e Paragon 70+ para adquirir esta recompensa.")
		return true
	end
	if getPlayerStorageValue(cid, "90508") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Zorvorax primeiro.")
		return true
	end 
    setPlayerStorageValue(cid, "90508", 1)
	doPlayerAddItem(cid, 13683, 1)
    doSendMagicEffect(getThingPos(cid), 29)
	
	local finalExp = getExperienceForLevel(151) - getExperienceForLevel(150)
	finalExp = finalExp/2
	doPlayerAddExperience(cid, finalExp)
	doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou a Alloy Legs.")
    return true
end