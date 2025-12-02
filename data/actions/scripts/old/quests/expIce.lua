local config = {
  exp = 250000,
  levelMin = 70
}


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getPlayerLevel(cid) < config.levelMin then
    doPlayerSendCancel(cid, getLangString(cid, "You need have level "..config.levelMin.." to do this quest.", "Você precisa ter level "..config.levelMin.." para fazer essa quest."))
    return true
  end

  if getPlayerStorageValue(cid, "hasDoIceQuestExp") == 1 then
    doPlayerSendCancel(cid, getLangString(cid, "Sorry, you already did this quest.", "Desculpe, você já completou essa quest."))
    return true
  end

  doSendMagicEffect(getThingPos(cid), 12)
  doPlayerAddExperience(cid, config.exp)
  setPlayerStorageValue(cid, "hasDoIceQuestExp", 1)
  sendBlueMessage(cid, getLangString("You have received "..config.exp.." points of experience.", "Você ganhou "..config.exp.." pontos de experiencia."))

  return true
end