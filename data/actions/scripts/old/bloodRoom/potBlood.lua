local fullBlood = 13020
local emptyBlood = 13021
local delay = 100

local function getDelayPlayer(cid)
  local level = getPlayerLevel(cid)

  local newDelay = delay-(level*2)

  if newDelay < 10 then
    return 10
  else
    return newDelay
  end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getDistanceBetween(fromPosition, toPosition) <= 1 then
    if not isPremium(cid) then
      sendBlueMessage(cid, WITHOUTPREMIUM)
      return false
    end
    
    if isPlayer(itemEx.uid) then
      if item.itemid == fullBlood then
        local bloodHitPoints = getItemAttribute(item.uid, "hitpoints") or 0
        doItemSetAttribute(item.uid, "description", "")
        doCreatureAddHealth(cid, bloodHitPoints)
        doTransformItem(item.uid, emptyBlood)
        doSendMagicEffect(fromPosition, 0)
      else
        if getPlayerStorageValue(cid, "playerDelayInBloodRoom") > os.time() then
          local timeToDo = (getPlayerStorageValue(cid, "playerDelayInBloodRoom")-os.time())
          doPlayerSendCancel(cid, getLangString(cid, "Sorry, you need wait "..timeToDo.." seconds to do it again.", "Desculpe, você precisa esperar "..timeToDo.." segundos para fazer isso novamente."))
          return true
        end
        local maxHealth = getCreatureMaxHealth(cid)
        if getCreatureHealth(cid) == maxHealth then
          setPlayerStorageValue(cid, "playerDelayInBloodRoom", os.time()+getDelayPlayer(cid))
          doTransformItem(item.uid, fullBlood)
          doItemSetAttribute(item.uid, "hitpoints", math.ceil(maxHealth*0.20))
          doItemSetAttribute(item.uid, "description", "This pot contains "..math.ceil(maxHealth*0.20).." hitpoints in blood drawn from "..getCreatureName(cid)..".")
          doItemSetAttribute(item.uid, "author", getCreatureName(cid))
          doCreatureAddHealth(cid, -maxHealth*0.20)
          doSendMagicEffect(getThingPos(cid), 0)
        else
          doPlayerSendCancel(cid, getLangString(cid, "Sorry, you need have a full life to do this action.", "Desculpe, você precisa estar com vida cheia para fazer isso."))
        end
      end
      return true
    end
  end
  return false
end