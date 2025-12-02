function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doRemoveItem(item.uid, 1)
	local random = math.random(1, 100)
	if random <= 20 then  -- supreme bless pot
		doPlayerAddItem(cid, 12830, 6)
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 6x Supreme Bless Potion. Check your backpack!", "Parabéns! Você ganhou 6x Supreme Bless Potion. Cheque sua backpack!"))
	elseif random <= 45 then -- bender + pot
		doPlayerAddItem(cid, 12754, 1)
		doPlayerAddItem(cid, 13848, 6)
		sendBlueMessage(cid, getLangString(cid, "You won 1x Strange Potion of Experience and 6x Bender Scroll. Check your backpack!", "Você ganhou 1x Strange Potion of Experience e 6x Bender Scroll. Cheque sua backpack!"))
	elseif random <= 75 then  -- full pot 
		doPlayerAddItem(cid, 12754, 2)
		sendBlueMessage(cid, getLangString(cid, "You won 2x Strange Potion of Experience. Check your backpack!", "Você ganhou 2x Strange Potion of Experience. Cheque sua backpack!"))
	else -- refills
		doPlayerAddItem(cid, 12753, 3)
		sendBlueMessage(cid, getLangString(cid, "You won 3x Stamina Refill. Check your backpack!", "Você ganhou 3x Stamina Refill. Cheque sua backpack!"))
	end
	doSendMagicEffect(getCreaturePosition(cid), 28)
  return true
end
