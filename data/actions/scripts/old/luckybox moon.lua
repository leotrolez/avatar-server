function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local totalWinCoins = getPlayerStorageValue(cid, "winCoins")
	if not totalWinCoins or totalWinCoins == -1 then 
		totalWinCoins = 0 
		setPlayerStorageValue(cid, "winCoins", 0)
	end
    doRemoveItem(item.uid, 1)
	local random = math.random(1, 100)
	if totalWinCoins >= 3 then
		random = math.random(1, 80)		
		setPlayerStorageValue(cid, "winCoins", 2)
	end
	if random <= 20 then  
		doPlayerAddItem(cid, 13401, 1)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Moon Helmet. Check your backpack!", "Você ganhou 1x Moon Helmet. Cheque sua backpack!"))
	elseif random <= 40 then 
		doPlayerAddItem(cid, 13402, 1)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Moon Chest. Check your backpack!", "Você ganhou 1x Moon Chest. Cheque sua backpack!"))
	elseif random <= 60 then  
		doPlayerAddItem(cid, 13403, 1)
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 1x Moon Legs. Check your backpack!", "Parabéns! Você ganhou 1x Moon Legs. Cheque sua backpack!"))
	elseif random <= 80 then  
		doPlayerAddItem(cid, 13404, 1)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Moon Boots. Check your backpack!", "Você ganhou 1x Moon Boots. Cheque sua backpack!"))
	else 
		doPlayerAddItem(cid, 11259, 25)
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 25 Elemental Coins. Check your backpack!", "Parabéns! Você ganhou 25 Elemental Coins. Cheque sua backpack!"))
		setPlayerStorageValue(cid, "winCoins", totalWinCoins+1)
	end
	if totalWinCoins > 0 and random <= 80 then
		setPlayerStorageValue(cid, "winCoins", totalWinCoins-1)
	end
	doSendMagicEffect(getCreaturePosition(cid), 28)
  return true
end
