function onDeath(cid, corpse, mostDamageKiller)
     local artigo = getPlayerSex(mostDamageKiller[1]) == 0 and "A jogadora" or "O jogador"
     if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower("Beelzeboss") then
          doBroadcastMessage("[Blood Castle] " .. artigo .. " " .. getPlayerName(mostDamageKiller[1]) .. " destruiu o Beelzeboss e conquistou o bending elixir!")
          doSendMagicEffect(getCreaturePosition(mostDamageKiller[1]), 66)
         -- doCreateTeleport(1387, bloodconfig.templo, bloodconfig.estatua)
          doPlayerAddEventPoints(mostDamageKiller[1], 3)
		  bloodRemovePlayers()
     end
	return true
end