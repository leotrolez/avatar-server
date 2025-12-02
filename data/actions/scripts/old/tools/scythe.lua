function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  return TOOLS.SCYTHE(cid, item, fromPosition, itemEx, toPosition, true)
end
