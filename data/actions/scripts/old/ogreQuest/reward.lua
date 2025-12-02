

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if getPlayerStorageValue(cid, "90506") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
		return true
	end 
    setPlayerStorageValue(cid, "90506", 1)
	setPlayerStorageValue(cid, "revivelevel2", 1)
   doPlayerAddItem(cid, 2160, 5)
   doPlayerAddItem(cid, 12930, 1) -- bota de vida
    doSendMagicEffect(getThingPos(cid), 29)
    doSendMagicEffect(getThingPos(cid), 65)
	
	local finalExp = getExperienceForLevel(136) - getExperienceForLevel(135)
	finalExp = finalExp/2
	doPlayerAddExperience(cid, finalExp)
	doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você completou a Rarods Quest. Como recompensa, você recebeu o espírito dos Rarods, reduzindo o cooldown da Passiva de Ressurreição de 3h para 2h e aumentando sua recuperação de 30% para 50% da vida. Você também recebeu "..finalExp.." pontos de experiência, 1x Red Spirit Boots e 50000 gold coins.")
    return true
end