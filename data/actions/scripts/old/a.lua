
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
        setPlayerStorageValue(cid, "hasDoQuest", 1)
	return true
end


