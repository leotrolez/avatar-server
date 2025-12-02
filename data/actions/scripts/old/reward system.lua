

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local actionid = item.actionid
	if not actionid or actionid == 0 then 
		return true
	end
	local reward = Game.ChestsInfo[actionid]
	if not reward or type(reward) ~= "table" then 
		return true
	end 
	if reward.level and reward.level ~= 0 then 
		if getPlayerLevel(cid) < reward.level then 
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Somente jogadores de nível "..reward.level.." ou superior podem receber esta recompensa.")
			return true
		end 
	end 
	local storage = 0
	local finalExp = 0
	local finalString = ""
	if not reward.storage or reward.storage == 0 then 
		storage = "questChests"..actionid..""
	else 
		storage = reward.storage
	end 	
	
	if getPlayerStorageValue(cid, storage) == -1 then 
		setPlayerStorageValue(cid, storage, 1)
		if reward.effect and reward.effect ~= 0 then 
			doSendMagicEffect(getCreaturePosition(cid), reward.effect)
		end
		if reward.givestorage and reward.givestorage ~= 0 then 
			setPlayerStorageValue(cid, reward.givestorage, 1)
		end 
		if reward.exp and reward.exp ~= 0 and reward.level and reward.level ~= 0 then 
			finalExp = getExperienceForLevel(reward.level+1) - getExperienceForLevel(reward.level)
			finalExp = finalExp * (reward.exp/100)
			doPlayerAddExperience(cid, finalExp)
			doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
		end 
		if reward.premios and type(reward.premios) == "table" then 
			for i = 1, #reward.premios do 
				local itemId = reward.premios[i][1]
				local quantia = reward.premios[i][2]
				doPlayerAddItem(cid, itemId, quantia)
				if finalExp ~= 0 and i == 1 then 
					finalString = finalString .. "Você recebeu "..finalExp.." pontos de experiência, "..quantia.."x "..getItemNameById(itemId)..""
					if i == #reward.premios then 
						finalString = "Você recebeu "..finalExp.." pontos de experiência e "..quantia.."x "..getItemNameById(itemId).."."
					end 
				elseif i == #reward.premios then 
					finalString = finalString .. " e "..quantia.."x "..getItemNameById(itemId).."."
					if i == 1 then
						finalString = "Você recebeu "..quantia.."x "..getItemNameById(itemId).."."
					end 
				elseif i ~= 1 then 
					finalString = finalString .. ", "..quantia.."x "..getItemNameById(itemId)..""
				else
					finalString = finalString .. "Você recebeu "..quantia.."x "..getItemNameById(itemId)..""
					if i == #reward.premios then 
						finalString = finalString .. "."
					end 
				end 
			end
		end 
		if reward.customText and type(reward.customText)== "string" and reward.customText ~= "" then 
			finalString = reward.customText
		end 
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, finalString)
	else 
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já recebeu esta recompensa.")
	end
	return true
end
