local function checkBossAlive()
local specs = getSpectators({x=312, y=846, z=14}, 30, 30)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and not isSummon(specs[i]) then 
				return true
			end 
		end 
	end 
	return false
end 
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	doTeleportThing(cid, {x=311, y=835, z=12})
	doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
	if getPlayerStorageValue(cid, "90505") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Algum monstro continua vivo, não houve recompensa.")
		return true
	end 
    setPlayerStorageValue(cid, "90505", 1)
   doPlayerAddItem(cid, 12939, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Ao derrotar o Medreth, você conquistou o medreth chest.")
    return true
end