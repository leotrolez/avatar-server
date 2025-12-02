function onStepIn(cid, item, position, fromPosition)
	
	local currentPos = getCreaturePosition(cid)
	local enterPos = {x=244, y=666, z=4}
	local exitPos = {x=getPlayerStorageValue(cid, "x"), y=getPlayerStorageValue(cid, "y")+1, z=getPlayerStorageValue(cid, "z")}

	if isPlayer(cid) then
		if getPlayerStorageValue(cid, "hasCompletedResetQuest") == 1 then
			if isPremium(cid) then
				if getPlayerStorageValue(cid, "onSpiritWorld") ~= 1 then
						doCreatureSetStorage(cid, "x", currentPos.x)
						doCreatureSetStorage(cid, "y", currentPos.y)
						doCreatureSetStorage(cid, "z", currentPos.z)
						doCreatureSetStorage(cid, "onSpiritWorld", 1)
						doTeleportCreature(cid, enterPos, 10)
						sendBlueMessage(cid, getLangString(cid, "You just enter the spiritual world, be careful warrior!", "Você acabou de entrar no mundo espiritual, cuidado guerreiro!"))
				elseif getPlayerStorageValue(cid, "onSpiritWorld") == 1 then
					doTeleportCreature(cid, exitPos, 10)
					sendBlueMessage(cid, getLangString(cid, "I have to say that you is a survivor, congratulations little mortal!", "Eu tenho que dizer que você é um sobrevivente, parabéns pequeno mortal!"))
					doCreatureSetStorage(cid, "onSpiritWorld", -1)
				end
			else
				sendBlueMessage(cid, getLangString(cid, "Sorry, only premiums have acess.", "Desculpe, somente premiums têm acessar."))
				doTeleportCreature(cid, {x=currentPos.x, y=currentPos.y+1, z=currentPos.z}, 2)
			end
		else
			sendBlueMessage(cid, getLangString(cid, "Sorry, you need to talk with NPC Isolde to have acess.", "Desculpe, você precisa falar com a NPC Isolde para acessar."))
			doTeleportCreature(cid, {x=currentPos.x, y=currentPos.y+1, z=currentPos.z}, 2)
		end
	end
	return true
end