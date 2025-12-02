local function checkBossAlive()
local specs = getSpectators({x=431, y=168, z=13}, 12, 12)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Kelpie" then 
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
	if getPlayerLevel(cid) < 200 or getPlayerResets(cid) < 90 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa de Level 200+ e Paragon 90+ para adquirir esta recompensa.")
		return true
	end
	if getPlayerStorageValue(cid, "90515") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	elseif checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Kelpie.")
		return true
	end 
   setPlayerStorageValue(cid, "90515", 1)
   doPlayerAddItem(cid, 12886, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou a crystal chest.")
    return true
end