function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
local config = {
storage = 28392, -- Uma storage, se quiser nao precisa modificar
keyID = 2091, -- ID de uma chave, você pode trocar.
aid = 62121, -- ActionID, tem que ser o mesmo do script acima.
}
 if getPlayerLevel(cid) < 80 then
   doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Somente jogadores de nível 80 ou superior podem receber esta recompensa.")
   return true
end 
 if getPlayerStorageValue(cid, config.storage) == -1 then
  local item = doPlayerAddItem(cid, config.keyID,1)
 if item then
  doItemSetAttribute(item, "aid", config.aid)
  setPlayerStorageValue(cid, config.storage, 1)
  doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You have found an item.", "Você encontrou um item."))
 end
 else
  doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The chest is empty.", "Esse chest está vazio."))
 end
return true
end