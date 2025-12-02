local newRunesIds = {18122, 18125, 18128}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "90510") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	end 
	if getPlayerLevel(cid) < 150 or getPlayerResets(cid) < 70 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa de Level 150+ e Paragon 70+ para adquirir esta recompensa.")
		return true
	end 
	if not isCreature(lastBossCid) then 
		setPlayerStorageValue(cid, "90510", 1)
		local runaId = newRunesIds[math.random(1, 3)]
		doPlayerAddItem(cid, 2160, 10) -- 100k
		doPlayerAddItem(cid, runaId, 1) -- uma das runas novas
		doSendMagicEffect(getThingPos(cid), 29)
		local finalExp = getExperienceForLevel(140) - getExperienceForLevel(139)
		finalExp = finalExp/2
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "Congratulations! You received "..finalExp.." experience points, 1x "..getItemNameById(runaId).." and 60000 gold coins.", "Parabéns! Você recebeu "..finalExp.." pontos de experiência, 1x "..getItemNameById(runaId).." e 100000 gold coins."))
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_ADVANCE, getLangString(cid, "You need to kill the The Baron from Below first.", "Você precisa matar o The Baron from Below primeiro."))
	end 
  return true
end