--focus ready--

local MyLocal = {}

MyLocal.spots = {384, 418, 8278, 8592}

local function toPosition(x,y,z)
    return {x=x,y=y,z=z}
end

function onCastSpell(creature, var)
	local cid = creature:getId()
  local position = getThingPosition(cid)
  position.stackpos = 0
  local ground = getThingFromPos(position)
  if(isInArray(MyLocal.spots, ground.itemid)) then
    if getSpellCancels(cid, "fire") == true then
          return false
      end
        if doPlayerAddExaust(cid, "fire", "scape", fireExausted.scape) == false then
        return false
       end
       if getPlayerHasStun(cid) then
            workAllCdAndAndPrevCd(cid, "fire", "scape", nil, 1)
          return true
        end
    local newPosition = position
    newPosition.y = newPosition.y + 1
    newPosition.z = newPosition.z - 1

        posPlayer = getCreaturePosition(cid)
        doSendMagicEffect(position, 6)
        doSendMagicEffect(toPosition(posPlayer.x+1,posPlayer.y,posPlayer.z), 6)
        doSendMagicEffect(toPosition(posPlayer.x-1,posPlayer.y,posPlayer.z), 6)
        doSendMagicEffect(toPosition(posPlayer.x,posPlayer.y+1,posPlayer.z), 6)
        doSendMagicEffect(toPosition(posPlayer.x,posPlayer.y-1,posPlayer.z), 6)
        addEvent(valid(doTeleportThing), 500, cid, newPosition, false)
        setCreatureNoMoveTime(cid, 500)
        addEvent(doSendMagicEffect, 500, newPosition, 6)
        getPlayerOverPower(cid, "fire", true, true)
        workAllCdAndAndPrevCd(cid, "fire", "scape", nil, 1)
    return true
  else
    doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    doSendMagicEffect(position, 2)
    return false
  end
end