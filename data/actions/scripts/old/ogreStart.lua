function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid 
	doPlayerSendCancel(cid, getLangString(cid, "Your team needs five players of level 135+ to start.", "Seu time precisa de cinco dobradores com level igual ou superior à 135 para começar."))
	return true
end
