dofile("data/lib/old/forge_system.lua")

local MyLocal = {}

MyLocal.picks = {
  [2553] = {normalChance = 100, specialChance = 10}
}

MyLocal.useablesTiles = {351, 352, 353, 355, 9021, 9022, 9023, 9024, 9025}
MyLocal.trashTiles = {6299}

MyLocal.normalNuggets = {{itemid = 13005, chance = 30, msg = {"You have found a bronze nugget.", "Vocï¿½ achou um bronze nugget."}, pointsUp = 15}, {itemid = 13006, chance = 70, msg = {"You have found an iron nugget.", "Vocï¿½ achou um iron nugget."}, pointsUp = 7}}
MyLocal.specialNuggets = {{itemid = 13003, chance = 15, msg = {"You have found a golden nugget.", "Vocï¿½ achou um golden nugget."}, pointsUp = 35}, {itemid = 13004, chance = 85, msg = {"You have found a silver nugget.", "Vocï¿½ achou um silver nugget."}, pointsUp = 20}}

MyLocal.delayToNewTile = 90
MyLocal.players, MyLocal.delay = {}, 0.5

local function tileToNormal(pos, itemId)
  local item = getTileItemById(pos, itemId)
  
  if item.uid > 0 then
    doRemoveItem(item.uid)
  end
end

local function tileToWast(uid, pos, win)
  if math.random(1, 10) <= 1 then
    local itemId = MyLocal.trashTiles[math.random(1, #MyLocal.trashTiles)]
    doCreateItem(itemId, pos)
    addEvent(tileToNormal, MyLocal.delayToNewTile*1000, pos, itemId)
    doSendMagicEffect(pos, 2)
  else
    if win then
      doSendMagicEffect(pos, 3)
    else
      doSendMagicEffect(pos, 2)
    end
  end
end

local function setItemAsBroke(cid, item, win)
  if math.random(1, 5) >= 3 then
    local itemDurability = getItemAttribute(item.uid, "durability") or 100
    doItemSetAttribute(item.uid, "durability", itemDurability-1)

    if itemDurability-1 <= 0 then
      local itemName = getItemNameById(item.itemid)
      sendBlueMessage(cid, getLangString(cid, "Sorry, your "..itemName.." has broke.", "Desculpe, seu "..itemName.." quebrou."))
      doSendMagicEffect(getThingPos(cid), 3)
      doRemoveItem(item.uid)
    end
  end
end

local function removeTable(cid)
  MyLocal.players[cid] = nil  
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if MyLocal.players[cid] ~= nil then
    return true
  end

  --RESET QUEST--
  if itemEx.actionid == 3488 and item.itemid == 2553 then
    removeTileItemByIds(toPosition, {6299}, 2)
    doTransformItem(itemEx.uid, 383)
    return true
  end
  --FIM--

  local playerMiningLevel, playerHasSuccess = getPlayerMiningLevel(cid), false
  local randomInitial, randomFinal = math.random(1, 1000), math.random(1, 100)

  if isInArray(MyLocal.useablesTiles, itemEx.itemid) then
    if randomInitial <= MyLocal.picks[item.itemid].specialChance+(math.floor(playerMiningLevel/3)) then
      for x = 1, #MyLocal.specialNuggets do
        if randomFinal <= MyLocal.specialNuggets[x].chance then
          doPlayerAddItem(cid, MyLocal.specialNuggets[x].itemid)
          sendBlueMessage(cid, getLangString(cid, MyLocal.specialNuggets[x].msg[1], MyLocal.specialNuggets[x].msg[2]), true)
          sendPercentToMining(cid, MyLocal.specialNuggets[x].pointsUp)
          playerHasSuccess = true
          break
        end 
      end
    elseif randomInitial <= MyLocal.picks[item.itemid].normalChance+(math.floor(playerMiningLevel/2)) then
      for x = 1, #MyLocal.normalNuggets do
        if randomFinal <= MyLocal.normalNuggets[x].chance then
          doPlayerAddItem(cid, MyLocal.normalNuggets[x].itemid)
          sendBlueMessage(cid, getLangString(cid, MyLocal.normalNuggets[x].msg[1], MyLocal.normalNuggets[x].msg[2]), true)
          sendPercentToMining(cid, MyLocal.normalNuggets[x].pointsUp)
          playerHasSuccess = true
          break
        end 
      end
    end

    tileToWast(itemEx.uid, toPosition, playerHasSuccess)
    setItemAsBroke(cid, item, playerHasSuccess)  
    MyLocal.players[cid] = true
    addEvent(removeTable, 1000*MyLocal.delay, cid)
  else
    if isInArray(MyLocal.trashTiles, itemEx.itemid) then
      doPlayerSendCancel(cid, getLangString(cid, "This tile has been completely explored.", "Esse tile jï¿½ estï¿½ completamente explorado."))
    else
      doPlayerSendCancel(cid, getLangString(cid, "Sorry, you cannot mine this tile, search a cave tile.", "Desculpe, vocï¿½ não pode minerar esse tile, procure outro."))
    end
  end
  return true
end