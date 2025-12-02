--[[
 * File destinado ao sistem de forja itens do servidor. (aprimorar, criar itens)
]]--

miningConfigs = {
  firstLevelPoints = 100,
  notProffisionMaxLevel = 5, 
  proffisionMaxLevel = 100
}

tableForje = {
  {itensNeed = {{itemid=2311, amount=1}, {itemid=2311, amount=1}, {itemid=2311, amount=1}, {itemid=2311, amount=1}},
   finalIten = 3212, chanceToBroke = 0}
}

function isPlayerMining(cid)
  return getPlayerStorageValue(cid, "getPlayerProffesionMining") == 1
end

function getPlayerMiningLevel(cid)
  return math.max(2, getPlayerStorageValue(cid, "miningLevel")+1)-1
end

function sendPercentToMining(cid, points)
  local storagePoints = math.max(1, getPlayerStorageValue(cid, "getPlayerMiningLevelPoints")+1)-1
  local playerMiningLevel = getPlayerMiningLevel(cid)
  local maxPointsToGo = miningConfigs.firstLevelPoints*getPlayerMiningLevel(cid)

  if not isPlayerMining(cid) then
    if playerMiningLevel >= miningConfigs.notProffisionMaxLevel then
      return false
    end
  end
  
  setPlayerStorageValue(cid, "getPlayerMiningLevelPoints", storagePoints+points)

  if storagePoints+points >= maxPointsToGo then
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You advanced to mining level "..(playerMiningLevel+1)..".")
    setPlayerStorageValue(cid, "miningLevel", playerMiningLevel+1)
  end
end

function getItensByPos(pos, exeptions) --{1645, 2555}
  local exeptions = exeptions or {}
  local funcItem = getThingfromPos
  local tableItens = {}

  for i = 1, 254 do
    local currentItem = funcItem({x=pos.x,y=pos.y,z=pos.z,stackpos=i})
    if currentItem.uid > 0 and not (isInArray(exeptions, currentItem.itemid)) then
      table.insert(tableItens, currentItem)
    end
  end

  return tableItens
end