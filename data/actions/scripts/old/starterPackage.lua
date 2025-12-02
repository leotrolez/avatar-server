local packageItens = {
13375, 1, -- glooth
12830, 5, -- bless
12754, 1, -- pots
11117, 1,
13848, 5 -- bend scroll
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doRemoveItem(item.uid, 1)
	for i = 1, #packageItens-1 do 
		if i % 2 ~= 0 then 
			doPlayerAddItem(cid, packageItens[i], packageItens[i+1])
		end
	end 
	doSendMagicEffect(getCreaturePosition(cid), 28)
    sendBlueMessage(cid, getLangString(cid, "Check your backpack!", "Pacote aberto! Cheque sua backpack."))
  return true
end
