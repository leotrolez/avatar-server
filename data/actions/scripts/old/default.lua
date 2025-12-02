function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local item = getItemInfo(item.itemid)
  if(item.weaponType == WEAPON_SWORD or item.weaponType == WEAPON_CLUB or item.weaponType == WEAPON_AXE) then
    return destroyItem(cid, itemEx, toPosition)
  end

  return false
end