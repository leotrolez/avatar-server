local fogo = {x = 431, y = 1476, z = 4}

local function colocarPedrass()
    local pos = fogo
    local v = getTileItemById(pos, 1485).uid
      doTransformItem(v, 1484)
end 

local function removerPedrass()
    local pos = fogo
    local v = getTileItemById(pos, 1484).uid
      doTransformItem(v, 1485)
end 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if itemEx.id == 1485 and item.itemid == 2007 then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Wait for the fire.")
    return false
  end

  if (itemEx.actionid == 62127 and item.itemid == 2007) and getPlayerStorageValue(cid, "90525") ~= 1 then
    removerPedrass()
    addEvent(colocarPedrass, 10*1000)
    doRemoveItem(item.uid, 1)
    doSendMagicEffect(toPosition, 1)
    setPlayerStorageValue(cid, "90525", 1)
    doCreatureSay(cid, "Você conseguiu apagar o fogo com a água sagrada! Sua missão aqui está quase completa, agora vá e enfrente-o!", TALKTYPE_ORANGE_1, false, cid)
  end

  return false
end