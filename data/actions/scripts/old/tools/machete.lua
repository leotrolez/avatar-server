function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  return TOOLS.MACHETE(cid, item, fromPosition, itemEx, toPosition, true)
end
