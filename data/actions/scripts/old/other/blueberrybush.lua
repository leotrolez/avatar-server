function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  doCreateItem(2677, 3, fromPosition)
  doTransformItem(item.uid, 2786)

  doDecayItem(item.uid)
  return true
end
