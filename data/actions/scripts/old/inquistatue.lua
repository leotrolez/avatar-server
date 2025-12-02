local config = {
effect = CONST_ME_TELEPORT,
posfinal = {x=687, y=1371, z=11},
msg = "Parabéns! Você completou a Profaned Quest."
}
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, config.msg)
		doTeleportThing(cid, config.posfinal)
		doSendMagicEffect(config.posfinal, config.effect)
		setPlayerStorageValue(cid, "90502", 1)
	return true
end 