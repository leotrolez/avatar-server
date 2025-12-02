function onStepIn(cid, item, position, fromPosition)
 if isPlayer(cid) then
   if getPlayerStorageValue(cid, "90502") >= 1 then
     doTeleportThing(cid, fromPosition, false)
     doSendMagicEffect(getThingPos(cid), 11)
     doPlayerSendTextMessage(cid, 25, "Desculpe, você já completou a Profaned Quest.")
	 return false
   end
 end
 
return true
end