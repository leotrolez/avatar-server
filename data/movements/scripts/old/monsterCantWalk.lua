function onStepIn(cid, item, position, fromPosition)
  if isMonster(cid) or isNpc(cid) then
    doCreatureSetNoMove(cid, true)
  end
  return true
end

local function doTeleportMonster(cid, pos)
	if isMonster(cid) then
		doTeleportThing(cid, pos, false)
	end
	return true
end

function onStepOut(cid, item, position, fromPosition)
	if isMonster(cid) then
		addEvent(doTeleportMonster, 100, cid, fromPosition)
	end
	return true
end
