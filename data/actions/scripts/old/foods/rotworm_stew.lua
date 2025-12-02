function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local food = SPECIAL_FOODS[item.itemid]
  if(food == nil) then
    return false
  end

  doCreatureAddHealth(cid, getCreatureMaxHealth(cid) - getCreatureHealth(cid))
  doRemoveItem(item.uid, 1)

  doCreatureSay(cid, food, TALKTYPE_MONSTER)
  return true
end
