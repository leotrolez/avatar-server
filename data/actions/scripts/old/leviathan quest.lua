function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "90519") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	end 
    setPlayerStorageValue(cid, "90519", 1)
	local pos = getThingPos(cid)
    doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 121)
	doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 134)

	doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 138)
	doSendMagicEffect({x=pos.x+1, y=pos.y-1, z=pos.z}, 138)
	doSendMagicEffect({x=pos.x-1, y=pos.y-1, z=pos.z}, 138)
	doSendMagicEffect({x=pos.x-1, y=pos.y+1, z=pos.z}, 138)
  
	doSendMagicEffect({x=pos.x+1, y=pos.y, z=pos.z}, 96)
	doSendMagicEffect({x=pos.x, y=pos.y-1, z=pos.z}, 96)
	doSendMagicEffect({x=pos.x-1, y=pos.y, z=pos.z}, 96)
	doSendMagicEffect({x=pos.x, y=pos.y+1, z=pos.z}, 96)

	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou o espírito do Avatar. Agora, os 4 elementos irão te ajudar no momento em que você mais precisar.")
    return true
end