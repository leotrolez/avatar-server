function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getPlayerStorageValue(cid, "questnova3") == 1 then  
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
    return true
  end 
    setPlayerStorageValue(cid, "questnova3", 1)
   doPlayerAddItem(cid, 2007, 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
  doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Utilize essa água sagrada com sabedoria.")
    return true
end