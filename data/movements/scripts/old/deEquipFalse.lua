function onDeEquip(cid, item, slot)
  doPlayerSendCancel(cid, "You cannot de equip this item.")
  return false
end