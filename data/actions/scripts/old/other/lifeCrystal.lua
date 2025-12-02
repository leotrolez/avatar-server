local config = {
  maxCanUse = 100,
  storage = "pointsUsedInLifeCrystal",
  effect = 12
}

local function getPlayerPointsHasUsed(cid)
  return math.max(getPlayerStorageValue(cid, config.storage)+1, 1)-1
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local maxPoints = getPlayerPointsHasUsed(cid)

  if maxPoints >= config.maxCanUse then
    doPlayerSendCancel(cid, getLangString(cid, "Sorry, you have reached the maximum level bonus of this item.", "Desculpe, você atingiu o level máximo do bonus desse item."))
    return true
  else  
    setPlayerStorageValue(cid, config.storage, maxPoints+1)
    setCreatureMaxHealth(cid, getCreatureMaxHealth(cid, true)+1)

    sendBlueMessage(cid, getLangString(cid, "Now, your max health was increased by +1 (Bonus level: "..getPlayerPointsHasUsed(cid)..").", "Agora, sua vida máxima foi aumentada +1 (Bonûs level: "..getPlayerPointsHasUsed(cid)..")."))
    doSendMagicEffect(toPosition, config.effect)
  end
  doRemoveItem(item.uid, 1)

  return true
end
