local config = {
  storageUseAgain = "getTimeToUsePotionReductionAgain",
  storageInEffect = "timeInEffectCdReduction",
  timeDurationMinutes = 20, --in Minutes
  timeToUseAgain = 12*60*60 --in Seconds
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local delayToUseAgain = getPlayerStorageValue(cid, config.storageUseAgain)

  if delayToUseAgain > os.time() then
    doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(delayToUseAgain-os.time()).." to use it again.", "VocÃª precisa esperar "..getSecsString(delayToUseAgain-os.time()).." para usar isso novamente."))
    return true
  end

  if getPlayerStorageValue(cid, config.storageInEffect) > os.time() then
    doPlayerSendCancel(cid, getLangString(cid, "You already in this item effect.", "Você já está sobre o efeito desse item."))
    return true
  end

  sendBlueMessage(cid, getLangString(cid, "You have enabled reduction potion, it will end in 20 minutes, to check how long type: !stats.", "Você ativou sua potion de redução, o buff terminará em 20 minutos, para checar o tempo que falta digite: !stats."))
  setPlayerStorageValue(cid, config.storageInEffect, os.time()+(config.timeDurationMinutes*60))
  setPlayerStorageValue(cid, config.storageUseAgain, os.time()+config.timeToUseAgain)
  doRemoveItem(item.uid, 1)
  return true
end
