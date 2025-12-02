local stoneList = {12686, 12688, 12689, 12687} -- 1 fire 2 water 3 air 4 earth

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	doTeleportThing(cid, {x=763, y=368, z=10})
	if getPlayerStorageValue(cid, "90504") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	end 
    setPlayerStorageValue(cid, "90504", 1)
   doPlayerAddItem(cid, stoneList[getPlayerVocation(cid)], 1)
   doPlayerAddItem(cid, 11258, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Ao derrotar o Lost Avatar, você conquistou o bending amulet e 1x "..getItemNameById(stoneList[getPlayerVocation(cid)])..".")
    return true
end