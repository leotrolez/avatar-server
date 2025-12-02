local MyLocal = {}

MyLocal.spots = {384, 418, 8278, 8592}

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end
  local position = getThingPosition(cid)
  position.stackpos = 0
  local ground = getThingFromPos(position)
  if(isInArray(MyLocal.spots, ground.itemid)) then
    if getPlayerExaust(cid, "water", "scape") == false then
        return false
      end
      if canUseWaterSpell(cid, 1, 3, false) then
      if getPlayerHasStun(cid) then
          workAllCdAndAndPrevCd(cid, "water", "scape", nil, 1)
            return true
        end
      doPlayerAddExaust(cid, "water", "scape", waterExausted.scape)
      local newPosition = position
      newPosition.y = newPosition.y + 1
      newPosition.z = newPosition.z - 1

          posPlayer = getCreaturePosition(cid)
          doSendMagicEffect(getPlayerPosition(cid), 53)
          addEvent(valid(doTeleportThing), 500, cid, newPosition, false)
          setCreatureNoMoveTime(cid, 500)
      return true
    else
      return false
    end
  else
    doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    doSendMagicEffect(position, 2)
    return false
  end
end
