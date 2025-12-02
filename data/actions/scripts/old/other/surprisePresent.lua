--chanceTotalSomada = 1000

local items = {
  {itemId = 2160, random = true, randomAmount = {6, 8}, chance = 650}, --60k a 80k
  {itemId = 13848, amount = 1, chance = 45}, --BenderScroll
  {itemId = 11259, random = true, randomAmount = {1, 2}, chance = 115}, --ec
  {itemId = 9693, amount = 1, chance = 30}, --event tokens
  {itemId = 12754, amount = 1, chance = 120} --PotionExp
}

local function getAllChances()
  local count = 0

  for x = 1, #items do
    count = count+items[x].chance
  end

  return count
end

local function getItemCount(index)
  local current = items[index]

  if current.random then
    return math.random(current.randomAmount[1], current.randomAmount[2])
  else
    return current.amount
  end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  assert(getAllChances() == 1000)

  local count, random, itemIndex = 0, math.random(1, 1000), 0

  for x = 1, #items do
    count = count+items[x].chance

    if count >= random then
      itemIndex = x
      break
    end
  end

  local count, itemName = getItemCount(itemIndex), getItemNameById(items[itemIndex].itemId)

  doPlayerAddItem(cid, items[itemIndex].itemId, count)
  doRemoveItem(item.uid, 1)

  sendBlueMessage(cid, string.format(getLangString(cid, "You have found %s %s(s) in surprise present, enjoy it!", "Parábens, Você encontrou %s %s(s) no presente surpresa, aproveite!"), count, itemName))
  return true
end
