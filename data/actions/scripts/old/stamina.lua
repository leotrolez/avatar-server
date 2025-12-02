local config = {
  delayToUseAgain = 24*60*60
}
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local delay = getPlayerStorageValue(cid, "delayPotionStamina")
    if delay < os.time() then
		if getPlayerStamina(cid) >= 2520 then 
			doPlayerSendTextMessage(cid, 22, getLangString(cid, "You already have full stamina.", "Sua stamina já está completa."))
			return true
		end 
		doPlayerAddStamina(cid, 2520 - getPlayerStamina(cid))
		doRemoveItem(item.uid, 1)
		doPlayerSendTextMessage(cid, 22, getLangString(cid, "Your stamina is now restored.", "Sua stamina foi restaurada."))
		doSendMagicEffect(getCreaturePosition(cid), 28)
		setPlayerStorageValue(cid, "delayPotionStamina", os.time()+config.delayToUseAgain)
		return true
	else
		doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(delay-os.time()).." to use it again.", "Você precisa esperar "..getSecsString(delay-os.time()).." para usar isso novamente."))
	end
	return true
end


