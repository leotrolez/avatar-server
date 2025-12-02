local players = {}
local emptyPouchId = 4863
local fullPouchId = 4864 

function onEquip(cid, item, slot)
  if item.uid > 0 then
    local water = 0

    if item.itemid == fullPouchId then
      water = getItemAttribute(item.uid, "water") or 100
    else
      water = getItemAttribute(item.uid, "water") or 0
    end

    sendWaterPounchToClient(cid, water)
  end
  return true
end