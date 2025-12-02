local function checkBossAlive()
local specs = getSpectators({x = 923, y = 452, z = 7}, 10, 10)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Spectre" then 
				return true
			end 
		end 
	end 
	return false
end 
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "90507") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif getPlayerLevel(cid) < 140 or getPlayerResets(cid) < 70 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa de Level 140+ e Paragon 70+ para adquirir esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Spectre.")
		return true
	end 
    setPlayerStorageValue(cid, "90507", 1)
   doPlayerAddItem(cid, 8907, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   local finalExp = 400000
	doPlayerAddExperience(cid, finalExp)
	doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou o Icy Shield.")
    return true
end