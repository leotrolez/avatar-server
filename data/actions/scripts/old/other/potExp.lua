local config = {
  delayToUseAgain = 7*24*60*60,
  delayToEnd = 7*24*60*60
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
 -- if getPlayerLevel(cid) < 20 then 
--	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa atingir o level 20 para utilizar esta poção.")
--	return false
 -- end 
  local delay = getPlayerStorageValue(cid, "delayPotionExp")
  if delay < os.time() then
	if getPlayerStorageValue(cid, "Archangel") == 1 then
		doPlayerSetExperienceRate(cid, 1.5)
		if getPlayerStamina(cid) >= 2400 then 
			doPlayerSetExperienceRate(cid, 1.8)
		end 
	else
		doPlayerSetExperienceRate(cid, 1.2)
		if getPlayerStamina(cid) >= 2400 then 
			doPlayerSetExperienceRate(cid, 1.5)
		end 
	end
    addEvent(removePotionExp, config.delayToEnd*1000, cid)
    setPlayerStorageValue(cid, "hasInPotionExp", os.time()+config.delayToEnd)
    setPlayerStorageValue(cid, "delayPotionExp", os.time()+config.delayToUseAgain)
    doSendMagicEffect(getThingPos(cid), 13)
    doRemoveItem(item.uid, 1)
    sendBlueMessage(cid, getLangString(cid, "You have enabled exp potion, it will end in 7 days.", "Você ativou sua poção de expêriencia, o efeito acabará em 7 dias."))
  else
    doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(delay-os.time()).." to use it again.", "Você precisa esperar "..getSecsString(delay-os.time()).." para usar isso novamente."))
  end

  return true
end
