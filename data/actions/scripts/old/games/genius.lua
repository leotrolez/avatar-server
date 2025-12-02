local enters = {
      {x=491,y=322,z=8}
}

local storages = {
      "geniusGame1"
}

local enterMoney = 200
local needPremium = false
local blocked = false

if blocked then
      print("Script genius com problema, arrumar script, colocar todas arenas.")
      return true
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
      if blocked then
            return true
      end

      if needPremium then
            if not isPremium(cid) then
                  doPlayerSendCancel(cid, WITHOUTPREMIUM)
                  return true
            end
      end

      if isPlayerPzLocked(cid) then
            doPlayerSendCancel(cid, "You cannot start the chellenge with battle active.")
            return true
      end

      for x = 1, #storages do
            if getStorage(storages[x]) <= 0 then
                  if doPlayerRemoveMoney(cid, enterMoney) then
                        doTeleportCreature(cid, enters[x], 10)
                  else
                        doPlayerSendCancel(cid, "You need have "..enterMoney.." gold coins to start this minigame.")
                  end
                  return true
            end
      end

      doPlayerSendCancel(cid, "Sorry, all rooms are in use, please try again later.")
      return true
end
