

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "90509") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	end 
    setPlayerStorageValue(cid, "90509", 1)
	doCreateItem(5070,1,{x=1118, y=1204, z=7})
	doTeleportThing(cid, {x=1051, y=1191, z=6})
   doPlayerAddItem(cid, 9933, 1)
    doSendMagicEffect(getThingPos(cid), 29)
	
	local finalExp = getExperienceForLevel(130) - getExperienceForLevel(129)
	finalExp = finalExp/2
	doPlayerAddExperience(cid, finalExp)
	doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você completou a Evil Zuko Quest. Como recompensa, você recebeu 1x Fire Boots.")
    return true
end