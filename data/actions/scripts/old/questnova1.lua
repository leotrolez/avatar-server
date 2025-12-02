function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if isPlayer(itemEx.uid) then
    return false
  end

  if itemEx.actionid == 62126 and item.itemid == 2147 then
    local counter = getPlayerResets(cid)
    if type(counter) ~= "number" then
      counter = 0
    end

    if isPlayerPzLocked(cid) then
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
      return false
    end

    if getPlayerLevel(cid) < 250 or getPlayerResets(cid) < 120 then
      doCreatureSay(cid, "Você precisa de Level 250+ e Paragon 120+ para entrar na Draptor Quest.", TALKTYPE_ORANGE_1, false, cid)
      return false
    end

    doRemoveItem(item.uid, 1)
    doSendMagicEffect(toPosition, 5)
    doSendMagicEffect(fromPosition, CONST_ME_TELEPORT)
    doTeleportThing(cid, {x = 430, y = 1494, z = 7})
    doSendMagicEffect({x = 430, y = 1494, z = 7}, CONST_ME_TELEPORT)
    doCreatureSay(cid, "Incrível, você entrou na Draptor Quest!", TALKTYPE_ORANGE_1, false, cid)
  end
  return false
end