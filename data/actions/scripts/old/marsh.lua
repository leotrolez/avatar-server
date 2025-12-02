local function checkBossAlive()
local specs = getSpectators({x=825, y=968, z=6}, 20, 20)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Marsh Prince" then 
				return true
			end 
		end 
	end 
	return false
end 
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	--doTeleportThing(cid, {x=311, y=835, z=12})
	--doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	if getPlayerResets(cid) < 110 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa de Paragon 110+ para adquirir esta recompensa.")
		return true
	end
	if getPlayerStorageValue(cid, "90523") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Marsh Prince.")
		return true
	end 
    setPlayerStorageValue(cid, "90523", 1)
   doPlayerAddItem(cid, 13684, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou a alloy boots.")
    return true
end