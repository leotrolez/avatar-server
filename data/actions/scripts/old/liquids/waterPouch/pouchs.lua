local MyLocal = {}
MyLocal.emptyPouchId = 4863
MyLocal.fullPouchId = 4864 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid

  if item.itemid == MyLocal.emptyPouchId then
    if isAvaliableTileWaterByPos(toPosition) == true or isAvaliableItemWaterById(itemEx.itemid) == true then
      doSendMagicEffect(toPosition, 25)
      doTransformItem(item.uid, MyLocal.fullPouchId)
      doItemSetAttribute(item.uid, "water", 100)
      
      if getPlayerSlotItem(cid, 10).uid == item.uid then
        sendWaterPounchToClient(cid, 100)
      end

      sendBlueMessage(cid, getLangString(cid, "Now, your pouch is full.", "Agora seu water pouch está cheio."))
      doItemSetAttribute(item.uid, "description", "it is 100% of water.")
    else
      doPlayerSendCancel(cid, getLangString(cid, "You need find water to fill your pouch.", "Você precisa achar água para encher isso."))
    end
  elseif item.itemid == MyLocal.fullPouchId then
    doItemSetAttribute(item.uid, "water", 0)
    doItemSetAttribute(item.uid, "description", "it is empty.")
    doTransformItem(item.uid, MyLocal.emptyPouchId)
    doDecayItem(doCreateItem(2017, getCreaturePosition(cid)))  
    sendBlueMessage(cid, getLangString(cid, "Now, your water pouch dried.", "Agora, o water pouch está completamente vazio."))
    if getPlayerSlotItem(cid, 10).uid == item.uid then
      sendWaterPounchToClient(cid, 0)  
    end
  end
  return true
end