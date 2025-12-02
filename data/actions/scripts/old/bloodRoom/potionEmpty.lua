local fullBlood = 13020
local emptyBlood = 13021

local potions = {
  [7635] = {identifier = "Ultimate Health Potion", maxHitPoints = (100*100*100*100)*100, fullItemId = 8473},
  [7634] = {identifier = "Strong Health Potion", maxHitPoints = 600, fullItemId = 7588},
  [7636] = {identifier = "Health Potion", maxHitPoints = 300, fullItemId = 7618}
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getDistanceBetween(getThingPos(cid), toPosition) <= 1 then

    if itemEx.itemid == fullBlood then
      local bloodItem = getItemAttribute(itemEx.uid, "hitpoints") or 0
      local author = getItemAttribute(itemEx.uid, "author") or "unknown"

      if bloodItem > 0 then
        if not isPremium(cid) then
          sendBlueMessage(cid, WITHOUTPREMIUM)
          return false
        end
        if potions[item.itemid] then
          if bloodItem > potions[item.itemid].maxHitPoints then
            doItemSetAttribute(itemEx.uid, "description", "This pot contains "..bloodItem-potions[item.itemid].maxHitPoints.." hitpoints in blood drawn from "..author..".")
            doItemSetAttribute(itemEx.uid, "hitpoints", bloodItem-potions[item.itemid].maxHitPoints)
            bloodItem = potions[item.itemid].maxHitPoints
          else
            doTransformItem(itemEx.uid, emptyBlood)
            doItemSetAttribute(itemEx.uid, "description", "")
          end
          doTransformItem(item.uid, potions[item.itemid].fullItemId)
          doItemSetAttribute(item.uid, "hitpoints", bloodItem)
          doItemSetAttribute(item.uid, "author", author)
          doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You have done a potion flask with "..bloodItem.." hitpoints in blood.")
          doSendMagicEffect(toPosition, 0)
        end
      end
    end
  end
  return true
end