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
		random = math.random(1, 85)		
		setPlayerStorageValue(cid, "winCoins", 2)
	end
	if random <= 15 then  
		doPlayerAddItem(cid, 13852, 1)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Crystal Helmet. Check your backpack!", "Você ganhou 1x Crystal Helmet. Cheque sua backpack!"))
	elseif random <= 30 then 
		doPlayerAddItem(cid, 12886, 1)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Crystal Chest. Check your backpack!", "Você ganhou 1x Crystal Chest. Cheque sua backpack!"))
	elseif random <= 45 then  
		doPlayerAddItem(cid, 11117, 1)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Crystal Boots. Check your backpack!", "Você ganhou 1x Crystal Boots. Cheque sua backpack!"))
	elseif random <= 65 then  
		doPlayerAddItem(cid, 13914, 1)
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 1x Crystal Legs. Check your backpack!", "Parabéns! Você ganhou 1x Crystal Legs. Cheque sua backpack!"))
	elseif random <= 85 then  
		doPlayerAddItem(cid, 12781, 1)
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 1x Crystal Shield. Check your backpack!", "Parabéns! Você ganhou 1x Crystal Shield. Cheque sua backpack!"))
	else 
		doPlayerAddItem(cid, 11259, 25)
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 25 Elemental Coins. Check your backpack!", "Parabéns! Você ganhou 25 Elemental Coins. Cheque sua backpack!"))
		setPlayerStorageValue(cid, "winCoins", totalWinCoins+1)
	end
	if totalWinCoins > 0 and random <= 85 then
		setPlayerStorageValue(cid, "winCoins", totalWinCoins-1)
	end
	doSendMagicEffect(getCreaturePosition(cid), 28)
  return true
end
