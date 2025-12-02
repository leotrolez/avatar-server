local config = {
  delayToUseAgain = 1*24*60*60,
  delayToEnd = 2*60*60
}
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local delay = getPlayerStorageValue(cid, "delayBelzeElixir")
	if delay > os.time() then
		doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(delay-os.time()).." to use it again.", "Você precisa esperar "..getSecsString(delay-os.time()).." para usar isso novamente."))
		return false
	else
		doRemoveItem(item.uid, 1)
		setPlayerStorageValue(cid, "belzeAtivo", os.time()+config.delayToEnd)
		setPlayerStorageValue(cid, "delayBelzeElixir", os.time()+config.delayToUseAgain)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "You are now with the Belzeboss power and will reflect 40% monster damages for 2 hours.", "Você recebeu o poder do Belzeboss e irá refletir 40% do dano causado por monstros durante 2 horas."))
		doSendMagicEffect(getThingPos(cid), 17)
	end
return true 
end