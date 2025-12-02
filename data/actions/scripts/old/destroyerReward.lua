local function checkBossAlive()
local specs = getSpectators({x = 769, y = 546, z = 8}, 12, 12)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Bretzecutioner" then 
				return true
			end 
		end 
	end 
	return false
end 
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "destroyersQuest") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif getPlayerLevel(cid) < 50 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa de nível 50 para pegar esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Bretzecutioner.")
		return true
	end 
    setPlayerStorageValue(cid, "destroyersQuest", 1)
   doPlayerAddItem(cid, 5741, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou o Skull Helmet.")
    return true
end