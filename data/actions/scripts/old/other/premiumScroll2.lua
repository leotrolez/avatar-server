local premiumDays = 3

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  doPlayerAddPremiumDays(cid, premiumDays)
  sendBlueMessage(cid, getLangString(cid, premiumDays.." Premium Account days have been added to your account.", premiumDays.." dias de Premium Account foram adicionados em sua conta."))
  doSendMagicEffect(getThingPos(cid), 29)
  doRemoveItem(item.uid, 1)
  return true
end
