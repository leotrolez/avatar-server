local POTIONS = {7588, 7589}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  doTransformItem(item.uid, POTIONS[math.random(1, table.maxn(POTIONS))])
  doSendMagicEffect(fromPosition, CONST_ME_MAGIC_RED)
  return true
end
