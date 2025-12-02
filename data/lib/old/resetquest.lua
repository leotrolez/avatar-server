local actionsids = {
  [3489] = {element = "fire", inUse = false},
  [3490] = {element = "water", inUse = false},
  [3491] = {element = "earth", inUse = false},
  [3492] = {element = "air", inUse = false}
}

local warHornUse = false

local snake = {
  {x=565,y=524,z=9, itemId=3200},{x=565,y=523,z=9, itemId=3207},{x=565,y=522,z=9, itemId=3211},
  {x=566,y=522,z=9, itemId=3210},{x=567,y=522,z=9, itemId=3212},{x=567,y=523,z=9, itemId=3208},
  {x=567,y=524,z=9, itemId=3214},{x=566,y=524,z=9, itemId=3213},{x=566,y=523,z=9, itemId=3206}
}

local timeToQuestClose = 15 --inMinutes

local function doSnakeInResetQuest()
  local count = 0

  for k, v in pairs(actionsids) do
    if v.inUse then
      count = count+1
    end
  end

  if count == 4 then
    for x = 1, #snake do
      addEvent(doCreateItem, 500*x, snake[x].itemId, 1, snake[x])
      
      if x == #snake then
        addEvent(doCreateTeleport, ((500*x)+500), 1387, {x=574,y=513,z=9}, snake[x])
        addEvent(doSetStorage, ((500*x)+500)+(timeToQuestClose*60*1000), "resetQuestClosed", 1)
      end
    end
  end
end

local function lockAltar(pos)
  doCreateItem(5070, 1, pos)
  doSendMagicEffect(pos, 11)
end

local bookLocked = false

function sendResetQuestRequisitions(item, toPosition)
  for actionid, v in pairs(actionsids) do
    local currentID = getStoneItemId(v.element)

    if item.itemid == currentID then
      local currentItem = getTileItemById(toPosition, 8268)

      if currentItem.uid > 0 then
        if currentItem.actionid == actionid and v.inUse == false then
          addEvent(lockAltar, 1, toPosition)
          v.inUse = true
          doSnakeInResetQuest()
          return true
        end
      end

      break
    end
  end

  if item.itemid == 11134 then --livro
    local currentItem = getTileItemById(toPosition, 8268)

    if currentItem.uid > 0 then
      if currentItem.actionid == 3508 then
        addEvent(lockAltar, 1, toPosition)
        local stoneBlock = getTileItemById({x=509,y=512,z=10}, 1354)

        if stoneBlock.uid > 0 then
          doRemoveItem(stoneBlock.uid, 1)
          doSendMagicEffect({x=509,y=512,z=10}, 2)
        end

        return true
      end
    end
  end

  if item.itemid == 11197 then
    local currentItem = getTileItemById(toPosition, 8268)

    if currentItem.uid > 0 then
      if currentItem.actionid == 3494 then
        addEvent(lockAltar, 1, toPosition)
        local stoneBlock = getTileItemById({x=557,y=521,z=10}, 1304)

        if stoneBlock.uid > 0 then
          doRemoveItem(stoneBlock.uid, 1)
          doSendMagicEffect({x=557,y=521,z=10}, 2)
        end

        return true
      end
    end
  end

  return false
end