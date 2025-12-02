function onDeath(cid, corpse, mostDamageKiller)
   local artigo = getPlayerSex(mostDamageKiller[1]) == 0 and "A jogadora" or "O jogador"
     if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower("Blood Guard") then
          bloodRemoveWalls()
          addEvent(bloodCreateAngel, 5*1000)
		  local jogadores = bloodGetPlayers()
		if #jogadores >= 1 then 
			for i = 1, #jogadores do 
				doPlayerSendTextMessage(jogadores[i], 22, "[Blood Castle] " .. artigo .. " " .. getPlayerName(mostDamageKiller[1]) .. " derrotou o guarda do portão! Prossigam para próxima sala e continuem lutando!")
			end
		end 
     end
	return true
end