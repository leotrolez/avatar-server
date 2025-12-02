local function checkBossAlive()
local specs = getSpectators({x=807, y=728, z=10}, 15, 15)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Spark of Destruction" then
				return true
			end 
		end 
	end 
	return false
end 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "90503") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Spark of Destruction.")
		return true
	end 
    setPlayerStorageValue(cid, "90503", 1)
   doPlayerAddItem(cid, 17986, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou a Spark Ring.")
    return true
end